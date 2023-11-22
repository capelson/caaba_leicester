#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-11-08 21:44:10 sander>

# ncv.py = create a zip file of a New Caaba Version
# Rolf Sander, 2020

import os, sys, shutil
assert sys.version_info >= (3, 6)
__target__ = os.readlink(__file__) if os.path.islink(__file__) else __file__
CAABADIR = os.path.realpath(os.path.dirname(__target__)+'/..')
sys.path.insert(1, os.path.realpath(CAABADIR+'/pycaaba'))
from datetime import datetime
from glob import glob
import re
from xchemprop import xchemprop
from pyteetime import tee # from pycaaba
from rstools import HLINE, grep_i, runcmd # from pycaaba
from xmecca import xmecca

DONTEDIT = 'created automatically by ncv.py, DO NOT EDIT!'
HOME = os.environ['HOME']
USER = os.environ['USER']
LOGFILENAME = CAABADIR + '/ncv.log'
LOGFILE = tee.stdout_start(LOGFILENAME, append=False) # stdout

##############################################################################

current_version = re.sub(".*'(.*)'.*", r'\1',
    grep_i('modver *=', 'messy_mecca.f90')[0])

if (len(sys.argv) > 1):
    version = sys.argv[1]
else:
    print('\nInfo (before making a new version):')
    version = datetime.now().strftime('%Y%m%d_%H%M%S')
    print('- Add all changes and current date to CHANGELOG,')
    print(f'  update version number (modver = "{current_version}"):')
    print('\n  e CHANGELOG messy_mecca.f90')
    print('\n- Enter standard settings:')
    print('  - Makefile:         COMPILER = g95')
    print('                      F90FLAGS = with checks')
    print('\n- Run model and plot results with:')
    print('  ./xcaaba mbl')
    print('\nUsage:')
    print('  ncv nn')
    print('  (nn = version number)')
    print('Examples:')
    print(f'  snapshot with current date:    ./ncv {version}')
    print(f'  proper version number, e.g.:   ./ncv {current_version}\n')
    sys.exit()

if (not os.path.isfile('sfmakedepend')): 
    print('\nThe perl script sfmakedepend does not exist. Please run')
    print('configure to create it from sfmakedepend.pl.in:')
    print('  ( cd ../../.. ; ./configure ; cd - )')
    sys.exit(1)

dirname = f'caaba_{version}'
oridir  = f'{HOME}/messy/mecca/ori'
if (os.path.isdir(oridir)):
    zipfile = f'{oridir}/{dirname}.zip'
else:
    pathname = os.path.realpath(CAABADIR+'/..')
    zipfile = f'{pathname}/{dirname}.zip'
if (os.path.isfile(zipfile)): 
    print(f'Error: The zip file exists already:\n{zipfile}')
    sys.exit('Please choose another version number!')

##############################################################################

# check for changed internal links and update _internal_links.tcsh:
runcmd('_update_internal_links.tcsh', check=True)

##############################################################################

# chemprop:
inputstring = input('Update chemprop? [y/n/q, default=y]\n')
if (inputstring == 'q'): sys.exit()
if (not inputstring == 'n'):
    xchemprop()

##############################################################################

def findrefs(filename):
    result = ''
    with open(filename, 'r') as infile:
        for line in infile:
            #arr = re.search('{&+([^}]+)}', line) # allow anything
            arr = re.search('{&+([0-9]+)}', line) # allow only numbers
            if (arr):
                # transform comma-separated values to one number per line:
                result += re.sub('[, ]+', '\n', arr.group(1)) + '\n'
    return result

##############################################################################

# meccanism.pdf and user manual:
inputstring = input('\nUpdate meccanism.pdf and caaba_mecca_manual.pdf? [y/n/q, default=y]\n')
if (inputstring == 'q'): sys.exit()
if (not inputstring == 'n'):
    # select full mechanism:
    xmecca.exe(f'{CAABADIR}/mecca/ini/latex.ini')
    # run pdflatex to create meccanism.pdf:
    olddir = os.getcwd()
    os.chdir('mecca/latex')
    # create bib file:
    if (USER=='sander'):
        # run pdflatex:
        output = runcmd(f'pdflatex -halt-on-error meccanism.tex', pipe=True)
        exitstatus = output.returncode
        if (exitstatus):
            print(output.stdout.rstrip('\n'))
            print(output.stderr.rstrip('\n'))
            sys.exit(exitstatus)
        # extract references from meccanism.aux:
        runcmd(f'gawk -f citetags.awk meccanism.aux > citetags.log')
        with open('citetags.log', 'a') as citetagsfile:
            # add references from gas.eqn:
            citetagsfile.write(findrefs('../gas.eqn'))
            # add references from other mechanisms:
            for eqnfile in glob('../eqn/**/*.eqn', recursive=True):
                citetagsfile.write(findrefs(eqnfile))
            # add references from all *.rpl files:
            for rplfile in glob('../rpl/**/*.rpl', recursive=True):
                citetagsfile.write(findrefs(rplfile))
            # add references from aqueous.eqn:
            citetagsfile.write(findrefs('../aqueous.eqn'))
        # create *.bib file:
        runcmd(f'gawk -f citefind.awk citetags.log {HOME}/tex/bib/literat.bib > meccalit.bib')
    print(f'\n{HLINE}\n\nRunning xmeccanism\n')
    from xmeccanism import xmeccanism
    xmeccanism('meccanism')
    os.chdir(olddir)
    # move meccanism.pdf to manual/ directory, otherwise it would be
    # deleted by 'xmecca simple':
    os.rename('mecca/latex/meccanism.pdf', 'manual/meccanism.pdf')
    # user manual:
    with open('manual/mecca_info.tex', 'w') as infofile:
        print(f'% {DONTEDIT}', file=infofile)
        print(fr'\def\meccaversion{{{current_version}}}', file=infofile)
    print(f'\n{HLINE}\n\nRunning xmanual\n')
    from xmanual import xmanual
    xmanual()

##############################################################################

# select simple mechanism:
xmecca.exe(f'{CAABADIR}/mecca/ini/simple.ini')
if (os.path.isfile('caaba.nml')): os.remove('caaba.nml')
os.symlink('nml/caaba_simple.nml', 'caaba.nml')

##############################################################################

# create zip file:
print(f'\n{HLINE}\n\nCreating zip file\n{zipfile}')
inputstring = input('Continue? [y/n/q, default=y] ')
if ((inputstring == 'q') or (inputstring == 'n')): sys.exit()
# temporarily rename the caaba directory to include the version:
os.chdir('..')
os.rename(CAABADIR, dirname)
os.chdir(dirname)

# create zip file:
os.system('_zipcaaba.tcsh zip')

# rename the caaba directory back to its original name:
os.chdir('..')
os.rename(dirname, CAABADIR)
os.chdir(CAABADIR)

# move zip file to final directory:
os.rename(f'{dirname}.zip', zipfile)

print(f'\nThe zipfile has been created:\n{zipfile}\n\n{HLINE}')

tee.stdout_stop()
print(f'Log output is now available in {LOGFILENAME}')

##############################################################################
