# -*- Shell-script -*-

# Sergey Gromov (2015-2016)
# isotope CO2 Monte-Carlo box-model study for CARIBIC-2 data

# my hack:
 set gaseqnfile   = eqn/gas/iCMCb.eqn
 set gasspcfile   = eqn/gas/iCMCb.spc
#set gastexfile   = gas.tex

# features:
 set ignoremassbalance
 set rplfile      =
 set wanted       = "\!Ara"

 set apn          = 0                 # number of aerosol phases [0...99, default=0]
 set enthalpy     = n                 # activate enthalpy in kJ/mol?
 set mcfct        = n                 # Monte-Carlo factor?
 set diagtracfile =                   # diagnostic tracers?
 set rxnrates     = n                 # calculate accumulated reaction rates?

 set tag          = y                 # perform (isotope) tagging?
 set tagcfg       = aA                # tagging cfg(s)
#set embud        = c                 # extended budgeting

 set kppoption    = 4                 # k=kpp, 4=kp4, q=quit
#set kppoption    = k                 # k=kpp, 4=kp4, q=quit
 set integr       = rosenbrock_mz     # integrator
#set integr       = rosenbrock_vec    # integrator
 set vlen         = 256               # only for kp4 and integr=rosenbrock_vec
 set decomp       = 1                 # remove indirect indexing
                                      # kp4: 0/1/2/3/q; kpp: y/n/q
 set deltmpkp4    = y                 # delete temporary kp4 files?
 set latex        = n                 # latex list of reactions?
 set deltmptex    = y                 # delete temporary LaTeX files?
 set deltmp       = y                 # delete temporary xmecca files?
 set graphviz     = n                 # graphviz plots?

 set setfixlist   = 'Dummy; \
  RHL; I12RHL; I13RHL; I16RHL; I17RHL; I18RHL; \
  RLL; I12RLL; I13RLL; I16RLL; I17RLL; I18RLL; \
   RC; I12RC;  I13RC;  I16RC;  I17RC;  I18RC; \
  RHL_CH4; RHL_N2O; RHL_SF6; RHL_CO; RHL_O3; \
  RLL_CH4; RLL_N2O; RLL_SF6; RLL_CO; RLL_O3; \
   BL_CH4;  BL_N2O;  BL_SF6;  BL_CO;  BL_O3; '

# xx; I12xx; I13xx; I16xx; I17xx; I18xx;
# RHL_xx; RLL_xx; BL_xx; 
# PC; I16RC; I17RC; I18RC;
