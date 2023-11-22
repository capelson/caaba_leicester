#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-21 13:38:43 sander>

import sys
assert sys.version_info >= (3, 6)
import os
import re
import graph_tool.all as gt
from tabulate import tabulate
import utils_graph as ug
from rstools import HLINE

__version__ = '1.0'
HELPTEXT = '''define a graph based on KPP files\n
example usage:
  %s''' % (os.path.basename(sys.argv[0]))
DEBUG = 0
BIPART = False # create also bipartite graph for Gupta analysis?

##############################################################################

def init_graph(verbose):
    g = gt.Graph()
    # make internal property maps:
    g.vp.name      = g.new_vertex_property('string')
    g.vp.atoms     = g.new_vertex_property('string') 
    g.vp.fillcolor = g.new_vertex_property('string') 
    # --
    g.ep.eqntag    = g.new_edge_property('string')
    g.ep.reactant  = g.new_edge_property('string')
    g.ep.prodstoic = g.new_edge_property('double') # stoic factor of product
    g.ep.rxnrate   = g.new_edge_property('double')
    # --
    g.gp.timestamp = g.new_graph_property('string')
    g.gp.batchfile = g.new_graph_property('string')
    g.gp.wanted    = g.new_graph_property('string')
    g.gp.mechanism = g.new_graph_property('object')
    g.gp.rxnrate   = g.new_graph_property('object')
    if verbose: g.list_properties()
    return g

##############################################################################

def define_composition(g, inputdir, verbose):
    # get elemental composition from *.spc file:
    SPCFILE = open(inputdir+'/mecca.spc')
    composition_dict = {}
    for line in iter(SPCFILE):
        search_result = re.search( r'^ *([A-z0-9_]+) *=([A-z0-9+ ]+);', line)
        if (not search_result): # skip lines that do not define a species
            continue
        spc_name = search_result.group(1)
        spc_composition = search_result.group(2).replace(' ','')
        if (spc_name[0:2]!='RR'): # ignore RR* rxn rate pseudo-species
            composition_dict[spc_name] = spc_composition
    SPCFILE.close()
    if verbose:
        print()
        print(tabulate(composition_dict.items(), headers=['Species', 'Composition']))
        print()
    return composition_dict

##############################################################################

