#!/usr/bin/env zsh

for i in sherpaProduction/pt*_*Had/;
do
    echo $i
    #from all data
    xsec=`grep -i "After filter: final cross section" $i/logs/*.err   | awk '{++n; s+=$7} END {print s/n}'`

    grep -i "After filter: final cross section" $i/logs/*.err   | awk '{print $7, $9}'

    echo $xsec

    cd $i
    #yodamerge -o merged.yoda **/Rivet.yoda
    #yodascale -c  ".* ${xsec}x" merged.yoda
    cd -

done
