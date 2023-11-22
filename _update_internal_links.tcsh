#! /bin/tcsh -f
# Time-stamp: <2020-11-09 09:41:28 sander>

set dontedit = "created automatically by _update_internal_links.tcsh, DO NOT EDIT\!"

# check for changed internal links and update _internal_links.tcsh:

# for basedir, $cwd must be used and not `pwd` because pwd changes
# messy_devel to messy_2.53.0.xx
set basedir = $cwd
set alllinks = ( `find -L . -xtype l | sed 's|^./||'` )
set linkfile     = "$basedir/_internal_links.tcsh"
set newlinkfile  = "$basedir/tmp_internal_links.tcsh"
set linklistfile = "$basedir/tmp_linklist.tcsh"
echo "#! /bin/tcsh -f"            > $newlinkfile
echo "# $dontedit"               >> $newlinkfile
echo "set internal_links = ( \\" >> $newlinkfile

set logfile = $basedir/_update_internal_links.log
echo "logfile created by _update_internal_links.tcsh" > $logfile

rm $linklistfile >& /dev/null
foreach link ($alllinks)
  echo "\nlink       = $link" >> $logfile
  set linktarget = `readlink $link`
  echo "linktarget = $linktarget" >> $logfile
  # go to directory in which the link is:
  cd `dirname $link`
  echo "from-dir   = $cwd" >> $logfile
  # go to directory to which the link points to:
  cd `dirname $linktarget`
  echo "to-dir     = $cwd" >> $logfile
  # is cwd either the same or a subdir of basedir?
  if ( $cwd =~ $basedir* ) then
    # if yes, add current link to list of internal links:
    if (( ! ($link =~ *e4chem*) ) && ( ! ($link =~ output/*) )) then
      echo "$link \\" >> $linklistfile
      echo "internal link" >> $logfile
    endif
  endif
  cd $basedir
end
sort $linklistfile >> $newlinkfile
echo ")"           >> $newlinkfile
echo "exit"        >> $newlinkfile
cmp -s _internal_links.tcsh $newlinkfile
if ($status) then
  echo;echo "Internal links have changed:"
  diff $linkfile $newlinkfile
  echo "Update _internal_links.tcsh and continue? [y/n/q, default=y]"
  set inputstring = $<
  if ( $inputstring == 'q' ) exit 1
  if ( $inputstring != 'n' ) then
    mv $linkfile $linkfile~
    cp $newlinkfile $linkfile
  endif
endif
rm $newlinkfile $linklistfile
exit
