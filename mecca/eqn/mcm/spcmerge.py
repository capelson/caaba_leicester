#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-05 23:05:04 sander>

# spcmerge.py: merge gas.spc with another *.spc file
# Authors: Rolf Sander, Sebastian Tauer, Hartwig Harder (MPI Mainz, 2017)

##############################################################################

import sys
assert sys.version_info >= (3, 6)
import re
from rstools import grep_i

#DEBUG = True
DEBUG = False

if __name__ == '__main__':

    if len(sys.argv)<=1:
        sys.exit('ERROR: Supply the name of an input *.spc file!')
    infilename = sys.argv[1]
    if len(sys.argv)<=2:
        sys.exit('ERROR: Supply the name of an output *.spc file!')
    outfilename = sys.argv[2]
    regexp = re.compile('^ *([A-z0-9_]+) *=')

    # put all species from gas.spc into the gasspcs array:
    GASSPCFILE = open('gas.spc')
    gasspc_data = GASSPCFILE.readlines()
    GASSPCFILE.close()
    gasspcs=[]
    for line in gasspc_data:
        result = regexp.search(line)
        if (DEBUG): print((result==False), line.strip())
        if result: # if not None
            if (DEBUG): print(result.group(1).upper())
            gasspcs.append(result.group(1).upper())
    if (DEBUG): print(gasspcs)
    # check all species in newspc:
    NEWSPCFILE = open(infilename)
    newspc_data = NEWSPCFILE.readlines()
    NEWSPCFILE.close()
    ADDNLFILE = open(outfilename,'w+')

    print('New species in %s:' % (infilename))
    for line in newspc_data:
        line=line.strip()
        result = regexp.search(line)
        if result: # if not None
            newspc = result.group(1)
            if (DEBUG): print('found spc : %s ' % newspc)
            if newspc.upper() not in gasspcs:
                print(newspc, end=' ')
                line_mcm = grep_i('^ *'+newspc+' ', 'all.spc')
                if (line_mcm):
                    print(line_mcm[0], file=ADDNLFILE)
                else:
                    print('(keeping IGNORE)', end=' ')
                    print(line, file=ADDNLFILE)
    print()
    ADDNLFILE.close()

##############################################################################
