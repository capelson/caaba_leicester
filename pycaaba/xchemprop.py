#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-11-08 18:55:07 sander>

'''
xchemprop: convert tools/chemprop/chemprop.tbl to
messy_main_constants_chemprop_mem.f90 and create LaTeX documentation
Author: Rolf Sander, 2020-...
'''

# To ensure that the f90 file is always up-to-date, this script is
# called automatically by main.mk whenever chemprop.tbl has changed.

import sys, os
assert sys.version_info >= (3, 6)
__target__ = os.readlink(__file__) if os.path.islink(__file__) else __file__
CAABADIR = os.path.realpath(os.path.dirname(__target__)+'/..')
CHEMPROPDIR = f'{CAABADIR}/tools/chemprop'
sys.path.insert(1, os.path.realpath(CAABADIR+'/pycaaba'))
import re
from glob import glob
from rstools import HLINE
import shutil

HLINE_SMALL  = '-' * 36
USER = os.environ['USER']
DONTEDIT = 'Created automatically by xchemprop, DO NOT EDIT!'
INT_PUB_PAR = 'INTEGER, PUBLIC, PARAMETER ::'
DEBUG = True

##############################################################################

def compare_to_gas_spc(tbl_spc_list):
    # Compare order of species in *.tbl to that in *.spc:
    import difflib
    difflist = ''
    gas_spc_list = []
    with open(f'{CAABADIR}/mecca/gas.spc', 'r') as spcfile:
        for line in spcfile:
            result = re.search('(.+)=.+;', line)
            if (result):
                gas_spc_list.append(result.group(1).strip())
        for line in difflib.unified_diff(gas_spc_list, tbl_spc_list,n=0,lineterm=''):
            line = line.strip()
            if ((line=='+++') or (line=='---') or (line[0:2]=='@@')):
                continue # don't print such lines
            if ('Dummy' in line):
                break # skip rest of species in gas.spc
            difflist += line
    return difflist

##############################################################################

def add_string(string1, string2):
    # Add string2 to string1, using a comma as separator. If necessary,
    # also add a line break.
    separator = ''
    if (len(string1) > 0):
        separator = ', '
        if (len(re.sub('.*\n', '', string1))+len(string2) > 70):
            separator = ', &\n    '
    return string1 + separator + string2

##############################################################################

