#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-22 17:13:32 sander>

import sys
assert sys.version_info >= (3, 6)
import os
import re
import graph_tool.all as gt # https://graph-tool.skewed.de/static/doc/quickstart.html
import matplotlib.pyplot as plt
from textwrap import fill
import utils_graph as ug
from rstools import HLINE

__version__ = '1.0'
HELPTEXT = '''analyze a graph and write a modified graph\n
example usage:
  %s mecca_graph.xml.gz graph.xml.gz''' % (os.path.basename(sys.argv[0]))

# ##############################################################################

def set_vcolor_Fe(g):
    for v in g.vertices():
        # yelow for Fe(II):
        if (g.vp.name[v]=='Fepp_a01'):  g.vp.fillcolor[v] = 'yellow'
        if (g.vp.name[v]=='FeClp_a01'): g.vp.fillcolor[v] = 'yellow'
        if (g.vp.name[v]=='FeOHp_a01'): g.vp.fillcolor[v] = 'yellow'
        # red for Fe(IV):
        if (g.vp.name[v]=='FeOpp_a01'): g.vp.fillcolor[v] = 'red'
    return g

##############################################################################

def set_vcolor_oic(g):
    import re
    g.vp.oic = g.new_vertex_property('double') # oic
    oicfilename = 'input/current/OIC.dat'
    OICFILE = open(oicfilename)
    for line in iter(OICFILE):
        search_result = re.search( r'^ *([-+.Ee0-9]+) *([A-Za-z0-9_]+) *$', line)
        oic     = float(search_result.group(1))
        species = search_result.group(2)
        v = n2v(g,species) # vertex number of the species in the graph
        if (v<0):
            if (DEBUG>1):
                print('%s not in current mechanism' % (species))
            continue
        else:
            g.vp.oic[v] = oic
            # cd ~/messy/mecca/mechanism_reduction/skeleton_simple_organic
            # nvar = 462/663, nreact = 1444/2091, eps = 0.0007
            # nvar = 429/663, nreact = 1320/2091, eps = 0.00098
            # nvar = 411/663, nreact = 1262/2091, eps = 0.001372
            g.vp.fillcolor[v] = '#FF5555' # red = default
            if (oic>0.0007):   g.vp.fillcolor[v] = '#F1A65B'
            if (oic>0.00098):  g.vp.fillcolor[v] = 'yellow'
            if (oic>0.001372): g.vp.fillcolor[v] = 'green'
            if (DEBUG):
                print('%s has color %s' % (species, g.vp.fillcolor[v]))
    OICFILE.close()
    return g

##############################################################################

def set_vcolor_nC(g, elem_count):
    for v in g.vertices():
        nC = elem_count[g.vp.name[v]]['C']
        if(nC==1): g.vp.fillcolor[v] = 'red'
        if(nC==2): g.vp.fillcolor[v] = 'orange'
        if(nC==3): g.vp.fillcolor[v] = 'yellow'
        if(nC==4): g.vp.fillcolor[v] = 'green'
        if(nC==5): g.vp.fillcolor[v] = 'lightblue'
        if(nC==6): g.vp.fillcolor[v] = 'blue'
        if(nC==7): g.vp.fillcolor[v] = 'purple'
        if(nC==8): g.vp.fillcolor[v] = 'magenta'
        if(nC>=9): g.vp.fillcolor[v] = 'black'
    return g

##############################################################################

