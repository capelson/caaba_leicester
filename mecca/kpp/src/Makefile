########################################################################################
#
#  KPP - The Kinetic PreProcessor
#        Builds simulation code for chemical kinetic systems
#
#  Copyright (C) 1995-1996 Valeriu Damian and Adrian Sandu
#  Copyright (C) 1997-2005 Adrian Sandu
#      with contributions from: Mirela Damian, Rolf Sander 
#
#  KPP is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation (http://www.gnu.org/copyleft/gpl.html); either version 2 of the
#  License, or (at your option) any later version.
#
#  KPP is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#
#  You should have received a copy of the GNU General Public License along
##  with this program; if not, consult http://www.gnu.org/copyleft/gpl.html or
#  write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#  Boston, MA  02111-1307,  USA.
#
#  Adrian Sandu
#  Computer Science Department
#  Virginia Polytechnic Institute and State University
#  Blacksburg, VA 24060
#  E-mail: sandu@cs.vt.edu
#
#######################################################################################
SYSTEM := $(shell uname)
include ../Makefile.defs.$(SYSTEM)

BISON=bison -d 
CFLAGS=`cat ../cflags`

all: kpp

# list the configuration:
.PHONY: list
list:
	@echo "SYSTEM       = $(SYSTEM)"
	@echo "CC           = $(CC)"
	@echo "FLEX         = $(FLEX)"
	@echo "FLEX_LIB_DIR = $(FLEX_LIB_DIR)"
	@echo "CC_FLAGS     = $(CC_FLAGS)"

.c.o:
	@echo "  "$(CC) -g $(CC_FLAGS) $(CFLAGS) -c $*.c
	@$(CC) -g $(CC_FLAGS) $(CFLAGS) -c $*.c

OBJS  = \
	y.tab.o \
	lex.yy.o \
	scanner.o \
	scanutil.o \
	kpp.o \
	gen.o \
	code.o \
	code_c.o \
	code_f77.o \
	code_f90.o \
	code_matlab.o \
	debug.o

kpp:    $(OBJS)
	@echo "  "$(CC) $(CC_FLAGS) $(CFLAGS) $(OBJS) -L$(FLEX_LIB_DIR) -lfl -o kpp
	@$(CC) $(CC_FLAGS) $(CFLAGS) $(OBJS) -L$(FLEX_LIB_DIR) -lfl -o kpp
	@mv kpp ../bin

clean:  
	@rm -f *~ *.o cflags 

maintainer-clean: clean
	@rm -f lex.yy.c y.tab.c y.tab.h

lex.yy.c: scan.l scan.h
	@echo "  "$(FLEX) scan.l
	@$(FLEX) -olex.yy.c scan.l 

y.tab.c: scan.y scan.h
	@echo "  "$(BISON) scan.y
	@$(BISON) -o y.tab.c scan.y

flex: lex.yy.c y.tab.c

scanner.o: scan.h gdata.h
scanutil.o: scan.h
kpp.o: gdata.h
gen.o: gdata.h code.h
debug.o: gdata.h
code.o: gdata.h code.h

code_c.o: gdata.h code.h
code_f.o: gdata.h code.h
