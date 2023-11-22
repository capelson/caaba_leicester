#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-11-08 18:51:25 sander>

'''
xskeleton: eXecute skeletal mechanism generation
Author: Rolf Sander, 2016-...
'''

##############################################################################

import os, sys, shutil
assert sys.version_info >= (3, 6)
__target__ = os.readlink(__file__) if os.path.islink(__file__) else __file__
CAABADIR = os.path.realpath(os.path.dirname(__target__)+'/..')
OUTPUTDIR = CAABADIR+'/output/skeleton'
sys.path.insert(1, os.path.realpath(CAABADIR+'/pycaaba'))
from netCDF4 import Dataset
import matplotlib.pyplot as plt
import time
from datetime import datetime
import numpy as np
from glob import glob
from contextlib import redirect_stdout
from pyteetime import tee # from pycaaba
from caabaplot import plot_0d, xxxg # from pycaaba
from rstools import HLINE, HLINE2, runcmd, evaluate_config_file # from pycaaba
from xmecca import xmecca # from pycaaba

KPPMODE  = '// -*- kpp -*- kpp mode for emacs'
DONTEDIT = 'created automatically by %s at %s, DO NOT EDIT!' % (
    sys.argv[0], datetime.now().strftime("%Y-%m-%d-%H:%M:%S"))
# Read info about targets from file:
targetdata = np.genfromtxt('targets.txt', dtype='U80,float,float', comments='#')

##############################################################################

def evaluate_command_line_arguments():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('inifile', help='''Configuration (*.ini) file
        from the ini/ directory''')
    args = parser.parse_args()
    return args

##############################################################################

