#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-11-08 18:51:44 sander>

'''
xcaaba: eXecute CAABA
Author: Rolf Sander, 2018-...
'''

##############################################################################

import os, sys, shutil
assert sys.version_info >= (3, 6)
__target__ = os.readlink(__file__) if os.path.islink(__file__) else __file__
CAABADIR = os.path.realpath(os.path.dirname(__target__)+'/..')
sys.path.insert(1, os.path.realpath(CAABADIR+'/pycaaba'))
import re # regexp
import subprocess
from datetime import datetime
from glob import glob
from pyteetime import tee # from pycaaba
from rstools import HLINE, HLINE2, cat, grep_i, runcmd, tail, evaluate_config_file # from pycaaba
from netCDF4 import Dataset
from caabatools import split_caaba_mecca_nc
#from netCDF4 import Dataset

TMPFILE = 'tmp.txt'
LOGFILENAME_TMP = 'xcaaba.logfile' # suffix .log would be deleted by gmake clean
LOGFILENAME = os.path.splitext(LOGFILENAME_TMP)[0] + '.log'
HOME = os.environ['HOME']
HOST = os.environ['HOST']
USER = os.environ['USER']
DATE_NOW = datetime.now().strftime('%Y-%m-%d')
TIME_NOW = datetime.now().strftime('%H:%M:%S')

##############################################################################

def evaluate_command_line_arguments():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('inifile', nargs='?', default=None,
                        help='configuration file (*.ini)')
    args = parser.parse_args()
    return args

##############################################################################

def initial_checks():

    # ensure that $HOME/tmp directory exists:
    tmpdir = HOME+'/tmp'
    if (not os.path.isdir(tmpdir)):
        os.mkdir(tmpdir)

    # check that the input directory is okay:
    if (not os.path.isdir('input')): # if it is not a directory
        sys.exit('ERROR: The CAABA input directory is missing.')
    # check that the testsuite directory is okay:
    if (not os.path.isdir('testsuite')): # if it is not a directory
        sys.exit('ERROR: The CAABA testsuite directory is missing.')

    # delete old *.log files:
    list(map(os.remove, glob('*.log')))

##############################################################################

def maybe_xmecca(inifile):

    l_xmecca = False # default is not to start xmecca
    if (inifile):
        meccainifile = ini_xcaaba.get('meccainifile')
        if (meccainifile):
            l_xmecca = True
    else:
        meccainifile = ''
        print('\nYou can create a new chemical mechanism with xmecca now.')
        print('This is necessary, if:')
        print('- you have changed any of the *.eqn, *.spc, or *.kpp files')
        print('- you have changed your MECCA config (*.ini) file')
        inputstring = input('Start xmecca? [y|n|q|default=n] ')
        if (inputstring == 'q'): sys.exit(0)
        if (inputstring == 'y'):
            l_xmecca = True

    if (not l_xmecca):
        # check that kpp-generated f90 files are newer than kpp files:
        gaseqntime     = os.path.getmtime('mecca/gas.eqn')
        gasspctime     = os.path.getmtime('mecca/gas.spc')
        aqueouseqntime = os.path.getmtime('mecca/aqueous.eqn')
        aqueousspctime = os.path.getmtime('mecca/aqueous.spc')
        kpptime        = os.path.getmtime('mecca/messy_mecca_kpp.kpp')
        f90time        = os.path.getmtime('messy_mecca_kpp.f90')
        l_xmeccayes = False
        if (gaseqntime>f90time):
            print('WARNING: gas.eqn is newer than kpp-generated f90 files')
            l_xmeccayes = True
        if (gasspctime>f90time):
            print('WARNING: gas.spc is newer than kpp-generated f90 files')
            l_xmeccayes = True
        if (aqueouseqntime>f90time):
            print('WARNING: aqueous.eqn is newer than kpp-generated f90 files')
            l_xmeccayes = True
        if (aqueousspctime>f90time):
            print('WARNING: aqueous.spc is newer than kpp-generated f90 files')
            l_xmeccayes = True
        if (kpptime>f90time):
            print('WARNING: messy_mecca_kpp.kpp is newer than kpp-generated f90 files')
            l_xmeccayes = True
        if (l_xmeccayes):
            if (inifile):
                print('ERROR: Create new f90 files with KPP via xmecca')
                print('       before running xcaaba with a config file!')
                sys.exit(1)
            else:
                print('It is strongly suggested to create new f90 files via xmecca.')
                inputstring = input('Start xmecca? [y|n|q|default=y] ')
                if (inputstring == 'q'): sys.exit(0)
                if (inputstring != 'n'):
                    l_xmecca = True

    if (l_xmecca):
        print(f'\n{HLINE}\nStarting xmecca...\n{HLINE}')
        from xmecca import xmecca
        xmecca.exe(f'{CAABADIR}/mecca/ini/{meccainifile}.ini')
        print(f'\n{HLINE}\nxmecca has finished\n{HLINE}\n')

    return l_xmecca

