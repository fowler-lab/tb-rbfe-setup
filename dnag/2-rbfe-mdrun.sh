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

            cd $leg

            mpirun -np 8 gmx_mpi mdrun -multidir 0 1 2 3 4 5 6 7 -replex 1000 -nex 10000 -deffnm $system-$structure-$mutation-$repeat-$state-$leg -stepout 10 -v

            cd ..

        done;

        cd ..

    done;

    cd ..

done;
