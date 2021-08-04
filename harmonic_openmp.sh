#!/bin/sh 

#SBATCH --job-name=harmfit3d

#SBATCH --partition=mpi_long2

#SBATCH --ntasks=24 

#SBATCH --cpus-per-task=1

export OMP_NUM_THREADS=24

date
./jobcomp
date
