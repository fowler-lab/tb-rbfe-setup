#! /bin/bash

system='dnag'
structure='5bs8'
drug='mfx'
mutation='a90v'

for repeat in 01 02 03 04 05 06 07 08 09 10; do

    for state in apo $drug; do

        gmx grompp  -f common/alchembed.mdp\
                    -p common/$system-$structure-$mutation-$state-qoff.top\
                    -c $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state.gro\
                    -o $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state-alchembed.tpr\
                    -po $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state-alchembed.mdp

    done;

done;