##############################################################################

def compile_code(inifile, l_xmecca):

    infostring = {
        's': 'Start from scratch ("gmake clean", then compile)',
        'c': 'Compile recently changed files with "gmake"',
        'r': 'Run existing executable'}

    if (inifile):
        option = ini_xcaaba.get('compile', 'c')
    else:
        print('Choose an option:')
        print('s = %s' % (infostring['s']))
        print('c = %s [default]' % (infostring['c']))
        if (not l_xmecca):
            print('r = %s' % (infostring['r']))
        print('q = Quit')
        inputstring = input('')
        if (inputstring == 'q'):
            sys.exit(0)
        elif ((inputstring == 'r') or (inputstring == 's')):
            option = inputstring
        else:
            option = 'c' # default

    print(f'You have chosen: {option} = {infostring[option]}\n\n{HLINE}')
    if (option == 's'):
        print('\ngmake clean')
        subprocess.call('gmake clean', shell=True)
    if ((option == 'c') or (option == 's')):
        print('\ngmake validate')
        exitstatus = subprocess.call('gmake validate', shell=True)
        print(f'exit status from "gmake validate" is: {exitstatus}')
        if (exitstatus != 0): sys.exit(1)
        print(f'\n{HLINE}')
        print('\ngmake (writing output to gmake.log)')
        cmd = 'gmake -j' # the option '-j' allows simultaneous jobs
        # activate next line (instead of the one above) to show more debugging info:
        # cmd = 'gmake -j --debug=basic'
        CMDLOGFILE = open('gmake.log','w+', 1)
        exitstatus = subprocess.call(cmd, stdout=CMDLOGFILE, stderr=CMDLOGFILE, shell=True)
        CMDLOGFILE.close()
        print(f'exit status from "gmake" is: {exitstatus}')
        if (exitstatus != 0):
            tail('gmake.log',20)
            print('\nOnly the last 20 lines of the compiler output are shown.')
            print('For further details, check gmake.log!\n')
            sys.exit(1)
        print(f'\n{HLINE}')
    if ((option == 'r') and (l_xmecca)):
        print('ERROR: You must choose option c or s')
        print('       after creating a new chemical mechanism with xmecca')
        sys.exit(1)

##############################################################################

def select_nml(inifile):
    if (inifile):
        nmlfile = ini_xcaaba.get('nmlfile')
        if (nmlfile):
            nmlfile = 'nml/' + nmlfile
        else:
            sys.exit('ERROR: You must provide a namelist file ("nmlfile").')
    else:
        defaultnml = os.readlink('caaba.nml')
        allfiles = sorted(glob('nml/*.nml'))
        print('\nChoose a namelist file from the nml/ directory:')
        for i, nmlfile in enumerate(allfiles): # list all possibilities
            print(f'{i+1:2}) {os.path.basename(nmlfile)}')
        print(' q) quit')
        inputstring = input('The default is %s (same as last time)\n' % (
            os.path.basename(defaultnml)))
        if (inputstring == 'q'):
            sys.exit(0)
        try:
            nmlindex = int(inputstring)-1
        except ValueError:
            nmlindex = -1
        if((nmlindex < len(allfiles)) and (nmlindex >= 0)):
            nmlfile = allfiles[nmlindex]
        else:
            nmlfile = defaultnml # default
        print(HLINE)
    if (os.path.isfile('caaba.nml')): os.remove('caaba.nml')
    os.symlink(nmlfile, 'caaba.nml')
    print('\nThe active contents of caaba.nml is:')
    os.system("sed -ne '/^&CAABA[ ]*$/,/^\//p' caaba.nml | " +
              f"grep -v '^!' | grep -v '^ *$' > {TMPFILE}")
    cat(TMPFILE)
    print(f'{HLINE}\n\nThe active contents of mecca.nml is:')
    os.system("sed -ne '/^&CTRL/,/^\//p' mecca.nml | " +
              f" grep -v '^!' | grep -v '^ *$' > {TMPFILE}")
    cat(TMPFILE)
    if (not inifile):
        print(f'{HLINE}\n\nBefore you continue, ensure that the selected namelist')
        print(os.path.basename(nmlfile))
        print('is consistent with the selected chemistry mechanism!')
    # ----------------------
    # mecca.nml:
    if (os.path.isfile('mecca.nml')): os.remove('mecca.nml')
    os.symlink('nml/mecca_default.nml', 'mecca.nml')

