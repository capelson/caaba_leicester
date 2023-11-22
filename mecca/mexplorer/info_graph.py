#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-22 14:34:13 sander>

import sys
assert sys.version_info >= (3, 6)
import os
import graph_tool.all as gt # https://graph-tool.skewed.de/static/doc/quickstart.html
from tabulate import tabulate
from textwrap import fill
import utils_graph as ug
from rstools import HLINE

__version__ = '1.0'

##############################################################################

ARGV0 = os.path.basename(sys.argv[0])
HELPTEXT = '''Show info about a chemical mechanism which is stored in 
graph-tool format in a *.xml.gz file.\n
Example usage:
  %s -s chapman.xml.gz       -> show all species
  %s -r chapman.xml.gz       -> show all reactions
  %s -si CH4,3 simple.xml.gz -> show CH4 sinks and species produced in <=3 steps
  %s -so HCHO simple.xml.gz  -> show sources of HCHO and species producing it
''' % tuple([ARGV0]*4)

def evaluate_command_line_arguments():
    import argparse
    parser = argparse.ArgumentParser(description=HELPTEXT,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('inputfile')
    parser.add_argument('-v',  '--verbose',    action='store_true',
                        help='verbose output')
    parser.add_argument('-g',  '--graph',      action='store_true',
                        help='show general info about graph')
    parser.add_argument('-d',  '--delta_C',    action='store_true',
                        help='show Delta C of reactions')
    parser.add_argument('-s',  '--species',    action='store_true',
                        help='show chemical species')
    parser.add_argument('-r',  '--reactions',  action='store_true',
                        help='show chemical reactions')
    parser.add_argument('-e',  '--edges',      action='store_true',
                        help='show edges')
    parser.add_argument('-p',  '--primary',    action='store_true',
                        help='show primary species')
    parser.add_argument('-f',  '--final',      action='store_true',
                        help='show final products')
    parser.add_argument('-c',  '--components', action='store_true',
                        help='show strongly connected components')
    parser.add_argument('--sort_rxnrate', action='store_true',
                        help='sort by reaction rates')
    parser.add_argument('-so', '--sources',    default=None, help='tgt,steps')
    parser.add_argument('-si', '--sinks',      default=None, help='src,steps')
    args = parser.parse_args()
    return args

##############################################################################

def info_graph(g, ini_info, args=None):

    if (args):
        # take values in argparse from command line arguments:
        verbose           = args.verbose
        l_show_graph      = args.graph
        l_show_delta_C    = args.delta_C
        l_show_species    = args.species
        l_show_reactions  = args.reactions
        l_show_edges      = args.edges
        l_show_primary    = args.primary
        l_show_final      = args.final
        l_show_components = args.components
        l_sort_rxnrate    = args.sort_rxnrate
        show_sources      = args.sources
        show_sinks        = args.sinks
    else:
        # take values in ini_info from config (*.ini) file
        verbose           = ini_info.getboolean('verbose')
        inputfile         = ini_info.get('inputfile')
        l_show_graph      = ini_info.getboolean('l_show_graph')
        l_show_delta_C    = ini_info.getboolean('l_show_delta_C')
        l_show_species    = ini_info.getboolean('l_show_species')
        l_show_reactions  = ini_info.getboolean('l_show_reactions')
        l_show_edges      = ini_info.getboolean('l_show_edges')
        l_show_primary    = ini_info.getboolean('l_show_primary')
        l_show_final      = ini_info.getboolean('l_show_final')
        l_show_components = ini_info.getboolean('l_show_components')
        l_sort_rxnrate    = ini_info.getboolean('l_sort_rxnrate')
        show_sources      = ini_info.get('show_sources')
        show_sinks        = ini_info.get('show_sinks')
        if (inputfile):
            g = gt.load_graph(inputfile)

    g.purge_vertices()
    g.clear_filters()

    elem_count = ug.elemental_composition(g) # dictionary with elemental composition
        
    if (l_show_species):
        print(f'\n{HLINE}\nList of all ({g.num_vertices()}) species ' +
              f'(and their elemental composition)\n{HLINE}\n')
        for v in g.vertices():
            print('%-15s (%s) ' % (g.vp.name[v], g.vp.atoms[v]))

    eqntagset = set()
    for e in g.edges():
        # if g.ep.eqntag[e] is list of comma-separated merged eqntag, split it:
        for tag in g.ep.eqntag[e].split(','):
            eqntagset.add(tag)
    if (l_show_reactions):
        print(f'\n{HLINE}\nList of all ({len(eqntagset)}) reactions\n{HLINE}\n')
        infolist = []
        for eqntag,fullrxn in g.gp.mechanism.items():
            if (eqntag in eqntagset):
                if (g.gp.rxnrate): # rxn rates are available
                    infolist.append(['<'+eqntag+'>', fullrxn, g.gp.rxnrate[eqntag]])
                else: # rxn rates are not available
                    infolist.append(['<'+eqntag+'>', fullrxn])
        sorted_infolist = sorted(infolist) # sort by eqntag
        if (g.gp.rxnrate):
            print('eqntag                rxnrate reaction')
            if (l_sort_rxnrate):
                sorted_infolist = sorted(infolist, key=lambda x: x[2]) # sort by rxnrate
            for rxn in sorted_infolist:
                print(f'{rxn[0]:16s} {rxn[2]:12g} {rxn[1]}')
        else:
            print('eqntag            reaction')
            for rxn in sorted_infolist:
                print(f'{rxn[0]:16s} {rxn[1]}')
                
    if (l_show_edges):
        print(f'\n{HLINE}\nList of all ({g.num_edges()}) edges\n{HLINE}\n')
        edgelist = []
        for e in g.edges():
            if (l_show_delta_C):
                nC_source = f'({elem_count[g.vp.name[e.source()]]["C"]}C)'
                nC_target = f'({elem_count[g.vp.name[e.target()]]["C"]}C)'
            else:
                nC_source = ''
                nC_target = ''
            fromstring = f'{g.vp.name[e.source()]} {nC_source}'
            tostring   = f'{g.vp.name[e.target()]} {nC_target}'
            rxnstring  = f'<{g.ep.eqntag[e]}> {g.gp.mechanism[g.ep.eqntag[e]]}'
            edgelist.append([fromstring, tostring, rxnstring])
        print(tabulate(edgelist, headers=['From', 'To', 'Reaction']))

    if (l_show_components):
        print(f'\n{HLINE}\nList of all strongly connected components ' +
              f'("families") with >1 species\n{HLINE}\n')
        #comp, _ = gt.label_components(g, directed=False)
        comp, _ = gt.label_components(g)
        for i in range(max(comp.a)+1):
            spclist = []
            for v in g.vertices():
                if (comp[v]==i):
                    spclist.append(g.vp.name[v])
            if (len(spclist)>1):
                print(fill(f'--> ' + ', '.join(spclist)))

    # print sources and sinks, i.e., vertices with in-degree=0 or out-degree=0:
    list_of_sources = []
    list_of_sinks   = []
    for v in g.vertices():
        if (g.get_in_degrees([v])==0):
            list_of_sources.append(g.vp.name[v])
        if (g.get_out_degrees([v])==0):
            list_of_sinks.append(g.vp.name[v])
    if (l_show_primary):
        print(f'\n{HLINE}\nList of all ({len(list_of_sources)}) sources\n{HLINE}\n')
        print(fill(', '.join(list_of_sources)))
    if (l_show_final):
        print(f'\n{HLINE}\nList of all ({len(list_of_sinks)}) sinks\n{HLINE}\n')
        print(fill(', '.join(list_of_sinks)))

    if (show_sources):
        predecessors = show_sources.split(',')
        src = predecessors[0]
        print(f'\n{HLINE}\nList of species that produce {src}\n{HLINE}\n')
        steps = int(predecessors[1]) if len(predecessors)>1 else 1
        sourcelist = [''] * steps
        t_dist = gt.shortest_distance(gt.GraphView(g, reversed=True), source=ug.n2v(g,src))
        for v in g.vertices():
            if ((t_dist[v]>0) and (t_dist[v]<=steps)):
                sourcelist[t_dist[v]-1] += g.vp.name[v] + ' '
                #print('%d steps to %s from %s' % (t_dist[v], src, g.vp.name[v]))
        for i in range(steps):
            if (i==0):
                print(f'{src} is produced directly from:')
                print(sourcelist[i], '\n')
                alltags = ','.join([g.ep.eqntag[edge] for edge in ug.n2v(g,src).in_edges()])
                if alltags:
                    alltags = sorted(list(set(alltags.split(','))))
                for eqntag in alltags:
                    print('%-15s %s' % ('<'+eqntag+'>', g.gp.mechanism[eqntag]))
            else:
                print(f'\nIn {i+1} steps, {src} is produced from:')
                print(fill(sourcelist[i]))
                        
    if (show_sinks):
        successors = show_sinks.split(',')
        tgt = successors[0]
        print(f'\n{HLINE}\nList of species produced from {tgt}\n{HLINE}\n')
        steps = int(successors[1]) if len(successors)>1 else 1
        sinklist = [''] * steps
        s_dist = gt.shortest_distance(g, source=ug.n2v(g,tgt))
        for v in g.vertices():
            if ((s_dist[v]>0) and (s_dist[v]<=steps)):
                sinklist[s_dist[v]-1] += g.vp.name[v] + ' '
                #print('%d steps from %s to %s' % (s_dist[v], tgt, g.vp.name[v]))
        for i in range(steps):
            if (i==0):
                print(f'{tgt} reacts directly to:')
                print(sinklist[i], '\n')
                alltags = ','.join([g.ep.eqntag[edge] for edge in ug.n2v(g,tgt).out_edges()])
                if alltags:
                    alltags = sorted(list(set(alltags.split(','))))
                for eqntag in alltags:
                    print('%-15s %s' % ('<'+eqntag+'>', g.gp.mechanism[eqntag]))
            else:
                print(f'\nIn {i+1} steps, {tgt} reacts to:')
                print(fill(sinklist[i]))
                
    if (l_show_graph):
        print(f'\n{HLINE}\nGeneral information about graph\n{HLINE}\n')
        print(f'N_species:   {g.num_vertices()}')
        print(f'N_reactions: {len(eqntagset)}')
        print(f'N_edges:     {g.num_edges()}')
        print('\nGraph, vertex and edge properties:')
        g.list_properties()

    print(f'\n{HLINE}')
    
##############################################################################

if __name__ == '__main__':

    args = evaluate_command_line_arguments()
    g = gt.load_graph(args.inputfile)
    info_graph(g, ini_info=None, args=args)