def process_tblfile(tblfilename, f90filename):

    errorstring = ''
    spcnum = 0
    nprop = 0
    texdefsstring = ''
    tbl_spc_list = []

    with open(tblfilename, 'r') as tblfile, open(f90filename, 'w') as f90file:
        print(f'! -*- f90 -*- {DONTEDIT}\n', file=f90file)
        print(HLINE_SMALL)
        print('col chemprop             default    ')
        print(HLINE_SMALL)

        # --------------------------------------------------------------------

        # start main loop over all lines of the *.tbl file:
        for line in tblfile:
            # skip empty lines:
            if (re.search('^ *$', line)):
                continue
            # skip comment line starting with '#':
            if (re.search('^#', line)):
                continue
            # skip line separator:
            if (re.search('^\\|-', line)):
                continue
            # LaTeX definitions:
            if (re.search('^\\\\', line)):
                texdefsstring += line
                continue
            # define properties:
            if (re.search('^\\| *<CHEMPROP>', line)):
                print('MODULE messy_main_constants_chemprop_mem\n',                                           file=f90file)
                print('  USE messy_main_constants_mem ! DP, STRLEN_KPPSPECIES, and molar masses of elements', file=f90file)
                print('  IMPLICIT NONE',                                                                      file=f90file)
                print('  PRIVATE',                                                                            file=f90file)
                print('  PUBLIC :: get_chemprop_index\n',                                                     file=f90file)
                integernum = 0
                realnum = 0
                stringnum = 0
                NAMES_CASK_I_CHEMPROP = ''
                NAMES_CASK_R_CHEMPROP = ''
                NAMES_CASK_S_CHEMPROP = ''
                chemprop = line.split('|') # split current line (field separator is '|' )
                nprop = len(chemprop)
                for i in range(2, nprop-1):
                    chemprop[i] = chemprop[i].strip()
                    if (re.search('^I_', chemprop[i])):
                        integernum += 1
                        print(f'  {INT_PUB_PAR} {chemprop[i]} = {integernum}', file=f90file)
                        NAMES_CASK_I_CHEMPROP = add_string(
                            NAMES_CASK_I_CHEMPROP, "'%-15s'" % re.sub('^I_', '', chemprop[i]))
                    if (re.search('^R_', chemprop[i])):
                        realnum += 1
                        print(f'  {INT_PUB_PAR} {chemprop[i]} = {realnum}', file=f90file)
                        NAMES_CASK_R_CHEMPROP = add_string(
                            NAMES_CASK_R_CHEMPROP, "'%-15s'" % re.sub('^R_', '', chemprop[i]))
                    if (re.search('^S_', chemprop[i])):
                        stringnum += 1
                        print(f'  {INT_PUB_PAR} {chemprop[i]} = {stringnum}', file=f90file)
                        NAMES_CASK_S_CHEMPROP = add_string(
                            NAMES_CASK_S_CHEMPROP, "'%-15s'" % re.sub('^S_', '', chemprop[i]))
                # header:
                print(f'  {INT_PUB_PAR} MAX_CASK_I_CHEMPROP = {integernum}',                        file=f90file)
                print(f'  {INT_PUB_PAR} MAX_CASK_R_CHEMPROP = {realnum}',                           file=f90file)
                print(f'  {INT_PUB_PAR} MAX_CASK_S_CHEMPROP = {stringnum}',                         file=f90file)
                print('  CHARACTER(LEN=STRLEN_KPPSPECIES), DIMENSION(MAX_CASK_I_CHEMPROP), &',      file=f90file)
                print('    PARAMETER, PUBLIC :: NAMES_CASK_I_CHEMPROP = (/ &',                      file=f90file)
                print(f'    {NAMES_CASK_I_CHEMPROP} /)',                                            file=f90file)
                print('  CHARACTER(LEN=STRLEN_KPPSPECIES), DIMENSION(MAX_CASK_R_CHEMPROP), &',      file=f90file)
                print('    PARAMETER, PUBLIC :: NAMES_CASK_R_CHEMPROP = (/ &',                      file=f90file)
                print(f'    {NAMES_CASK_R_CHEMPROP} /)',                                            file=f90file)
                print('  CHARACTER(LEN=STRLEN_KPPSPECIES), DIMENSION(MAX_CASK_S_CHEMPROP), &',      file=f90file)
                print('    PARAMETER, PUBLIC :: NAMES_CASK_S_CHEMPROP = (/ &',                      file=f90file)
                print(f'    {NAMES_CASK_S_CHEMPROP} /)',                                            file=f90file)
                print('  TYPE, PUBLIC :: t_meta_chemprop',                                          file=f90file)
                print('    CHARACTER(LEN=20) :: kppname',                                           file=f90file)
                print('    INTEGER, DIMENSION(MAX_CASK_I_CHEMPROP) :: cask_i',                      file=f90file)
                print('    REAL(DP), DIMENSION(MAX_CASK_R_CHEMPROP) :: cask_r',                     file=f90file)
                print('    CHARACTER(LEN=STRLEN_MEDIUM), DIMENSION(MAX_CASK_S_CHEMPROP) :: cask_s', file=f90file)
                print('  END TYPE t_meta_chemprop\n',                                               file=f90file)
                continue

            if (nprop == 0):
                print('ERROR: properties must be defined first!')
                sys.exit(1)

            # define LaTeX info:
            if (re.search('^\\| *<LATEX>', line)):
                # split current line (field separator is '|' ) and save in 'latex':
                latex = line.split('|')
                latextoken = [None] * len(latex)
                texstring = []
                printlatex = False
                for i in range(2, nprop-1):
                    latex[i] = latex[i].strip()
                    latextoken[i] = ''
                    if (re.search('^<', latex[i])):
                        latex[i] = re.sub('^< *', '', latex[i])
                        texstring.append('') # create new item in list
                        latexstring = ''
                        printlatex = True
                        latextoken[i] = '<'
                        columns = 'l'
                    if (re.search('>$', latex[i])):
                        latex[i] = re.sub(' *>$', '', latex[i])
                        if (latextoken[i] == '<'):
                          latextoken[i] = '='
                        else:
                          latextoken[i] = '>'
                    if (printlatex):
                        columns += 'll'
                        latexstring = f'{latexstring} & {latex[i]} & Reference '
                    if (latextoken[i]=='>' or latextoken[i]=='='):
                        header = f'KPP name{latexstring}\\\\\n\\hline'
                        texstring[-1] += '\\begin{longtable}{%s}\n'      % (columns)
                        texstring[-1] += '\\hline\n%s\n\\endfirsthead\n' % (header)
                        texstring[-1] += '\\hline\n%s\n\\endhead\n'      % (header)
                        texstring[-1] += '\\hline\n\\endfoot\n'
                        printlatex = False
                continue

            # define defaultvalue:
            if (re.search('^\\| *<DEFAULT>', line)):
                # split current line (field separator is '|' ):
                defaultvalue = line.split('|')
                n = len(defaultvalue)
                for i in range(2, n-1):
                    defaultvalue[i] = defaultvalue[i].strip()
                    print(f'{i:3} {chemprop[i]:20.20} {defaultvalue[i]}')
                continue

            # data entry:
            spcnum += 1
            integerdata = ''
            realdata = ''
            stringdata = ''
            # split current line (field separator is '|' ):
            items = line.split('|')
            n = len(items)
            kppname = items[1].strip()
            if kppname in tbl_spc_list:
                print(f'ERROR: duplicate species {kppname}')
                sys.exit(1)
            else:
                tbl_spc_list.append(kppname)
            if (n != nprop):
                print(f'ERROR: {line}')
                sys.exit(1)

            texstringnum = -1
            printlatex = False
            # loop over data columns:
            for i in range(2, n-1):
                item = items[i].strip()
                # if empty, use default:
                if (item == ''):
                    item = defaultvalue[i]
                    if (item == ''):
                        print(f'ERROR: {chemprop[i]} is missing for {kppname} (there is no default).')
                        sys.exit(1)

                if (latextoken[i]=='<' or latextoken[i]=='='):
                    printlatex = True
                    texstringnum += 1
                    texstring[texstringnum] += kppname + ' '

                # store BibTeX references like {&1400} in ref:
                ref = re.findall('{&([^}]+)}', item)
                if (ref):
                    ref = ref[0]
                    # delete bibliography info from item:
                    item = re.sub(' *{&'+ref+'*} *', '', item)
                    if (ref=='SN'):
                        ref = 'see notes'
                    else:
                        # put each BibTeX reference into \citet{}
                        # here, '&' represents the matched regexp:
                        ref = re.sub('([^, ]+)', r'\\citet{\1}', ref)
                else:
                    ref = '???'

                if (printlatex):
                    latexitem = re.sub('_', '\\\\_', item)
                    texstring[texstringnum] += f'& {latexitem} & {ref} '

                if (latextoken[i]=='>' or latextoken[i]=='='):
                    texstring[texstringnum] += '\\\\\n'
                    printlatex = False

                # integer:
                if (re.search('^I_', chemprop[i])):
                    integerdata = add_string(integerdata, item)

                # real:
                if (re.search('^R_', chemprop[i])):
                    if (chemprop[i] == 'R_molarmass'):
                        # convert sum formula into molar mass:
                        item = re.sub('([A-Z][a-z]?)', '+M\\1*', item)
                        item = re.sub('^\\+', '', item)
                        item = re.sub('\\*\\+', '+', item)
                        item = re.sub('\\*$', '', item)

                    # add '_DP' to all REAL numbers:
                    realdata = add_string(realdata,
                      re.sub('([0-9]+\\.?[0-9]*([eE][-+]?[0-9]+)?)', '\\1_DP', item))

                # string:
                if (re.search('^S_', chemprop[i])):
                    # the number 24 here must be identical to STRLEN_MEDIUM:
                    stringdata = add_string(stringdata, f"'{item:24}'")

            print(f'  TYPE(t_meta_chemprop), PARAMETER :: spc_{spcnum:03} = t_meta_chemprop( &', file=f90file)
            print(f"    '{kppname}', &",                   file=f90file)
            print(f'    (/ {integerdata} /), & ! integer', file=f90file)
            print(f'    (/ {realdata} /), & ! real',       file=f90file)
            print(f'    (/ {stringdata} /) ) ! string\n',  file=f90file)

        # end of main loop over all lines of the *.tbl file

        # --------------------------------------------------------------------

        print(HLINE_SMALL)
        # Create f90 variable 'chemprop' in f90file:
        spcnumlist = ''
        print('  ! combine all species into one array:',                         file=f90file)
        print(f'  {INT_PUB_PAR} N_CHEMPROP = {spcnum}',                          file=f90file)
        print('  TYPE(t_meta_chemprop), PUBLIC, PARAMETER, DIMENSION(N_CHEMPROP) :: chemprop = &', file=f90file)
        for i in range(spcnum):
             spcnumlist = add_string(spcnumlist, f'spc_{i+1:03}')
        print(f'    (/ {spcnumlist} /)\n',                                       file=f90file)
        print('CONTAINS\n',                                                      file=f90file)
        print('  INTEGER FUNCTION get_chemprop_index(name)',                     file=f90file)
        print('    IMPLICIT NONE',                                               file=f90file)
        print('    CHARACTER(LEN=*), INTENT(IN)  :: name',                       file=f90file)
        print('    INTEGER :: i',                                                file=f90file)
        print('    get_chemprop_index = 0 ! dummy value for non-existing index', file=f90file)
        print('    DO i = 1, N_CHEMPROP',                                        file=f90file)
        print('      IF (TRIM(chemprop(i)%kppname)==name) THEN',                 file=f90file)
        print('        get_chemprop_index = i',                                  file=f90file)
        print('      ENDIF',                                                     file=f90file)
        print('    ENDDO',                                                       file=f90file)
        print('  END FUNCTION get_chemprop_index',                               file=f90file)
        print('\nEND MODULE messy_main_constants_chemprop_mem',                  file=f90file)

    # Put parts of LaTeX file together:
    with open(f'{CHEMPROPDIR}/chemprop.tex', 'w') as texfile:
        print(f'% {DONTEDIT}', file=texfile)
        with open(f'{CHEMPROPDIR}/chemprop_begin.tex') as f:
            print(f.read(), end='', file=texfile)
        print(texdefsstring, end='', file=texfile)
        for i in range(len(texstring)):
            texstring[i] += '\\end{longtable}\n\\newpage'
            print(texstring[i], end='', file=texfile)
        with open(f'{CHEMPROPDIR}/chemprop_end.tex') as f:
            print('\n'+f.read(), end='', file=texfile)

    # Compare order of species in chemprop.tbl to that in gas.spc:
    difflist = compare_to_gas_spc(tbl_spc_list)
    if (difflist):
        print('\nWARNING: The order of species in chemprop.tbl is ' +
              'not the same as that in gas.spc:')
        print(difflist)

