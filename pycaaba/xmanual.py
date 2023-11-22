#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-11-08 18:52:36 sander>

'''
xmanual: eXecute LaTeX to create the CAABA/MECCA User Manual
Author: Rolf Sander, 2020-...
'''

import os, sys
assert sys.version_info >= (3, 6)
__target__ = os.readlink(__file__) if os.path.islink(__file__) else __file__
MANUALDIR = os.path.realpath(os.path.dirname(__target__)+'/../manual')
from rstools import runcmd

##############################################################################

def clean():
    suffixes = ('log', 'toc', 'lof', 'lot', 'dvi', 'aux', 'brf', 'blg',
                'ilg', 'ind', 'idx', 'vrb', 'snm', 'out', 'nav')
    for suffix in suffixes:
        tmpfile = 'caaba_mecca_manual.' + suffix
        if (os.path.isfile(tmpfile)):
            print(f'removing temporary file {tmpfile}')
            os.remove(tmpfile)

##############################################################################

def xmanual(cleanup=False):

    def run_pdflatex(filename):
        print('Running pdflatex {filename}...')
        output = runcmd(f'pdflatex -halt-on-error {filename}.tex', pipe=True)
        exitstatus = output.returncode
        if (exitstatus):
            print(output.stdout.rstrip('\n'))
            print(output.stderr.rstrip('\n'))
            sys.exit(exitstatus)

    olddir = os.getcwd()
    os.chdir(MANUALDIR)
    filename = 'caaba_mecca_manual'
    run_pdflatex(filename)        
    # BibTeX:
    print('Running bibtex...')
    os.system(f'bibtex {filename}')
    with open(filename+'.blg') as f:
        for line in f:
            if ("Warning--I didn't find a database entry" in line):
                sys.exit(1)
    run_pdflatex(filename)        
    # makeindex:
    os.system(f'makeindex {filename}.idx -s myindex.ist -c')
    run_pdflatex(filename)        
    run_pdflatex(filename)

    if cleanup:
        clean()

    os.chdir(olddir)

##############################################################################

if __name__ == '__main__':

    if (len(sys.argv)>1):
        if (sys.argv[1]=='--clean'):
            clean()
    else:
        xmanual()

##############################################################################
