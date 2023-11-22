#! /bin/tcsh -f
# Time-stamp: <2020-10-27 17:25:00 sander>

set tmp_tbl = "tmp_`date +"%Y%m%d%H%M%S"`.tbl"

# mz_sg_20190715: added standardname, removed I_wetdep
#   generally it is the worst practice to have these fields
#   hardcoded, sequence-dependend! => needs revision
gawk '{if ($1 ~ /^</) {nr=$1; gsub("<","RR",nr); gsub(">","",nr);\
  sub("=","= "nr" +",$0); \
  print "| "nr" | | | | AIR | | | OFF | OFF | OFF | OFF | | OFF | | | | | | | | |" > "'$tmp_tbl'"} }' $eqnfile

# split aqueous-phase species into basename and subname:
sed -e "s/_a\([0-9][0-9]\) | | | | AIR |/ | a\1 | | AEROSOL |/" $tmp_tbl > $rxnratestblfile
