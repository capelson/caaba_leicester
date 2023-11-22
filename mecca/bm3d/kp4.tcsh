#! /bin/tcsh -f

echo "starting kp4.tcsh"
set echo_style=both    
echo "integr = $integr"

# OPTIONS:
# scalar    :
# vector    : -v <length>
# deindexing: [-i <0,1,2,3>]

##################################################################
### vector (length) or scalar mode
##################################################################

switch ($integr)

 case "rosenbrock_vec":
    set integr = rosenbrock
    echo "vlen = $vlen"
    set vopt = "-v $vlen"
    breaksw

 default:
    set vopt = ''
    breaksw

endsw

##################################################################
### indirect indexing
##################################################################

echo "decomp = $decomp"

switch ($decomp)

 case "q":
    exit 1
    breaksw

 case "1":
 case "2":
 case "3":
    set diopt = "-i $decomp"
    breaksw

 default:
    set diopt = '-i 0'
    breaksw

endsw

echo "starting kp4.sh"
echo "./bin/kp4.sh -m $submodel -s $integr $vopt $diopt"
cd ../../../tools/kp4
./bin/kp4.sh -m $submodel -s $integr $vopt $diopt
if ($status != 0) then
   echo "ERROR in kp4.sh / kp4.exe"
   exit 1
endif
echo "kp4.sh finished successfully"

# mz_rs_20150220+
# normally, the submodel path is just the name of the submodel:
set submodelpath = $submodel
# (currently, kp4.tcsh is only used by MECCA. The above definition may
# be used later when, e.g., SCAV is updated to KPP2 and uses KP4 as
# well)
# For MECCA, the core is in mbm/caaba/mecca:
if ( "$submodel" == "mecca" || "$submodel" == "mtchem") then
  set submodelpath = caaba/mecca
endif
# This applies also to polymecca (mecca### with a 3-digit number):
echo $submodel | grep  -q -e '^mecca[0-9][0-9][0-9]$'
if ( $status == 0 ) then
  set submodelpath = caaba/mecca
endif
if ( "$submodel" == "gmxe_aerchem") then
  set submodelpath = gmxe/aerchem
endif
# mz_rs_20150220-

# new code
echo "\nMoving the kp4-generated file messy_${submodel}_kpp.f90 into"
echo "the directory mbm/$submodelpath/smcl"
mv -f messy_${submodel}_kpp.f90 ../../mbm/$submodelpath/smcl/.
# for tracdef.awk
mv -f tmp_workdir/messy_${submodel}_kpp_Parameters.f90 ../../mbm/$submodelpath/tmp_param

# remove temporary files
set tmpfiles = "tmp_workdir/*"

echo "deltmpkp4 = $deltmpkp4"
if ( "$deltmpkp4" == "q" ) exit 1
if ( "$deltmpkp4" != "n" ) then
  if (${?TRASH}) then
    # move to trash directory
    mv -f $tmpfiles $TRASH
  else
    # or delete
    rm $tmpfiles
    rmdir ./tmp_workdir
  endif
endif

cd -

# --------------------------------------------------------------------------
# modifying some *_kpp.f90 files for compliance with NAG compiler
# Note: This needs to be improved according to the known issues listed
#       in the header of the script cleanRO2.tcsh
echo ; echo "modifying (for NAG) messy_${submodel}_kpp.f90"
cd smcl
../bm3d/del_Cindex0.tcsh messy_${submodel}_kpp.f90 >& ../bm3d/del_Cindex0_${submodel}.log
cd -

exit 0
