MCMtools
========

MCMtools

    ls --color=none -d */ | tr "/" " " | awk '{print "ls --color=none "$1"/*.lhe > mylist;  ./mergeLHE mylist ; mv /tmp/amassiro/out.lhe "$1".lhe ;"}'


    cmsLHEtoEOSManager.py -n -f   Int7TeVHw1RoScMiCutOnPeak.lhe


Upload MG gridpack
===

     https://twiki.cern.ch/twiki/bin/view/CMS/GeneratorWebRepo

e.g.

    ./uploadGridpack.sh --energy 8TeV   --process  DY1JetsToLL_MLL-10To50  --arch slc6_amd64_gcc472 --mgversion V5_1.5.11  DY1JetsToLL_MLL-10To50_gridpack.tar.gz
    DY1JetsToLL_MLL-10To50



