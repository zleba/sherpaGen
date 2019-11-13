void divide()
{
    auto fH = TFile::Open("sherpaProduction/had.root");
    auto fN = TFile::Open("sherpaProduction/nohad.root");

    auto fHo = TFile::Open("/nfs/dust/cms/user/zlebcr/fastProducer/cmsPlotter/npCorrsPlotter/histos/sherpaBack_Had.root");
    auto fNo = TFile::Open("/nfs/dust/cms/user/zlebcr/fastProducer/cmsPlotter/npCorrsPlotter/histos/sherpaBack_noHad.root");


    int y = 3;
    auto hH = (TH1D*) fH->Get(Form("CMS_2019_incJets/ak4_y%d",y));
    auto hN = (TH1D*) fN->Get(Form("CMS_2019_incJets/ak4_y%d",y));
    auto hHo= (TH1D*) fHo->Get(Form("CMS_2019_incJets/ak4_y%d",y));
    auto hNo= (TH1D*) fNo->Get(Form("CMS_2019_incJets/ak4_y%d",y));

    hH->Divide(hN);
    hHo->Divide(hNo);

    hH->Draw();
    hHo->SetLineColor(kRed);
    hHo->Draw("same");

    //hH->SetMinimum(0.7);
    //hH->SetMaximum(0.3);
    hH->GetYaxis()->SetRangeUser(0.7, 1.3);


    gPad->SetLogx();




}