def define_mechanism(g, inputdir, composition_dict, verbose):
    # get reactions from *.eqn file:
    rxnlist = []
    eqn_dictionary = {}
    EQNFILE = open(inputdir+'/mecca.eqn')
    for line in iter(EQNFILE):
        # skip lines that start with '//'
        if (re.search('^ *//', line)):
            continue
        line = re.sub('{[^}]*}', '', line) # delete all comments {...} from line
        # define graph property 'timestamp':
        search_result = re.search( r"timestamp *= *'(.*)'", line)
        if (search_result): 
            g.gp.timestamp = search_result.group(1)
        # define graph property 'batchfile':
        search_result = re.search( r"batchfile *= *'(.*)'", line)
        if (search_result): 
            g.gp.batchfile = search_result.group(1)
        # define graph property 'wanted':
        search_result = re.search( r"wanted *= *'(.*)'", line)
        if (search_result): 
            g.gp.wanted = search_result.group(1)
        # search for equation:
        search_result = re.search( r'<([A-Za-z_0-9]+)> *(.*)=(.*):.*;', line)
        if (not search_result): # skip lines that do not define a reaction
            if (DEBUG): print('NO:  |%s|' % (line))
            continue
        if (DEBUG): print(HLINE)
        eqntag        = search_result.group(1)
        rxnlist.append(eqntag)
        reactants_str = search_result.group(2).replace(' ','')
        products_str  = search_result.group(3).replace(' ','')
        # remove 1st species from product list if it is a reaction rate dummy RR*+:
        if (DEBUG): print('BEFORE: %s' % (products_str))
        products_str = re.sub('^RR[^+]*\+', '', products_str)
        if (DEBUG): print('AFTER:  %s' % (products_str))
        fullrxn_str = (reactants_str+' -> '+products_str).replace('+',' + ')
        # add space between stoichiometric number and species:
        fullrxn = re.sub('( [0-9.]+)', '\\1 ', fullrxn_str)
        if ((DEBUG) and (fullrxn_str!=fullrxn)):
            print('OLD: ', fullrxn_str)
            print('NEW: ', fullrxn)
        eqn_dictionary[eqntag] = fullrxn
        if (DEBUG): print('FULL: %9s %s' % ('<'+eqntag+'>', fullrxn))
        reactants = reactants_str.split('+')
        products  = products_str.split('+')
        prods     = [re.sub('^([0-9.]*)', '', x) for x in products] # w/o stoic numbers
        if (DEBUG): print('%10s %s -> %s' % ('<'+eqntag+'>', reactants_str, products_str))
        #---------------------------------------------------------------------
        # define a vertex for every species in this reaction if it doesn't exist already:
        for spc_name in reactants+prods:
            if (spc_name=='hv'): continue # ignore pseudo-reactant hv
            if (not gt.find_vertex(g, g.vp.name, spc_name)):
                # new species, add vertex to graph describing it:
                newvertex = g.add_vertex()
                g.vp.name[newvertex]  = spc_name
                if (spc_name in composition_dict):
                    g.vp.atoms[newvertex] = composition_dict[spc_name]
                else:
                    sys.exit('ERROR: ' + spc_name + ' is not defined in *.spc file:' +
                             '\n       ' + fullrxn)
                g.vp.fillcolor[newvertex]  = 'yellow'
                if (BIPART): bipart_insertSpeciesName(spc_name, composition_dict)
        #---------------------------------------------------------------------
        for reactant in reactants:
            if (reactant=='hv'): continue # ignore pseudo-reactant hv
            for product in products:
                # separate stoichiometric factor:
                search_result = re.search( '^([0-9.]*)(.*)', product)
                stoic = search_result.group(1)
                stoic = 1 if (stoic=='') else float(stoic)
                prod = search_result.group(2)
                if DEBUG: print(eqntag, prod, stoic)
                # add edge to graph describing this reaction:
                newedge = g.add_edge(g.vertex(ug.n2v(g,reactant)), g.vertex(ug.n2v(g,prod)))
                g.ep.prodstoic[newedge] = stoic
                g.ep.eqntag[newedge]    = eqntag
                other_reactants = reactants[:]
                other_reactants.remove(reactant)
                if other_reactants:
                    g.ep.reactant[newedge]  = '+'.join(other_reactants)
                else:
                    g.ep.reactant[newedge]  = '1st'
                if DEBUG: print('edge: %9s %s -> %s' % ('<'+eqntag+'>', reactant, product))
        if (BIPART): bipart_insertEdges(reactants, products, eqntag, composition_dict)
    EQNFILE.close()

    # define graph property 'mechanism':
    g.gp.mechanism = eqn_dictionary

    N_rxns = len(rxnlist)
    print(f'The mechanism has {N_rxns} reactions.')
    return g, N_rxns

##############################################################################

def define_rxnrates(g, inputdir, rxnfilename, N_rxns):

    from netCDF4 import Dataset, num2date
    ncid = Dataset(inputdir+'/'+rxnfilename)
    time = ncid.variables['time']
    mytime = len(time)-36 # last day at noon if delta_t = 20 min
    print('Selecting time', num2date(time[mytime],time.units), 'from', rxnfilename)
    rxnrates_dict = {}
    for rxn in ncid.variables:
        if (rxn[0:2]=='RR'):
            mydata = ncid.variables[rxn][mytime,0,0,0]
            rxnrates_dict[rxn[2:]] = mydata # dict with eqntags -> rxnrates
    ncid.close()
    N_rxnrates = len(rxnrates_dict)
    if (N_rxnrates != N_rxns):
        sys.exit(f'ERROR: Found {N_rxns} reactions but {N_rxnrates} reaction rates!')
    # store reaction rates in a graph property map:
    g.gp.rxnrate = rxnrates_dict
    # store reaction rates also in an edge property map because parallel
    # edges from different reactions may be combined later:
    for e in g.edges():
        eqntag = g.ep.eqntag[e]
        if (eqntag in rxnrates_dict):
            g.ep.rxnrate[e] = rxnrates_dict[eqntag]           
        else:
            sys.exit(f'ERROR: Cannot find reaction rate for {eqntag}!')
    return g

