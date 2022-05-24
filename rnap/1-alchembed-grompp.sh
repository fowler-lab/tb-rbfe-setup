#! /bin/bash

system='rnap'
structure='5uh6'
drug='rfp'
mutation='s450l'

for repeat in 01 02 03 04 05 06 07 08 09 10; do

    for state in apo $drug; do

        gmx grompp  -f common/alchembed.mdp\
                    -p common/$system-$structure-$mutation-$state-vdw.top\
                    -c $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state.gro\
                    -o $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state-alchembed.tpr\
                    -po $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state-alchembed.mdp\
                    -maxwarn 2

    done;

done;
