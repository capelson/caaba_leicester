#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-18 13:23:59 sander>

# The python script check_eqns.py analyses the reactions present
# in a *.eqn file, assessing the conservation of the chemical elements
# as given in a *.spc file. Reactions found to be non-conserving are
# written to standard output along with a report of the elemental
# imbalance in each case.

# authors:
# based on original perl code from Tim Butler (2008)
# rewritten from scratch in python: Rolf Sander, Mainz (2018-2020)

# Usage:
#   - check_eqns.py is normally executed via xmecca

import sys, os
assert sys.version_info >= (3, 6)
import re
CAABADIR = os.path.realpath(os.path.dirname(__file__)+'/..')
sys.path.insert(1, os.path.realpath(CAABADIR+'/pycaaba'))

HLINE =  '-' * 78
DEBUG = False #True

##############################################################################

def num_var(chunk):
    # split a chunk into number and variable, e.g.: 0.7H2O2 -> 0.7, H2O2
    search_result = re.search('([0-9.]*)(.*)', chunk)
    number = search_result.group(1)
    if (number):
        number = float(number)
    else:
        number = float(1)
    variable = search_result.group(2).strip()
    return number, variable

##############################################################################

def get_elements_spc(spcfilename):

    elements = {} # create a dictionary
    if DEBUG: print(HLINE)
    SPCFILE = open(spcfilename, 'r', encoding='utf-8')
    for line in iter(SPCFILE): # loop over *.spc file
        line = line.strip() # remove leading and trailing whitespace
        search_result = re.search('^ *([A-z0-9_#]+) *=([A-z0-9+ #]+);', line)
        if (not search_result): # skip lines that do not define a species
            if DEBUG: print('NO:  |%s|' % (line))
            continue # proceed with next line in *.spc file
        if DEBUG: print(HLINE)
        species = search_result.group(1)
        elements[species] = {} # create a sub-dictionary for this species
        spc_composition = search_result.group(2).replace(' ','') # rm whitespace
        if DEBUG: print('|%s|' % (line))
        if DEBUG: print('|%s|' % (search_result.group()))
        if DEBUG: print('%20s =  ' % (species), end='')
        if DEBUG: print('|%s|' % (spc_composition))
        for chunk in spc_composition.split('+'): # split into atoms
            count, element = num_var(chunk) # separate stoichiometric factor
            if DEBUG: print('%g * %s + ' % (count, element))
            elements[species][element] = count # add element count to dictionary
    SPCFILE.close()
    if DEBUG: print(HLINE)
    if DEBUG: print(elements)
    return elements

##############################################################################