class xskeleton:

    @classmethod
    def read_skeletoninifile(cls):
        import ast
        ini_xskeleton = evaluate_config_file(cls.inifile, 'xskeleton')
        cls.inifile_short = cls.inifile.replace(CAABADIR+'/','')
        print(f'Contents of config file {cls.inifile_short}:')
        for key in ini_xskeleton:
            print(f'{key:20}= {ini_xskeleton[key]}')
        cls.meccainifile      = ini_xskeleton.get('meccainifile', 'mom')
        cls.samplepointfile   = ini_xskeleton.get('samplepointfile', '')
        cls.eps0              = float(ini_xskeleton.get('eps0', '5E-4'))
        cls.eps_increase      = float(ini_xskeleton.get('eps_increase', '1.2'))
        cls.plot_delta_skel   = int(ini_xskeleton.get('plot_delta_skel', '1'))
        cls.plot_targets      = int(ini_xskeleton.get('plot_targets', '1'))
        cls.plot_samplepoints = int(ini_xskeleton.get('plot_samplepoints', '1'))
        cls.plotspecies       = ini_xskeleton.get('plotspecies')
        if (cls.plotspecies):
            cls.plotspecies = ast.literal_eval(cls.plotspecies) # convert string to list
        else:
            cls.plotspecies = ['O1D', 'O3', 'OH', 'HO2', 'H2O2', 'NOx', 'NOy',
                'SO2', 'H2SO4', 'CH3SO3H', 'DMS', 'DMSO']

    ##########################################################################

    @staticmethod
    def cleanup():
        if (os.path.isdir(OUTPUTDIR)):
            os.rename(OUTPUTDIR, OUTPUTDIR + '-' + time.strftime(
                '%Y-%m-%d-%H:%M:%S', time.localtime(os.path.getmtime(OUTPUTDIR))))
        os.mkdir(OUTPUTDIR)

    ##########################################################################

    @staticmethod
    def get_workdir(skelnum):
        if (skelnum):
            # workdir contains skelnum with 3 digits:
            workdir = '%s/skeleton_%3.3d' % (OUTPUTDIR, skelnum)
        else:
            workdir = '%s/fullmech' % (OUTPUTDIR)
        if (not os.path.isdir(workdir)):
            os.mkdir(workdir)
        workdir_short = workdir.replace(CAABADIR+'/','')
        return workdir, workdir_short

    ##########################################################################

    @classmethod
    def show_reaction(cls, rxn):
        reagents = ''
        products = ''
        for spc_num, spc_stoic in enumerate(cls.StoichNum[rxn]): # loop over species
            if (spc_stoic < 0):
                reagents += ' + %g %s' % (-spc_stoic, cls.oicdata[spc_num][1])
            if (spc_stoic > 0):
                products += ' + %g %s' % (spc_stoic, cls.oicdata[spc_num][1])
        return '%-10s %s -> %s' % ('<'+cls.EQN_TAGS[rxn]+'>', reagents, products)

    ##########################################################################

    @classmethod
    def create_skeletal_mechanism(cls, eps):
        f_mechlog = open(cls.workdir+'/mechanism.log','w+', 1) # 1=line-buffered
        print('%s\neps = %g\n%s' % (HLINE, eps, HLINE), file=f_mechlog)
        # Create empty list of reactions to delete:
        cls.del_rxn = [False] * len(cls.StoichNum)
        N_var_skel = 0
        # Create mechanism including all species with OIC>eps:
        for num, (oic, name) in enumerate(cls.oicdata): # loop over species
            if (oic > eps): # keep!
                print('\nKEEP   %4d %s %15g' % (num+1, name, oic), file=f_mechlog)
                N_var_skel += 1
            else: # delete!
                print('\nDELETE %4d %s %15g' % (num+1, name, oic), file=f_mechlog)
                # Find rxns that contain this species:
                for rxn in range(cls.N_rxns): # loop over reactions
                    if (cls.StoichNum[rxn][num] != 0):
                        if (cls.StoichNum[rxn][num] < 0):
                            cls.del_rxn[rxn] = True # mark for deletion
                            print('  '+cls.show_reaction(rxn), file=f_mechlog)
                            print('    delete because reagent %10g %15s' % (
                                    cls.StoichNum[rxn][num], name), file=f_mechlog)
                        if (cls.StoichNum[rxn][num] > 0):
                            cls.del_rxn[rxn] = True # mark for deletion
                            print('  '+cls.show_reaction(rxn), file=f_mechlog)
                            print('    delete because product %10g %15s' % (
                                    cls.StoichNum[rxn][num], name), file=f_mechlog)
        print('\n%s\nSUMMARY OF DELETED REACTIONS\n%s:' % (
            HLINE, HLINE), file=f_mechlog)
        for rxn in range(cls.N_rxns): # loop over reactions
            if (cls.del_rxn[rxn]):
                print('DELETE: '+cls.show_reaction(rxn), file=f_mechlog)
        print('\n%s\nSUMMARY OF KEPT REACTIONS\n%s:' % (HLINE, HLINE), file=f_mechlog)
        for rxn in range(cls.N_rxns): # loop over reactions
            if (not cls.del_rxn[rxn]):
                print('KEEP: '+cls.show_reaction(rxn), file=f_mechlog)
        f_mechlog.close()
        skelinfo = 'nvar = %d/%d, nreact = %d/%d, eps = %g' % (
            N_var_skel, cls.N_var_full, cls.del_rxn.count(False), cls.N_rxns, eps)
        print(skelinfo)
        cls.epslist.append(eps)
        # Create rpl file:
        cls.create_skeleton_rpl(cls.del_rxn, skelinfo)
        cls.del_rxnlist.append(cls.del_rxn)

    ##########################################################################

    @classmethod
    def create_skeleton_rpl(cls, delrxn, skelinfo=None):
        # A rpl file that deletes several reactions is used to create the
        # skeletal mechanism. Initially, an empty rpl file creates the full
        # mechanism.
        rplfilename = CAABADIR+'/skeleton/skeleton.rpl'
        f_rpl = open(rplfilename,'w+')
        print(KPPMODE + '\n// ' + DONTEDIT,                                file=f_rpl)
        print('// inifile = %s' % (cls.inifile_short),                     file=f_rpl)
        print('//\n// target               abstol     reltol',             file=f_rpl)
        for num, (target, abstol, reltol) in enumerate(targetdata):
            print('// %-15s %10G %8G ' % (target, abstol, reltol),         file=f_rpl)
        print('//\n// sample point file = %s.nc' % (cls.samplepointfile),  file=f_rpl)
        print('// epsilon0          = %G' % (cls.eps0),                    file=f_rpl)
        print('// eps_increase      = %G' % (cls.eps_increase),            file=f_rpl)
        if skelinfo:
            print('// skeleton number = %s, %s' % (cls.skelnum, skelinfo), file=f_rpl)
        else:
            print('// full mechanism',                                     file=f_rpl)
        if (delrxn):
            for rxn, delete in enumerate(delrxn): # loop over reactions
                if (delete):
                    print('#REPLACE %-10s' % ('<'+cls.EQN_TAGS[rxn]+'>'),  file=f_rpl)
                    print('#ENDREPLACE',                                   file=f_rpl)
        f_rpl.close()
        # Save *.rpl file in workdir:
        os.system('cp -p ' + rplfilename + ' ' + cls.workdir)
        print('replacement file skeleton.rpl is in:\n  %s' % (cls.workdir_short))

    ##########################################################################

    @classmethod
    def caaba_multirun(cls):
        from multirun import multirun
        if (cls.samplepointfile):
            olddir = os.getcwd()
            print('\nrunning xmecca...', end=' ')
            config = evaluate_config_file(
                f'{CAABADIR}/mecca/ini/{cls.meccainifile}.ini')
            if (config['xmecca'].get('rplfile')):
                sys.exit(f'\n\nERROR: The MECCA *.ini file {cls.meccainifile}.ini ' +
                         f'contains "rplfile={rplfile}"\n' +
                         'but xskeleton needs a file with an empty rplfile entry.')
            config['xmecca']['rplfile']  = 'skeleton'
            config['xmecca']['rxnrates'] = 'n' # don't calculate accumulated reaction rates
            config['xmecca']['latex']    = 'n' # no latex list of reactions
            config['xmecca']['graphviz'] = 'n' # no graphviz plots
            skeleton_meccainifile = f'{CAABADIR}/mecca/ini/skeleton.ini'
            with open(skeleton_meccainifile, 'w') as f_config:
                print(f'# {DONTEDIT}', file=f_config)
                config.write(f_config)
            with open(cls.workdir+'/xmecca.log', 'w') as f:
                with redirect_stdout(f):
                    xmecca.exe(skeleton_meccainifile)
            print('DONE')
            os.chdir(CAABADIR) # cd to CAABA base directory
            # Use the namelist file caaba_skeleton.nml:
            os.system('ln -fs nml/caaba_skeleton.nml caaba.nml')
            # Compile caaba:
            runcmd('gmake', cls.workdir+'/gmake.log')
            # Run CAABA for all sample points:
            multirun.complete('skeleton/samplepoints/'+cls.samplepointfile+'.nc')
            # Move output to final destination:
            shutil.move('output/multirun/' + cls.samplepointfile, cls.workdir+'/multirun')
            shutil.move(skeleton_meccainifile, cls.workdir)
            os.chdir(olddir)
        else:
            print('Skipping CAABA multirun because there is no samplepointfile')

    ##########################################################################

    @staticmethod
    def get_samplepointnames():
        fullsamplepointnames = sorted(glob(OUTPUTDIR+'/fullmech/multirun/runs/*'))
        samplepointnames = list(map(os.path.basename, fullsamplepointnames))
        N_samplepoints = len(samplepointnames)
        print('N_samplepoints = ', N_samplepoints)
        return samplepointnames, N_samplepoints

    ##########################################################################

    @classmethod
    def calc_oic(cls):
        if (cls.samplepointfile):
            print('\nCalculate DICs and OICs for full mechanism.')
            # Compile skeleton:
            runcmd('gmake', cls.workdir+'/gmake_oic.log')
            # Run oic:
            runcmd('./oic.exe', cls.workdir+'/oic.log')
            os.system('cp -p OIC.dat StoichNum.dat EQN_*.dat ' + cls.workdir)
        else:
            print('''Skipping calculation of OIC with oic.exe because there
                  is no samplepointfile''')
        if (os.path.basename(cls.workdir) == 'fullmech'):
            # Load OIC data from oic.exe into a numpy structured array:
            # http://docs.scipy.org/doc/numpy/user/basics.rec.html
            cls.oicdata = np.genfromtxt('OIC.dat', dtype='float,U80')
            cls.N_var_full = len(cls.oicdata) # number of variable species
            # Load StoichNum from oic.exe:
            cls.StoichNum = np.genfromtxt('StoichNum.dat')
            cls.N_rxns = len(cls.StoichNum) # number of reactions
            # Load EQN_TAGS from oic.exe:
            cls.EQN_TAGS = np.genfromtxt('EQN_TAGS.dat', dtype='str')
            # Load EQN_NAMES from oic.exe:
            cls.EQN_NAMES = [line.rstrip() for line in open('EQN_NAMES.dat')]

    ##########################################################################

    @classmethod
    def save_rates(cls, delrxn):
        rates = np.zeros((cls.N_samplepoints,len(delrxn)))
        keep_rxn = np.invert(np.array(delrxn))
        # sample point loop:
        for samplepointnum, samplepoint in enumerate(cls.samplepointnames):
            ratesfile = cls.workdir+'/multirun/runs/'+samplepoint+'/caaba_mecca_a_end.dat'
            rates0 = np.genfromtxt(ratesfile, dtype='float')
            rates[samplepointnum,keep_rxn] = rates0
        return rates

    ##########################################################################

    @classmethod
    def calc_error(cls):
        olddir = os.getcwd()
        os.chdir(cls.workdir)
        f_err = open('skel_error.dat','w+', 1) # 1=line-buffered
        # delta_samplepoints is a 2D array (list of lists) containing the
        # errors of the current skeletal mechanism compared to the full
        # mechanism for all targets and for all sample points:
        delta_samplepoints = []
        for samplepoint in cls.samplepointnames: # sample point loop
            print('sample point: %s' % (samplepoint), file=f_err)
            filename_part2 = 'multirun/runs/'+samplepoint+'/caaba_mecca_c_end.nc'
            # ncfile_full = NetCDFFile('../fullmech/'+filename_part2)
            # ncfile_skel = NetCDFFile(filename_part2)
            ncfile_full = Dataset('../fullmech/'+filename_part2)
            ncfile_skel = Dataset(filename_part2)
            # delta_targets is a 1D array (list) containing the errors of
            # the current skeletal mechanism compared to the full mechanism
            # for all targets:
            delta_targets = [None] * len(targetdata)
            print('target           abstol      reltol    ' +
                'mixrat_skel    mixrat_full     err/reltol', file=f_err)
            # target loop:
            for num, (target, abstol, reltol) in enumerate(targetdata):
                # read one number in a 4D array:
                mixrat_full = ncfile_full.variables[target][0][0][0][0]
                mixrat_skel = ncfile_skel.variables[target][0][0][0][0]
                delta_targets[num] = abs(max(mixrat_skel,abstol)/
                  max(mixrat_full,abstol)-1) / reltol
                print('%-15s %10G %8G %14G %14G %14G' % (
                    target, abstol, reltol, mixrat_skel, mixrat_full,
                    delta_targets[num]), file=f_err)
            delta_samplepoints.append(delta_targets)
            ncfile_full.close()
            ncfile_skel.close()
        f_err.close()
        os.chdir(olddir)
        return delta_samplepoints

    ##########################################################################

    @classmethod
    def analyze_results(cls):
        delta_samplepoints = cls.calc_error() # calculate error relative to full mechanism
        delta_skel = np.amax(delta_samplepoints) # max error over all targets and samplepoints
        # add rates in current skeletal mechanism to all_rates:
        cls.all_rates = np.dstack((cls.all_rates, cls.save_rates(cls.del_rxn)))
        if (delta_skel > 1.):
            f_rates = open(OUTPUTDIR+'/rates.dat','w+', 1) # 1=line-buffered
            # difference of current to previous skeletal mechanism:
            diff = cls.all_rates[:,:,-1] - cls.all_rates[:,:,-2]
            print('\n%s\nError of skeletal mechanism has become too big.\n%s' % (
                HLINE, HLINE))
            print('List of sample points with delta_skel>1:')
            for samplepointnum in range(cls.N_samplepoints): # sample point loop
                idx = np.argsort(abs(diff[samplepointnum,:]))
                # check if this is a problem sample point:
                if (max(delta_samplepoints[samplepointnum]) > 1.):
                    print(HLINE+'\n\n*** sample point: %04d\n' % (samplepointnum+1),
                          file=f_rates)
                    for targetnum, delta_target in enumerate(
                            delta_samplepoints[samplepointnum]):
                        if (delta_target > 1.):
                            print('Sample point: %04d, delta_skel: %10G, target: %s' % (
                                samplepointnum+1, delta_target, targetdata[targetnum][0]))
                        print('delta_skel: %10G, target: %s' % (
                            delta_target, targetdata[targetnum][0]), file=f_rates)
                    print('\nColumn 1: Reaction rate in previous ' +
                        '(s%03d) skeletal mechanism [cm-3 s-1]' % (cls.skelnum-1),
                          file=f_rates)
                    print('Column 2: Is reaction also included in current ' +
                        '(s%03d) skeletal mechanism?' % (cls.skelnum), file=f_rates)
                    print('Column 3: Difference (s%03d-s%03d)' % (cls.skelnum, cls.skelnum-1)
                        + ' of current minus previous reaction rate\n', file=f_rates)
                    print('        s%03d  s%03d         diff reaction' % (
                        cls.skelnum-1, cls.skelnum), file=f_rates)
                    for i in range(idx.shape[0]):
                        x = idx[-i-1]
                        if (not cls.del_rxnlist[-2][x]): # if rxn was in previous skeleton
                            print('%12G %5s %12G %-10s %s' % (
                                cls.all_rates[samplepointnum,x,-2],
                                not cls.del_rxnlist[-1][x], diff[samplepointnum,x],
                                '<'+cls.EQN_TAGS[x]+'>', cls.EQN_NAMES[x]), file=f_rates)
                    print(file=f_rates)
            print(HLINE, file=f_rates)
            f_rates.close()
            # copy previous replacement file to OUTPUTDIR:
            os.system('cp -p %s/skeleton.rpl %s/' % (
                cls.get_workdir(cls.skelnum-1)[0], OUTPUTDIR))
            # copy config *.ini file and targets.txt to OUTPUTDIR:
            os.system('cp -p %s %s/' % (cls.inifile, OUTPUTDIR))
            os.system('cp -p %s/skeleton/targets.txt %s/' % (CAABADIR, OUTPUTDIR))

        return delta_skel, delta_samplepoints

    ##########################################################################

    @classmethod
    def list_species(cls, epslist):
        f_spec = open(OUTPUTDIR+'/species.dat','w+', 1) # 1=line-buffered
        print(HLINE,                                       file=f_spec)
        for epsnum,eps in enumerate(epslist):
            if (epsnum == 0):
                print('full', end=' ',                     file=f_spec)
            else:
                print('s%03d' % (epsnum), end=' ',         file=f_spec)
        print('OIC          species',                      file=f_spec)
        print(HLINE,                                       file=f_spec)
        for oic, species in np.sort(cls.oicdata):
            for epsnum,eps in enumerate(epslist):
                if (oic < eps):
                    print('    ', end=' ',                 file=f_spec)
                else:
                    if (epsnum == 0):
                        print('full', end=' ',             file=f_spec)
                    else:
                        print('s%03d' % (epsnum), end=' ', file=f_spec)
            print('%12E %s' % (oic, species),              file=f_spec)
        print(HLINE,                                       file=f_spec)
        f_spec.close()

    ##########################################################################

    @classmethod
    def list_reactions(cls, del_rxnlist):
        f_rxns = open(OUTPUTDIR+'/reactions.dat','w+', 1) # 1=line-buffered
        print(HLINE, file=f_rxns)
        for rxn in range(cls.N_rxns): # loop over reactions
            for mechnum, delrxn in enumerate(del_rxnlist):
                if (delrxn[rxn]):
                    print('    ', end=' ', file=f_rxns)
                else:
                    if (mechnum == 0):
                        print('full', end=' ', file=f_rxns)
                    else:
                        print('s%03d' % (mechnum), end=' ', file=f_rxns)
            # use either EQN_TAGS+EQN_NAMES or show_reaction:
            print('%-10s %s' % ('<'+cls.EQN_TAGS[rxn]+'>', cls.EQN_NAMES[rxn]), file=f_rxns)
        print(HLINE, file=f_rxns)
        f_rxns.close()

    ##########################################################################

    @classmethod
    def make_target_plots(cls, plot_targets):
        from viewport import viewport # from pycaaba
        if (not plot_targets): return
        print('\nPlotting these skeletal mechanisms:\n', cls.all_skel, '\n')
        viewport.init(4, 4, OUTPUTDIR+'/targets.pdf', 17, 8) # open pdf
        print(HLINE)
        for num, (target, abstol, reltol) in enumerate(targetdata): # target loop
            print('Plotting target %-15s' % (target))
            for samplepoint in cls.samplepointnames: # sample point loop
                plot_0d(
                    modelruns = [[OUTPUTDIR+'/'+skel+'/multirun/runs/'+samplepoint, skel]
                                   for skel in cls.all_skel],
                    species   = target,
                    pagetitle = 'Target species: '+target,
                    plottitle = 'Sample point: '+samplepoint,
                    timeformat  = '%-Hh')
        viewport.exit() # close pdf

    ##########################################################################

    @classmethod
    def make_samplepoint_plots(cls, plot_samplepoints):
        if (not plot_samplepoints): return
        # delete old plots:
        list(map(os.remove, glob(OUTPUTDIR+'/samplepoint_*.pdf')))
        print(HLINE, '\n')
        # define plotsamplepoints:
        if (plot_samplepoints == 1):
            plotsamplepoints = cls.samplepointnames
        else:
            plotsamplepoints = ['0003', '0027'] # selected samplepoints
        for samplepoint in plotsamplepoints: # sample point loop
            print('Plotting sample point %-15s' % (samplepoint))
            xxxg(
                modelruns   = [[OUTPUTDIR+'/'+skel+'/multirun/runs/'+samplepoint, skel]
                               for skel in cls.all_skel],
                plotspecies = cls.plotspecies,
                pdffile     = OUTPUTDIR+'/samplepoint_'+samplepoint,
                pagetitle   = 'sample point: '+samplepoint,
                timeformat  = '%-Hh')
            print()

    ##########################################################################

    @classmethod
    def make_delta_skel_plots(cls, plot_delta_skel):
        from viewport import viewport # from pycaaba
        from cycler import cycler
        if (not plot_delta_skel): return
        linecolors = ['k', 'r', 'g', 'b', 'm', 'y', 'c']
        print(HLINE, '\nPlotting delta_skel errors')
        viewport.init(4, 4, OUTPUTDIR+'/delta_skel.pdf', 17, 8) # open pdf
        # sample point loop:
        for samplepointnum, samplepoint in enumerate(cls.samplepointnames):
            ax = viewport.next()
            ax.set_prop_cycle(cycler('color', linecolors))
            if (viewport.current == 1):
                # on new page, start with legend on a dummy plot:
                # target loop:
                for targetnum, (target, abstol, reltol) in enumerate(targetdata):
                    lines = plt.plot([0,0], linewidth=3, label='%s (abstol=%G, reltol=%G)' % (
                        target, abstol, reltol))
                plt.axis('off')
                legend = plt.legend(loc='center',
                                    mode='expand',
                                    fontsize = 'small',
                                    title='delta_skel errors',
                                    fancybox=True,
                                    shadow=True,
                                    borderaxespad=0.)
                plt.setp(legend.get_title(),fontsize='large')
                ax = viewport.next()
                ax.set_prop_cycle(cycler('color', linecolors))
            # target loop:
            for targetnum, (target, abstol, reltol) in enumerate(targetdata):
                mydata = cls.delta_skel_all[:,samplepointnum,targetnum]
                xval = np.arange(1, len(mydata)+1, 1)
                plt.plot(xval, mydata[:], '*', linestyle='solid')
            plt.xlim(0,len(mydata)+1)
            plt.ylim(0.,1.)
            plt.title('sample point: '+samplepoint)
            plt.xlabel('skeletal mechanism number')
            plt.ylabel('delta_skel')
        viewport.exit() # close pdf

    ##########################################################################

    @classmethod
    def finalize(cls, info):
        print(HLINE)
        print('Summary of results: %d targets, %d sample points, %d skeletal mechanisms' % (
            info[2], info[1], info[0]))
        print(HLINE)
        print('Sample points                  acro samplepoints/'+cls.samplepointfile+'.pdf')
        print('Go to output directory:        cd ../output/skeleton')
        print('Logfile:                       e xskeleton.log')
        print('List of species:               e species.dat')
        print('List of reactions:             e reactions.dat')
        print('List of rates:                 e rates.dat')
        print('Best replacement file:         e skeleton.rpl')
        print('Errors of skeletal mechanisms: e skeleton_*/skel_error.dat')
        print('Plots of errors:               acro delta_skel.pdf')
        print('Plots of target species:       acro targets.pdf')
        print('Plots of sample points:        acro samplepoint_*.pdf')
        print(HLINE)

    ##########################################################################

    @classmethod
    def exe(cls, inifile):
        cls.inifile = inifile
        if (not os.path.isdir(OUTPUTDIR)):
            os.mkdir(OUTPUTDIR)
        print(f'{HLINE2}\nxskeleton\n{HLINE2}\n')
        cls.read_skeletoninifile()
        eps = cls.eps0
        if (cls.samplepointfile):
            cls.cleanup()
        print(f'\n{HLINE2}\n***** Full mechanism *****\n{HLINE2}\n')
        cls.workdir, cls.workdir_short = cls.get_workdir(None)
        cls.create_skeleton_rpl(None)
        cls.caaba_multirun()
        cls.samplepointnames, cls.N_samplepoints = cls.get_samplepointnames()
        cls.calc_oic()
        cls.del_rxn = [False] * len(cls.StoichNum)
        cls.all_rates = cls.save_rates(cls.del_rxn)
        cls.skelnum = 1
        # list of all mechanisms (full mechanism means del_rxnlist[:]=True):
        cls.del_rxnlist = [cls.del_rxn]
        # list of all eps (full mech means eps=0):
        cls.epslist = [0]
        N_var = cls.N_var_full
        # delta_skel_all_list is a list of lists of lists containing the errors
        # of all current skeletal mechanisms compared to the full mechanism
        # for all sample points and for all targets:
        delta_skel_all_list = []
        while True: # loop over skeletal mechanisms for skelnum = 1, 2, 3, ...
            eps_last = eps
            cls.workdir, cls.workdir_short = cls.get_workdir(cls.skelnum)
            print('%s\n***** Skeletal mechanism %d *****\n%s\n' % (
                HLINE2, cls.skelnum, HLINE2))
            # Increase epsilon_ep to include less reactions:
            eps_too_small = True
            while eps_too_small:
                eps *= cls.eps_increase
                # Confirm that new mechanism contains less species:
                N_var_new = np.sum(cls.oicdata['f0']>eps) # f0=oic values, f1=species
                if (N_var_new < N_var):
                    print('Number of species reduced from %d to %d' % (N_var, N_var_new))
                    N_var = N_var_new
                    eps_too_small = False
                else:
                    print('Still %d species in mechanism with eps = %g.' % (N_var, eps))
            if (N_var_new == 0):
                sys.exit('ERROR: N_var=0')
            # Create skeletal mechanism excluding species with OIC < eps:
            cls.create_skeletal_mechanism(eps)
            cls.caaba_multirun()
            # maybe calc_oic() here again?
            delta_skel, delta_samplepoints = cls.analyze_results()
            delta_skel_all_list.append(delta_samplepoints)
            # Exit loop when error is too big:
            if (delta_skel > 1.):
                break
            cls.skelnum += 1
        print('\n%s\nEnd of skeletal mechanism testing loop\n%s' % (HLINE2, HLINE2))
        eps = eps_last
        # convert list of lists of lists to 3D numpy array:
        cls.delta_skel_all = np.asarray(delta_skel_all_list)
        cls.list_species(cls.epslist)
        cls.list_reactions(cls.del_rxnlist)
        # define directories of full and all skeletal mechanisms:
        cls.all_skel = ['fullmech']
        for skeldir in sorted(glob(OUTPUTDIR+'/skeleton_*')):
            cls.all_skel.append(os.path.basename(skeldir))
        # if there are too many skeletal mechanisms, show only the
        # last 4 and the full mechanism:
        if (len(cls.all_skel)>5):
            cls.all_skel = [cls.all_skel[i] for i in [0]+list(range(-4,0))]
        cls.make_target_plots(cls.plot_targets)
        cls.make_samplepoint_plots(cls.plot_samplepoints)
        cls.make_delta_skel_plots(cls.plot_delta_skel)
        cls.finalize(cls.delta_skel_all.shape)

##############################################################################

if __name__ == '__main__':

    LOGFILE = tee.stdout_start('xskeleton.log', append=False) # stdout
    args = evaluate_command_line_arguments()
    # type inifile with or without ini/ directory name and extension .ini:
    inifile = '%s/skeleton/ini/%s.ini' % (CAABADIR,
        os.path.splitext(os.path.basename(args.inifile))[0])

    xskeleton.exe(inifile)

    tee.stdout_stop()
    os.system('cp -p xskeleton.log %s/' % (OUTPUTDIR)) # copy logfile to OUTPUTDIR

##############################################################################
