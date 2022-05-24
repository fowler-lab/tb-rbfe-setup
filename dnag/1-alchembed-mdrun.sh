#!/bin/bash

system='dnag'
structure='5bs8'
drug='mfx'
mutation='a90v'

cd $mutation/

for repeat in 01 02 03 04 05 06 07 08 09 10; do

    cd $repeat/

    for state in apo $drug; do

        cd $state/

        gmx mdrun   -s $system-$structure-$mutation-$repeat-$state-alchembed.tpr\
                    -deffnm $system-$structure-$mutation-$repeat-$state-alchembed\
                    -v

        cd ..

    done;

    cd ..

done;
