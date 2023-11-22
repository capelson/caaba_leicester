#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-10-27 11:59:59 sander>
# Rolf Sander, 2020

import os, sys
assert sys.version_info >= (3, 6)
import re
from glob import glob

def convert(basename):
    print(f'converting {basename}.bat...')
    inside_header = True
    with open(basename+'.bat', 'r') as infile, open('../../ini/'+basename+'.ini', 'w') as outfile:
        for line in infile:
            # write info about configparser instead of emacs tcsh mode:
            if ('-*- Shell-script -*-' in line):
                line = '# https://docs.python.org/3.6/library/configparser.html'
            # remove shell-specific comments:
            if ('The shell variables defined here will be used by xmecca' in line):
                line = '# Variables defined here are used by xmecca.py.'
            if ('when it is run in batch mode' in line):
                continue
            # add '[xmecca]' after header to start config section:
            if (inside_header):
                if ((not re.search('^\s*#',line)) and (not re.search('^\s*$',line))):
                    inside_header = False
                    print('[xmecca]', file=outfile)
            # add 'True' to lines without '=' sign:
            line = line.replace('set ignoremassbalance','ignoremassbalance = True')
            line = line.replace('set ignorecarboncount','ignorecarboncount = True')
            # delete leading and trailing whitespace:
            line = line.strip()
            # config file doesn't use double quotes for strings:
            line = line.replace('"','')
            # change boolean expression to python syntax:
            line = line.replace('&&','and').replace('||','or').replace('\!','not ')
            # remove tcsh command 'set':
            line = re.sub('^set ', '', line)
            print(line, file=outfile)
        
if __name__ == '__main__':

    # convert one batch file:
    #convert('mbl')
    convert('TAG/tmp_test')
    
    # convert all batch files:
    #for batfile in sorted(glob('**/*.bat', recursive=True)):
    #    convert(os.path.splitext(batfile)[0])
