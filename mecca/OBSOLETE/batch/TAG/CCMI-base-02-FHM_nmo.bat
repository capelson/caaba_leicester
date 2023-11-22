# -*- Shell-script -*-

# Authors: 
# Rolf Sander (2014),
# - based on CCMI-base-02.bat from Patrick Joeckel (2013)
# - create SCAV-L-mechanism with: (Sc && !I && !Hg)
# Franziska Frank and Sergey Gromov (2016),
# - H tagging and D/H isotope-inclusive setups
# - corrections to kinetics for 3D runs

# The shell variables defined here will be used by xmecca 
# when it is run in batch mode (i.e. not interactive).

 set apn          = 0                 # number of aerosol phases [0...99, default=0]
 set gaseqnfile   = gas.eqn
 set rplfile      = mim1-CCMI-base-02-FHM_nmo # back to mim1 + fix H2O production + new methane oxidation scheme + ESCiMO
 set ignoremassbalance                # MIM1 violates the mass balance
 set wanted       = "(((Tr && (G || Het) && \!I) || St) && \!Hg)"
 set enthalpy     = n                 # activate enthalpy in kJ/mol?
 set mcfct        = n                 # Monte-Carlo factor?
 set diagtracfile = CCMI-base-02-ISO_nmo # diagnostic tracers?
 set rxnrates     = n                 # calculate accumulated reaction rates?

 set tag          = y                 # perform (isotope) tagging?
 set tagcfg       = J                  # tag_FHM.cfg JMj
# set embud        = H                 # extended budgeting for monte carlo runs
# set setfixlist   = "O2; O3; N2; N2O; NO2; CO2; CH4; Cl; Br;"    # chemically fixed species
# set setfixlist   = "O2; N2; N2O; CO2; CH4; Cl; Br;"    # chemically fixed species
# set setfixlist   = "O2; O3; N2; N2O; CO2; CH4; Cl; Br;"    # chemically fixed species
# set setfixlist   = "O2; N2; N2O; NO2; CO2; CH4; Cl; Br;"    # chemically fixed species
# set setfixlist   = "N2; CH4; Cl; Br;"    # chemically fixed species
#set setfixlist   = "O2;CO2;N;NO3;N2O5;HNO4;HNO3;NO;N2O;N2;NO2;NH3;H;OH;HO2;H2O;O3P;O1D;H2;O2;H2O2;O3;CH4;CH3OH;CO;HCOOH;HCHO;Cl;OClO;HOCl;Cl2O2;Cl2;ClNO3;HCl;CH3O2;CH3OOH;CFCl3;CF2Cl2;CH3Cl;CCl4;CH3CCl3;SO2;ClO;"
#set setfixlist   = "N2; CH4; Cl; Br; OH; HO2; O1D;"    # chemically fixed species
#set setfixlist   = "O2; N2; CH4; CO2; Cl; H2; H2O; OH; O1D; NO; CFCl3; CF2Cl2; CH3Cl; CCl4; CH3CCl3;"    # chemically fixed species
#set setfixlist   = "O2; N2; CH4; CO2; Cl; H2; H2O; NO; CFCl3; CF2Cl2; CH3Cl; CCl4; CH3CCl3;"    # chemically fixed species
#set setfixlist   = "O2; N2; CH4; CO2; Cl; O1D; NO; CFCl3; CF2Cl2; CH3Cl; CCl4; CH3CCl3;"    # chemically fixed species
#set setfixlist   = "O2; N2; CH4; CO2; Cl; O1D; NO; CFCl3; CF2Cl2; CCl4;"    # chemically fixed species
set setfixlist   = "CH4; CO2; O2; O1D; Cl; Br; CCl4; CH3CCl3; CF2Cl2; CFCl3; CH2ClBr; CHCl2Br; CHClBr2; CH2Br2; CHBr3; CF3Br; CF2ClBr; C2H6; C2H4; C3H8; C3H6; NC4H10; MVK; MEK; C5H8; N2; NH3; N2O; NO; DMS; SO2;"


 set kppoption    = 4                 # k=kpp, 4=kp4, q=quit
 set integr       = rosenbrock_mz     # integrator
 set vlen         = 256               # only for kp4 and integr=rosenbrock_vec
 set decomp       = 1                 # remove indirect indexing
                                      # kp4: 0/1/2/3/q; kpp: y/n/q
 set deltmpkp4    = y                 # delete temporary kp4 files?
 set latex        = n                 # latex list of reactions?
 set graphviz     = n                 # graphviz plots?
 set deltmp       = y                 # delete temporary xmecca files?
