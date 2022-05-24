#! /bin/bash

system='dnag'
structure='5bs8'
drug='mfx'
mutation='a90v'

cd $mutation/

for repeat in 01 02 03 04 05 06 07 08 09 10; do

    cd $repeat

    for state in apo $drug; do

        cd $state

        for leg in qoff vdw qon; do

            mkdir -p $leg
            cd $leg

            for lambda in 0 1 2 3 4 5 6; do

                mkdir -p $lambda
                cd $lambda

                gmx grompp  -f ../../../../../common/rbfe-$state-$leg-$lambda.mdp\
                            -p ../../../../../common/$system-$structure-$mutation-$state-$leg.top\
                            -n ../../../../../common/$system-$structure-$mutation-$state.ndx\
                            -c ../../$system-$structure-$mutation-$repeat-$state-alchembed.gro\
                            -o  $system-$structure-$mutation-$repeat-$state-$leg.tpr\
                            -po $system-$structure-$mutation-$repeat-$state-$leg.mdp\
                            -maxwarn 1 &

                cd ..

            done;

            lambda=7
            mkdir -p $lambda
            cd $lambda

            gmx grompp  -f ../../../../../common/rbfe-$state-$leg-$lambda.mdp\
                        -p ../../../../../common/$system-$structure-$mutation-$state-$leg.top\
                        -n ../../../../../common/$system-$structure-$mutation-$state.ndx\
                        -c ../../$system-$structure-$mutation-$repeat-$state-alchembed.gro\
                        -o  $system-$structure-$mutation-$repeat-$state-$leg.tpr\
                        -po $system-$structure-$mutation-$repeat-$state-$leg.mdp\
                        -maxwarn 1 

            cd ..

            cd ..

        done;

        cd ..

    done;

    cd ..

done;
