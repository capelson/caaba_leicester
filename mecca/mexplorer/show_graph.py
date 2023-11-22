#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-22 13:15:06 sander>

import sys
assert sys.version_info >= (3, 6)
import os
import re
import graph_tool.all as gt # https://graph-tool.skewed.de/static/doc/quickstart.html
import utils_graph as ug
import matplotlib.pyplot as plt
import numpy as np

__version__ = '1.0'
HELPTEXT = '''show a graph\n
example usage:
  %s graph.xml.gz''' % (os.path.basename(sys.argv[0]))
DEBUG = 0

##############################################################################

# layout for plotting with cairo, see:
# https://graph-tool.skewed.de/static/doc/draw.html#graph_tool.draw.graph_draw
def create_graph_draw(g, outputfile, v_plus=None, e_plus=None):
    v_dict = {
        'shape':'circle',
        #'color':'black',
        'fill_color':g.vp.fillcolor,
        #'font_size':9,
        #'text_position':-20,
        #'aspect':3,
        #'text':g.vp.vlabel,
        'size':20
        }
    e_dict = {
        #'text':g.ep.eqntag,
        #'text':g.ep.elabel,
        'pen_width':g.ep.penwidth,
        #'text_color':'black', # color of edge labels
        #'gradient':[0.5,0,0,0,1, 0.9,1,0,0,1],
        'marker_size':10,
        'end_marker':'arrow',
        #'font_size':9,
        #'color':'black'    # color of arrows
        }
    if (v_plus):
        v_dict.update(v_plus)
    if (e_plus):
        e_dict.update(e_plus)
    #pos = gt.sfdp_layout(g)
    #pos = gt.fruchterman_reingold_layout(g, n_iter=1000)
    #pos = gt.arf_layout(g)
    #pos = gt.planar_layout(g)
    #pos = gt.radial_tree_layout(g, g.vertex(0))
    gt.graph_draw(g,
                  #pos=pos, 
                  output_size=(6400, 3600), 
                  adjust_aspect=False,
                  vprops=v_dict,
                  eprops=e_dict,
                  output=outputfile)

##############################################################################

# layout for plotting with graphviz, see:
# http://www.graphviz.org/doc/info/attrs.html
def create_graphviz_draw(g, outputfile, g_plus=None, v_plus=None, e_plus=None):
    g_dict = {
        'layout':'dot', 
        'ratio':'auto',
        }
    v_dict = {
        #'color':'black', # circle around vertex
        'fillcolor':g.vp.fillcolor, # vertex fill color
        'fontname':'Helvetica',
        'label':g.vp.vlabel,
        'shape':'oval',
        'style':'filled',
        }
    e_dict = {
        'arrowhead':'normal',
        'arrowsize':1.2,
        'color':'#8888cc;0.9:#0000ff;0.1',
        'fontname':'Helvetica',
        'label':g.ep.elabel,
        'penwidth':g.ep.penwidth, # arrow thickness
        }
    if (g_plus):
        g_dict.update(g_plus)
    if (v_plus):
        v_dict.update(v_plus)
    if (e_plus):
        e_dict.update(e_plus)
    gt.graphviz_draw(g, # http://www.graphviz.org/doc/info/attrs.html
                     #pos=pos,
                     gprops=g_dict,
                     vprops=v_dict,
                     eprops=e_dict,
                     output=outputfile)

##############################################################################

