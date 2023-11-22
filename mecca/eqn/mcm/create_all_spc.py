#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-10-16 16:55:11 sander>

# create_all_spc.py: create all.spc file for all organic MCM species
# Authors: Rolf Sander (MPI Mainz, 2020)

##############################################################################

import sys
assert sys.version_info >= (3, 6)
import re
from rstools import runcmd

#DEBUG = True
DEBUG = False

def inchi2sumformula(inchi):
    cmd = 'echo "'+inchi+'" | obabel -iinchi -oreport | grep FORMULA'
    result = runcmd(cmd, pipe=True)
    return result.stdout.replace('FORMULA:','').strip()

def element_count(formula):
    if (DEBUG): print('FORMULA: ', formula)
    elem_count = {}
    items = re.findall('[A-Z][a-z]?\d*', formula)
    for item in items:
        result = re.search('([A-Z][a-z]?)(\d*)', item)
        element = result.group(1)
        if (result.group(2)):
            count   = int(result.group(2))
        else:
            count = 1
        if (DEBUG): print('  ', item, element, count, end=' ')
        if (element in elem_count):
            if (DEBUG): print('element already included')
            elem_count[element] += count
        else:
            if (DEBUG): print('new element')
            elem_count[element] = count
    if (DEBUG): print('  ', elem_count, '\n')
    return elem_count

def main():
    maxlen_mcmname = 0
    maxlen_elem_count = 0
    i = 0
    inside_header = True
    all_mass_file =  'all_mass.txt'
    with open(all_mass_file, 'r') as infile, open('all.spc', 'w') as outfile:
        for line in infile:
            if (inside_header):
                if line.startswith(' *****'):
                    inside_header = False
                continue
            line = line.strip()
            if line:
                i += 1 
                if ((DEBUG) and (i>10)): sys.exit() 
                mcmname, smiles, inchi, molarmass = line.split()
                print(f'{i:5}: {mcmname}')
                maxlen_mcmname = max(maxlen_mcmname, len(mcmname))
                if (DEBUG): print(mcmname, maxlen_mcmname)
                sumformula = inchi2sumformula(inchi)
                elem_count_dict = element_count(sumformula)
                elem_count_list = []
                for key, value in elem_count_dict.items():
                    if (value==1):
                        elem_count_list.append(f'  {key:2}')
                    else:
                        elem_count_list.append(f'{value:2}{key:2}')
                elem_count = ' + '.join(elem_count_list)
                maxlen_elem_count = max(maxlen_elem_count, len(elem_count))
                if (DEBUG): print('|'+elem_count+'|', maxlen_elem_count)
                latex_str = '{@' + mcmname + '}'
                print(f'{mcmname:12} = {elem_count:32} ; {latex_str:15} {{MCM: {smiles}}}',
                      file=outfile)
    print('longest elemental composition has', maxlen_elem_count, 'characters')
    print('longest MCM name has', maxlen_mcmname, 'characters')
                
##############################################################################

if __name__ == '__main__':
    main()

##############################################################################