##############################################################################

def run_caaba_exe(inifile):

    # check_if_monte_carlo:
    if (grep_i('REQ_MCFCT *= *\.TRUE\.', 'messy_mecca_kpp*.f90')):
        if (inifile):
            l_montecarlo = ini_xcaaba.getboolean('l_montecarlo')
        else:
            inputstring = input(
                '\nRun Monte-Carlo simulations with CAABA? [y|n|q|default=y] ')
            if (inputstring == 'q'):
                sys.exit(0)
            l_montecarlo = False if (inputstring=='n') else True
        if (l_montecarlo):
            from montecarlo import montecarlo
            print('\nStarting Monte-Carlo runs with montecarlo...')
            outputdir = montecarlo()
            return outputdir

    if (inifile):
        runcaaba = ini_xcaaba.get('runcaaba', 'y')
    else:
        print('\nRun CAABA/MECCA?')
        print('y = yes (default)')
        print('m = multirun')
        print('n = no')
        print('q = quit')
        runcaaba = input('')
        print(HLINE)
        if (runcaaba == 'q'): sys.exit(0)

    if (runcaaba == 'm'): # multirun
        from multirun import multirun
        if (inifile):
            multirun_ncfile = 'input/multirun/' + ini_xcaaba.get('multirun_ncfile')
            if (not os.path.isfile(multirun_ncfile)):
                multirun_ncfile = None
        else:
            print('\nChoose an input file from the input/multirun/ directory:')
            print('[q|number]')
            allfiles = sorted(glob('input/multirun/*.nc'))
            for i, ncfile in enumerate(allfiles): # list all possibilities
                print(f'{i+1:2}) {os.path.basename(ncfile)}')
            inputstring = input('')
            if (inputstring == 'q'): sys.exit(0)
            try:
                ncindex = int(inputstring)-1
            except ValueError:
                ncindex = -1
            if((ncindex < len(allfiles)) and (ncindex >= 0)):
                multirun_ncfile = allfiles[ncindex]
            else:
                multirun_ncfile = None
        if (multirun_ncfile):
            outputdir = multirun.complete(multirun_ncfile)
            return outputdir
        else:
            sys.exit('ERROR: No valid *.nc file selected for multirun')

    if (runcaaba == 'n'):
        print('\nNot running caaba.exe because "runcaaba=n"')
        return None
    else: # default
        # remove old output files, if any:
        list(map(os.remove, glob('caaba_*.nc')))
        print('Starting CAABA. Please wait...\n')
        # run the CAABA/MECCA box model (script for line buffering):
        os.system(f"script -q -c '\\time -p ./caaba.exe' {TMPFILE}")
        # convert to unix format and add to logfile:
        with open(TMPFILE, 'r') as f:
            print(f.read().replace('\r', ''), file=LOGFILE)
        # set exitstatus to the value in the file status.log:
        statusfile = 'status.log'
        with open(statusfile) as f:
            exitstatus = int(f.read())
        os.remove(statusfile)
        if (exitstatus == 0):
            print(f'\ncaaba.exe has finished successfully\n\n{HLINE}')
        else:
            sys.exit(f"\nERROR: exit status from 'caaba.exe' is: {exitstatus}")
        # check if there are any reaction rates RR* in caaba_mecca.nc:
        split_caaba_mecca_nc()
        # save results:
        outputdir = save_model_output(inifile)
        # plot results:
        visualize(inifile, outputdir)
        return outputdir

##############################################################################

