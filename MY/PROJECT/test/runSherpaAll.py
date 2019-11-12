#!/usr/bin/env python


ptVals=[15, 30,  50, 80, 120, 170, 300, 470, 600, 800, 1000, 1400, 1800, 2400, 3200]

for pt in ptVals:
    for tag in ("Had", "noHad"):
        import os
        n = 'pt'+str(pt)+'_'+tag
        os.mkdir('sherpaProduction/'+n)
        os.mkdir('sherpaProduction/'+n+'/logs')

        nEv = 30000
        nJobs = 20

        #condor_submit -batch-name SherpaHad   tag=Had   runRivet.submit
        import subprocess
        #subprocess.call(['condor_submit', '-batch-name', n,   'tag=', tag, 'pt=', str(pt),   'nEv=', str(nEv),   'nJobs=', str(nJobs)  ])
        s = 'condor_submit -batch-name '+n+ ' tag='+ tag+ ' pt='+str(pt)+  ' nEv='+str(nEv)+  ' nJobs='+str(nJobs)  + '  runSherpa.submit'
        print s

        my_env = os.environ.copy()
        my_env["LD_LIBRARY_PATH_STORED"] = my_env["LD_LIBRARY_PATH"]

        #subprocess.call('export LD_LIBRARY_PATH_STORED=$LD_LIBRARY_PATH', shell=True)
        subprocess.call(s, shell=True , env=my_env)

