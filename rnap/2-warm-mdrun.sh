#!/bin/bash

system='rnap'
structure='5uh6'
drug='rfp'
mutation='s450l'

cd $mutation/

for repeat in 01 02 03 04 05 06 07 08 09 10; do
# for repeat in 02; do

    cd $repeat/

    for state in apo $drug; do

        cd $state/
        cd warm

        for lambda in 0 1 2 3 4 5 6; do

            cd $lambda

            gmx mdrun   -s $system-$structure-$mutation-$repeat-$state-alchembed-warm.tpr\
                        -deffnm $system-$structure-$mutation-$repeat-$state-alchembed-warm\
                        -v -ntmpi 1 -ntomp 1 &

            cd ..
        done;

        lambda=7
        cd $lambda/
        gmx mdrun   -s $system-$structure-$mutation-$repeat-$state-alchembed-warm.tpr\
                    -deffnm $system-$structure-$mutation-$repeat-$state-alchembed-warm\
                    -v -ntmpi 1 -ntomp 1
        cd ..

        cd ..
        cd ..

    done;

    cd ..

done;
