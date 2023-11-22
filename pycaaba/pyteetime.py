#!/usr/bin/env python3
# -*- coding: utf-8 -*- Time-stamp: <2020-08-03 21:14:44 sander>*-

# pyteetime: python version of unix tee
# Version: 1.0
# http://www.rolf-sander.net/software/pyteetime

# Based on original code from Akkana Peck, see
# http://shallowsky.com/blog/programming/python-tee.html

# This program is free software: you can use and distribute it under the
# terms of the GPL v2 or, at your option, any later GPL version:
# http://www.gnu.org/licenses/

##############################################################################

import sys
assert sys.version_info >= (3, 6)

class tee(object):
    """ tee for python
    """
    def __init__(self, _fd1, _fd2):
        self.fd1 = _fd1
        self.fd2 = _fd2
    def __del__(self):
        if ((self.fd1 != sys.stdout) and (self.fd1 != sys.stderr)):
            self.fd1.close()
        if ((self.fd2 != sys.stdout) and (self.fd2 != sys.stderr)):
            self.fd2.close()
    def write(self, text):
        self.fd1.write(text)
        self.fd2.write(text)
    def flush(self):
        self.fd1.flush()
        self.fd2.flush()

    # STDOUT:
    @classmethod
    def stdout_start(cls, logfilename='stdout.log', append=True):
        cls.stdoutsav = sys.stdout
        if (append):
            cls.LOGFILE = open(logfilename, 'a')
        else:
            cls.LOGFILE = open(logfilename, 'w')
        sys.stdout = tee(cls.stdoutsav, cls.LOGFILE)
        return cls.LOGFILE
    @classmethod
    def stdout_stop(cls):
        cls.LOGFILE.close()
        sys.stdout = cls.stdoutsav

    # STDERR:
    @classmethod
    def stderr_start(cls, errfilename='stderr.log', append=True):
        cls.stderrsav = sys.stderr
        if (append):
            cls.ERRFILE = open(errfilename, 'a')
        else:
            cls.ERRFILE = open(errfilename, 'w')
        sys.stderr = tee(cls.stderrsav, cls.ERRFILE)
        return cls.ERRFILE
    @classmethod
    def stderr_stop(cls):
        cls.ERRFILE.close()
        sys.stderr = cls.stderrsav

##############################################################################