##############################################################################

def xchemprop(tblfilename=None):

    olddir = os.getcwd()
    os.chdir(CHEMPROPDIR)

    print(f'\n{HLINE}\n\nStarting xchemprop...\n')

    if (tblfilename):
        f90filename = os.path.splitext(tblfilename)[0] + '.f90' # change extension
    else:
        tblfilename = 'chemprop.tbl' # default value
        f90filename = 'messy_main_constants_chemprop_mem.f90' # default value
    if os.path.exists(f90filename):
        os.remove(f90filename) # necessary if output is symlink into tag/ dir

    # ------------------------------------------------------------------------

    process_tblfile(tblfilename, f90filename)

    # ------------------------------------------------------------------------

    # Create chemprop.pdf if pdflatex is available:
    if (shutil.which('pdflatex')):
        print('\nCreating chemprop.pdf...')
        if (USER == 'sander'):
            # create chemprop.bib file, extracting references from literat.bib:
            os.system('pdflatex chemprop > /dev/null')
            os.system('gawk -f citetags.awk chemprop.aux | sort > citetags.log')
            os.system(
                'gawk -f citefind.awk citetags.log ~/tex/bib/literat.bib > chemprop.bib')
        os.system('pdflatex chemprop > /dev/null')
        os.system('bibtex   chemprop > /dev/null')
        os.system('pdflatex chemprop > /dev/null')
        os.system('pdflatex chemprop > /dev/null')
    else:
        print('\nSkipping generation of chemprop.pdf because pdflatex is not available.')

    # ------------------------------------------------------------------------

    list(map(os.remove, glob('tmp_*'))) # delete temporary files

    os.chdir(olddir)

##############################################################################

if __name__ == '__main__':

    if len(sys.argv) > 1:
        xchemprop(sys.argv[1]) # different input *.tbl file (e.g., for tagging)
    else:
        xchemprop()
    print(f'{sys.argv[0]} has finished successfully\n\n{HLINE}\n')

##############################################################################
