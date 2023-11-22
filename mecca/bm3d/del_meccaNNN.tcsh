#! /bin/tcsh -f
# Time-stamp: <2020-10-21 13:19:30 sander>

# Since xmecca was NOT started via xpolymecca, or since this is the
# first mechanism created via xpolymecca, all mecca### files ("###" =
# 3-digit number) must be deleted, e.g.:
# messy/smcl/messy_mecca001_kpp*.f90
# messy/mbm/caaba/mecca/*mecca001*
# messy/mbm/caaba/mecca/latex/mecca001*
cd ../../../../messy/smcl
find . -regex '.*/messy_mecca[0-9][0-9][0-9].*' | xargs rm -fv
cd -
cd ../../../../messy/smil
find . -regex '.*/messy_mecca[0-9][0-9][0-9].*' | xargs rm -fv
cd -
find . -regex '.*mecca[0-9][0-9][0-9].*' | xargs rm -fv
# Create messy_chemglue.inc. If xmecca WAS NOT started via xpolymecca,
# this is the correct file. If xmecca WAS started via xpolymecca, then
# it will be overwritten by xpolymecca later.
set incfile = "../../../smcl/messy_chemglue.inc"
echo "! -*- f90 -*- $DONTEDIT"    > $incfile
echo "NMAXMECCA = 1" >> $incfile
