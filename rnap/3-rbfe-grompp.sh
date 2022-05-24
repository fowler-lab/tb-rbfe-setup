#! /bin/bash

system='rnap'
structure='5uh6'
drug='rfp'
mutation='s450l'

cd $mutation/

for repeat in 01 02 03 04 05 06 07 08 09 10; do

    cd $repeat

    for state in apo; do

        cd $state

        for leg in qoff vdw qon; do

            mkdir -p $leg
            cd $leg

            if [ $leg = 'vdw' ]; then
                seed=$lambda
            elif [ $leg = 'qoff' ]; then
                seed=0
            elif [ $leg = 'qon' ]; then
                seed=7
            fi

            for lambda in 0 1 2 3 4 5 6 7; do

                mkdir -p $lambda
                cd $lambda

                cp ../../../../../common/rbfe-$state-$leg-$lambda.mdp run.mdp

                if [ $repeat = '02' ]; then
                    perl -pi -e 's/0.5778/0.523/g' run.mdp
                elif [ $repeat = '03' ]; then
                    perl -pi -e 's/0.5778/0.501/g' run.mdp
                elif [ $repeat = '04' ]; then
                    perl -pi -e 's/0.5778/0.505/g' run.mdp
                elif [ $repeat = '05' ]; then
                    perl -pi -e 's/0.5778/0.638/g' run.mdp
                elif [ $repeat = '06' ]; then
                    perl -pi -e 's/0.5778/0.571/g' run.mdp
                elif [ $repeat = '07' ]; then
                    perl -pi -e 's/0.5778/0.584/g' run.mdp
                elif [ $repeat = '08' ]; then
                    perl -pi -e 's/0.5778/0.582/g' run.mdp
                elif [ $repeat = '09' ]; then
                    perl -pi -e 's/0.5778/0.669/g' run.mdp
                elif [ $repeat = '10' ]; then
                    perl -pi -e 's/0.5778/0.617/g' run.mdp
                fi

                cd ..

            done;

            for lambda in 0 1 2 3 4 5 6; do

                cd $lambda

                gmx grompp  -f run.mdp\
                            -p ../../../../../common/$system-$structure-$mutation-$state-$leg.top\
                            -n ../../../../../common/$system-$structure-$mutation-$state.ndx\
                            -c ../../warm/$seed/$system-$structure-$mutation-$repeat-$state-alchembed-warm.gro\
                            -o  $system-$structure-$mutation-$repeat-$state-$leg.tpr\
                            -po $system-$structure-$mutation-$repeat-$state-$leg.mdp\
                            -maxwarn 2 &

                cd ..

            done;

            lambda=7
            cd $lambda
            gmx grompp  -f run.mdp\
                        -p ../../../../../common/$system-$structure-$mutation-$state-$leg.top\
                        -n ../../../../../common/$system-$structure-$mutation-$state.ndx\
                        -c ../../warm/$seed/$system-$structure-$mutation-$repeat-$state-alchembed-warm.gro\
                        -o  $system-$structure-$mutation-$repeat-$state-$leg.tpr\
                        -po $system-$structure-$mutation-$repeat-$state-$leg.mdp\
                        -maxwarn 2 
            cd ..

            cd ..

        done;

        cd ..
    
    done;

    for state in $drug; do

        cd $state

        for leg in qoff vdw qon rest0 rest1; do

            mkdir -p $leg
            cd $leg

            if [ $leg = 'vdw' ]; then
                seed=$lambda
            elif [ $leg = 'qoff' ]; then
                seed=0
            elif [ $leg = 'rest0' ]; then
                seed=0
            elif [ $leg = 'qon' ]; then
                seed=7
            elif [ $leg = 'rest1' ]; then
                seed=7
            fi

            for lambda in 0 1 2 3 4 5 6 7; do

                mkdir -p $lambda
                cd $lambda

                cp ../../../../../common/rbfe-$state-$leg-$lambda.mdp run.mdp

                if [ $repeat = '02' ]; then
                    perl -pi -e 's/0.5778/0.523/g' run.mdp
                elif [ $repeat = '03' ]; then
                    perl -pi -e 's/0.5778/0.501/g' run.mdp
                elif [ $repeat = '04' ]; then
                    perl -pi -e 's/0.5778/0.505/g' run.mdp
                elif [ $repeat = '05' ]; then
                    perl -pi -e 's/0.5778/0.638/g' run.mdp
                elif [ $repeat = '06' ]; then
                    perl -pi -e 's/0.5778/0.571/g' run.mdp
                elif [ $repeat = '07' ]; then
                    perl -pi -e 's/0.5778/0.584/g' run.mdp
                elif [ $repeat = '08' ]; then
                    perl -pi -e 's/0.5778/0.582/g' run.mdp
                elif [ $repeat = '09' ]; then
                    perl -pi -e 's/0.5778/0.669/g' run.mdp
                elif [ $repeat = '10' ]; then
                    perl -pi -e 's/0.5778/0.617/g' run.mdp
                fi

                cd ..

            done;

            for lambda in 0 1 2 3 4 5 6; do

                cd $lambda

                gmx grompp  -f run.mdp\
                            -p ../../../../../common/$system-$structure-$mutation-$state-$leg.top\
                            -n ../../../../../common/$system-$structure-$mutation-$state.ndx\
                            -c ../../warm/$seed/$system-$structure-$mutation-$repeat-$state-alchembed-warm.gro\
                            -o  $system-$structure-$mutation-$repeat-$state-$leg.tpr\
                            -po $system-$structure-$mutation-$repeat-$state-$leg.mdp\
                            -maxwarn 2 &

                cd ..

            done;

            lambda=7
            cd $lambda
            gmx grompp  -f run.mdp\
                        -p ../../../../../common/$system-$structure-$mutation-$state-$leg.top\
                        -n ../../../../../common/$system-$structure-$mutation-$state.ndx\
                        -c ../../warm/$seed/$system-$structure-$mutation-$repeat-$state-alchembed-warm.gro\
                        -o  $system-$structure-$mutation-$repeat-$state-$leg.tpr\
                        -po $system-$structure-$mutation-$repeat-$state-$leg.mdp\
                        -maxwarn 2 
            cd ..

            cd ..

        done;

        cd ..

    done;

    cd ..

done;
