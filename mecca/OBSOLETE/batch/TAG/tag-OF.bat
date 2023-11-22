# -*- Shell-script -*-

# Author: S .Gromov (2016),
# This is oxygen fraction tagging
# The shell variables defined here will be used by xmecca 
# when it is run in batch mode (i.e. not interactive).

 set apn          = 0                 # number of aerosol phases [0...99, default=0]
 set gaseqnfile   = eqn/gas/mim1.eqn
 set gasspcfile   = eqn/gas/mim1.spc
#set rplfile      = mim1-CCMI-base-02-ISO # back to mim1 + fix H2O production + ESCiMO
 set rplfile      =
 set ignoremassbalance                # MIM* violate the mass balance
 set wanted       = "(((Tr && (G || Het) && \!I) || St) && \!Hg)"
 set enthalpy     = n                 # activate enthalpy in kJ/mol?
 set mcfct        = n                 # Monte-Carlo factor?
 set diagtracfile =                   # diagnostic tracers?
 set rxnrates     = n                 # calculate accumulated reaction rates?

 set setfixlist   = "O2; FAO2; FWO2; FZO2; N2; CO2; FAH2O; FZH2O; FAO3; FWO3; "    # chemically fixed species
 set tag          = y                 # perform (isotope) tagging?
 set tagcfg       = O                 # oxygen fraction tagging
 set embud        = O                 # extended budgeting

#set kppoption    = k                 # k=kpp, 4=kp4, q=quit
 set kppoption    = 4                 # k=kpp, 4=kp4, q=quit
 set integr       = rosenbrock_mz     # integrator
 set vlen         = 256               # only for kp4 and integr=rosenbrock_vec
 set decomp       = 1                 # remove indirect indexing
                                      # kp4: 0/1/2/3/q; kpp: y/n/q
 set deltmpkp4    = y                 # delete temporary kp4 files?
 set latex        = n                 # latex list of reactions?
 set graphviz     = n                 # graphviz plots?
 set deltmp       = y                 # delete temporary xmecca files?
