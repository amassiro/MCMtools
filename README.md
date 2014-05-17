MCMtools
========

MCMtools

    ls --color=none -d */ | tr "/" " " | awk '{print "ls --color=none "$1"/*.lhe > mylist;  ./mergeLHE mylist ; mv /tmp/amassiro/out.lhe "$1".lhe ;"}'


    cmsLHEtoEOSManager.py -n -f   Int7TeVHw1RoScMiCutOnPeak.lhe



