// -*- C++ -*-
#include "Rivet/Analysis.hh"
#include "Rivet/Projections/FinalState.hh"
#include "Rivet/Projections/FastJets.hh"
#include "Rivet/Tools/BinnedHistogram.hh"


namespace Rivet {


const vector<double> genBins{74,97,133,174,220,272,330,395,468,548,638,737,846,967,1101,1248,1410,1588,1784,2000,2238,2500,2787,3103,3450};
                         //  0  1  2   3   4   5   6   7   8   9   10  11  12  13  14   15   16   17   18   19   20   21   22   23   24
//vector<int> nBinsY = {24, 23, 22, 19, 16, 15};
const vector<double> yEdges {0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0};

  /// Inclusive jet pT at 13 TeV
  class CMS_2019_incJets : public Analysis {
  public:

    /// Constructor
    DEFAULT_RIVET_ANALYSIS_CTOR(CMS_2019_incJets);


    /// Book histograms and initialize projections:
    void init() {

      // Initialize the projections
      const FinalState fs;
      declare(FastJets(fs, FastJets::ANTIKT, 0.4), "JetsAK4");
      declare(FastJets(fs, FastJets::ANTIKT, 0.7), "JetsAK7");

      // Book sets of histograms, binned in absolute rapidity
      // AK7
      for(int y = 0; y < 6; ++y) {
         vector<double> bins = genBins;
         //bins.resize(nBinsY[y]+1);
         _hist_sigmaAK7.addHistogram(yEdges[y], yEdges[y+1], bookHisto1D("ak7_y"+to_string(y), bins ));
         _hist_sigmaAK4.addHistogram(yEdges[y], yEdges[y+1], bookHisto1D("ak4_y"+to_string(y), bins ));

      }
      /*
      _hist_sigmaAK7.addHistogram(0.0, 0.5, bookHisto1D(1, 1, 1));
      _hist_sigmaAK7.addHistogram(0.5, 1.0, bookHisto1D(2, 1, 1));
      _hist_sigmaAK7.addHistogram(1.0, 1.5, bookHisto1D(3, 1, 1));
      _hist_sigmaAK7.addHistogram(1.5, 2.0, bookHisto1D(4, 1, 1));
      _hist_sigmaAK7.addHistogram(2.0, 2.5, bookHisto1D(5, 1, 1));
      // AK4
      _hist_sigmaAK4.addHistogram(0.0, 0.5, bookHisto1D(8, 1, 1));
      _hist_sigmaAK4.addHistogram(0.5, 1.0, bookHisto1D(9, 1, 1));
      _hist_sigmaAK4.addHistogram(1.0, 1.5, bookHisto1D(10, 1, 1));
      _hist_sigmaAK4.addHistogram(1.5, 2.0, bookHisto1D(11, 1, 1));
      _hist_sigmaAK4.addHistogram(2.0, 2.5, bookHisto1D(12, 1, 1));
      */
    }


    /// Per-event analysis
    void analyze(const Event &event) {
        /*
        auto particles  = event.allParticles();
        for(int i = 0; i < particles.size(); ++i) { //loop over all
            cout << "Radek " <<i <<" : "<< particles[i].pid() <<" "<< particles[i].isStable() << endl;
        }
        */

      const double weight = event.weight();

      // AK4 jets
      const FastJets& fjAK4 = applyProjection<FastJets>(event, "JetsAK4");
      const Jets& jetsAK4 = fjAK4.jets(Cuts::ptIn(70*GeV, 3500.0*GeV) && Cuts::absrap < 3.0);
      for (const Jet& j : jetsAK4) {
        _hist_sigmaAK4.fill(j.absrap(), j.pT(), weight);
      }

      // AK7 jets
      const FastJets& fjAK7 = applyProjection<FastJets>(event, "JetsAK7");
      const Jets& jetsAK7 = fjAK7.jets(Cuts::ptIn(70*GeV, 3500.0*GeV) && Cuts::absrap < 3.0);
      for (const Jet& j : jetsAK7) {
        _hist_sigmaAK7.fill(j.absrap(), j.pT(), weight);
      }

    }


    // Finalize
    void finalize() {
      /// @note Extra division factor is the *signed* dy, i.e. 2*d|y|
      _hist_sigmaAK4.scale(crossSection()/picobarn/sumOfWeights()/2.0, this);
      _hist_sigmaAK7.scale(crossSection()/picobarn/sumOfWeights()/2.0, this);
    }


    /// @name Histograms
    //@{
    BinnedHistogram<double> _hist_sigmaAK4;
    BinnedHistogram<double> _hist_sigmaAK7;
    //@}

  };


  // This global object acts as a hook for the plugin system.
  DECLARE_RIVET_PLUGIN(CMS_2019_incJets);

}
