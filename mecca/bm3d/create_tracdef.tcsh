#! /bin/tcsh -f

# create a tracer definition ("tracdef") file by combining process_gas.tbl and
# process_aqueous.tbl for all selected aerosol phases:

echo ""
echo "Executing create_tracdef.tcsh..."
set tracdeftblfile  = "tmp_create_tracdef.tbl"

cat $gastblfile > $tracdeftblfile
set counter=0
while ($counter<$apn)
  @ counter=$counter + 1
  set aerophasename = `printf "%2.2d" $counter`
  echo -n "$aerophasename "
  sed -e "s/##/$aerophasename/g" $aqueoustblfile >> $tracdeftblfile
end
echo ""
if ("$diagtracfile" != "") then
  # add diagnostic tracers from $diagtracfile.tbl:
  sort $diagtractblfile | uniq >> $tracdeftblfile
endif
if ( "$rxnrates" == "y" ) then
  # accumulated reaction rates:
  cat $rxnratestblfile >> $tracdeftblfile
endif
if ( "$tag" == "y" ) then
  # tagged tracers:
  cat tag/messy_${submodel}_tag_process.tbl  >> $tracdeftblfile
endif
# tracdef_tbl.awk extracts all KPP_XXX from $paramfile and inserts
# these species into messy_${submodel}_idt_si.inc. For all KPP_XXX
# that are not zero it also inserts the species into
# messy_${submodel}_c2mr_si.inc, messy_${submodel}_mr2c_si.inc, and
# messy_${submodel}_trac_si.inc, using the tracer info in
# $tracdeftblfile.
# For strange reasons, gawk only works properly if LC_ALL = C
(setenv LC_ALL C ; gawk -f bm3d/tracdef_tbl.awk -v submodel=$submodel -v tracdef=$tracdeftblfile -v tag=$tag $paramfile)

if ( "$tag" == "y" ) then
  # tagged tracers additional properties:
  cat tag/messy_${submodel}_tag_chemprop.inc >> messy_${submodel}_trac_si.inc
endif
