#!/bin/bash
#SBATCH -J RNG_TEST
#SBATCH -p small
#SBATCH --oversubscribe
#SBATCH -N 1
#SBATCH --ntasks-per-node 24
#SBATCH --mem 1000
#SBATCH --time 00:03:00

folder=`pwd`
tstamp=`date +%d-%m-%Y_%H%M`
module load tryton/matlab/2017a
matlab -nodisplay -nodesktop -logfile $folder/logfile_${tstamp}.log  <  $folder/test_rng_cvpart.m

