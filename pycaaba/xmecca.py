#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-11-08 20:49:38 sander>

'''
xmecca: eXecute MECCA
(based on tcsh script xmecca)
Author: Rolf Sander, 2020-...
'''

##############################################################################

import os, sys, shutil
assert sys.version_info >= (3, 6)
__target__ = os.readlink(__file__) if os.path.islink(__file__) else __file__
MECCADIR = os.path.realpath(os.path.dirname(__target__)+'/../mecca')
sys.path.insert(1, os.path.realpath(MECCADIR+'/../pycaaba'))
import regex as re # regexp
from datetime import datetime
from glob import glob
from pyteetime import tee # from pycaaba
from rstools import HLINE, HLINE2, cat, grep_i, runcmd, tail, fileselector, \
    evaluate_config_file # from pycaaba
import subprocess

##############################################################################

# INITIALIZATION:

HOME = os.environ['HOME']
HOST = os.environ['HOST']
USER = os.environ['USER']
DATE_NOW = datetime.now().strftime('%Y-%m-%d')
TIME_NOW = datetime.now().strftime('%H:%M:%S')
TIMESTAMP = 'xmecca was run on %s at %s by user %s on machine %s' % (
    DATE_NOW, TIME_NOW, USER, HOST)
DONTEDIT  = 'created automatically by xmecca, DO NOT EDIT!'

##############################################################################