def save_model_output(inifile):
    if not os.path.exists(CAABADIR + '/output'):
        os.mkdir(CAABADIR + '/output')
    defaultoutputdir = f'output/{DATE_NOW}-{TIME_NOW}'
    if (inifile):
        if ('outputdir' in ini_xcaaba):
            if (ini_xcaaba['outputdir']):
                outputdir = 'output/' + ini_xcaaba['outputdir']
            else:
                outputdir = defaultoutputdir
        else:
            outputdir = defaultoutputdir
        # if a directory with this name exists already, rename it:
        if (os.path.isdir(outputdir)):
            newname = outputdir + '-' + datetime.fromtimestamp(
                os.path.getmtime(outputdir)).strftime('%Y-%m-%d-%H:%M:%S')
            print(f'\nRenaming {outputdir} to {newname}')
            os.rename(outputdir, newname)
    else:
        print('\nSave the output and model code?')
        print('Choose an option or type a directory name:')
        print(f'y (default) = yes, save in {defaultoutputdir}')
        print('n           = no (output stays in current directory)')
        print('q           = quit')
        print('<dirname>   = save in output/<dirname>')
        inputstring = input('')
        if (inputstring == 'q'):
            sys.exit(0)
        elif (inputstring == '' or inputstring == 'y'):
            outputdir = defaultoutputdir
        elif (inputstring == 'n'):
            outputdir = False
        else:
            # remove unsuitable characters:
            myoutputdir = re.sub('[^-A-Za-z0-9:_+=.]', '', inputstring)
            if (inputstring != myoutputdir):
                print('Unsuitable characters (e.g., from pressing arrow keys) have been')
                print('removed from the name of the output directory. The new name is:')
                print(myoutputdir)
            outputdir = f'output/{myoutputdir}'
            # ensure directory doesn't exist yet:
            if (os.path.isdir(outputdir)):
                print(f'Directory {outputdir} already exists.')
                print('Using default directory instead.')
                outputdir = defaultoutputdir
            # confirmation:
            print(f'Name of output directory = {outputdir}')
            inputstring2 = input('Confirm to save output now [y|n|q, default=y]\n')
            if (inputstring2 == 'q'): sys.exit(0)
            if (inputstring2 == 'n'): outputdir = False
    if (outputdir):
        print('\nCreating zip file of caaba model code. Please wait...')
        os.mkdir(outputdir)
        # os.system(f'gmake zip > {TMPFILE}')
        # with open(TMPFILE, 'r') as f:
        #     print(f.read(), file=LOGFILE) # add to logfile
        # shutil.move(f'{os.path.basename(CAABADIR)}.zip', outputdir)
        os.system(f'cp -p *.nc *.dat pycaaba/_*.py {outputdir}')
        print(f'Model code and output have been saved to {outputdir}:')
        for thefile in sorted(os.listdir(outputdir)):
            print(thefile)
    else:
        print('Model code and output have not been saved.')
    print(f'\n{HLINE}')
    return outputdir

##############################################################################

def visualize(inifile, outputdir):
    from caabaplot import makeplots
    if (inifile):
        l_caabaplot = ini_xcaaba.getboolean('l_caabaplot')
    else:
        inputstring = input('\nPlot results with caabaplot? [y|n, default=n]\n')
        l_caabaplot = True if (inputstring=='y') else False
    if (l_caabaplot):
        makeplots(inifile)
    else:
        print('\nResults are not plotted because l_caabaplot is False')

##############################################################################

def finalize(outputdir=False):
    if (os.path.isfile(TMPFILE)): os.remove(TMPFILE)
    print(f'\n{HLINE}\nxcaaba has finished\n{HLINE}\n')
    tee.stdout_stop()
    os.rename(LOGFILENAME_TMP, LOGFILENAME) # final suffix .log
    if outputdir:
        [shutil.copy2(logfile, outputdir) for logfile in glob('*.log')]
    print(f'Log output is now available in {LOGFILENAME}')

##############################################################################

if __name__ == '__main__':

    LOGFILE = tee.stdout_start(LOGFILENAME_TMP, append=False) # stdout
    print('xcaaba was started on %s at %s by user %s on machine %s' % (
        DATE_NOW, TIME_NOW, USER, HOST), file=LOGFILE)
    args = evaluate_command_line_arguments()
    inifile = args.inifile
    if (inifile):
        # type inifile with or without ini/ directory name and extension .ini:
        inifile = '%s/ini/%s.ini' % (CAABADIR,
            os.path.splitext(re.sub('^ini/','',args.inifile))[0])
        ini_xcaaba = evaluate_config_file(inifile, 'xcaaba')
        print(f'Contents of config file {inifile}:')
        for key in ini_xcaaba:
            print(f'{key:16}= {ini_xcaaba[key]}')
    else:
        print('No config file (*.ini).')
    initial_checks()
    l_xmecca = maybe_xmecca(inifile)
    compile_code(inifile, l_xmecca)
    select_nml(inifile)
    # run the CAABA/MECCA model:
    outputdir = run_caaba_exe(inifile)
    # final cleanup:
    finalize(outputdir)

##############################################################################