def create_max_flow(g, src, tgt, verbose):

    g.ep.cap = g.new_edge_property('double')
    for e in g.edges():
        eqntag = g.ep.eqntag[e]
        rxnrate = g.ep.rxnrate[e]
        prodstoic = g.ep.prodstoic[e] # stoic factor of product
        g.ep.cap[e] = prodstoic*rxnrate

    # choose one:
    res = gt.edmonds_karp_max_flow(g, src, tgt, g.ep.cap)
    #res = gt.push_relabel_max_flow(g, src, tgt, g.ep.cap)
    #res = gt.boykov_kolmogorov_max_flow(g, src, tgt, g.ep.cap)
    res.a = g.ep.cap.a - res.a  # the actual flow
    max_flow = sum(res[e] for e in tgt.in_edges())
    print('max flow: %g' % (max_flow))
    g.ep.penwidth = gt.prop_to_size(res, mi=1, ma=7, power=0.3)
    #-------------------------------------------------------------------------
    print() ; print() ; print('Sorted listing of important reactions from %s to %s:' % (
        g.vp.name[src], g.vp.name[tgt]))
    # put all info into mylist:
    mylist = []
    for e in g.edges():
        if (res[e]>0):
            mylist.append(
                [g.ep.cap[e], res[e], g.ep.penwidth[e], g.ep.eqntag[e],
                 g.vp.name[e.source()], g.vp.name[e.target()]])
    # sort and print mylist:
    print('  rxn rate       flow  penwidth             eqntag reaction')
    #for myitem in sorted(mylist, reverse=True, key=lambda tup: tup[0]):
    for myitem in sorted(mylist, key=lambda x: x[1]):
        print('%10.3g %10.3g     %-8.3g %15s %s -> %s' % (
            float(myitem[0]), float(myitem[1]), float(myitem[2]),
            "<"+myitem[3]+">", myitem[4], myitem[5]))
    #-------------------------------------------------------------------------
    # # filter out all edges that contribute < 1 %
    # for e in g.edges():
    #     if (res[e] < max_flow/100.):
    #         g.ep.myfilter[e] = False
    #     else:
    #         g.ep.myfilter[e] = True
    #     print g.ep.myfilter[e], res[e], g.ep.eqntag[e], g.gp.mechanism[g.ep.eqntag[e]]
    # g.set_edge_filter(g.ep.myfilter) # keep if True
    #-------------------------------------------------------------------------
    # filter out all vertices that contribute very little:
    keep = []
    delete = []
    for v in g.vertices():
        rxnrate = (sum(res[e] for e in v.in_edges()) +
                    sum(res[e] for e in v.out_edges())) / 2.
        if (rxnrate/max_flow < 1E-3):
            g.vp.myfilter[v] = False
            delete.append(g.vp.name[v])
        else:
            g.vp.myfilter[v] = True
            keep.append(g.vp.name[v])
    print('Keep: ', sorted(keep))
    print('Delete: ', sorted(delete))
    #-------------------------------------------------------------------------
    # vertex colors:
    for v in g.vertices():
        if('_a01' in g.vp.name[v]):
            g.vp.fillcolor[v] = 'lightblue'
        else:
            g.vp.fillcolor[v] = 'yellow'
    g.vp.fillcolor[src] = 'red'
    g.vp.fillcolor[tgt] = 'green'
    #-------------------------------------------------------------------------

    return g

##############################################################################

def set_filter_rxnrate(g, rate_threshold, verbose):

    # remove slow reactions, i.e., all edges where g.ep.rxnrate<rate_threshold
    print(f'\nreaction rate threshold filter')
    for e in g.edges():
        if (verbose):
            print(g.vp.name[e.source()], g.vp.name[e.target()],
                  g.ep.rxnrate[e], rate_threshold)
        if (g.ep.rxnrate[e]<rate_threshold):
            g.ep.myfilter[e] = False
    return g

##############################################################################

def set_filter_ovoc(g, elem_count, verbose):

    print(f'\novoc filter')
    for v in g.vertices():
        if('_a01' in g.vp.name[v]):
            print(f'aq:  {g.vp.name[v]}')
        else:
            print(f'gas: {g.vp.name[v]}')
            g.vp.myfilter[v] = False
        if (elem_count[g.vp.name[v]]['C']<1):
            g.vp.myfilter[v] = False
    return g

##############################################################################

def filter_out_C_increase(g, elem_count, verbose):

    # remove edges where number of C atoms increases:
    includes = []
    excludes = []
    for e in g.edges():
        if (elem_count[g.vp.name[e.source()]]['C'] <
            elem_count[g.vp.name[e.target()]]['C']):
            g.ep.myfilter[e] = False
            excludes.append(f'<{g.ep.eqntag[e]}> ' +
                            f'{g.vp.name[e.source()]} -> {g.vp.name[e.target()]}')
        else:
            includes.append(f'<{g.ep.eqntag[e]}> ' +
                            f'{g.vp.name[e.source()]} -> {g.vp.name[e.target()]}')
    if (excludes):
        print(f'\n{HLINE}\nList of edges excluded because n(C) increases\n{HLINE}\n')
        print('\n'.join([x for x in excludes]))
    return g

