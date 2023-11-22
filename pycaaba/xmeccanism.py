#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-10-25 18:18:20 sander>

# xmeccanism.py = eXecute LaTeX to create a pdf of the MECCA mechanism
# based on tcsh script xmeccanism

# Rolf Sander, 2020-...

##############################################################################

import os, sys
assert sys.version_info >= (3, 6)
from rstools import runcmd

def xmeccanism(filename):

    def run_pdflatex(filename):
        print(f'Running pdflatex {filename}...')
        output = runcmd(f'pdflatex -halt-on-error {filename}.tex', pipe=True)
        exitstatus = output.returncode
        if (exitstatus):
            print(output.stdout.rstrip('\n'))
            print(output.stderr.rstrip('\n'))
            sys.exit(exitstatus)

    run_pdflatex(f'{filename}')        
    # create *.bbl file:
    print('Running bibtex...')   ; os.system(f'bibtex {filename}')
    with open(filename+'.blg') as f:
        for line in f:
            if ("Warning--I didn't find a database entry" in line):
                sys.exit(1)
    run_pdflatex(f'{filename}')
    run_pdflatex(f'{filename}')
    run_pdflatex(f'{filename}')

##############################################################################

if __name__ == '__main__':

    if (len(sys.argv)>1):
        filename = sys.argv[1]
    else:
        filename = 'meccanism'
    xmeccanism(filename)

##############################################################################
