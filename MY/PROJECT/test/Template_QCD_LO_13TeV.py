#!/usr/bin/env python

runCard="""
(run){
  % general setting
  EVENTS 1M; ERROR 0.99;
  
  % scales, tags for scale variations
  FSF:=1.; RSF:=1.; QSF:=1.;
  SCALES METS{FSF*MU_F2}{RSF*MU_R2}{QSF*MU_Q2};

  % tags for process setup
  % YOUR INPUT IS NEEDED HERE
  NJET:=1; LJET:=0; QCUT:=20.;

  % me generator settings
  ME_SIGNAL_GENERATOR Comix Amegic LOOPGEN;
  EVENT_GENERATION_MODE PartiallyUnweighted;

  %LOOPGEN:=Internal; % BlackHat/OpenLoops
  LOOPGEN:=OpenLoops;

  % exclude tau from lepton container
  MASSIVE[15] 1;
MpiHad MI_HANDLER None; FRAGMENTATION Off;

  % PDF definition
  % https://twiki.cern.ch/twiki/bin/view/CMS/QuickGuideMadGraph5aMCatNLO#Specific_information_for_2017_pr
  % Using 2017 recommended PDF
  PDF_LIBRARY     = LHAPDFSherpa;
  PDF_SET         = NNPDF31_nnlo_hessian_pdfas;
  HEPMC_USE_NAMED_WEIGHTS=1;
  % https://github.com/cms-sw/genproductions/blob/mg26x/MetaData/pdflist_4f_2017.dat
  %SCALE_VARIATIONS 1.,1. 1.,2. 1.,0.5 2.,1. 2.,2. 2.,0.5 0.5,1. 0.5,2. 0.5,0.5
  %PDF_VARIATIONS NNPDF31_nnlo_as_0118_nf_4[all]

  % collider setup
  BEAM_1 2212; BEAM_ENERGY_1 6500.;
  BEAM_2 2212; BEAM_ENERGY_2 6500.;
}(run)

(processes){
  % https://sherpa.hepforge.org/doc/SHERPA-MC-2.2.5.html#LHC_005fWJets
  % YOUR INPUT IS NEEDED HERE
  Process 93 93 -> 93 93;
  Order (*,0);
  CKKW sqr(20/E_CMS)
  Integration_Error 0.05;

  End process;

}(processes)

(selector){
  PT         93  ptMin. ptMax.
}(selector)
"""

pts = [15, 30, 50, 80, 120, 170, 300, 470, 600, 800, 1000, 1400, 1800, 2400, 3200, 5000]
for pt1, pt2 in zip(pts, pts[1:]):
    runCardNow = runCard.replace('ptMin', str(pt1))
    runCardNow = runCardNow.replace('ptMax', str(pt2))
    runCardHad = runCardNow.replace('MpiHad', '#')
    runCardNoHad = runCardNow.replace('MpiHad', ' ')
    with open('sherpaFiles/Run.dat_QCD_pt'+str(pt1)+'_Had_LO_13TeV','w') as outFile:
        outFile.write(runCardHad)
    with open('sherpaFiles/Run.dat_QCD_pt'+str(pt1)+'_noHad_LO_13TeV','w') as outFile:
        outFile.write(runCardNoHad)
