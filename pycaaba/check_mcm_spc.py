#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-05 17:41:30 sander>

import sys
assert sys.version_info >= (3, 6)
import os
import re
from tabulate import tabulate
from rstools import HLINE, grep_i

CAABADIR = os.path.realpath(os.path.dirname(__file__)+'/..')
DEBUG = 0

##############################################################################

def sorted_composition(spc_composition):
    spc_composition = spc_composition.replace(' ','').split('+')
    spc_composition = '+'.join(sorted(spc_composition))
    return spc_composition
 
##############################################################################

def elemental_composition(spc_composition):
    import re
    elem_count = {} # define dictionary for elemental composition
    for v in g.vertices(): # loop over all species
        # create temporary dictionary with element count set to zero:
        tmp_dict = {'Ignore':0,'Pls':0,'Min':0,'O':0,'H':0,'N':0,'C':0,'F':0,
                    'Cl':0,'Br':0,'I':0,'S':0,'Hg':0,'Fe':0}
        # loop over all elements of current species:
        for element in g.vp.atoms[v].split('+'):
            # search for count and element symbol:
            search_result = re.search('([0-9]*)([A-Za-z]+)', element)
            if (search_result.group(1)==''):
                count = 1
            else:
                count = int(search_result.group(1))
            # update current element in temporary dictionary:
            tmp_dict[search_result.group(2)] = count
        # add elemental composition of current species to dictionary:
        elem_count[g.vp.name[v]] = tmp_dict
        if (DEBUG>1):
            print('%-15s %-15s' % (g.vp.name[v],g.vp.atoms[v]), end=' ')
            print(tmp_dict)
    # example usage: print(f'HCHO has {elem_count["HCHO"]["H"]} H atoms')
    return elem_count

##############################################################################

def main():
    # get elemental composition from *.spc file:
    SPCFILE = open(CAABADIR+'/mecca/gas.spc')
    NEWSPCFILE = open('/tmp/newgas.spc', 'w')
    for line_mecca in iter(SPCFILE):
        line_mecca = line_mecca.rstrip('\n')
        search_result = re.search('^ *([A-z0-9_]+) *=([A-z0-9+ ]+);', line_mecca)
        if (not search_result): # skip lines that do not define a species
            print(line_mecca, file=NEWSPCFILE)
            continue
        name_mecca = search_result.group(1)
        mecca_composition = sorted_composition(search_result.group(2))
        line_mcm = grep_i('^ *'+name_mecca+' ', CAABADIR+'/mecca/eqn/mcm/all.spc')
        if (line_mcm):
            search_result2 = re.search('=([A-z0-9+ ]+);.*{MCM: +(.*)}', line_mcm[0])
            mcm_composition = sorted_composition(search_result2.group(1))
            smiles = search_result2.group(2)
            if (DEBUG): print(f'name_mecca: {name_mecca:15}')
            if (mecca_composition != mcm_composition):
                print(f'ERROR: {name_mecca:12} gas.spc: {mecca_composition:18}' +
                      f'MCM: {mcm_composition}')
            if (DEBUG): print(f'smiles: {smiles}\n')
            if (not '{MCM' in line_mecca):
                print(f'ERROR: {name_mecca} is from MCM but MCM is not mentioned')
            # add smiles to comment:
            line_mecca = line_mecca.replace('{MCM: ','{SMI: "'+smiles+'" MCM: ')
            line_mecca = line_mecca.replace('MCM: }','MCM}')
            print(line_mecca, file=NEWSPCFILE)
        else:
            if (DEBUG): print(f'{name_mecca} is not in MCM')
            if ('{MCM' in line_mecca):
                print(f'ERROR: MCM is mentioned but {name_mecca} is not from MCM')
            print(line_mecca, file=NEWSPCFILE)
    SPCFILE.close()
    NEWSPCFILE.close()
    if (DEBUG):
        print()
        print(tabulate(composition_dict.items(), headers=['Species', 'Composition']))
        print()

##############################################################################

if __name__ == '__main__':

    main()

##############################################################################