def set_filter_element(g, element, elem_count, verbose):

    print(f'\n{HLINE}\nElement filter for {element}\n{HLINE}\n')
    includes = []
    excludes = []
    for v in g.vertices():
        if (elem_count[g.vp.name[v]][element]>0):
            includes.append(g.vp.name[v])
        else:
            g.vp.myfilter[v] = False
            excludes.append(g.vp.name[v])
    if (verbose):
        print(fill(f'{len(includes)} species included: ' +
              ', '.join([x for x in includes])) + '\n')
        print(fill(f'{len(excludes)} species excluded: ' +
              ', '.join([x for x in excludes])))
    return g

def set_filter_src_tgt(g, src, tgt, N_v, elem_count, verbose):

    print(f'\n{HLINE}\nSource to target filter for ' +
          f'{g.vp.name[src]} -> {g.vp.name[tgt]}\n{HLINE}\n')
    # remove unreachable species:
    s_dist = gt.shortest_distance(g, source=src)
    g.set_reversed(True)
    t_dist = gt.shortest_distance(g, source=tgt)
    g.set_reversed(False)
    reachables = []
    unreachables = []
    for v in g.vertices(): # loop over filtered graph
        if (s_dist[v]<N_v and t_dist[v]<N_v):
            reachables.append(g.vp.name[v])
        else:
            unreachables.append(g.vp.name[v])
            g.vp.myfilter[v] = False
    if (verbose):
        print(fill(f'{len(reachables)} species included: ' +
              ', '.join([x for x in reachables]))   + '\n')
        print(fill(f'{len(unreachables)} species excluded: ' +
              ', '.join([x for x in unreachables])) + '\n')
    # show shortest path from source to target:
    print(f'The shortest path from {g.vp.name[src]} to {g.vp.name[tgt]} is\n')
    vlist, elist = gt.shortest_path(g, src, tgt)
    print(fill(' -> '.join([g.vp.name[v] for v in vlist])))
    print('\nvia these reactions:\n')
    for e in elist:
        print(f'{"<"+g.ep.eqntag[e]+">":16}{g.gp.mechanism[g.ep.eqntag[e]]}')
    return g, src, tgt

##############################################################################

def remove_parallel_edges_merge_elabels(g):
    # all parallel edges in g are reduced to just one edge in g2:
    g2 = gt.GraphView(g, efilt=gt.label_parallel_edges(g).fa == 0)
    # loop over the remaining edges in the simple graph:
    for e in g2.edges():
        # create a list with all edges from g that connect the same
        # vertices as the current edge in g2:
        edgelist = g.edge(e.source(), e.target(), all_edges=True)

        # calculate sum of all reaction rates:
        rxnrate = 0
        for edge in edgelist:
            rxnrate += g.ep.rxnrate[edge]
        g2.ep.rxnrate[e] = rxnrate

        # replace eqntag by comma-separated merged eqntag:
        # ("list(set())" removes duplicates)
        g2.ep.eqntag[e] = ','.join(
            list(set([g.ep.eqntag[edge] for edge in edgelist])))
        # replace reactant by comma-separated merged reactant:
        g2.ep.reactant[e] = ','.join(
            list(set([g.ep.reactant[edge] for edge in edgelist])))
    return g2

##############################################################################

def misc(src, tgt, elem_count):

    # create graph view gC with only organic species (C>=1):
    gC = gt.GraphView(g, vfilt=lambda v: elem_count[g.vp.name[v]]['C']>0)

    # for v in gC.vertices():
    #     print '%-15s %d %d %d %d' % (
    #         gC.vp.name[v], int(gC.vp.myfilter[v]),
    #         elem_count[gC.vp.name[v]]['C'], s_dist[v], t_dist[v])

    # remove edges where number of C atoms increases:
    print(HLINE) ; ug.list_edges(gC)
    gC = gt.GraphView(gC, efilt=lambda e:
                      elem_count[gC.vp.name[e.source()]]['C'] >=
                      elem_count[gC.vp.name[e.target()]]['C'])
    print(HLINE) ; ug.list_edges(gC)

    s_dist = gt.shortest_distance(gC, source=src)
    gC.set_reversed(True)
    t_dist = gt.shortest_distance(gC, source=tgt)
    gC.set_reversed(False)
    fraction = g.new_vertex_property('float')
    ug.list_vertices(gC)
    # remove unreachable species from graph:
    gC = gt.GraphView(gC, vfilt=lambda v: s_dist[v]<N_v and t_dist[v]<N_v)
    ug.list_vertices(gC)
    print('name, #C, %s->, ->%s, fraction' % (gC.vp.name[src], gC.vp.name[tgt]))
    for v in gC.vertices():
        fraction[v] = float(s_dist[v])/(s_dist[v]+t_dist[v])
        print('%-15s %d %d %d %s' % (
            gC.vp.name[v], elem_count[gC.vp.name[v]]['C'],
            s_dist[v], t_dist[v], fraction[v]))

    #-------------------------------------------------------------------------

    # centrality:
    # x = gt.katz(g)
    # print x.a

    #-------------------------------------------------------------------------

    # correlations:
    # https://graph-tool.skewed.de/static/doc/correlations.html
    # h = gt.corr_hist(g, 'out', 'out')
    # plt.clf()
    # plt.xlabel('Source out-degree')
    # plt.ylabel('Target out-degree')
    # plt.imshow(h[0].T, interpolation='nearest', origin='lower')
    # plt.colorbar()
    # plt.savefig('corr.pdf')

