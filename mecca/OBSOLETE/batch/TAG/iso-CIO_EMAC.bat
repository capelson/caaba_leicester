# -*- Shell-script -*-

# Author: Sergey Gromov, MPIC (2018)
# Setup: iso-O2 -- clumped oxygen isotopes (D36 and D35 signatures, fractional tagging)

 set ignoremassbalance
 set gaseqnfile   = eqn/tag/mim1.eqn
 set gasspcfile   = eqn/tag/mim1.spc
 set rplfile      =
#set rplfile      = mim1-CCMI-base-02-ISO_nmo # NMO+MIM1 mechanism
#set wanted       = "((Tr && G && \!Cl && \!Br && \!I && \!Aro && \!Ter) || St) && \!Hg && \!Het"
#set wanted       = "Tr && G && \!Cl && \!Br && \!I && \!Aro && \!Ter && \!Hg && \!Het"
 set wanted       = "(((Tr && (G || Het) && \!I) || St) && \!Hg)"  # CCMI-like setup
 set apn          = 0                 # number of aerosol phases [0...99, default=0]
 set enthalpy     = n                 # activate enthalpy in kJ/mol?
 set mcfct        = n                 # Monte-Carlo factor?
 set diagtracfile =                   # diagnostic tracers?
 set rxnrates     = n                 # calculate accumulated reaction rates?

 set tag          = y                 # perform (isotope) tagging?
 set tagcfg       = x                 # tagging cfg
 set embud        = x                 # extended budgeting

 set kppoption    = k                 # k=kpp, 4=kp4, q=quit
#set kppoption    = 4                 # k=kpp, 4=kp4, q=quit
 set integr       = rosenbrock_mz     # integrator
#set integr       = rosenbrock_vec    # integrator
 set vlen         = 256               # only for kp4 and integr=rosenbrock_vec
 set decomp       = 1                 # remove indirect indexing
                                      # kp4: 0/1/2/3/q; kpp: y/n/q
#set decomp       = y                 # remove indirect indexing
 set deltmpkp4    = y                 # delete temporary kp4 files
 set latex        = n                 # latex list of reactions
 set deltmptex    = y                 # delete temporary LaTeX files?
 set deltmp       = y                 # delete temporary xmecca files?
 set graphviz     = n                 # graphviz plots

 set setfixlist   = 'Dummy; N2; CO2;' # H2;'
