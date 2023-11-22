#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-07-23 14:50:59 sander>

# montecarloplot: plot results from CAABA Monte-Carlo runs
# Rolf Sander, 2020

# https://www.machinelearningplus.com/plots/matplotlib-histogram-python-examples
# https://matplotlib.org/api/_as_gen/matplotlib.pyplot.hist.html

##############################################################################

import sys
assert sys.version_info >= (3, 6)
from viewport import viewport
from netCDF4 import Dataset, num2date
import matplotlib.pyplot as plt
import os
import numpy as np
from scipy import stats

HLINE =  '-' * 78

MINR2 = 0.1

##############################################################################

def get_varlist(ncid):
    varlist = []
    for var in ncid.variables:
        if var not in ncid.dimensions:
            varlist.append(var)
    return sorted(varlist)

def plot_k_histograms():
    print(f'{HLINE}\nPlotting histograms for: ', end='')
    for rxn in rxn_names:
        rxndata = k_end.variables[rxn][:]
        print(rxn, end=' ', flush=True)
        ax = viewport.next()
        plt.hist(rxndata, bins=50)
        plt.ylabel('Magnitude')
        plt.title(rxn)
    print()
    viewport.newpage()

def scatterplots(spc):
    def regrline(x):
        return intercept+x*slope
    spcdata = c_end.variables[spc][:]
    for rxn in rxn_names:
        rxndata = k_end.variables[rxn][:]
        # skip if all k values are the same:
        if (not np.amin(rxndata)<np.amax(rxndata)):
            continue
        # perform linear regression:
        slope, intercept, r, _, _ = stats.linregress(rxndata, spcdata)
        if (r**2 > MINR2):
            ax = viewport.next()
            plt.plot(rxndata, spcdata, '.', color='black')
            left, right = plt.xlim()
            plt.plot([left, right], [regrline(left), regrline(right)], color='red')
            plt.xlabel(f'{rxn} (r2={r**2:.2f})')
            plt.ylabel(spc)
            print(f'vs {rxn:8} {slope:25}, {intercept:25}, {r**2:.5f}')
        else:
            #print(f'vs {rxn:8} {slope:25}, {intercept:25}, {r**2:.5f} (not shown)')
            pass
    viewport.newpage()

def plot_c_histograms():
    for spc in spc_names:
        print(f'{HLINE}\n{spc} histogram and scatterplots (slope, intercept, r^2):')
        spcdata = c_end.variables[spc][:]
        ax = viewport.next()
        plt.hist(spcdata, bins=50)
        plt.ylabel('Magnitude')
        plt.title(spc)
        scatterplots(spc)

##############################################################################

if len(sys.argv)>1:
    outputdir = sys.argv[1]
    print(outputdir)
else:
    outputdir = 'output/montecarlo/latest'

viewport.init(4, 5, outputdir+'/montecarlo.pdf', 17, 10) # open pdf
viewport.newpage()

k_end = Dataset(outputdir+'/caaba_mecca_k_end.nc', 'r')
c_end = Dataset(outputdir+'/caaba_mecca_c_end.nc', 'r')

rxn_names = get_varlist(k_end)
spc_names = get_varlist(c_end)

plot_k_histograms()

plot_c_histograms()

print(HLINE)
print(f'\nTo show the results, type:\n  qpdfview {outputdir}/montecarlo.pdf &\n')

k_end.close()
c_end.close()

viewport.exit() # close pdf

##############################################################################
