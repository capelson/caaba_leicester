#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-09-06 11:38:40 sander>

# Authors: Rolf Sander (MPI Mainz, 2020)

##############################################################################

import sys
assert sys.version_info >= (3, 6)
import os
from glob import glob

for kppfile in glob('*.kpp'):
    cmd = 'xmcm2mecca ' + kppfile
    print(cmd)
    os.system(cmd)
