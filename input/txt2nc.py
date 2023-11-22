#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-06-29 15:50:37 sander>

# Rolf Sander, 2017-...

import sys
assert sys.version_info >= (3, 6)
from os.path import splitext
import numpy as np
from netCDF4 import Dataset # http://unidata.github.io/netcdf4-python

def range1(n):
    # range1 goes from 1 to n (unlike range which goes from 0 to n-1)
    return [i+1 for i in range(n)]

def txt2nc(filename, time_unit, time_name, verbose=False):
    # read data from *.txt file:
    txtdata = np.genfromtxt(filename+'.txt', names=True, comments='#')
    # write data to *.nc file:
    ncfile = Dataset(filename+'.nc', 'w', format='NETCDF3_CLASSIC')
    # Create dimensions:
    time = ncfile.createDimension(time_name, None)
    # Create coordinate variables:
    times = ncfile.createVariable(time_name, np.float64, (time_name,))
    times.units = time_unit # default is a dummy value
    times[:] = range1(txtdata.size) # dummy time values 1,2,3,...

    # global attributes for nml variables:
    ncfile.description             = 'multirun input file created by txt2nc.py'
    
    for col,name in enumerate(txtdata.dtype.names):
        if verbose: print(col, name, txtdata[name])
        if (name==time_name):
            times[:] = txtdata[time_name]
        else:
            var = ncfile.createVariable(name, np.float64, (time_name,))
            var[:] = txtdata[name]
            ## add some attibutes:
            var.units = 'mol/mol' # default unit for mixing ratio
            if (name == 'LON'):
                var.units = 'degrees east' # longitude
            if (name == 'LAT'):
                var.units = 'degrees north' # latitude
            if (name == 'TEMP'):
                var.units = 'K' # temperature
            if (name == 'PRESS'):
                var.units = 'Pa' # pressure
            if (name == 'SPECHUM'):
                var.units = 'kg/kg' # specific humidity
            if (name[0:2]=='J_'):
                var.units = '1/s' # J value
            var.long_name = name # a nice long name that describes the data
    ncfile.close()

if __name__ == '__main__':
    if len(sys.argv)>3:
        time_name = sys.argv[3]
    else:
        time_name = 'TIME'
    if len(sys.argv)>2:
        time_unit = sys.argv[2]
    else:
        time_unit = 'seconds since 2000-01-01 00:00:00'
    if len(sys.argv)>1:
        filename = splitext(sys.argv[1])[0] # without extension
        print('Converting %s.txt to %s.nc' % (filename, filename))
        txt2nc(filename, time_unit, time_name, verbose=True)
    else:
        print('Usage:')
        print('  txt2nc.py <txtfile> [<timeunitstring>] [<timename>]')
        print('Examples:')
        print("  txt2nc.py example_small.txt")
        print("  txt2nc.py example_small.txt 'MINUTES since 2006-12-14 14:00'")
        print("  txt2nc.py example_small.txt 'MINUTES since 2006-12-14 14:00' time")
