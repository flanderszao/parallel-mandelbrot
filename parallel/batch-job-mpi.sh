#!/bin/bash
#SBATCH --job-name=mpi_test_cases
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log
#SBATCH --error=error_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Compila o código MPI
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm

for processes in 8; do
    echo "Running with -np $processes"
    mpirun -np $processes ./mandelbrot_mpi
done

echo "Job $SLURM_JOB_ID finished at $(date)"