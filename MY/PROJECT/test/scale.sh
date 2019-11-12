#!/usr/bin/env zsh

for i in sherpaProduction/pt*_noHad/;
do
    echo $i
    xsec=`grep -i "After filter: final cross section" $i/logs/2.err   | awk '{print $7}'`
    echo $xsec
    cp $i/2/Rivet.yoda $i/testNo.yoda
    cd $i
    yodascale -c  ".* ${xsec}x" testNo.yoda
    cd -

done
