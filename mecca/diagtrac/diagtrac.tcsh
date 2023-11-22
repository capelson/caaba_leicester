#! /bin/tcsh -f
# Time-stamp: <2020-10-21 20:12:07 sander>

# temporary files:
set tmpfile = 'tmp_diagtrac'
set tmpfile4eqn = 'tmp_diagtrac_4.eqn'
set tmpfile5eqn = 'tmp_diagtrac_5.eqn'
set tmpfile2spc = 'tmp_diagtrac_2.spc'
set tmpfile2tbl = 'tmp_diagtrac_2.tbl'

echo "you selected $diagtracfile"
if (! -e diagtrac/$diagtracfile.tex) then
   echo diagtrac/$diagtracfile.tex does not exist
   exit 1
endif  
# for strange reasons, gawk only works properly if LC_ALL = C
(setenv LC_ALL C ; sed 's/%.*//g' diagtrac/$diagtracfile.tex | sed '/^$/d' >&! $tmpfile2tbl)
set eqnlist  = `gawk -F '&' '{print $1}' $tmpfile2tbl | sed 's/ //g'`
set traclist = `gawk -F '&' '{print $2}' $tmpfile2tbl | sed 's/ /_SPACE_/g'`
if (${#eqnlist} >= 1) then
  echo -n "" >! $tmpfile2spc
  cp -f $eqnfile $tmpfile4eqn
  @ count = 1
  while ($count <= ${#eqnlist})
    set eqnnr = $eqnlist[${count}]
    set dtrac = `echo $traclist[${count}] | sed 's/_SPACE_/ /g'`
    echo "adding $dtrac as product to equation $eqnnr"
    # add diagnostic tracer to spcfile:
    # (if $dtrac starts with a factor, then $dtrac[${#dtrac}] only
    # contains the last item, i.e. the name of the diagnostic tracer)
    set dtrac_tex = `echo "$dtrac[${#dtrac}]" | sed 's/_/\\_/g' `
    echo "$dtrac[${#dtrac}] = IGNORE ; {@${dtrac_tex}}" >> $tmpfile2spc
    # add diagnostic tracer to "tracdef.tbl":
    # mz_sg_20190715+: added standardname, removed I_wetdep
    #                   generally it is the worst practice to have these fields hardcoded, sequence-dependend! => needs revision
    echo "| $dtrac[${#dtrac}] | | | ONE | AIR | | | OFF | OFF | OFF | OFF | | OFF | | | | | | | | |" >> $diagtractblfile
    # mz_sg_20190715-
    # add diagnostic tracers to eqnfile:
    gawk -F '>' '{if ($1">" == "'$eqnnr'") \
                    {a=$0; \
                     sub("=","= '"$dtrac"' + ",a); \
                     print a} \
                 else print}' $tmpfile4eqn >! $tmpfile5eqn
    diff $tmpfile4eqn $tmpfile5eqn > $tmpfile
    if ( -s $tmpfile == 0 ) then
      echo "WARNING: Cannot find $eqnnr in eqn file $tmpfile4eqn \!"
    endif
    sed 's/+[ ]*-/ - /g' $tmpfile5eqn >! $tmpfile4eqn 
    @ count++
  end
endif
cp -f $tmpfile4eqn $eqnfile

# add diagnostic tracers to spc file:
echo "{--- diagnostic tracers from $diagtracfile.tex, added via xmecca.py ---}" >> $spcfile
echo "#DEFVAR" >> $spcfile
setenv LC_ALL C
sort $tmpfile2spc | uniq >> $spcfile