##############################################################################

# some functions for bipartite graphs for Gupta analysis:

def bipart_read_rxn_rates(inputdir):
    from netCDF4 import Dataset, num2date
    rxnfilename = 'caaba_mecca_rr.nc'
    ncid = Dataset(inputdir+'/'+rxnfilename)
    time = ncid.variables['time']
    mytime = len(time)-36 # last day at noon if delta_t = 20 min
    print('Selecting time', num2date(time[mytime],time.units), 'from ', rxnfilename)
    rxnrates = {}
    for rxn in ncid.variables:
        if (rxn[0:2]=='RR'):
            mydata = ncid.variables[rxn][mytime,0,0,0]
            rxnrates[rxn[2:]] = mydata
    ncid.close()
    return rxnrates # dict with eqntags -> rxnrates

def bipart_insertEdges(reactants, products, eqntag, composition_dict):
    rxnnum = -1-rxnlist.index(eqntag)
    for reactant in reactants:
        if (not reactant=='hv'):
            print('G.insertEdges(%4d, %4d, 1); // %s: %s ->' % (
                composition_dict.index(reactant)+1, rxnnum, eqntag, reactant), file=HPPFILE)
    for product in products:
        # remove stoichiometric factor:
        prod  = re.sub('^[0-9.]+', '', product)
        print('G.insertEdges(%4d, %4d, 2); // %s: -> %s' % (
            composition_dict.index(prod)+1, rxnnum, eqntag, prod), file=HPPFILE)
    # categorize reactions as slow and fast:
    if (rxnrates[eqntag]>1e-14):
        speed = 'FAST'
    else:
        speed = 'SLOW'
    print('G.insertIrreversibleRxns(%4d, %s); // %s' % (
        rxnnum, speed, eqntag), file=HPPFILE)        

def bipart_insertSpeciesName(spc_name, composition_dict):
    # if not hasattr(bipart_insertSpeciesName, 'counter'):
    #     bipart_insertSpeciesName.counter = 1
    # else:
    #     bipart_insertSpeciesName.counter += 1
    # spc_num = bipart_insertSpeciesName.counter
    # print >> HPPFILE, 'G.insertSpeciesName(%4d, "%s")' % (
    #     spc_num, spc_name)
    print('G.insertSpeciesName(%4d, "%s");' % (
        composition_dict.index(spc_name)+1, spc_name), file=HPPFILE)
                
##############################################################################

def define_graph(ini_define):
    # create a graph that contains the reaction mechanism:

    verbose     = ini_define.getboolean('verbose')
    inputdir    = ini_define.get('inputdir')
    outputfile  = ini_define.get('outputfile')
    rxnfilename = ini_define.get('rxnfilename')

    if (not rxnfilename):
        rxnfilename = 'caaba_mecca_rr.nc'
    if (not outputfile):
        outputfile = inputdir + '.xml.gz'
    inputdir   = 'input/' + inputdir

    g = init_graph(verbose)

    if (BIPART): HPPFILE = open('mecca.hpp','w')
    if (BIPART): rxnrates = bipart_read_rxn_rates(inputdir)

    # define elemental composition dictionary for all species in *.spc file:
    composition_dict = define_composition(g, inputdir, verbose)

    # define chemical species and their composition as vertices of the
    # graph, and define reactions and their stoichiometry as edges of
    # the graph:
    g, N_rxns = define_mechanism(g, inputdir, composition_dict, verbose)

    # define reaction rates:
    if (os.path.exists(inputdir+'/'+rxnfilename)):
        g = define_rxnrates(g, inputdir, rxnfilename, N_rxns)
    else:
        print(f'No file with reaction rates available')
        
    if (BIPART): HPPFILE.close()

    # save graph to file:
    g.save(outputfile)

    return g

##############################################################################

if __name__ == '__main__':

    print(f'use {sys.argv[0]} via caaba_graph.py, not directly!')

##############################################################################
