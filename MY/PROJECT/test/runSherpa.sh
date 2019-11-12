#!/usr/bin/env bash

if [ -z ${LD_LIBRARY_PATH_STORED} ];
then
    echo "Default env used";
else
    echo "Taking evn from LD_LIBRARY_PATH_STORED";
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_STORED
fi


tag=Had
slice=1000
nEv=200
id=0

if [ "$#" -eq 4 ]
then
    tag=$1
    slice=$2
    nEv=$3
    id=$4
fi



mkdir -p sherpaProduction/pt${slice}_${tag}/$id

#cp sherpaFiles/QCD_pt1000_Had_LO_13TeV/sherpa_QCD_pt1000_Had_LO_13TeV_MASTER.tgz  sherpaProduction/pt${slice}_${tag}/$id
#cp sherpaFiles/QCD_pt1000_Had_LO_13TeV/sherpa_QCD_pt1000_Had_LO_13TeV_MASTER_cff_py_GEN.py  sherpaProduction/pt${slice}_${tag}/$id
cp sherpaFiles/QCD_pt${slice}_${tag}_LO_13TeV/sherpa_QCD_pt${slice}_${tag}_LO_13TeV_MASTER.tgz     sherpaProduction/pt${slice}_${tag}/$id
cp sherpaFiles/QCD_pt${slice}_${tag}_LO_13TeV/sherpa_QCD_pt${slice}_${tag}_LO_13TeV_MASTER_cff_py_GEN.py  sherpaProduction/pt${slice}_${tag}/$id

cd sherpaProduction/pt${slice}_${tag}/$id

#sed -i 's/CMS_2016_I1459051/'   sherpa_QCD_pt${slice}_${tag}_LO_13TeV_MASTER_GEN.py
sed -i "s/int32(1000)/int32(${nEv})/"   sherpa_QCD_pt${slice}_${tag}_LO_13TeV_MASTER_cff_py_GEN.py
sed -i "s/CMS_2016_I1459051/CMS_2016_I1459051/"   sherpa_QCD_pt${slice}_${tag}_LO_13TeV_MASTER_cff_py_GEN.py

echo Starting cmsRun
cmsRun    sherpa_QCD_pt${slice}_${tag}_LO_13TeV_MASTER_cff_py_GEN.py
