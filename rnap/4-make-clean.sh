#! /bin/bash

system='rnap'
structure='5uh6'
drug='rfp'
mutation='s450l'

# first remove all the individual lambda folders
find $mutation/ -maxdepth 4 -name '?' -exec rm -rf {} \;

# then the leg folders
find $mutation/ -maxdepth 3 -name 'qoff' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'qon' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'vdw' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'warm' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'rest0' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'rest1' -exec rm -rf {} \;

# finally remove all the alchembed gromacs files
find $mutation/ -name '*alchembed*' -delete
