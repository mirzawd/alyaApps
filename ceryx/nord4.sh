#!/bin/bash
#SBATCH --job-name=ceryxMultiMehs
#SBATCH --output=alya.out
#SBATCH --error=alya.err
#SBATCH --ntasks=3
#SBATCH --ntasks-per-core=1
###SBATCH --ntasks-per-socket=24
#SBATCH --ntasks-per-node=16
#SBATCH --distribution=cyclic
#SBATCH --time=00:30:00
###SBATCH --qos=bsc_case

set -e

module purge
#module load gcc/7.2.0
module load intel/2021.4
module load impi/2021.4
module load mkl/2021.4
#module load EXTRAE
module load dlb

export ROMIO_HINTS=./io_hints
export I_MPI_EXTRA_FILESYSTEM_LIST=gpfs
export I_MPI_EXTRA_FILESYSTEM=on
export NO_STOP_MESSAGE=1
export LD_LIBRARY_PATH=:$LD_LIBRARY_PATH:/apps/PM/dlb/latest/impi/lib

export DLB_ARGS+=" --barrier"

ALYA=/gpfs/projects/bsc21/bsc21448/WORK-CONSTA/ALYA/alya-nord3/configure-dlb/Alya.x



if ldd $ALYA | grep -iq libdlb; then
    echo "Alya was compiled WITH dlb"
else
    echo "Alya was compiled WITHOUT dlb. Please recompile"
    exit 1
fi
     

date
mpirun -rr -np 3 $ALYA run_name
date
#../../resources.sh
