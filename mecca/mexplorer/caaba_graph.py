#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-22 16:40:10 sander>

# caaba_graph: create and anylyze reaction mechanism with graph-tool
# Rolf Sander, 2020-....

##############################################################################

import sys
assert sys.version_info >= (3, 6)
import configparser
from rstools import evaluate_config_file, corename, HLINE2

##############################################################################

def evaluate_command_line_arguments():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--inifile', help='configuration file (*.ini)')
    args = parser.parse_args()
    return args

##############################################################################

if __name__ == '__main__':

    args = evaluate_command_line_arguments()
    inifile = args.inifile

    g = None
    config = evaluate_config_file('ini/'+inifile)
    if (config.has_section('define')):
        print(f'\n{HLINE2}\nDEFINE\n{HLINE2}')
        from define_graph import define_graph
        g = define_graph(config['define'])
    if (config.has_section('analyze')):
        print(f'\n{HLINE2}\nANALYZE\n{HLINE2}')
        from analyze_graph import analyze_graph
        g = analyze_graph(g, config['analyze'])
    if (config.has_section('info')):
        print(f'\n{HLINE2}\nINFO\n{HLINE2}')
        from info_graph import info_graph
        info_graph(g, config['info'])
    if (config.has_section('show')):
        print(f'\n{HLINE2}\nSHOW\n{HLINE2}')
        from show_graph import show_graph
        if (not config.has_option('show','outputfile')):
            config['show']['outputfile'] = corename(inifile)+'.pdf'
        show_graph(g, config['show'])
    
##############################################################################
