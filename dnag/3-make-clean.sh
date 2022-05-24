#! /bin/bash

system='dnag'
structure='5bs8'
drug='mfx'
mutation='a90v'

# first remove all the individual lambda folders
find $mutation/ -maxdepth 4 -name '?' -exec rm -rf {} \;

# then the leg folders
find $mutation/ -maxdepth 3 -name 'qoff' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'qon' -exec rm -rf {} \;
find $mutation/ -maxdepth 3 -name 'vdw' -exec rm -rf {} \;

# finally remove all the alchembed gromacs files
find $mutation/ -name '*alchembed*' -delete
