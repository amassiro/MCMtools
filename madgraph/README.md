Madgraph
====

upload gridpack

    https://twiki.cern.ch/twiki/bin/view/CMS/GeneratorWebRepo


example

    ./uploadGridpack.sh --energy [8TeV,13TeV] --process <process name> --arch <architecture> --mgversion <MadGraph version> <process name>_gridpack.tar.gz

    ./uploadGridpack.sh --energy 8TeV --process DY1Jet --arch slc6_amd64_gcc472 --mgversion V5_1.5.11 DY1Jet_gridpack.tar.gz