def analyze_eqn(elements, eqnfilename, neweqnfilename):
    
    NEWEQNFILE = open(neweqnfilename,'w', encoding='utf-8')
    exitstatus = 0
    eqntag_list = []
    EQNFILE = open(eqnfilename, 'r', encoding='utf-8')
    regexp = re.compile('^<(.*)>(.*)=(.*):(.*);(.*)$')
    for line0 in iter(EQNFILE): # loop over *.eqn file
        # find a label in current line:
        labels = re.findall('{%([^}]*)}', line0)
        # create a dictionary for mass balance:
        massbal = {}
        # check for tab characters:
        if ('\t' in line0):
            exitstatus = exitstatus | 0b0001000 # set 4th bit for TAB error
            print('ERROR: Illegal TAB character detected:')
            showtab = line0.replace('\t',r'\t')
            print(f'  {showtab}')
        # remove all {...} comments and final \n:
        line = re.sub('{[^}]*}','',line0).strip()
        reaction = regexp.search(line) # check if line contains a reaction
        if reaction:
            labels = labels[0] # convert singleton list to scalar
            element_set = set()
            eqntag = reaction.group(1).strip()        # e.g.: <G2111>
            reactants_str = reaction.group(2).strip() # e.g.: H2O + O1D
            products_str = reaction.group(3).strip()  # e.g.: 2 OH
            display_reaction = re.sub(
                ' +', ' ', f'<{eqntag}> {reactants_str} -> {products_str}')
            rate = reaction.group(4).strip()          # e.g.: 1.63E-10*EXP(60./temp)
            extra = reaction.group(5).strip()         # e.g.: // products assumed
            reactants = reactants_str.split('+')
            products  = products_str.split('+')
            all_species = reactants + products
            # ----------------------------------------------------------------
            if DEBUG: print('  eqntag:    <%s>' % (eqntag))
            nC = 0
            # analyze products first:
            if DEBUG: print('  products:  %s' % (products_str))
            for chunk in products:
                chunk = chunk.replace(' ','') # rm whitespace
                stoic, product = num_var(chunk) # separate stoichiometric factor
                if DEBUG: print('|%s| |%s| |%s|' % (stoic, product, elements[product]))
                nC_product = elements[product].get('C')
                if nC_product: nC = max(nC, int(nC_product))
                # add all atoms from current product to mass balance:
                for key, value in elements[product].items():
                    if (key=='Min'): # subtract negative charge from Pls
                        key = 'Pls'
                        value = -value
                    if key in massbal:
                        massbal[key] += stoic * value
                    else:
                        massbal[key] = stoic * value
            # based on the elements in the reaction, define the section where it should be:
            elem_sect = '0'
            if ('O'  in massbal): elem_sect =  '1'
            if ('H'  in massbal): elem_sect =  '2'
            if ('N'  in massbal): elem_sect =  '3'
            if ('C'  in massbal): elem_sect =  '4'
            if ('F'  in massbal): elem_sect =  '5'
            if ('Cl' in massbal): elem_sect =  '6'
            if ('Br' in massbal): elem_sect =  '7'
            if ('I'  in massbal): elem_sect =  '8'
            if ('S'  in massbal): elem_sect =  '9'
            if ('Hg' in massbal): elem_sect = '10'
            if ('Fe' in massbal): elem_sect = '11'
            if (eqntag.startswith('J0')): elem_sect = '0' # e* reactions
            # analyze reactants next:
            if DEBUG: print('  reactants: %s' % (reactants_str))
            for chunk in reactants:
                chunk = chunk.replace(' ','') # rm whitespace
                if (chunk=='hv'): continue # ignore pseudo-reactant hv
                stoic, reactant = num_var(chunk) # separate stoichiometric factor
                if DEBUG: print('|%s| |%s| |%s|' % (stoic, reactant, elements[reactant]))
                nC_reactant = elements[reactant].get('C')
                if nC_reactant: nC = max(nC, int(nC_reactant))
                # subtract all atoms from current reactant from mass balance:
                for key, value in list(elements[reactant].items()):
                    if (key=='Min'): # subtract negative charge from Pls
                        key = 'Pls'
                        value = -value
                    if key in massbal:
                        massbal[key] -= stoic * value
                    else:
                        massbal[key] = -stoic * value
            # write errorstring if mass balance is not correct:
            errorstring = ''
            for element, balance in sorted(massbal.items()):
                # activate the following lines to ignore specific elements:
                if (element.upper()=='IGNORE'): continue
                if (element=='H'):              continue
                if (element=='O'):              continue
                if (abs(balance)>1E-14):
                    errorstring = '%s %+g %s,' % (errorstring, balance, element)
            if (errorstring):
                exitstatus = exitstatus | 0b0000100 # set 3rd bit for mass balance error
                print(f'ERROR: Incorrect mass balance: {errorstring.rstrip(",")}')
                print(f'  {display_reaction}\n')
            if DEBUG: print('  rate:      %s' % (rate))
            if DEBUG: print('  extra:     %s' % (extra))
            # ----------------------------------------------------------------
            # check if reactions are in correct section:
            section = re.search('^[A-z]*([0-9]+)', eqntag).group(1) # number in eqntag
            if not section.startswith(elem_sect):
                exitstatus = exitstatus | 0b1000000 # set 7th bit for section error
                print(f'ERROR: Incorrect section: Reaction <{eqntag}> should ' +
                      f'be in section {elem_sect}:\n  {display_reaction}\n')
            # ----------------------------------------------------------------
            # check carboncount for reactions A4*, G4*, J4* and PH4*:
            if((eqntag[0:2]=='A4') or (eqntag[0:2]=='G4') or
               (eqntag[0:2]=='J4') or (eqntag[0:3]=='PH4')):
                if (eqntag[0:3]=='PH4'):
                    nC2 = int(eqntag[3:4]) # PH4* is one character longer than others
                else:
                    nC2 = int(eqntag[2:3])
                # 2nd digit of eqntag is 0 for >= 10 C atoms
                if ((nC2!=nC) and (nC2!=0 or nC<10)):
                    exitstatus = exitstatus | 0b0000010 # set 2nd bit for carboncount error
                    print('ERROR: Incorrect carbon count: The largest species in ' +
                          f'<{eqntag}> should have {nC2} C atoms, not {nC}:')
                    print(f'  {display_reaction}\n')
            # ----------------------------------------------------------------
            # add_element_labels:
            for species in all_species:
                # remove leading and trailing whitespace:
                species = species.strip()
                # remove stoichiometric factor:
                species = re.sub('^[0-9.]* *','',species)
                # remove hv:
                if (species=='hv'):
                    continue
                # find all elements in this species:
                for elem, value in elements[species].items():
                    if (elem=='C' and value==1):
                        continue                    
                    if elem in ['H', 'Pls', 'Min', 'IGNORE', 'O']:
                        continue                    
                    element_set.add(elem)
            elem_labels = ''
            labellist = re.findall('[A-Z][a-z0-9]*', labels)
            for elem in sorted(element_set):
                # check if element label was already in list of labels:
                if (elem in labellist):
                    exitstatus = exitstatus | 0b0000001 # set 1st bit for element label error
                    print('ERROR: Element labels are generated automatically, ' +
                          'do not insert them manually:')
                    print(f'  Remove {elem} in {labels} in the reaction')
                    print(f'  {display_reaction}\n')
                # concatenate all element labels from current reaction:
                elem_labels += elem
            newline = line0.replace('{%'+labels+'}','{%'+labels+elem_labels+'}')
            print(newline.rstrip(('\n')), file=NEWEQNFILE)
            # ----------------------------------------------------------------
            # check length of eqntag:
            if (len(eqntag)>27):
                exitstatus = exitstatus | 0b0010000 # set 5th bit for eqntag length error
                print('ERROR: Equation tag must not be longer than (about) 27 characters:')
                print(f'  <{eqntag}>\n')
            # ----------------------------------------------------------------
            # check for duplicate eqntags:
            if eqntag in eqntag_list:
                exitstatus = exitstatus | 0b0100000 # set 6th bit for duplicate eqntag error
                print('ERROR: Duplicate equation tag:')
                print(f'  <{eqntag}>\n')
            else:
                eqntag_list.append(eqntag)
            # ----------------------------------------------------------------
        else:
            # current line is not a reaction:
            print(line0.rstrip('\n'), file=NEWEQNFILE)
            if DEBUG: print('NO:  %s' % (line))
    EQNFILE.close()
    NEWEQNFILE.close()
    return exitstatus

##############################################################################

def check_eqns(spcfilename, eqnfilename, neweqnfilename):
    # get elemental composition from *.spc file:
    elements = get_elements_spc(spcfilename)
    # analyze *.eqn file:
    exitstatus = analyze_eqn(elements, eqnfilename, neweqnfilename)
    return exitstatus

##############################################################################

if __name__ == '__main__':

    if len(sys.argv) > 3:
        spcfilename    = sys.argv[1]
        eqnfilename    = sys.argv[2]
        neweqnfilename = sys.argv[3]
    else:
        sys.exit('ERROR: provide spcfilename, eqnfilename and neweqnfilename')
    if DEBUG: print(f'spcfile = {spcfilename}')
    if DEBUG: print(f'eqnfile = {eqnfilename}')
    exitstatus = check_eqns(spcfilename, eqnfilename, neweqnfilename)
    if DEBUG: print(f'exitstatus = {exitstatus}')
    sys.exit(exitstatus)

##############################################################################