##############################################################################

def analyze_graph(g, ini_analyze):

    verbose         = ini_analyze.getboolean('verbose')
    l_maxflow       = ini_analyze.getboolean('l_maxflow')
    l_show_rxnrates = ini_analyze.getboolean('l_show_rxnrates')
    inputfile       = ini_analyze.get('inputfile')
    outputfile      = ini_analyze.get('outputfile')
    rate_threshold  = ini_analyze.get('rate_threshold')
    velemfilter     = ini_analyze.get('velemfilter')
    vfilter         = ini_analyze.get('vfilter')
    vcolor          = ini_analyze.get('vcolor')
    vlabel          = ini_analyze.get('vlabel')

    if (rate_threshold):
        rate_threshold = float(rate_threshold)
    
    # load graph produced by define_graph.py:
    if (inputfile):
        g = gt.load_graph(inputfile)
    N_v = g.num_vertices() # number of species

    src = ug.n2v(g,ini_analyze.get('src'))
    tgt = ug.n2v(g,ini_analyze.get('tgt'))

    # define dictionary with elemental composition:
    elem_count = ug.elemental_composition(g)

    g.ep.penwidth = g.new_edge_property('double', val=1.5)

    #-------------------------------------------------------------------------

    # filter some vertices and/or edges:
    g.vp.myfilter = g.new_vertex_property('bool') # vertex filter (internal property map)
    g.vp.myfilter.a = True
    g.set_vertex_filter(g.vp.myfilter) # keep if True

    g.ep.myfilter = g.new_edge_property('bool')   # edge filter   (internal property map)
    g.ep.myfilter.a = True
    g.set_edge_filter(g.ep.myfilter) # keep if True

    if (rate_threshold):
        g = set_filter_rxnrate(g, rate_threshold, verbose)  
    if (velemfilter):
        g = set_filter_element(g, velemfilter, elem_count, verbose)

    g = filter_out_C_increase(g, elem_count, verbose)
        
    if (vfilter=='ovoc'):
        g = set_filter_ovoc(g, elem_count, verbose)
    if (vfilter=='src_tgt'):
        g, src, tgt = set_filter_src_tgt(g, src, tgt, N_v, elem_count, verbose)

    # g.clear_filters()

    #-------------------------------------------------------------------------

    # fill colors for the vertices:
    if (vcolor=='Fe'):
        g = set_vcolor_Fe(g)
    if (vcolor=='oic'):
        g = set_vcolor_oic(g)
    if (vcolor=='nC'):
        g = set_vcolor_nC(g, elem_count)
        
    #-------------------------------------------------------------------------

    # labels for vertices:
    if (vlabel=='oic'):
        g = ug.set_labels_oic(g)

    #-------------------------------------------------------------------------

    if (l_maxflow):
        g = create_max_flow(g, src, tgt, verbose)

    # misc(src, tgt, elem_count)

    g = remove_parallel_edges_merge_elabels(g)

    # line thickness:
    if (l_show_rxnrates):
        g.ep.penwidth = gt.prop_to_size(g.ep.rxnrate, mi=1, ma=7, power=0.3)
                
    # save graph to file:
    if (outputfile):
        g.save(outputfile)

    return g

##############################################################################

if __name__ == '__main__':

    print(f'use {sys.argv[0]} via caaba_graph.py, not directly!')