def create_interactive_window(g, u):

    # https://graph-tool.skewed.de/static/doc/draw.html#graph_tool.draw.interactive_window
    # for options, see "List of vertex properties" at:
    # https://graph-tool.skewed.de/static/doc/draw.html#graph_tool.draw.graph_draw

    #-------------------------------------------------------------------------

    def keypressed(self, g, keyval, picked, pos, vprops, eprops):

        def redraw():
            # if self.picked == False:
            #     self.init_picked()
            # else:
            #     self.picked = False
            #     self.selected.fa = False
            #     self.vertex_matrix = None
            self.reset_layout()
            self.apply_transform()
            # self.fit_to_window()
            # self.regenerate_surface(reset=True)
            # self.queue_draw()
            print('redraw finished')

        def y_pressed(g, picked):
            N_species = g.num_vertices()
            print('Neighbors:')
            s_dist = gt.shortest_distance(g, source=picked)
            for v in g.vertices():
                distance = int(s_dist[v])
                if (distance<N_species):
                    print('distance to %s = %d' % (g.vp.name[v], distance))
            t_dist = gt.shortest_distance(gt.GraphView(g, reversed=True), source=picked)
            for v in g.vertices():
                distance = int(t_dist[v])
                if (distance<N_species):
                    print('distance from %s = %d' % (g.vp.name[v], distance))
            self.queue_draw()

        def x_pressed(g, picked):
            print('Sinks:')
            alleqntags = ','.join([g.ep.eqntag[edge] for edge in picked.out_edges()])
            if alleqntags:
                alleqntags = sorted(list(set(alleqntags.split(','))))
            for eqntag in alleqntags:
                print('%-15s %s' % ('<'+eqntag+'>', g.gp.mechanism[eqntag]))
            print('Sources:')
            alleqntags = ','.join([g.ep.eqntag[edge] for edge in picked.in_edges()])
            if alleqntags:
                alleqntags = sorted(list(set(alleqntags.split(','))))
            for eqntag in alleqntags:
                print('%-15s %s' % ('<'+eqntag+'>', g.gp.mechanism[eqntag]))

        def i_pressed(g):
            # for v in g.vertices():
            #     print('%s' % (g.vp.name[v]))
            print(f'{g.num_vertices()} species are visible:')
            print (', '.join([g.vp.name[v] for v in g.vertices()]))
            # print(g.vp.displayfilter.a)
            # for v in u.vertices():
            #     print('%d, %s' % (g.vp.displayfilter[v], g.vp.name[v]))

        def setfilter_s(n):
            s_dist = gt.shortest_distance(u, source=picked)
            if (DEBUG>1):
                for v in u.vertices():
                    print('%d steps from %s to %s' % (s_dist[v], u.vp.name[picked], u.vp.name[v]))
                    print()
            for v in u.vertices():
                g.vp.displayfilter[v] = (s_dist[v]<=n)
            redraw()
            if (DEBUG>1): print('displayfilter = ', g.vp.displayfilter.a)

        def setfilter_t(n):
            t_dist = gt.shortest_distance(gt.GraphView(u, reversed=True), source=picked)
            if (DEBUG>1):
                for v in u.vertices():
                    print('%d steps to %s from %s' % (t_dist[v], u.vp.name[picked], u.vp.name[v]))
                print()
            for v in u.vertices():
                g.vp.displayfilter[v] = (t_dist[v]<=n)
            redraw()
            if (DEBUG>1): print('displayfilter = ', g.vp.displayfilter.a)

        NSELECTED = 0
        if (DEBUG>1): print('you pressed the key: %s (%s)' % (chr(keyval), keyval))
        if (picked and keyval<65000):
            if isinstance(picked, gt.PropertyMap):
                NSELECTED = np.sum(picked.a)
                print('%d selected species:' % (NSELECTED), end=' ')
                for spec in np.where(picked.a==True)[0]:
                    print(g.vp.name[spec], end=' ')
                print()
            else:
                NSELECTED = 1
                print('one selected species: %s' % (g.vp.name[picked]))
        else:
            if (DEBUG): print('no species selected')
        if (chr(keyval)=='0'):
            g.vp.displayfilter.a = True
            print('drawing the whole graph')
            redraw()
        if (chr(keyval)=='i'):
            i_pressed(g)
        if (NSELECTED==1):
            if (chr(keyval)=='x'):
                x_pressed(g, picked)
            if (chr(keyval)=='y'):
                y_pressed(g, picked)
            if (chr(keyval)=='1'):
                setfilter_s(1)
            if (chr(keyval)=='2'):
                setfilter_s(2)
            if (chr(keyval)=='3'):
                setfilter_s(3)
            if (chr(keyval)=='4'):
                setfilter_t(1)
            if (chr(keyval)=='5'):
                setfilter_t(2)
            if (chr(keyval)=='6'):
                setfilter_t(3)
        print()

    #-------------------------------------------------------------------------

    def layoutchanged(self, g, picked, pos, vprops, eprops):
        print('layoutchanged')

        NSELECTED = 0
        if (picked):
            if isinstance(picked, gt.PropertyMap):
                NSELECTED = np.sum(picked.a)
                for spec in np.where(picked.a==True)[0]:
                    print(g.vp.name[spec], end=' ')
                print()
            else:
                NSELECTED = 1
                print(g.vp.name[picked])

    #-------------------------------------------------------------------------

    print('\nKeymap for interactive window:')
    print('- a:     autozoom')
    print('- i:     list visible species')
    print('- r:     resize and center')
    print('- s:     spring-block layout for all non-selected species')
    print('- x:     list sources and sinks of selected species')
    print('- y:     list neighbors of selected species')
    print('- z:     zoom to selected species')
    print('- 0:     draw the whole graph')
    print('- 1,2,3: show species 1,2,3 reactions away, starting from selected species')
    print('- 4,5,6: show species 1,2,3 reactions away, ending at selected species')
    print('Mouse actions for interactive window:')
    print('- left button:              select vertex')
    print('- middle button:            move')
    print('- right button:             unselect all')
    print('- wheel:                    zoom')
    print('- shift + wheel:            zoom (including vertex + edge sizes)')
    print('- control + wheel:          rotate')
    print('- shift + left button drag: select several species\n')

    g.vp.displayfilter = g.new_vertex_property('bool')
    g.vp.displayfilter.a = True
    for v in g.vertices():
        g.vp.displayfilter[v] = (g.get_in_degrees([v])==0)
        if DEBUG: print(f'in_degrees({g.vp.name[v]}) = {g.get_in_degrees([v])}')
    # if nothing was selected, show all species:
    if (max(g.vp.displayfilter.fa)==0):
        g.vp.displayfilter.a = True
    g.set_vertex_filter(g.vp.displayfilter)

    gt.interactive_window(
        g,
        geometry=(900, 800), # initial window size
        vprops={'text':g.vp.vlabel,
                'font_family':'helvetica',
                'font_size':15,
                #'text_color':'black',
                # 'text_out_color':'red', 'text_out_width':5, # no effect?
                'pen_width':0.5, # thickness of circle line
                'color':'black', # color of circle
                #'fill_color':g.vp.fillcolor,
                'fill_color':g.vp.fillcolor,
                'halo_color':[1.,0.,0.,0.4], # [r,g,b,opacity]
                'halo_size':1.3,
                'size':30
        },
        eprops={'text':g.ep.elabel,
                'text_distance':0,
                'color':'blue', # color of arrow
                'font_family':'helvetica',
                'marker_size':10, # size of arrowhead
                'pen_width':g.ep.penwidth,
                'dash_style':[0.03,0.01,0.],
                'gradient':[0.,0.,0.,0.,1., 0.9,1.,0.,0.,1.] # black -> red
        },
        #layout_callback=layoutchanged,
        key_press_callback=keypressed,
        highlight_color=[1.,0.7,0.,0.4], # [r,g,b,opacity] for neighbors of selected vertex
        #display_props=g.vp.name,
        display_props=[g.vp.name,g.vp.atoms],
        display_props_size=20
    )