def evaluate_command_line_arguments():

    import argparse
    parser = argparse.ArgumentParser(description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('inifile', nargs='?', default=None,
                        help='MECCA configuration file (*.ini)')
    parser.add_argument('mecnum', nargs='?', default=None,
                        help='MECCA number (only for polymecca)')
    args = parser.parse_args()
    return args

##############################################################################

class xmecca:

    # input files:
    gasspcfile        = 'gas.spc'
    aqueousspcfile    = 'aqueous.spc'
    defaultgaseqnfile = 'gas.eqn'
    aqueouseqnfile    = 'aqueous.eqn'
    gastblfile        = 'bm3d/process_gas.tbl'
    aqueoustblfile    = 'bm3d/process_aqueous.tbl'
    # temporary files:
    diagtractblfile  = 'tmp_diagtrac.tbl'
    rxnratestblfile  = 'tmp_rxnrates.tbl'
    # do not change the name of the parameter file because 'tmp_param' is
    # also used by messy/tools/kp4/bin/kp4.tcsh:
    paramfile  = 'tmp_param'
    # ferret jnl files:
    jnlfile1 = '../jnl/_rxnrates.jnl'
    jnlfile2 = '../jnl/_rxnrates_scaled.jnl'
    # matplotlib files:
    rxnfile1 = '../pycaaba/_rxnrates.py'
    rxnfile2 = '../pycaaba/_rxnrates_scaled.py'

    ##########################################################################

    @staticmethod
    def get_tmp_name(suffix):
        return 'tmp_' + datetime.now().strftime('%Y%m%d%H%M%S%f') + suffix

    ##########################################################################

    @classmethod
    def define_bm3d(cls):

        # for 3d, make KPP and KP4 executables available first:
        # cp kpp.exe MESSY3D/messy/mbm/caaba/mecca/kpp/bin
        # cd MESSY3D/messy/tools/kp4/src
        # gmake
        # cp kp4.exe MESSY3D/bin/ 
        if (os.path.isdir(os.path.join(MECCADIR,'../../../smil'))):
            print('\nThe directory ../../smil has been found and it is now assumed that')
            print('MECCA is part of an 3D-BM/MESSy system. xmecca will also create the')
            print('files necessary for running global MECCA chemistry with 3D-BM/MESSy.')
            cls.bm3d = True
        else:
            cls.bm3d = False

    ##########################################################################

    @classmethod
    def read_inifile(cls):

        cls.inifile_short = cls.inifile.replace(MECCADIR+'/ini/','')
        print(f'\n{HLINE}\n\nReading MECCA config (*.ini) file: {cls.inifile_short}\n')
        try:
            ini_xmecca = evaluate_config_file(cls.inifile, 'xmecca')
        except:
            sys.exit('ERROR: You did not select a valid *.ini file.')
        print(f'Contents of config file {cls.inifile_short}:')
        for key in ini_xmecca:
            print(f'{key:20}= {ini_xmecca[key]}')
        cls.apn                = int(ini_xmecca.get('apn', '0'))
        cls.decomp             = ini_xmecca.get('decomp')
        cls.deltmp             = ini_xmecca.get('deltmp')
        cls.diagtracfile       = ini_xmecca.get('diagtracfile')
        cls.enthalpy           = ini_xmecca.get('enthalpy')
        cls.gaseqnfile         = ini_xmecca.get('gaseqnfile')
        cls.graphviz           = ini_xmecca.get('graphviz')
        cls.ignorecarboncount  = ini_xmecca.get('ignorecarboncount')
        cls.ignoremassbalance  = ini_xmecca.get('ignoremassbalance')
        cls.ignoresectionerror = ini_xmecca.get('ignoresectionerror')
        cls.integr             = ini_xmecca.get('integr')
        cls.kppoption          = ini_xmecca.get('kppoption')
        cls.latex              = ini_xmecca.get('latex')
        cls.mcfct              = ini_xmecca.get('mcfct')
        cls.rplfile            = ini_xmecca.get('rplfile')
        cls.rxnrates           = ini_xmecca.get('rxnrates')
        cls.setfixlist         = ini_xmecca.get('setfixlist')
        cls.submodel           = ini_xmecca.get('submodel')
        cls.tag                = ini_xmecca.get('tag')
        cls.tagcfg             = ini_xmecca.get('tagcfg')
        cls.wanted             = ini_xmecca.get('wanted')
        if (cls.bm3d):
            cls.deltmpkp4      = ini_xmecca.get('deltmpkp4')
            cls.vlen           = ini_xmecca.get('vlen')

    ##########################################################################

    @classmethod
    def define_submodel(cls):

        print(f'\n{HLINE}')
        # If submodel was defined, check that it is okay:
        # allow scav here as well?
        #if ((cls.submodel) and (cls.submodel != 'mtchem') and (cls.submodel != 'scav')):
        if ((cls.submodel) and (cls.submodel != 'mtchem')):
            sys.exit(f'\nERROR: submodel = {cls.submodel} is not a valid option.')

        # If xmecca was started via xpolymecca, define the submodel name
        # based on the mechanism number (mecnum) in mecnum:
        if (cls.mecnum):
            # test if $mecnum is a 3-digit number:
            if (re.search('^[0-9][0-9][0-9]$', cls.mecnum)):
                cls.submodel = 'mecca' + cls.mecnum
            else:
                sys.exit(f'\nERROR: Mechanism number (mecnum={cls.mecnum}) ' +
                         'must be a 3-digit number.')
        else:
            if (cls.bm3d):
                runcmd('bm3d/del_meccaNNN.tcsh', check=True, env={'DONTEDIT':DONTEDIT})
            # Create messy_mecca_poly_si.f90. If xmecca WAS NOT started via
            # xpolymecca, this is the correct file. If xmecca WAS started via
            # xpolymecca, then it will be overwritten by xpolymecca later.
            shutil.copy('template_messy_mecca_poly_si.f90', 'messy_mecca_poly_si.f90')

        # At this point, the variable submodel was either created based on
        # mecnum (via xpolymecca, see above), or it has been read from the
        # batch file, or it is still undefined. In the latter case, use the
        # default value 'mecca':
        if (cls.submodel):
            if (cls.bm3d):
                os.system(f'sed "s/mecca./{cls.submodel}./g" messy_mecca_kpp.kpp > ' +
                          f'messy_{cls.submodel}_kpp.kpp')
            else:
                sys.exit('ERROR: For CAABA, "submodel" must be undefined.')
        else:
            cls.submodel = 'mecca'
        print(f'\nSubmodel = {cls.submodel}')
        # input for KPP (selected reactions only):
        cls.spcfile  = cls.submodel + '.spc'
        cls.eqnfile  = cls.submodel + '.eqn'

    ##########################################################################

    @classmethod
    def apply_rplfile(cls, rplfile_fullname, eqn_out):

        # read gaseqnfile, apply rplfile_fullname, and write result to eqn_out

        # STEP 1: evaluate '#include' preprocessor commands in rplfile_fullname
        # (currently, nesting of include files is not possible):
        tmp_rpl = cls.get_tmp_name('.rpl')
        tmp_eqn = cls.get_tmp_name('.eqn')
        print(f'\nApplying  replacement (*.rpl) file {rplfile_fullname}...')
        with open(rplfile_fullname, 'r') as infile, open(tmp_rpl, 'w') as outfile:
            for line in infile:
                arr = re.search('^#include\s+(\S*)', line)
                if (arr):
                    # include a file:
                    incfile = 'rpl/include/' + os.path.splitext(arr.group(1))[0] + '.rpl'
                    if (os.path.isfile(incfile)):
                        print(f'Including replacement (*.rpl) file {incfile}...')
                        print(f'// Start of included file {incfile}', file=outfile)
                        with open(incfile) as f_inc:
                            outfile.write(f_inc.read())
                        print(f'// End of included file {incfile}', file=outfile)
                    else:
                        sys.exit(f'ERROR: Cannot find include file {incfile}')
                else:
                    outfile.write(line)
        # STEP 2: make replacements:
        shutil.copy(cls.gaseqnfile, eqn_out)
        with open(tmp_rpl, 'r') as infile:
            for line in infile:
                arr = re.search('^#REPLACE\s*<([A-Za-z0-9_]*[*]?)>', line)
                if (arr):
                    # #REPLACE command was found and the eqntag, i.e. the
                    # '([A-Za-z0-9]*[*]?)' part of the above regexp, is stored in arr.
                    eqntag = arr.group(1)
                    line = next(infile) # read next line
                    replacementexists = False
                    # put all eqns from current #REPLACE...#ENDREPLACE block into neweqns:
                    neweqns = ''
                    while (not re.search('^#ENDREPLACE', line)): # loop until #ENDREPLACE
                        replacementexists = True
                        if ('*' in eqntag): # leave eqntag unchanged for wildcards:
                            neweqns += line
                        else: # prepend main eqntag into angle brackets:
                            neweqns += re.sub('<([A-Za-z0-9_]*)>', '<'+eqntag+r'\1>', line)
                        line = next(infile) # read next line
                    if (eqntag):
                        if (replacementexists):
                            print(f'Replacing reaction {eqntag}...')
                        else:
                            print(f'Deleting reaction {eqntag}...')
                        # insert the new equations into the eqn file:
                        eqntag_found = False
                        eqntag = eqntag.replace('*', '[^>]*') # change wildcard '*' to regexp
                        with open(eqn_out, 'r') as infile2, open(tmp_eqn, 'w') as f_rpl0:
                            for line in infile2:
                                if (re.search(f'^\s*<{eqntag}>', line)):
                                    if (not eqntag_found):
                                        f_rpl0.write(neweqns)
                                        eqntag_found = True
                                else:
                                    f_rpl0.write(line)
                        if (not eqntag_found):
                            sys.exit(f'Eqntag <{eqntag}> not found')
                        shutil.copy(tmp_eqn, eqn_out)
                    else:
                        print('Adding new reaction(s)...')
                        with open(eqn_out, 'a') as f_out:
                            f_out.write(neweqns)
                else:
                    # #REPLACE command was not found. Empty lines and
                    # comments starting with '//' are okay, otherwise print
                    # an error message:
                    if ((not re.search('^\s*$', line)) and (not re.search('^//', line))):
                        sys.exit(f'ERROR in *.rpl file:\n{line}\n')

    ##########################################################################

    @classmethod
    def spc2jnl(cls, jnlfile):

        def intersperse(matchobj):
            # matchobj.group(1) = '_' or '^'
            # matchobj.group(2) = integer with two or more digits
            return ''.join([matchobj.group(1)+char for char in matchobj.group(2)])

        tmp_spc = cls.get_tmp_name('.spc')
        with open(tmp_spc, 'w') as outfile:
            with open(cls.gasspcfile) as infile:
                outfile.write(infile.read())
            with open(cls.aqueousspcfile) as infile:
                outfile.write(infile.read())
        print(f'Creating {jnlfile} for ferret from {cls.gasspcfile} and {cls.aqueousspcfile}...')
        with open(tmp_spc, 'r') as infile, open(jnlfile, 'w') as outfile:
            print('! ' + DONTEDIT, file=outfile)
            for line in infile:
                # store name for the species like {@H_2SO_4} in texname:
                search_result = re.search('{@([^}]*)}', line)
                if (search_result):
                    texname = search_result.group(1)
                else:
                    texname = ''
                # convert long sub/superscripts like '_<abc>' into '_a_b_c':
                texname = re.sub('([_^])<([^>]+)>', intersperse, texname)
                # aqueous-phase suffix:
                texname = texname.replace('(a##)', '($ax)')
                # delete all comments {...}:
                line = re.sub('{[^}]*}', '', line)
                # is current line a line with a species definition?
                search_result = re.search('^[ \t]*([A-Za-z][A-Za-z0-9_#]*)[ \t]*=.*;', line)
                if (search_result):
                    kppname = search_result.group(1)
                    kppname = kppname.replace('_a##', '_($ax)')
                    if (texname==''):
                        print(f'WARNING: species {kppname} has no tex name')
                        texname = kppname
                    if (kppname=='I'):
                        kppname = 'Iod' # 'I' cannot be used in ferret as a variable name
                    # define hfill for vertical alignment:
                    print('LET/D %-15s = 0 ; DEF SYMBOL %-15s = %s' % (
                        kppname, kppname, texname), file=outfile)

    ##########################################################################

    @classmethod
    def spc2mpl(cls, mplfile):

        print(f'Creating {mplfile} for matplotlib from {cls.spcfile}...')
        spclist = []
        with open(cls.spcfile, 'r') as infile, open(mplfile, 'w') as outfile:
            print('# ' + DONTEDIT + '\ndef spc_names():\n    return {', file=outfile)
            for line in infile:
                # store name for the species like {@H_2SO_4} in texname:
                search_result = re.search('{@([^}]*)}', line)
                if (search_result):
                    texname = "'" + search_result.group(1) + "'"
                else:
                    texname = ''
                # convert long sub/superscripts like '_<10>' into '_{10}':
                texname = re.sub('([_^])<([^>]+)>', r'\1{\2}', texname)
                # convert \FormatAq<SPECIES><##> to SPECIES(a##):
                texname = re.sub('\\\\FormatAq<([^>]+)><([^>]+)>', r'\1(a\2)', texname)
                # delete all comments {...}:
                line = re.sub('{[^}]*}', '', line)
                # is current line a line with a species definition?
                search_result = re.search('^[ \t]*([A-Za-z][A-Za-z0-9_#]*)[ \t]*=.*;', line)
                if (search_result):
                    kppname = "'" + search_result.group(1) + "'"
                    if (texname==''):
                        print(f'WARNING: species {kppname} has no tex name')
                        texname = kppname
                    # define hfill for vertical alignment:
                    spclist.append('        %-22s: r%s' % (kppname, texname))
            print(',\n'.join(spclist) + '}', file=outfile)

    ##########################################################################

    @classmethod
    def check_eqns(cls, eqn_in, eqn_out, DEBUG=False):

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

        # get elemental composition from *.spc file:
        elements = {} # create a dictionary
        if DEBUG: print(HLINE)
        SPCFILE = open(cls.spcfile, 'r', encoding='utf-8')
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

        # analyze *.eqn file:
        NEWEQNFILE = open(eqn_out,'w', encoding='utf-8')
        exitstatus = 0
        eqntag_list = []
        EQNFILE = open(eqn_in, 'r', encoding='utf-8')
        regexp = re.compile('^<(.*)>(.*)=([^:]*):([^;]*);(.*)$')
        for line0 in iter(EQNFILE): # loop over *.eqn file
            # find a label in current line:
            labels = re.findall('{%([^}]*)}', line0)
            # create a dictionary for mass balance:
            massbal = {}
            # check for tab characters:
            if ('\t' in line0):
                exitstatus = exitstatus | 0b0001000 # set 4th bit (TAB error)
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
                # based on the elements in the reaction,
                # define the section where it should be:
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
                    exitstatus = exitstatus | 0b0000100 # set 3rd bit (mass balance error)
                    print(f'ERROR: Incorrect mass balance: {errorstring.rstrip(",")}')
                    print(f'  {display_reaction}\n')
                if DEBUG: print('  rate:      %s' % (rate))
                if DEBUG: print('  extra:     %s' % (extra))
                # ----------------------------------------------------------------
                # check if reactions are in correct section:
                section = re.search('^[A-z]*([0-9]+)', eqntag).group(1) # number in eqntag
                if not section.startswith(elem_sect):
                    exitstatus = exitstatus | 0b1000000 # set 7th bit (section error)
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
                        exitstatus = exitstatus | 0b0000010 # set 2nd bit (carboncount error)
                        print('ERROR: Incorrect carbon count: The largest species in ' +
                              f'<{eqntag}> should have {nC2} C atoms, not {nC}:')
                        print(f'  {display_reaction}\n')
                # ----------------------------------------------------------------
                # add elementlabels:
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
                    # check if elementlabel was already in list of labels:
                    if (elem in labellist):
                        exitstatus = exitstatus | 0b0000001 # set 1st bit (elementlabel error)
                        print('ERROR: Element labels are generated automatically, ' +
                              'do not insert them manually:')
                        print(f'  Remove {elem} in {labels} in the reaction')
                        print(f'  {display_reaction}\n')
                    # concatenate all elementlabels from current reaction:
                    elem_labels += elem
                newline = line0.replace('{%'+labels+'}','{%'+labels+elem_labels+'}')
                print(newline.rstrip(('\n')), file=NEWEQNFILE)
                # ----------------------------------------------------------------
                # check length of eqntag:
                if (len(eqntag)>27):
                    exitstatus = exitstatus | 0b0010000 # set 5th bit (eqntag length error)
                    print('ERROR: Eqntag must not be longer than (about) 27 characters:')
                    print(f'  <{eqntag}>\n')
                # ----------------------------------------------------------------
                # check for duplicate eqntags:
                if eqntag in eqntag_list:
                    exitstatus = exitstatus | 0b0100000 # set 6th bit (duplicate eqntag error)
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

    ##########################################################################

    @classmethod
    def select_wanted(cls, eqn_in):

        def locate(label):
            # True if a label (component of a marker) is found in current line:
            return bool(re.search('{%[A-Za-z0-9]*'+label+'(}|[^a-z][A-Za-z0-9]*})', line))

        print(f'\n{HLINE}\n\nSelecting reactions as specified in "wanted"...\n')
        logfile = open('wanted.log', 'w')
        print(cls.wanted)
        print(f'\nThe wanted string is copied to messy_{cls.submodel}_kpp_global.f90,')
        print('full details of the selection are in the logfile.')
        REQ_HET     = '.FALSE.'
        REQ_PHOTRAT = '.FALSE.'
        REQ_AEROSOL = '.FALSE.'
        empty_mechanism = True
        with open(eqn_in, 'r') as infile, open(cls.eqnfile, 'w') as outfile:
            for line in infile:
                # is there a {%...} marker in the current line?
                marker = bool(re.search('{%[A-Za-z0-9]*}', line))
                # is current line a reaction?
                reaction = bool(re.search('=.+:.+;', line))
                if (reaction): empty_mechanism = False
                # altitude:
                Tr  = locate('Tr')
                St  = locate('St')
                Up  = locate('Up')
                # phase:
                G   = locate('G')
                Aa  = locate('Aa')
                Ara = locate('Ara')
                Het = locate('Het')
                # elements:
                N   = locate('N')
                C   = locate('C')
                F   = locate('F')
                Cl  = locate('Cl')
                Br  = locate('Br')
                I   = locate('I')
                S   = locate('S')
                Hg  = locate('Hg')
                Fe  = locate('Fe')
                # other:
                Aro = locate('Aro')
                J   = locate('J')
                Mbl = locate('Mbl')
                Sc  = locate('Sc')
                Scm = locate('Scm')
                Ter = locate('Ter')
                # evaluate wanted for current reaction:
                l_wanted = eval(cls.wanted)
                # info for logfile:
                print(f'\n{line.rstrip()}',                               file=logfile)
                print(f'marker:   {marker}',                              file=logfile)
                if (marker):
                    print(f'altitude: Tr={Tr} St={St} Up={Up}',           file=logfile)
                    print(f'phase:    G={G} Aa={Aa} Ara={Ara} Het={Het}', file=logfile)
                    print(f'elements: N={N} C={C} F={F} Cl={Cl} Br={Br} I={I} ' +
                          f'S={S} Hg={Hg} Fe={Fe}',                       file=logfile)
                    print(f'other:    Aro={Aro} J={J} Mbl={Mbl} Sc={Sc} Scm={Scm} Ter={Ter}',
                                                                          file=logfile)
                    print(f'wanted:   {l_wanted}',                        file=logfile)
                # select current line?
                if ((not marker) or (l_wanted)):
                    outfile.write(line)
                # set requirements:
                if (Het and l_wanted): REQ_HET     = '.TRUE.'
                if (J   and l_wanted): REQ_PHOTRAT = '.TRUE.'
                if (Aa  and l_wanted): REQ_AEROSOL = '.TRUE.'
                # print warnings, if necessary:
                if (not Tr and not St and not Up and reaction):
                    print(f'WARNING: No height range (Tr,St,Up) specified for:\n{line}')
                if (not G and not Aa and not Ara and not Het and reaction):
                    print(f'WARNING: No phase (G,Aa##,Ara,Het) specified for:\n{line}')
                if (sum([G,Aa,Ara,Het])>1):
                    print(f'WARNING: Specify only one phase (G,Aa##,Ara,Het) for:\n{line}')
            print(f'\nREQ_HET     = {REQ_HET}',                           file=logfile)
            print(f'REQ_PHOTRAT = {REQ_PHOTRAT}',                         file=logfile)
            print(f'REQ_AEROSOL = {REQ_AEROSOL}',                         file=logfile)
            print(f'#INLINE F90_GLOBAL',                                  file=outfile)
            print(f'  ! from xmecca:',                                    file=outfile)
            print(f'  LOGICAL, PARAMETER :: REQ_HET     = {REQ_HET}',     file=outfile)
            print(f'  LOGICAL, PARAMETER :: REQ_PHOTRAT = {REQ_PHOTRAT}', file=outfile)
            print(f'  LOGICAL, PARAMETER :: REQ_AEROSOL = {REQ_AEROSOL}', file=outfile)
            print(f'#ENDINLINE {{above lines go to messy_{cls.submodel}_kpp_global}}',
                                                                          file=outfile)
        if (empty_mechanism):
            sys.exit('\nERROR: Your selection created an empty mechanism.')
        logfile.close()

    ##########################################################################

    @classmethod
    def rxnrates_awk(cls):

        print(f'Creating {cls.jnlfile1} and {cls.jnlfile2} for ferret from {cls.eqnfile}...')
        # analyze one side of the equation:
        def analyze(prodloss, oneside, eqntag, equation):
            # split oneside into individual terms:
            arr3 = oneside.split('+')
            for term in arr3:
                # add space between factor and species:
                term = re.sub('^[0-9.]+', '& ', term).strip()
                # check if there is already a factor:
                if (re.search('^[A-z]', term)):
                    # add factor '1':
                    term = re.sub('^', '1 ', term)
                # split term into factor and species:
                arr2 = term.split()
                factor  = arr2[0].strip()
                species = arr2[1].strip()
                if (prodloss=='loss'):
                    factor = '-' + factor
                else:
                    factor = '+' + factor
                # print budget unless species is a 'RR*' dummy variable:
                if (not re.search('^RR', species)):
                    print(f'LET/UNITS="mol/mol/s" rate = ({factor}) * RR{eqntag} ; GO ' +
                          f'_plot_rxnrates_scaled rate "{factor}*{eqntag}: {loss}" ' +
                          f'"{species}"', file=out_2)

        with open(cls.eqnfile, 'r') as infile, \
             open(cls.jnlfile1, 'w') as out_1, open(cls.jnlfile2, 'w') as out_2:
            print(f'! {DONTEDIT}', file=out_1)
            print(f'! {DONTEDIT}', file=out_2)
            errorstring = ''
            for line in infile:
                # delete all comments {...} from $0:
                line = re.sub('^//.*}', '', line)
                # store eqntag like G3102b or A8703_a## in eqntag:
                arr = re.search('<([A-z_0-9#]+)>', line)
                if (arr):
                    eqntag = arr.group(1)
                else:
                    eqntag = ''
                # does current line contain a chemical equation, i.e. something like
                # ' = ... : ... ; ' ?
                if (re.search('=.*:.*;', line)):
                    # check if eqntag exists
                    if (not eqntag):
                        errorstring += f'ERROR: This reaction has no eqntag:\n  {line}\n'
                    # delete all comments {...} from line:
                    line = re.sub('{[^}]*}', '', line)
                    # delete eqntag from line:
                    line = re.sub(f'<{eqntag}>', '', line)
                    # delete rate constant from line:
                    line = re.sub(':.*', '', line)
                    # reduce multiple spaces to one:
                    line = re.sub('  +', ' ', line)
                    # remove leading spaces:
                    line = re.sub('^ +', '', line)
                    # remove trailing spaces:
                    line = re.sub(' +$', '', line)
                    # split into loss and prod:
                    arr = line.split('=')
                    loss = arr[0].strip()
                    prod = arr[1].strip()
                    analyze('loss', loss, eqntag, line)
                    analyze('prod', prod, eqntag, line)
                    print(f'go _plot_rxnrates RR{eqntag} "{eqntag}: {loss}"', file=out_1)

        if (errorstring!=''):
            sys.exit(errorstring)

    ##########################################################################

    @classmethod
    def rxn2mpl(cls):

        print(f'Creating {cls.rxnfile1} and {cls.rxnfile2} for matplotlib ' +
              f'from {cls.eqnfile}...')
        # analyze one side of the equation:
        def analyze(prodloss, oneside, eqntag, equation):
            # split oneside into individual terms:
            arr3 = oneside.split('+')
            for term in arr3:
                # add space between factor and species:
                term = re.sub('^[0-9.]+', '& ', term).strip()
                # check if there is already a factor:
                if (re.search('^[A-z]', term)):
                    # add factor '1':
                    term = re.sub('^', '1 ', term)
                # split term into factor and species:
                arr2 = term.split()
                factor  = arr2[0].strip()
                species = arr2[1].strip()
                if (prodloss=='loss'):
                    factor = '-' + factor
                else:
                    factor = '+' + factor
                # print budget unless species is a 'RR*' dummy variable:
                if (not re.search('^RR', species)):
                    # define hfill for vertical alignment:
                    print("rxns.append((%-11s %-17s %-18s '%s'))" % (
                        factor+',', "'"+eqntag+"',", "'"+species+"',", loss), file=out_2)

        with open(cls.eqnfile, 'r') as infile, \
             open(cls.rxnfile1, 'w') as out_1, open(cls.rxnfile2, 'w') as out_2:
            print(f'# {DONTEDIT}',    file=out_1)
            print('def eqn_names():', file=out_1)
            print('    return {',     file=out_1)
            print(f'# {DONTEDIT}',    file=out_2)
            print('rxns = []',        file=out_2)
            errorstring = ''
            for line in infile:
                # delete all comments {...} from line:
                line = re.sub('^//.*}', '', line)
                # store eqntag like G3102b or A8703_a## in eqntag:
                arr = re.search('<([A-z_0-9#]+)>', line)
                if (arr):
                    eqntag = arr.group(1)
                else:
                    eqntag = ''
                # does current line contain a chemical equation, i.e. something like
                # ' = ... : ... ; ' ?
                if (re.search('=.*:.*;', line)):
                    # check if eqntag exists
                    if (not eqntag):
                        errorstring += 'ERROR: This reaction has no eqntag:\n  {line}\n'
                    # delete all comments {...} from line:
                    line = re.sub('{[^}]*}', '', line)
                    # delete eqntag from line:
                    line = re.sub(f'<{eqntag}>', '', line)
                    # delete rate constant from line:
                    line = re.sub(':.*', '', line)
                    # reduce multiple spaces to one:
                    line = re.sub('  +', ' ', line)
                    # remove leading spaces:
                    line = re.sub('^ +', '', line)
                    # remove trailing spaces:
                    line = re.sub(' +$', '', line)
                    # split into loss and prod:
                    arr = line.split('=')
                    loss = arr[0].strip()
                    prod = arr[1].strip()
                    analyze('loss', loss, eqntag, line)
                    analyze('prod', prod, eqntag, line)
                    quoted_eqntag = "'" + eqntag + "'"
                    print(f"        {quoted_eqntag:17}: '{loss}',", file=out_1)
            # dummy must be added because previous line ends with ',':
            print("        'Dummy'          : 'Dummy'}", file=out_1)
        if (errorstring):
            sys.exit(errorstring)

    ##########################################################################

    @classmethod
    def spc2tex(cls):

        warningstring = ''
        texfile = cls.spcfile.replace('.','_') + '.tex' # output file
        with open(f'../{cls.spcfile}', 'r') as infile, open(texfile, 'w') as outfile:
            print(f'% {DONTEDIT}',  file=outfile)
            print(r'\makeatletter', file=outfile)
            print(r'\def\defkpp#1#2{\expandafter\def\csname #1\endcsname{\chem{#2}}}%',
                  file=outfile)
            print(r'\def\kpp#1{\@ifundefined{#1}' +
                  r'{\errmessage{#1 undefined}}{\csname #1\endcsname}}%',
                  file=outfile)
            # KPP dummy species hv and PROD:
            print(r'\defkpp{hv}{h\nu}%', file=outfile)
            print(r'\defkpp{PROD}{products}%', file=outfile)
            for line in infile:
                # store LaTeX text for the species like {@H_2SO_4} in latexname:
                arr = re.search('{@([^}]*)}', line)
                if (arr):
                    latexname = arr.group(1).replace('<','{').replace('>','}')
                else:
                    latexname = ''
                # delete all comments {...} from line:
                line = re.sub('{[^}]*}', '', line)
                # is current line a line with a species definition?
                arr = re.search('^[ \t]*([A-z][A-z0-9_]*)[ \t]*=.*;', line)
                if (arr):
                    kppname = arr.group(1)
                    if (not latexname):
                        warningstring += f'WARNING: species {kppname} has no LaTeX name\n'
                        latexname = kppname
                    # write a line into the LaTeX table:
                    print(fr'\defkpp{{{kppname}}}{{{latexname}}}%', file=outfile)
            print(r'\makeatother', file=outfile)
        if(warningstring):
            print(warningstring)

    ##########################################################################

    @classmethod
    def eqn2tex(cls):

        def open_texfiles(rxntype):
            # open output files:
            tablefile = open(basename+f'_{rxntype}.tex',       'w')
            notesfile = open(basename+f'_{rxntype}_notes.tex', 'w')
            # write header line:
            print(f'% {DONTEDIT}', file=tablefile)
            print(f'% {DONTEDIT}', file=notesfile)
            return tablefile, notesfile, ''

        logfile = open('eqn2tex.log', 'w')
        # open output files:
        basename = cls.eqnfile.replace('.','_')
        afile,   anotesfile,   rowcol_a   = open_texfiles('a')
        eqfile,  eqnotesfile,  rowcol_eq  = open_texfiles('eq')
        gfile,   gnotesfile,   rowcol_g   = open_texfiles('g')
        hetfile, hetnotesfile, rowcol_het = open_texfiles('het')
        hfile,   hnotesfile,   rowcol_h   = open_texfiles('h')
        iexfile, iexnotesfile, rowcol_iex = open_texfiles('iex')
        jfile,   jnotesfile,   rowcol_j   = open_texfiles('j')
        phfile,  phnotesfile,  rowcol_ph  = open_texfiles('ph')
        # initialize some strings:
        errorstring = ''
        graycol    = r'\rowcolor[gray]{0.95}'

        with open(f'../{cls.eqnfile}', 'r') as infile:
            for line in infile:
                logfile.write(f'\nline: {line}')
                # store equation tag like G3102b in eqntag:
                arr = re.search('<([A-z_0-9]+)>', line)
                if (arr):
                    eqntag = arr.group(1)
                    print(f'eqntag     = {eqntag}', file=logfile)
                    # baseeqntag without letters at the end:
                    baseeqntag = re.sub('([A-Z]+[0-9]+).*', r'\1', eqntag)
                    print(f'baseeqntag = {baseeqntag}', file=logfile)
                else:
                    eqntag = ''
                    print('no eqntag found', file=logfile)
                # does current line contain a chemical equation, i.e. something like
                # ' = ... : ... ; ' ?
                if (re.search('=.*:.*;', line)):
                    logfile.write(f'equation  = {line}')
                    # check if eqntag exists:
                    if (not eqntag):
                        errorstring += f'ERROR: This reaction has no eqntag:\n  {line}\n'
                    # store marker like {%StTrGNJ} in marker:
                    arr = re.search('{%([^}]*)}', line)
                    if (arr):
                        marker = arr.group(1)
                        print(f'marker    = {marker}', file=logfile)
                    else:
                        marker = ''
                        print('no marker found', file=logfile)
                    # store alternative LaTeX text for the rate
                    # constant's A-factor like {@} in klatex:
                    arr = re.search('{@([^}]*)}', line)
                    if (arr):
                        klatex = arr.group(1).replace('<','{').replace('>','}')
                        print(f'klatex    = {klatex}', file=logfile)
                    else:
                        klatex = ''
                        print('no klatex found', file=logfile)
                    # store alternative LaTeX text for the rate constant's exponent
                    # like {$} in kexplatex:
                    arr = re.search('{\$([^}]*)}', line)
                    if (arr):
                        kexplatex = arr.group(1).replace('<','{').replace('>','}')
                        print(f'kexplatex = {kexplatex}', file=logfile)
                    else:
                        kexplatex = ''
                        print('no kexplatex found', file=logfile)
                    # store LaTeX note in note:
                    arr = re.search('// *(.*)', line)
                    if (arr):
                        note = arr.group(1)
                        print(f'note = {note}', file=logfile)
                    else:
                        note = ''
                        print('no note found', file=logfile)
                    # store BibTeX references like {&1400} in ref:
                    arr = re.search('{&([^}]+)}', line)
                    if (arr):
                        ref = arr.group(1)
                        if (ref=='SGN'):
                            ref = 'see general notes$^*$'
                        else:
                            # put each BibTeX reference into \citet{}
                            ref = re.sub('([^, ]+)', r'\citet{\1}', ref)
                        # if there is a note, add an asterisk to refer to it:
                        if (note):
                            ref = ref+'$^*$'
                        print(f'ref       = {ref}', file=logfile)
                    else:
                        if (re.search('^EQ[0-9]*b', eqntag)):
                            # equilibrium backward reaction EQ##b doesn't need a reference:
                            print(f'no ref needed for equilibrium backward reaction {eqntag}',
                                  file=logfile)
                        elif (re.search('^D', baseeqntag)):
                            # dummy reaction D... doesn't need a reference:
                            print(f'no ref needed for dummy reaction {eqntag}', file=logfile)
                        elif (note):
                            ref = 'see note$^*$'
                            print(f'no ref needed for {eqntag} because there is a note',
                                  file=logfile)
                        else:
                            ref = r'\rule{8mm}{3mm}'
                            errorstring += f'ERROR: Reaction {eqntag} has no reference\n'
                    # mz_sg_20150506+
                    # isotopic composition transfer string
                    if (re.search('isotrans', marker)):
                        # eqntag is not shown, element transfer is passed via marker
                        # [ e.g. {%isotrans:C} ]
                        arr = marker.split(':')
                        # remove '//' from line and equation:
                        equation = equation.replace('//', '')
                        line = line.replace('//', '')
                        marker = arr.group(2) + ' transfer:'
                        eqntag = ''
                        ref    = ''
                        note   = ''
                    # tagging reaction
                    if (re.search('^TAG', eqntag)):
                        # eqntag is not shown, tagging info is passed via marker
                        # [ e.g. {%tag:IC} ]
                        # removing 'TAG' to fork equation below
                        baseeqntag = baseeqntag.replace('TAG', '')
                        # adding whitespace after : in marker tag:CFG
                        marker = marker.replace('tag:', 'tag: ')
                        eqntag = ''
                        ref    = ''
                        note   = ''
                    # mz_sg_20150506-
                    # delete all comments {...} from line:
                    line = re.sub('{[^}]*}', '', line)
                    # delete all eqntags <...> from line:
                    line = re.sub('<([A-z_0-9]+)>', '', line)
                    # turn TABs into spaces:
                    line = re.sub('[\t]', ' ', line)
                    # reduce multiple spaces to one:
                    line = re.sub('  +', ' ', line)
                    # split into equation and rateconst using the kpp-syntax separators ':;':
                    arr = re.split('[:;]', line)
                    equation  = arr[0].strip()
                    rateconst = r'\code{' + arr[1].strip() + '}'
                    print(f'equation  = {equation}', file=logfile)
                    print(f'rateconst = {rateconst}', file=logfile)
                    # delete reaction rate pseudo-species RR*:
                    equation = re.sub('= RR[A-z_0-9]+ \+', '=', equation)
                    print(f'equation  = {equation}', file=logfile)
                    # put LaTeX command \kpp{} around each specie in equation
                    equation = re.sub('([A-z][A-z0-9_]*)', r'\kpp{\1}', equation)
                    print(f'equation  = {equation}', file=logfile)
                    # create reaction arrow
                    equation = equation.replace('=', r'$\rightarrow$')
                    print(f'equation  = {equation}', file=logfile)
                    # use alternative LaTeX text for rate constant base?
                    if (klatex):
                        rateconst = klatex
                    # write a line into the specific LaTeX table:
                    if (re.search('^G[0-9]', baseeqntag)):
                        # G = gas-phase reaction:
                        rowcol_g = '' if rowcol_g else graycol # alternate row color
                        print(fr'{rowcol_g}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {ref}\\', file=gfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=gnotesfile)
                        if (kexplatex):
                            errorstring += f'ERROR: {eqntag} cannot use {kexplatex}\n'
                    elif (re.search('^J[0-9]', baseeqntag)):
                        # J = photolysis reaction:
                        rowcol_j = '' if rowcol_j else graycol # alternate row color
                        print(fr'{rowcol_j}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {ref}\\', file=jfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=jnotesfile)
                        if (kexplatex):
                            errorstring += f'ERROR: {eqntag} cannot use {kexplatex}\n'
                    elif (re.search('^PH[0-9]', baseeqntag)):
                        # PH = aqueous-phase photolysis reaction:
                        rowcol_ph = '' if rowcol_ph else graycol # alternate row color
                        print(fr'{rowcol_ph}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {ref}\\', file=phfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=phnotesfile)
                        if (kexplatex):
                            errorstring += f'ERROR: {eqntag} cannot use {kexplatex}\n'
                    elif (re.search('^HET[0-9]', baseeqntag)):
                        # HET = HET reaction:
                        rowcol_het = '' if rowcol_het else graycol # alternate row color
                        print(fr'{rowcol_het}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {ref}\\', file=hetfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=hetnotesfile)
                        if (kexplatex):
                            errorstring += f'ERROR: {eqntag} cannot use {kexplatex}\n'
                    elif (re.search('^A[0-9]', baseeqntag)):
                        # A = aqueous-phase reaction:
                        rowcol_a = '' if rowcol_a else graycol # alternate row color
                        print(fr'{rowcol_a}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {kexplatex} & {ref}\\',
                              file=afile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=anotesfile)
                    elif (re.search('^EQ[0-9]*b', eqntag)):
                        pass # backward reaction, do nothing
                    elif (re.search('^EQ[0-9]*f', eqntag)):
                        # EQ = equilibria (acid-base and others):
                        # delete f in equation id:
                        eqntag = eqntag.replace('f_', '_')
                        # replace rightarrow by rightleftharpoons:
                        equation = equation.replace('rightarrow', 'rightleftharpoons')
                        rowcol_eq = '' if rowcol_eq else graycol # alternate row color
                        print(fr'{rowcol_eq}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {kexplatex} & {ref}\\',
                              file=eqfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=eqnotesfile)
                    #  mz_sg_20150505+
                    elif (re.search('^IEX.*', baseeqntag)):
                        # IEX = isotope exchange reaction
                        # replace rightarrow by rightleftharpoons
                        equation = equation.replace('// ', '')
                        equation = equation.replace('rightarrow', 'rightleftharpoons')
                        equation = re.sub('*', '^{abun}&',                1, equation)
                        equation = re.sub('*', '^{abun}&',                4, equation)
                        equation = re.sub('(.+)(.+)(.+)', '^{rare}&',     2, equation)
                        equation = re.sub('(.+)(.+)(.+)(.+)', '^{rare}&', 3, equation)
                        rowcol_iex = '' if rowcol_iex else graycol # alternate row color
                        print(fr'{rowcol_iex}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {ref}\\', file=iexfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=iexnotesfile)
                    #  mz_sg_20150505-
                    elif (re.search('^H[0-9]', baseeqntag)):
                        # H = aqueous-phase heterogenous and Henry reaction:
                        rowcol_h = '' if rowcol_h else graycol # alternate row color
                        print(fr'{rowcol_h}\code{{{eqntag}}} & {marker} & ' +
                              fr'{equation} & {rateconst} & {ref}\\', file=hfile)
                        if (note):
                            print('\n'+fr'\note{{{eqntag}}}{{{note}}}', file=hnotesfile)
                        if (kexplatex):
                            errorstring += f'ERROR: {eqntag} cannot use {kexplatex}\n'
                    elif (re.search('^D', baseeqntag)):
                        pass # dummy reaction, do nothing
                    else:
                        errorstring += f'ERROR: Unknown type of eqntag: {eqntag}\n'
                        print(fr'\code{{{eqntag}}} & {marker} & {equation} & ' +
                              fr'{rateconst} & {kexplatex} & {ref}\\', file=logfile)
                else:
                    # not an equation line, check for LaTeX text {@...}:
                    arr = re.search('{@([^}]*)}', line)
                    if (arr):
                        klatex = arr.group(1)
                        print(f'klatex    = {klatex}', file=logfile)
                        # write a line into the specific LaTeX table:
                        if (re.search('^G[0-9]', baseeqntag)):
                            # G = gas-phase reaction:
                            print(klatex, file=gfile)
                        elif (re.search('^J[0-9]', baseeqntag)):
                            # J = photolysis reaction:
                            print(klatex, file=jfile)
                        elif (re.search('^PH[0-9]', baseeqntag)):
                            # PH = aqueous-phase photolysis reaction:
                            print(klatex, file=phfile)
                        elif (re.search('^HET', baseeqntag)):
                            # HET = HET reaction:
                            print(klatex, file=hetfile)
                        elif (re.search('^A[0-9]', baseeqntag)):
                            # A = aqueous-phase reaction:
                            print(klatex, file=afile)
                        elif (re.search('^EQ[0-9]', baseeqntag)):
                            # EQ = equilibria (acid-base and others):
                            print(klatex, file=eqfile)
                        elif (re.search('^H[0-9]', baseeqntag)):
                            # H = aqueous-phase heterogenous and Henry reaction:
                            print(klatex, file=hfile)
                        elif (re.search('^IEX.*', baseeqntag)):
                            # IEX = isotope exchange reaction:
                            print(klatex, file=iexfile)
                        else:
                            errorstring += f'ERROR: Unknown type of eqntag: {baseeqntag}\n'
        if (errorstring):
            sys.exit(f'\nThere were errors:\n{errorstring}')
        afile.close()   ; anotesfile.close()
        eqfile.close()  ; eqnotesfile.close()
        gfile.close()   ; gnotesfile.close()
        hetfile.close() ; hetnotesfile.close()
        hfile.close()   ; hnotesfile.close()
        iexfile.close() ; iexnotesfile.close()
        jfile.close()   ; jnotesfile.close()
        phfile.close()  ; phnotesfile.close()
        logfile.close()

    ##########################################################################

    @classmethod
    def generate_mecca_spc(cls):

        # DETERMINE NUMBER OF AEROSOL PHASES:
        print(f'\n{HLINE}\n\nSelected number of aerosol phases = {cls.apn}')
        if ((cls.apn<0) or (cls.apn>99)):
            sys.exit('\nERROR: Number of aerosol phases is out of range.')
        if ((cls.apn == 3) and (USER != 'sander')):
            sys.exit('\nERROR: Do not use apn=3 which is still under construction.')
        cls.apn_or_1 = max(cls.apn, 1)

        print(f'\n{HLINE}\n\nGenerating species file mecca.spc...\n')
        print(f'Gas-phase species from: {cls.gasspcfile}')
        print(f'Aerosol   species from: {cls.aqueousspcfile}')
        with open(cls.spcfile, 'w') as f_spc:
            # create complete *.spc file by combining gas and aqueous file:
            print('{%s}' % (DONTEDIT), file=f_spc)
            print('{'+TIMESTAMP+'}', file=f_spc)
            # gas phase:
            print('{***** START: gas-phase species from '+cls.gasspcfile+' *****}',
                  file=f_spc)
            with open(cls.gasspcfile) as infile:
                for line in infile:
                    # skip comment lines starting with //:
                    if (not re.search('^//', line)):
                        print(line.rstrip(), file=f_spc)
            print('{***** END:   gas-phase species from '+cls.gasspcfile+' *****}',
                  file=f_spc)
            # aqueous phase:
            for counter in range(cls.apn_or_1):
                print('{**** START: aerosol species (phase %d) from %s ****}' % (
                    counter+1, cls.aqueousspcfile), file=f_spc)
                aerophasename = '%2.2d' % (counter+1)
                with open(cls.aqueousspcfile) as infile:
                    for line in infile:
                        # skip comment lines starting with //:
                        if re.search('^//', line):
                            continue
                        # \FormatAq{}{} is used in meccanism.tex and spc2mpl
                        # for formatting aqueous phase with LaTeX:
                        line = re.sub('{@([^}]*)}', r'{@\\FormatAq<\1><##>}', line)
                        # insert current aerosol phase number:
                        line = line.replace('##', aerophasename)
                        print(line.rstrip(), file=f_spc)
                    print('{**** END:   aerosol species (phase %d) from %s ****}' % (
                    counter+1, cls.aqueousspcfile), file=f_spc)
            print()
            # set H2O fixed:
            print('{SETFIX H2O_a* is done via xmecca}', file=f_spc)
            for counter in range(cls.apn):
                aerophasename = '%2.2d' % (counter+1)
                print(f'#SETFIX H2O_a{aerophasename};', file=f_spc)

        # check length of species names:
        results = ''
        with open(cls.spcfile) as f:
            for line in f:
                if (re.search('^\s*[A-z0-9_]{21,}\s*=', line)):
                    results += line
        if (results):
            print(results)
            sys.exit('ERROR: Species name cannot have more than 20 characters.')

        # create info for ferret:
        cls.spc2jnl('../jnl/_mecca_spc.jnl')
        # create info for matplotlib:
        cls.spc2mpl('../pycaaba/_mecca_spc.py')

        return cls.apn, cls.apn_or_1

    ##########################################################################

    @classmethod
    def generate_mecca_eqn(cls):

        ######################################################################

        tmp0eqn = cls.get_tmp_name('.eqn')
        tmp1eqn = cls.get_tmp_name('.eqn')
        tmp2eqn = cls.get_tmp_name('.eqn')
        tmp3eqn = cls.get_tmp_name('.eqn')
        tmp4eqn = cls.get_tmp_name('.eqn')
        tmp5eqn = cls.get_tmp_name('.eqn')
        tmp6eqn = cls.get_tmp_name('.eqn')
        tmp7eqn = cls.get_tmp_name('.eqn')

        ######################################################################

        # SELECT GAS-PHASE EQUATION FILE:

        print(f'\n{HLINE}\n\nSelecting gas-phase equation file...\n')
        if (not cls.gaseqnfile):
            cls.gaseqnfile = cls.defaultgaseqnfile
        print(f'gaseqnfile = {cls.gaseqnfile}')

        ######################################################################

        # APPLY REPLACEMENT (*.rpl) FILES TO EQUATION FILE:

        if (cls.rplfile):
            print(f'\n{HLINE}\n\nrplfile = {cls.rplfile}')
            rplfile_fullname = f'rpl/{cls.rplfile}.rpl'
            if (not os.path.isfile(rplfile_fullname)):
                sys.exit(f'\nERROR: Replacement file {rplfile_fullname} does not exist.')
            cls.apply_rplfile(rplfile_fullname, tmp0eqn)
        else:
            print(f'\n{HLINE}\n\nNo replacements with any *.rpl files')
            shutil.copy(cls.gaseqnfile, tmp0eqn)

        ######################################################################

        # ADD AEROSOL INFO, COMBINE GAS- AND AQUEOUS-PHASE EQUATION FILES:

        print(f'\n{HLINE}\n\nCombining gas- and aqueous-phase equation files...\n')

        decl = '' # declarations of ind_*_a arrays
        init = '' # initializations of ind_*_a arrays
        with open(cls.spcfile, 'r') as infile:
            for line in infile:
                # is current line a definition of an aerosol species like 'XYZ_a01 =' ?
                arr = re.search('^\s*([A-z0-9]+)_a01\s*=', line)
                if (arr):
                    spc = f'{arr.group(1)}_a'
                    decl += f'  INTEGER, PUBLIC, DIMENSION(APN) :: ind_{spc:17} = 0\n'
                    for i in range(cls.apn):
                        lhs = f'ind_{spc}({i+1:02})'
                        rhs = f'ind_{spc}{i+1:02}'
                        init += f'  {lhs:25} = {rhs}\n'
        # print aqueous definitions at beginning of equation file:
        with open(tmp1eqn, 'w') as f_eqn1:
            print('#INLINE F90_GLOBAL',                                    file=f_eqn1)
            print('  ! from xmecca for aerosol:',                          file=f_eqn1)
            print(f'  INTEGER, PARAMETER, PUBLIC :: APN = {cls.apn_or_1}', file=f_eqn1)
            f_eqn1.write(decl)
            print(f'#ENDINLINE {{above lines go to messy_{cls.submodel}_kpp_global}}',
                                                                           file=f_eqn1)
            print('#INLINE F90_UTIL',                                      file=f_eqn1)
            print('! from xmecca:',                                        file=f_eqn1)
            print('SUBROUTINE initialize_indexarrays',                     file=f_eqn1)
            print(f'  USE messy_{cls.submodel}_kpp_global     ! ind_XYZ_a(:) arrays',
                                                                           file=f_eqn1)
            print(f'  USE messy_{cls.submodel}_kpp_parameters ! ind_XYZ_a## scalars',
                                                                           file=f_eqn1)
            print('  IMPLICIT NONE',                                       file=f_eqn1)
            if (cls.apn>0):
                f_eqn1.write(init)
            print('END SUBROUTINE initialize_indexarrays',                 file=f_eqn1)
            print(f'#ENDINLINE {{above lines go to messy_{cls.submodel}_kpp_util}}',
                                                                           file=f_eqn1)

            # gas phase:
            print(f'Gas-phase reactions from:     {cls.gaseqnfile}')
            print('{***** START: gas-phase chemistry from %s *****}' %
                  (cls.gaseqnfile), file=f_eqn1)
            # tmp0eqn is either identical to gaseqnfile or it was modified with a rpl file:
            with open(tmp0eqn) as f:
                f_eqn1.write(f.read())
            print('{***** END:   gas-phase chemistry from %s *****}' %
                  (cls.gaseqnfile), file=f_eqn1)

            # aqueous phase:
            if (cls.apn>0):
                print(f'Aqueous-phase reactions from: {cls.aqueouseqnfile}')
                for counter in range(cls.apn):
                    print('{**** START: aerosol chemistry (phase %d) from %s ****}' %
                          (counter+1, cls.aqueouseqnfile), file=f_eqn1)
                    aerophasename = '%2.2d' % (counter+1)
                    with open(cls.aqueouseqnfile) as infile:
                        for line in infile:
                            # insert current aerosol phase number:
                            f_eqn1.write(line.replace('##', aerophasename))
                    print('{**** END:   aerosol chemistry (phase %d) from %s ****}' %
                          (counter+1, cls.aqueouseqnfile), file=f_eqn1)
            else:
                print('No aqueous-phase reactions')

        # delete comments starting with // and empty lines:
        with open(tmp1eqn, 'r') as infile, open(tmp2eqn, 'w') as outfile:
            for line in infile:
                if (re.search('^//',  line)): continue
                if (re.search('^\s$', line)): continue
                outfile.write(line)

        ######################################################################

        # CHECK EQUATION FILE AND ADD ELEMENT LABELS:

        print(f'\n{HLINE}\n\nChecking syntax of equation file...')
        # exitstatus is the sum of several error bits:
        #  1 add element labels
        #  2 carbon count
        #  4 mass and charge balance
        #  8 tab characters
        # 16 eqntag length
        # 32 duplicate eqntags
        # 64 section error
        exitstatus = cls.check_eqns(tmp2eqn, tmp3eqn) # in=tmp2eqn, out=tmp3eqn
        if (exitstatus & 2): # 2 = 2nd bit for carboncount error
            if (cls.ignorecarboncount):
                print('\nCarbon count imbalance ignored because "ignorecarboncount" is set')
                # remove 2nd bit for mass balance error with bitwise AND operator:
                exitstatus = exitstatus & 253 # = 255 - 2 = 11111101
        if (exitstatus & 4): # 4 = 3rd bit for mass and charge balance error
            if (cls.ignoremassbalance):
                print('\nMass/charge imbalance ignored because "ignoremassbalance" is set')
                # remove 3rd bit for mass balance error with bitwise AND operator:
                exitstatus = exitstatus & 251 # = 255 - 4 = 11111011
        if (exitstatus & 64): # 64 = 7th bit for section error
            if (cls.ignoresectionerror):
                print('\nSection error ignored because "ignoresectionerror" is set')
                # remove 7th bit for section error with bitwise AND operator:
                exitstatus = exitstatus & 191 # = 255 - 64 = 10111111
        if (exitstatus):
            print('\nERROR: Syntax problems detected in equation file (see above)')
            sys.exit(exitstatus)

        ######################################################################

        # SELECT REACTIONS AS SPECIFIED IN wanted:

        cls.select_wanted(tmp3eqn) # in=tmp3eqn, out=eqnfile

        ######################################################################

        # ACTIVATE ENTHALPY (kJ/mol) IN EQUATION FILE:

        print(f'\n{HLINE}\n\nenthalpy = {cls.enthalpy}')
        if (cls.enthalpy == 'y'):
            print('\nActivating enthalpy (kJ/mol) in equation file:')
            shutil.copy(cls.eqnfile, tmp4eqn)
            with open(tmp4eqn, 'r') as infile, open(cls.eqnfile, 'w') as outfile:
                for line in infile:
                    line = re.sub('{(\+ *[-+.e0-9]+ *kjmol)}', r'\1', line,
                                  flags=re.IGNORECASE)
                    outfile.write(line)

        ######################################################################

        # ADD MONTE-CARLO FACTOR TO EQUATION FILE:

        print(f'\n{HLINE}\n\nmcfct = {cls.mcfct}')
        shutil.copy(cls.eqnfile, tmp5eqn)
        if (cls.mcfct == 'y'):
            i = 1
            with open(tmp5eqn, 'r') as infile, open(cls.eqnfile, 'w') as outfile:
                for line in infile:
                    # note that: exp( ln(f) * mcfct ) = f^mcfct
                    while (re.search('{§§[^}]*}', line)):
                        # logarithmic uncertainty (e.g., IUPAC evaluation):
                        line = re.sub('{§§([^}]*)}', fr'*EXP(\1*LOG(10.)*mcexp({i}))',
                                      line, 1)
                        i += 1
                    while (re.search('{§}', line)):
                        # default uncertainty assumed to be 1.25:
                        line = re.sub('{§}', f'*EXP(LOG(1.25)*mcexp({i}))', line, 1)
                        i += 1
                    while (re.search('{§[^}]*}', line)):
                        # uncertainty factor (e.g. JPL evaluation):
                        line = re.sub('{§([^}]*)}', fr'*EXP(LOG(\1)*mcexp({i}))', line, 1)
                        i += 1
                    outfile.write(line)
                # make the number of random numbers available to Fortran code via MAX_MCEXP:
                print('#INLINE F90_GLOBAL',                                    file=outfile)
                print('  ! from xmecca:',                                      file=outfile)
                print(f'  INTEGER, PARAMETER, PUBLIC :: MAX_MCEXP = {i-1}',    file=outfile)
                print('!KPPPP_DIRECTIVE vector variable definition start',     file=outfile)
                print('  REAL :: mcexp(MAX_MCEXP) ! Monte-Carlo factor',       file=outfile)
                print('!KPPPP_DIRECTIVE vector variable definition end',       file=outfile)
                print('#ENDINLINE {above lines go to messy_mecca_kpp_global}', file=outfile)
            REQ_MCFCT = '.TRUE.'
        else:
            with open(tmp5eqn, 'r') as infile, open(cls.eqnfile, 'w') as outfile:
                # remove factors from eqn file (necessary inside inlined f90 code):
                for line in infile:
                    line = re.sub('{§[^}]*}', '', line)
                    outfile.write(line)
                # define dummy array size for MAX_MCEXP:
                print('#INLINE F90_GLOBAL\n' +
                      '  ! from xmecca:\n' +
                      '  INTEGER, PARAMETER, PUBLIC :: MAX_MCEXP = 1\n' +
                      '!KPPPP_DIRECTIVE vector variable definition start\n' +
                      '  REAL :: mcexp(MAX_MCEXP) ! dummy Monte-Carlo factor\n' +
                      '!KPPPP_DIRECTIVE vector variable definition end\n', file=outfile)
                print(f'#ENDINLINE {{above lines go to messy_{cls.submodel}_kpp_global}}',
                      file=outfile)
                REQ_MCFCT = '.FALSE.'

        ######################################################################

        # ADD DIAGNOSTIC TRACERS TO EQUATION FILE:

        print(f'\n{HLINE}\n\ndiagtracfile = {cls.diagtracfile}')
        if (os.path.isfile(cls.diagtractblfile)):
            os.remove(cls.diagtractblfile)
        if (not cls.diagtracfile):
            print('\nNo diagtracfile selected')
        else:
            runcmd('diagtrac/diagtrac.tcsh', check=True, env={
                'diagtracfile':cls.diagtracfile,
                'diagtractblfile':cls.diagtractblfile,
                'eqnfile':cls.eqnfile,
                'spcfile':cls.spcfile})

        ######################################################################

        # ADD PSEUDO-KPP SPECIES RR* FOR ACCUMULATED REACTION RATES:

        print(f'\n{HLINE}\n\nrxnrates = {cls.rxnrates}')
        if (cls.rxnrates == 'y'):
            print('\nAdding pseudo-KPP species RR* for accumulated reaction rates...\n')
            with open(cls.eqnfile,  'r') as infile, \
                 open(cls.spcfile,  'a') as spc_out, \
                 open(tmp6eqn, 'w') as eqn_out:
                print('#DEFVAR', file=spc_out)
                print('{**** START: accumulated reaction rates ****}', file=spc_out)
                for line in infile:
                    search_result = re.search('^<(.*)>.*=.*:.*;.*$', line)
                    if search_result:
                        eqntag = search_result.group(1)
                        eqn_out.write(line.replace('=', f'= RR{eqntag} +', 1))
                        # add rxnrate species to *.spc file:
                        print('RR%s = IGNORE ; {@RR%s} {diagnostic tracer}' %
                              (eqntag, eqntag), file=spc_out)
                    else:
                        eqn_out.write(line)
                print('{**** END: accumulated reaction rates ****}', file=spc_out)
            if (cls.bm3d):
                runcmd('bm3d/add_RR_to_process_tbl.tcsh', check=True, env={
                'rxnratestblfile':cls.rxnratestblfile, 'eqnfile':cls.eqnfile})
            runcmd(f"sed 's/+[ ]*-/ - /g' {tmp6eqn} > {cls.eqnfile}")
            # create jnl files for reaction rates:
            cls.rxnrates_awk()
            # create matplotlib files for reaction rates:
            cls.rxn2mpl()
        else:
            cls.rxnrates = 'n'
            if (os.path.isfile(cls.jnlfile1)):     os.remove(cls.jnlfile1)
            if (os.path.isfile(cls.jnlfile2)):     os.remove(cls.jnlfile2)
            if (os.path.isfile(cls.rxnfile1)):     os.remove(cls.rxnfile1)
            if (os.path.isfile(cls.rxnfile2)):     os.remove(cls.rxnfile2)
            if (os.path.isfile(cls.rxnfile1+'c')): os.remove(cls.rxnfile1+'c') # *.pyc
            if (os.path.isfile(cls.rxnfile2+'c')): os.remove(cls.rxnfile2+'c') # *.pyc

        ######################################################################

        # TAGGING:

        print(f'\n{HLINE}\n\ntag = {cls.tag}')
        if (cls.tag == 'y'):
            sys.exit('TODO: change xtag input from *.bat file to *.ini')
            output = runcmd(f'(cd tag ; ./xtag norm {cls.inifile})', check=True, pipe=True,
                env={'xmecca_wanted4imtag':cls.wanted, 'xmecca_gastblfile':cls.gastblfile})
            print('STDOUT: %s' % (output.stdout.rstrip('\n')))
            print('STDERR: %s' % (output.stderr.rstrip('\n')))
        else:
            print(f'\nResetting tag to zero configuration with "xtag zero"...')
            cls.tag = 'n'
            runcmd('(cd tag ; ./xtag zero)', check=True)

        ######################################################################

        # ADD SETFIX AND HEADER AT BEGINNING OF EQUATION FILE:

        print(f'\n{HLINE}\n\nAdding SETFIX and header at beginning of equation file:')

        if (cls.setfixlist):
            setfixcomment = 'fixed species from setfixlist in inifile'
        else:
            cls.setfixlist = 'CO2; O2; N2;'
            setfixcomment = 'default values'
        print(f'\nFixed species are:\n#SETFIX {cls.setfixlist}')
        ls_gasspcfile      = runcmd(f'ls -l {cls.gasspcfile}',     pipe=True).stdout.strip()
        ls_aqueousspcfile  = runcmd(f'ls -l {cls.aqueousspcfile}', pipe=True).stdout.strip()
        ls_gaseqnfile      = runcmd(f'ls -l {cls.gaseqnfile}',     pipe=True).stdout.strip()
        ls_aqueouseqnfile  = runcmd(f'ls -l {cls.aqueouseqnfile}', pipe=True).stdout.strip()
        sum_gasspcfile     = runcmd(f'sum {cls.gasspcfile}',       pipe=True).stdout.strip()
        sum_aqueousspcfile = runcmd(f'sum {cls.aqueousspcfile}',   pipe=True).stdout.strip()
        sum_gaseqnfile     = runcmd(f'sum {cls.gaseqnfile}',       pipe=True).stdout.strip()
        sum_aqueouseqnfile = runcmd(f'sum {cls.aqueouseqnfile}',   pipe=True).stdout.strip()
        shutil.copy(cls.eqnfile, tmp7eqn)
        with open(tmp7eqn, 'r') as infile, open(cls.eqnfile, 'w') as f_out:
            print('{'+DONTEDIT+'}',                                            file=f_out)
            print('#SETFIX '+cls.setfixlist,                                   file=f_out)
            print('{'+setfixcomment+'}',                                       file=f_out)
            print('{SETFIX of liquid H2O_a* is done in mecca.spc via xmecca}', file=f_out)
            print("#INLINE F90_GLOBAL",                                        file=f_out)
            print("  ! MECCA info from xmecca:",                               file=f_out)
            print("  CHARACTER(LEN=*), PUBLIC, PARAMETER :: &",                file=f_out)
            print(f"    timestamp            = '{TIMESTAMP}', &",              file=f_out)
            print(f"    inifile              = '{cls.inifile_short}', &",      file=f_out)
            print(f"    gas_spc_file         = '{ls_gasspcfile}', &",          file=f_out)
            print(f"    aqueous_spc_file     = '{ls_aqueousspcfile}', &",      file=f_out)
            print(f"    gas_eqn_file         = '{ls_gaseqnfile}', &",          file=f_out)
            print(f"    aqueous_eqn_file     = '{ls_aqueouseqnfile}', &",      file=f_out)
            print(f"    gas_spc_file_sum     = '{sum_gasspcfile}', &",         file=f_out)
            print(f"    aqueous_spc_file_sum = '{sum_aqueousspcfile}', &",     file=f_out)
            print(f"    gas_eqn_file_sum     = '{sum_gaseqnfile}', &",         file=f_out)
            print(f"    aqueous_eqn_file_sum = '{sum_aqueouseqnfile}', &",     file=f_out)
            print(f"    rplfile              = '{cls.rplfile}', &",            file=f_out)
            print(f"    wanted               = '{cls.wanted}', &",             file=f_out)
            print(f"    diagtracfile         = '{cls.diagtracfile}', &",       file=f_out)
            print(f"    rxnrates             = '{cls.rxnrates}', &",           file=f_out)
            print(f"    tag                  = '{cls.tag}'",                   file=f_out)
            print(f"  LOGICAL, PARAMETER :: REQ_MCFCT = {REQ_MCFCT}",          file=f_out)
            print(f"#ENDINLINE {{above lines go to messy_{cls.submodel}_kpp_global}}",
                                                                               file=f_out)
            f_out.write(infile.read())

    ##########################################################################

    @classmethod
    def execute_kpp(cls):

        print(f'\n{HLINE}\n\nExecuting KPP...')

        # define path to KPP (via pwd command to resolve symbolic links):
        KPP_HOME = os.path.realpath(MECCADIR+'/kpp')
        # define KPP version:
        with open(KPP_HOME+'/src/gdata.h') as f:
            for line in f:
                if ('KPP_VERSION' in line):
                    cls.KPP_VERSION = re.search('"(.*)"', line).group(1)
                    break
        print('\nPlease verify that the KPP version is >= 2.2.3')
        print(f'KPP_HOME    = {KPP_HOME}')
        print(f'KPP version = {cls.KPP_VERSION}')
        print(f'kppoption = {cls.kppoption}')
        print('removing all KPP-generated files from previous xmecca run')
        # delete old *.f90 files, including *.f90-ori:
        list(map(os.remove, glob(f'smcl/messy_{cls.submodel}_kpp*.f90*')))

        # --------------------------------------------------------------------

        if (cls.kppoption == 'k'):

            if (cls.mecnum):
                sys.exit('\nERROR: xpolymecca works only with kppoption=4.')

            print(f'integr = {cls.integr}')
            ls_spcfile  = runcmd(f'ls -l {cls.spcfile}', pipe=True).stdout.strip()
            ls_eqnfile  = runcmd(f'ls -l {cls.eqnfile}', pipe=True).stdout.strip()
            sum_spcfile = runcmd(f'sum {cls.spcfile}',   pipe=True).stdout.strip()
            sum_eqnfile = runcmd(f'sum {cls.eqnfile}',   pipe=True).stdout.strip()
            with open('integr.kpp', 'w') as f_out:
                print(f"// {DONTEDIT}",                                        file=f_out)
                print(f"#INTEGRATOR {cls.integr}",                             file=f_out)
                print(f"#INLINE F90_GLOBAL",                                   file=f_out)
                print(f"  ! KPP info from xmecca (via integr.kpp):",           file=f_out)
                print(f"  CHARACTER(LEN=*), PUBLIC, PARAMETER :: &",           file=f_out)
                print(f"    {cls.submodel}_spc_file     = '{ls_spcfile}', &",  file=f_out)
                print(f"    {cls.submodel}_eqn_file     = '{ls_eqnfile}', &",  file=f_out)
                print(f"    {cls.submodel}_spc_file_sum = '{sum_spcfile}', &", file=f_out)
                print(f"    {cls.submodel}_eqn_file_sum = '{sum_eqnfile}', &", file=f_out)
                print(f"    kppoption          = '{cls.kppoption}', &",        file=f_out)
                print(f"    KPP_HOME           = '{KPP_HOME}', &",             file=f_out)
                print(f"    KPP_version        = '{cls.KPP_VERSION}', &",      file=f_out)
                print(f"    integr             = '{cls.integr}'",              file=f_out)
                print(f"#ENDINLINE {{above lines go to messy_{cls.submodel}_kpp_global}}",
                                                                               file=f_out)

            # checking that KPP executable is available:
            if (not os.path.isfile(f'{KPP_HOME}/bin/kpp')):
                print('\nKPP executable not available, compiling KPP now.')
                runcmd(f'(cd {KPP_HOME} ; gmake)')

            kppcommand = f'{KPP_HOME}/bin/kpp messy_{cls.submodel}_kpp.kpp'
            print(f'\nStarting KPP with:\n{kppcommand}')
            output = runcmd(kppcommand, pipe=True, env={'KPP_HOME':KPP_HOME})
            print(output.stdout.rstrip('\n'))
            exitstatus = output.returncode
            print(f'exit status from KPP is: {exitstatus}')
            if (exitstatus):
                print('STDERR: %s' % (output.stderr.rstrip('\n')))
                sys.exit(exitstatus)

            # add USE messy_cmn_photol_mem:
            globalfile = f'messy_{cls.submodel}_kpp_Global.f90'
            tmp_f90 = cls.get_tmp_name('.f90')
            os.rename(globalfile, tmp_f90)
            use_param = f'USE messy_{cls.submodel}_kpp_Parameters'
            with open(tmp_f90, 'r') as infile, open(globalfile, 'w') as outfile:
                for line in infile:
                    outfile.write(line.replace(use_param,
                        'USE messy_cmn_photol_mem ! IP_MAX, ip_*, jname\n  '+use_param))

            print(f'\n{HLINE}\n\nCreating {cls.submodel} core files in smcl/...\n')

            # produce a copy of the parameter file because it will be needed later:
            shutil.copy(f'messy_{cls.submodel}_kpp_Parameters.f90', cls.paramfile)

            # move the KPP-generated *.f90 files (except for _Model) into the smcl/
            # directory and change the file names to lowercase:
            kpp_parts = ('Function', 'Global', 'Initialize', 'Integrator', 'Jacobian',
                        'JacobianSP', 'LinearAlgebra', 'Monitor', 'Parameters',
                        'Precision', 'Rates', 'Util')
            for kpp_part in kpp_parts:
                kppfile = f'messy_{cls.submodel}_kpp_{kpp_part}.f90'
                smclfile = 'smcl/' + kppfile.lower()
                print(f'creating {smclfile}')
                os.rename(kppfile, smclfile)

            # KPP/KP4 compatibility file:
            shutil.copy('template_messy_mecca_kpp.f90', 'smcl/messy_mecca_kpp.f90')

            # remove indirect indexing with decomp:
            print(f'\n{HLINE}\n\ndecomp = {cls.decomp}')
            if (cls.decomp == 'y'):
                shutil.copy(f'smcl/messy_{cls.submodel}_kpp_linearalgebra.f90',
                            f'tmp_before_decomp_messy_{cls.submodel}_kpp_linearalgebra.f90')
                shutil.copy(f'smcl/messy_{cls.submodel}_kpp_integrator.f90',
                            f'tmp_before_decomp_messy_{cls.submodel}_kpp_integrator.f90')
                if (cls.integr in ('rosenbrock', 'rosenbrock_mz')):
                    runcmd('(cd decomp ; ./seddecomp_ros-auto T)')
                else:
                    sys.exit(f'ERROR: No removal of indirect indexing for {cls.integr}')

        # end of kppoption=k section

        # --------------------------------------------------------------------

        if (cls.kppoption == '4'):
            if (cls.bm3d): # run KP4:
                runcmd('bm3d/kp4.tcsh', check=True, env={
                    'integr':cls.integr, 'vlen':cls.vlen, 'decomp':cls.decomp,
                    'deltmpkp4':cls.deltmpkp4, 'submodel':cls.submodel})
                runcmd('bm3d/create_tracdef.tcsh', check=True, env={
                    'apn':str(cls.apn), 'aqueoustblfile':cls.aqueoustblfile,
                    'diagtracfile':cls.diagtracfile, 'diagtractblfile':cls.diagtractblfile,
                    'gastblfile':cls.gastblfile, 'paramfile':cls.paramfile,
                    'rxnrates':cls.rxnrates, 'rxnratestblfile':cls.rxnratestblfile,
                    'tag':cls.tag, 'submodel':cls.submodel})
            else:
                sys.exit('\nERROR: KP4 is not available.')

        ######################################################################

        print(f'\n{HLINE}')
        if (cls.submodel == 'mecca'):
            print('\nMaking KPP-generated files available to CAABA...\n')
            # remove all kpp files, since it is unclear how many are present (kpp or kp4)
            os.chdir('..')
            list(map(os.remove, glob(f'messy_{cls.submodel}_kpp*.f90')))
            os.remove(f'messy_{cls.submodel}.f90')
            os.remove(f'messy_{cls.submodel}_aero.f90')
            os.remove(f'messy_{cls.submodel}_khet.f90')
            for kppfile in sorted(glob(f'mecca/smcl/messy_{cls.submodel}*.f90')):
                print(f'ln -s {kppfile} .')
                os.system(f'ln -s {kppfile} .')
            os.chdir(MECCADIR)

        if (cls.bm3d):
            print('\nMaking KPP-generated files available to ECHAM5/MESSy...\n')
            runcmd('bm3d/link_kpp_into_messy.tcsh', check=True, env={'submodel':cls.submodel})

    ##########################################################################

    @classmethod
    def statistics_and_LaTeX(cls):

        print(f'\n{HLINE}')

        # count number of selected species:
        all_spc = 0
        aq_spc  = 0
        with open(cls.paramfile) as f:
            for line in f:
                if (re.search(':: ind_.* = [1-9]+',             line)): all_spc += 1
                if (re.search(':: ind_.*_a[0-9][0-9] = [1-9]+', line)): aq_spc  += 1
                # don't count tagged species (isotopologues, ...):
                if (re.search(':: ind_I[1-9].* = [1-9]+',       line)): all_spc -= 1
                if (re.search(':: ind_F[M,I,O].* = [1-9]+',     line)): all_spc -= 1
                if (re.search(':: ind_OG.* = [1-9]+',           line)): all_spc -= 1
        gas_spc = all_spc - aq_spc
        print('\nNumber of species in selected mechanism:')
        print(f'gas phase:          {gas_spc:>4}')
        print(f'aqueous phase:      {aq_spc:>4}')
        print(f'all species:        {all_spc:>4}')
        # count number of selected reactions:
        all_eqns = 0
        G_eqns   = 0
        A_eqns   = 0
        H_eqns   = 0
        J_eqns   = 0
        PH_eqns  = 0
        HET_eqns = 0
        EQ_eqns  = 0
        IEX_eqns = 0
        D_eqns   = 0
        TAG_eqns = 0
        with open(cls.eqnfile) as f:
            for line in f:
                if (re.search('=.*:.*;',               line)): all_eqns += 1
                if (re.search('<G[0-9].*=.*:.*;',      line)): G_eqns   += 1
                if (re.search('<A[0-9].*=.*:.*;',      line)): A_eqns   += 1
                if (re.search('<H[0-9].*=.*:.*;',      line)): H_eqns   += 1
                if (re.search('<J[0-9].*=.*:.*;',      line)): J_eqns   += 1
                if (re.search('<PH[0-9].*=.*:.*;',     line)): PH_eqns  += 1
                if (re.search('<HET[0-9].*=.*:.*;',    line)): HET_eqns += 1
                if (re.search('<EQ[0-9].*=.*:.*;',     line)): EQ_eqns  += 1
                if (re.search('<IEX*.*=.*:.*;',        line)): IEX_eqns += 1
                if (re.search('<D[0-9].*=.*:.*;',      line)): D_eqns   += 1
                if (re.search('<TAG[A-Za-z].*=.*:.*;', line)): TAG_eqns += 1
        # sum over these reaction types:
        rxnsum = G_eqns + A_eqns + H_eqns + J_eqns + PH_eqns + HET_eqns + \
                 EQ_eqns + IEX_eqns + D_eqns - TAG_eqns
        print('\nNumber of reactions in selected mechanism:')
        print(f'gas phase      G:   {G_eqns:>4}')
        print(f'aqueous phase  A:   {A_eqns:>4}')
        print(f'Henry          H:   {H_eqns:>4}')
        print(f'photolysis     J:   {J_eqns:>4}')
        print(f'aq. photolysis PH:  {PH_eqns:>4}')
        print(f'heterogeneous  HET: {HET_eqns:>4}')
        print(f'equilibria     EQ:  {EQ_eqns:>4}')
        print(f'isotope exch.  IEX: {IEX_eqns:>4}')
        print(f'tagging        TAG: {TAG_eqns:>4}')
        print(f'dummy          D:   {D_eqns:>4}')
        print(f'all equations:      {all_eqns:>4}')
        if (rxnsum != all_eqns):
            print('sum of the above:   {rxnsum:>4}')
            print('WARNING: sum is not equal to all equations')

        ######################################################################

        # LATEX MECCANISM:

        print(f'\n{HLINE}\n\nlatex = {cls.latex}')
        if (cls.latex == 'y'):
            print(f'\nStarting xmeccanism to create {cls.submodel}nism.pdf')
            os.chdir('latex')
            smclfile = '../smcl/messy_mecca.f90'
            if ((cls.bm3d) and (cls.submodel != 'mecca')):
                runcmd(f"sed 's/mecca/{cls.submodel}/gI' meccanism.tex " +
                       f"> {cls.submodel}nism.tex")
                shutil.copy('meccalit.bib', f'{cls.submodel}lit.bib')
                smclfile = f'../../../../smcl/messy_{cls.submodel}.f90'
            # define submodel version:
            with open(smclfile) as f:
                for line in f:
                    if re.search('modver\s*=', line, re.IGNORECASE):
                        MODVER = re.search("'(.*)'", line).group(1)
                        break
            with open(f'{cls.submodel}_info.tex', 'w') as f_info:
                print('%% %s' % (DONTEDIT),                                    file=f_info)
                print('%% %s' % (TIMESTAMP),                                   file=f_info)
                print('\\def\\%sversion{\\code{%s}}' % (cls.submodel, MODVER), file=f_info)
                print('\\def\\kppversion{\\code{%s}}' % (cls.KPP_VERSION),     file=f_info)
                print('\\def\\gaseqnfile{\\code{%s}}' % (cls.gaseqnfile),      file=f_info)
                print('\\def\\wanted{\\code{%s}}' % (cls.wanted),              file=f_info)
                print('\\def\\inifile{\\code{%s}}' % (cls.inifile_short),      file=f_info)
                print('\\def\\integr{\\code{%s}}' % (cls.integr),              file=f_info)
                print('\\def\\rplfile{\\code{%s}}' % (cls.rplfile),            file=f_info)
                print('\\def\\apn{%s}' % (cls.apn),                            file=f_info)
                print('\\def\\gasspc{%s}' % (gas_spc),                         file=f_info)
                print('\\def\\aqspc{%s}' % (aq_spc),                           file=f_info)
                print('\\def\\allspc{%s}' % (all_spc),                         file=f_info)
                print('\\def\\Geqns{%s}' % (G_eqns),                           file=f_info)
                print('\\def\\Aeqns{%s}' % (A_eqns),                           file=f_info)
                print('\\def\\Heqns{%s}' % (H_eqns),                           file=f_info)
                print('\\def\\Jeqns{%s}' % (J_eqns),                           file=f_info)
                print('\\def\\PHeqns{%s}' % (PH_eqns),                         file=f_info)
                print('\\def\\HETeqns{%s}' % (HET_eqns),                       file=f_info)
                print('\\def\\EQeqns{%s}' % (EQ_eqns),                         file=f_info)
                print('\\def\\IEXeqns{%s}' % (IEX_eqns),                       file=f_info)
                print('\\def\\TAGeqns{%s}' % (TAG_eqns),                       file=f_info)
                print('\\def\\Deqns{%s}' % (D_eqns),                           file=f_info)
                print('\\def\\alleqns{%s}' % (all_eqns),                       file=f_info)
            cls.spc2tex()
            cls.eqn2tex()
            # run pdflatex to generate meccanism.pdf:
            from xmeccanism import xmeccanism
            xmeccanism(f'{cls.submodel}nism')
            if (shutil.which('acro')):
                os.system(f'acro {cls.submodel}nism.pdf &')
            else:
                os.system(f'acroread {cls.submodel}nism.pdf &')
            os.chdir(MECCADIR)

    ##########################################################################

    @classmethod
    def execute_graphviz(cls):
        print(f'\n{HLINE}\n\ngraphviz = {cls.graphviz}')
        if (cls.graphviz == 'y'):
            if (shutil.which('dot')):
                print('\nRunning graphviz...')
                runcmd(f'(cd graphviz ; ./xgraphvizall {cls.submodel} {cls.deltmp})')
            else:
                print('\nWARNING: graphviz is not available on this machine')

    ##########################################################################

    @classmethod
    def cleanup(cls):
        print(f'\n{HLINE}\n\ndeltmp = {cls.deltmp}')
        if (cls.deltmp == 'y'):
            print('\nDeleting temporary files...')
            def add_to_tmpfiles(filename):
                if (os.path.isfile(filename)):
                    tmpfiles.append(filename)
            if (cls.submodel == 'mtchem'):
                # temporary MTCHEM files:
                tmpfiles = glob('latex/*{cls.submodel}*')
                # don't delete pdf:
                if (f'latex/{cls.submodel}nism.pdf' in tmpfiles):
                    tmpfiles.remove(f'{cls.submodel}nism.pdf')
                add_to_tmpfiles(f'{cls.submodel}.eqn')
                add_to_tmpfiles(f'{cls.submodel}.spc')
                add_to_tmpfiles(f'messy_{cls.submodel}_kpp.kpp')
                for tmpfile in tmpfiles:
                    os.remove(tmpfile)
            tmpfiles = glob('tmp_*')
            # temporary LaTeX files:
            add_to_tmpfiles(f'latex/{cls.submodel}nism.aux')
            add_to_tmpfiles(f'latex/{cls.submodel}nism.bbl')
            add_to_tmpfiles(f'latex/{cls.submodel}nism.blg')
            # temporary KPP files:
            add_to_tmpfiles(f'messy_{cls.submodel}_kpp_Model.f90')
            add_to_tmpfiles(f'messy_{cls.submodel}_kpp.map')
            add_to_tmpfiles(f'Makefile_messy_{cls.submodel}_kpp')
            for tmpfile in tmpfiles:
                print(f'Deleting: {tmpfile}')
                os.remove(tmpfile)
        else:
            print('\nKeeping temporary files')

    ##########################################################################

    @classmethod
    def exe(cls, inifile, mecnum=None):

        cls.inifile = inifile
        cls.mecnum =  mecnum

        print('\nxmecca = eXecute KPP on equations from MECCA chemistry')
        print('         For more information, read:')
        print('         http://www.mecca.messy-interface.org')

        # GO TO MECCA DIRECTORY:
        olddir = os.getcwd()
        os.chdir(MECCADIR)
        # BOX OR GLOBAL MODEL?
        cls.define_bm3d()
        # READ CONFIG (*.ini) FILE:
        cls.read_inifile()
        # DEFINE SUBMODEL (DEFAULT = MECCA):
        cls.define_submodel()
        # GENERATE MECCA SPECIES FILE:
        cls.generate_mecca_spc()
        # GENERATE MECCA EQUATION FILE:
        cls.generate_mecca_eqn()
        # EXECUTE KPP:
        cls.execute_kpp()
        # CALCULATE MECHANISM STATISTICS AND RUN PDFLATEX:
        cls.statistics_and_LaTeX()
        # GRAPHVIZ:
        cls.execute_graphviz()
        # CLEANUP:
        cls.cleanup()
        # BACK TO INITIAL DIRECTORY:
        os.chdir(olddir)

##############################################################################

if __name__ == '__main__':

    LOGFILENAME = MECCADIR + '/xmecca.log'
    LOGFILE = tee.stdout_start(LOGFILENAME, append=False) # stdout
    print('xmecca was run on %s at %s by user %s on machine %s' % (
        DATE_NOW, TIME_NOW, USER, HOST), file=LOGFILE)
    args = evaluate_command_line_arguments()
    if (args.inifile):
        # type inifile with or without ini/ directory name and extension .ini:
        inifile = '%s/ini/%s.ini' % (MECCADIR,
            os.path.splitext(re.sub('^ini/','',args.inifile))[0])
    else:
        inifile = fileselector(MECCADIR+'/ini', '*.ini',
            'Select a file which defines the chemistry mechanism that you\n' +
            'want to generate (or a subdirectory). Please type a number [q=quit]:')

    xmecca.exe(inifile, args.mecnum)

    print('\n%s\n%48s\n%s\n' % (HLINE, 'xmecca has finished', HLINE))
    tee.stdout_stop()
    print('Log output is now available in %s' % (LOGFILENAME))

##############################################################################
