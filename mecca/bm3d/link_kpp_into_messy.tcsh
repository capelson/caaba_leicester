#! /bin/tcsh -f
# Time-stamp: <2020-10-23 17:42:07 sander>

if ("$submodel" == "mtchem") then
  # for mtchem, the files are moved:
  set command = "mv"
else
  # for mecca and mecca###, the files are linked:
  set command = "ln -fs"
endif
# SMCL:
cd ../../../smcl
echo "cd $PWD"
rm messy_${submodel}_kpp*.f90 >& /dev/null
rm messy_${submodel}_dbl*.f90 >& /dev/null
rm messy_${submodel}_tag*.f90 >& /dev/null
rm messy_${submodel}_dbl*.inc >& /dev/null
rm messy_${submodel}_tag*.inc >& /dev/null
set kppfiles = ( \
  ../mbm/caaba/mecca/smcl/messy_${submodel}_kpp*.f90 \
  ../mbm/caaba/mecca/smcl/messy_${submodel}_tag*.f90 \
  ../mbm/caaba/mecca/smcl/messy_${submodel}_tag*.inc )
foreach kppfile ($kppfiles)
  set fullcommand = "$command $kppfile ."
  echo "$fullcommand"
  eval "$fullcommand"
end
cd -
# SMIL:
cd ../../../smil
echo "cd $PWD"
rm messy_${submodel}_*.inc >& /dev/null
set kppfiles = (../mbm/caaba/mecca/bm3d/messy_${submodel}_*.inc)
foreach kppfile ($kppfiles)
  set fullcommand = "$command $kppfile ."
  echo "$fullcommand"
  eval "$fullcommand"
end
cd -
