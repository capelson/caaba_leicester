# -*- Shell-script -*-

# The shell variables defined here will be used by xmecca 
# when it is run in batch mode (i.e. not interactive).

 set apn          = 0                 # number of aerosol phases [0...99, default=0]
 set gaseqnfile   = gas.eqn
 set rplfile      = DeposRPL_8             # no replacements
 set wanted       = "Tr && G && \!Cl && \!Br && \!I && \!Hg"
 set setfixlist   = "O2; N2; H2; H2O; O3; CO; NO; NO2; CH4; HONO; C2H6; C3H8; C2H4; C3H6; IC4H10; NC4H10; CBUT2ENE; TBUT2ENE; BENZENE; TOLUENE; MVK; MEK; CH3OH; CH3CHO; CH3COCH3; CH3CO2H; SO2; H2O2; CH3OOH; HCHO; C5H8; APINENE; BPINENE;"
 set mcfct        = y                 # Monte-Carlo factor?
 set diagtracfile =                   # diagnostic tracers?
 set rxnrates     = y                 # calculate accumulated reaction rates?
 set tagdbl       = n                 # tagging, doubling, both, none ??
 set kppoption    = k                 # k=kpp, 4=kp4, q=quit
 set integr       = rosenbrock_posdef # integrator
 set decomp       = n                 # remove indirect indexing
 set latex        = n                 # latex list of reactions
 set graphviz     = n                 # graphviz plots?
 set deltmp       = y                 # delete temporary xmecca files?
