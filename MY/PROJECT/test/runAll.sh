export LD_LIBRARY_PATH_STORED=$LD_LIBRARY_PATH

condor_submit -batch-name SherpaHad   tag=Had   runRivet.submit
#condor_submit -batch-name SherpaNoHad tag=noHad runRivet.submit

#condor_submit -batch-name SherpaNoHadFl tag=noHad runRivet.submit
#condor_submit -batch-name SherpaHadFl   tag=Had   runRivet.submit
