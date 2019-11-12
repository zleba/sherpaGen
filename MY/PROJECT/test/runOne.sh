#!/usr/bin/env bash
#./MakeSherpaLibs.sh -p $outDir -D Run.dat_$outDir -f $PWD/$outDir -o LBCR -v -m mpirun -M '-n 9'


if [ -z ${LD_LIBRARY_PATH_STORED} ];
then
    echo "Default env used";
else
    echo "Taking evn from LD_LIBRARY_PATH_STORED";
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_STORED
fi



ptVals=(15 30  50  80  120  170  300  470  600  800  1000  1400  1800  2400  3200)


pt=120
tag=Had


if [ "$#" -eq 2 ]
then
    tag=$1
    pt=${ptVals[$2]}
fi

if [ "$#" -eq 1 ]
then
    tag=$1
    pt=Flat
fi




outDir=QCD_pt${pt}_${tag}_LO_13TeV
mkdir -p sherpaFiles/$outDir

#exit


./MakeSherpaLibs.sh -i $PWD/sherpaFiles -p $outDir  -f $PWD/sherpaFiles/$outDir  -o LBCR -v -m mpirun -M '-n 4'

#Produce sherpapack
cd sherpaFiles/$outDir
../../PrepareSherpaLibs.sh -p $outDir

#cmsDriver.py MY/PROJECT/python/sherpa_${outDir}_MASTER_cff.py \
#        -s GEN -n 1000 --no_exec --conditions auto:mc --eventcontent RAWSIM
cp  sherpa_${outDir}_MASTER_cff.py  $CMSSW_BASE/src/MY/PROJECT/python
cmsDriver.py MY/PROJECT/python/sherpa_${outDir}_MASTER_cff.py   -s GEN -n 1000 --no_exec --conditions auto:mc --eventcontent RAWSIM

cat <<EOF >>  sherpa_${outDir}_MASTER_cff_py_GEN.py 
def customise(process):
    process.load('GeneratorInterface.RivetInterface.rivetAnalyzer_cfi')
    process.rivetAnalyzer.AnalysisNames = cms.vstring('CMS_2016_I1459051')
    process.rivetAnalyzer.OutputFile = cms.string('Rivet.yoda')
    process.rivetAnalyzer.CrossSection = cms.double(1)
    process.generation_step+=process.rivetAnalyzer
    process.schedule.remove(process.RAWSIMoutput_step)
    return(process)     
process = customise(process)
EOF

