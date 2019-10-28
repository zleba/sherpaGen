# sherpaGen

Based on the CMS Sherpa tutorial
https://twiki.cern.ch/twiki/bin/view/CMS/SherpaTutorial2019

Aim is to generate the sherpa samples on CRAB for various slices in pThat with MPI&HAD on and off.

## Settings
```
scram project CMSSW_10_3_0 
cd CMSSW_10_3_0/src 
git clone git@github.com:zleba/sherpaGen.git
cmsenv
export TOPDIR=$PWD 

git cms-addpkg GeneratorInterface/SherpaInterface
cp GeneratorInterface/SherpaInterface/data/*SherpaLibs.sh MY/PROJECT/test
```
