#!/bin/zsh

# a version containing yodamerge
cd CMSSW_10_1_0
cmsenv
cd -
cd sherpaProduction
#

for i in pt*/
do
    cd $i
    yodamerge -o merge.yoda **/Rivet.yoda
    cd -
done
