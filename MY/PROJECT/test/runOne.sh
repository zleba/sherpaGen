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


pt=15
tag=Had


if [ "$#" -eq 2 ]
then
    jobName=$1
    prepid=$2
    analysis=$3

    tag=$1
    pt=${ptVals[0]}
    echo $jobName  $prepid  $analysis  $nJobs  $nEv
fi

outDir=QCD_pt${pt}_${tag}_LO_13TeV
mkdir -p sherpaFiles/$outDir

exit


./MakeSherpaLibs.sh -i $PWD/sherpaFiles -p $outDir  -f $PWD/sherpaFiles/$outDir  -o LBCR -v -m mpirun -M '-n 9'