##############################################################################

def show_graph(g, ini_show):

    verbose       = ini_show.getboolean('verbose')
    inputfile     = ini_show.get('inputfile')
    outputfile    = ini_show.get('outputfile')
    l_interactive = ini_show.getboolean('l_interactive')
    g_plus        = ini_show.get('g_plus')
    v_plus        = ini_show.get('v_plus')
    e_plus        = ini_show.get('e_plus')
    edge_label    = ini_show.get('edge_label')
    backend       = ini_show.get('backend', 'graphviz')

    if (inputfile):
        g = gt.load_graph(inputfile)
    g.purge_vertices()
    g.clear_filters()

    # create a view of the unfiltered graph, which will be necessary to
    # inspect the whole graph while a filter is active:
    u = gt.GraphView(g)

    # if label does not exist, use name:
    if (not 'vlabel' in g.vertex_properties):
        g.vp.vlabel = g.new_vertex_property('string')
        for v in g.vertices():
            g.vp.vlabel[v] = g.vp.name[v]

    # if penwidth does not exist, use 1.5:
    if (not 'penwidth' in g.edge_properties):
        g.ep.penwidth = g.new_edge_property('double', val=1.5)

    # if fillcolor does not exist, use 'yellow':
    if (not 'fillcolor' in g.vertex_properties):
        g.vp.fillcolor = g.new_vertex_property('string', val='yellow')

    # define elabel:
    if (not 'elabel' in g.edge_properties):
        g.ep.elabel = g.new_edge_property('string')
    for e in g.edges():
        if (DEBUG>1):
            print(f'{g.vp.name[e.source()]} {g.vp.name[e.target()]} <{g.ep.eqntag[e]}>')
        if (edge_label=='eqntag'):
            g.ep.elabel[e] = g.ep.eqntag[e]
        else:
            g.ep.elabel[e] = g.ep.reactant[e]
        nrxns = g.ep.eqntag[e].count(',')
        # if (nrxns>1):
        if (len(g.ep.elabel[e])>20):
            g.ep.elabel[e] = '%d rxns' % (nrxns+1)

    # if available, evaluate dictionary updates from config file:
    if(g_plus):
        g_plus = eval(g_plus)
    if(v_plus):
        v_plus = eval(v_plus)
    if(e_plus):
        e_plus = eval(e_plus)

    if (l_interactive):
        for v in g.vertices():
            g.vp.vlabel[v] = g.vp.name[v]
        # # line break if vlabel is too long:
        # for v in g.vertices():
        #     if (len(vlabel[v])>7):
        #         vlabel[v] = vlabel[v][:6] + '\n' + vlabel[v][6:]
        create_interactive_window(g, u)
    else:
        if (backend=='cairo'):
            create_graph_draw(g, outputfile, v_plus, e_plus)
        else:
            create_graphviz_draw(g, outputfile, g_plus, v_plus, e_plus)
        print('\nqpdfview %s &\n' % (outputfile))

##############################################################################

if __name__ == '__main__':

    print(f'use {sys.argv[0]} via caaba_graph.py, not directly!')
