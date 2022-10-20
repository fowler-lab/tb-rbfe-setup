# tb-rbfe-setup

## Aim and Scope

The files and scripts in this repository are intended to help anyone reproduce using GROMACS how 
* the Ala90Val mutation affects the binding free energies of moxifloxacin to the _M. tuberculosis_ DNA gyase
* the Ser450Leu mutation affects the binding free energies of moxifloxacin to the _M. tuberculosis_ RNA polymerase

These (and other) mutations are studied in this manuscript:

> Predicting antibiotic resistance in complex protein targets using alchemical free energy methods
> 
> Alice E Brankin and Philip W Fowler
> 
> [J Comp Chem (2022) 43:1371](https://doi.org/10.1002/jcc.26979)

As described in the Methods, each mutation is seeded from a different structure taken from a molecular dynamics simulation. Each mutation here has ten apo and ten drug-bound structures. Despite the alchembed step which aims to gradually introduce the mutation into the structure, not all simulations are expected to complete successfully as some will crash, presumably due to steric clashes. If this occurs, either move onto the next structure, or you may wish to experiment with e.g. reducing the timestep from 2 fs to 1 fs and removing bond constraints.

Since the alchemical free energies themselves are calculated via thermodynamic integration you can either calculate them using simple command line tools like `awk` etc or use a standard tool that is compatible from GROMACS `dudl.xvg` files.

Alice E Brankin and Philip W Fowler
20 Oct 2022

## Structure of repository

Each protein is completely self-contained in its own folder with the DNA gyrase in `dnag` and the RNA polymerase in `rnap`. Each contains a series of `bash` scripts and two folders, one of which is called `common` and contains the topology (`top, itp`), GROMACS parameters (`mdp`) and forcefield files needed to setup the necessary GROMACS simulations. The other folder is named after the mutation e.g. `a90v` and contains ten folders, one per seed (e.g. `02`). 

## Instructions

First clone the repo

```
git clone https://github.com/fowler-lab/tb-rbfe-setup
cd tb-rbfe-setup
```
The remainder of the instructions will focus on the S450L RNAP mutation; the process is very similar for the A90V DNA gyrase mutation. To save space the `gro` files were compressed -- we need to uncompress them (the script assumes you have GNU `parallel` installed).

```
cd rnap
bash 0-uncompress-gro.sh
```

Now we need to run the alchembed step which using a fast-growth step, grows the mutation into the structure with the intention of gently resolving any steric clashes. First we need to source the `GMRX` file of the version of GROMACS you are using. This repository has been tested with GROMACS 2022.1, however as described in the manuscript these calculations were performed using GROMACS 2016.3 (and 2019.1 for DNAG). You need to have compiled your chosen version of GROMACS on your machine (including an `MPI` version for the RBFE calcualtions themselves).

```
source /usr/local/gromacs/2022.1/bin/GMXRC
bash 1-alchembed-grompp.sh
bash 1-alchembed-mdrun.sh
```

Note that the second script will autodetect the number of cores on your machine and use all them using OpenMP. For this, and all subsequent `mdrun`, scripts you may wish to refactor them to run on an HPC cluster or cloud, but for simplicity they are provided in the form which will run on a local workstation. Now we run a short warming step, keeping the velocities; this step is not necessary for the DNAG mutation.

```
bash 2-warm-grompp.sh
bash 2-warm-mdrun.sh
```

Again this will run on your local workstation; a single warming simulation is run for each of the 8 lambda simulations concurrently so you will need a minimum of 8 cores. Be warned that this will take several hours to complete.

```
bash 3-rbfe-grompp.sh
bash 3-rbfe-mdrun.sh
```

Now we can create the necessary `tpr` files and run the RBFE calculations themselves. Whilst these are setup to run on a local workstation, each will take days to complete so we'd recommend either (i) refactoring to run on HPC or (ii) (if you simply want to test the process and are not concerned about convergence etc) reduce `nsteps` in the `mdp` files in `common/` and re-`grompp`.

Finally, all of the above will produce a large number of intermediate files, to clean up simply issue

```
bash 4-make-clean.sh
```

















