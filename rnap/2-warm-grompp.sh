#! /bin/bash

system='rnap'
structure='5uh6'
drug='rfp'
mutation='s450l'

for repeat in 01 02 03 04 05 06 07 08 09 10; do

    for state in apo $drug; do

        mkdir -p $mutation/$repeat/$state/warm

        for lambda in 0 1 2 3 4 5 6 7; do

            mkdir -p $mutation/$repeat/$state/warm/$lambda

            echo "0" | gmx trjconv -f $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state-alchembed.xtc\
                        -dump 0.$lambda\
                        -s $mutation/$repeat/$state/$system-$structure-$mutation-$repeat-$state-alchembed.tpr\
                        -o $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed.gro
        done;

        for lambda in 0 1 2 3 4 5 6; do

            gmx grompp  -f common/warm-short-$lambda.mdp\
                        -p common/$system-$structure-$mutation-$state-vdw.top\
                        -c $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed.gro\
                        -o $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed-warm.tpr\
                        -po $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed-warm.mdp\
                        --maxwarn 1 &
        done;

        lambda=7
        gmx grompp  -f common/warm-short-$lambda.mdp\
                        -p common/$system-$structure-$mutation-$state-vdw.top\
                        -c $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed.gro\
                        -o $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed-warm.tpr\
                        -po $mutation/$repeat/$state/warm/$lambda/$system-$structure-$mutation-$repeat-$state-alchembed-warm.mdp\
                        --maxwarn 1 

    done;

done;
