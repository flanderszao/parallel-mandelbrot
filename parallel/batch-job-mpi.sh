#!/bin/bash
#SBATCH --job-name=mpi_test_cases
#SBATCH --nodes=2
#SBATCH --ntasks=32                   # Permite até 64 processos (HT em 2 nós)
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log
#SBATCH --error=error_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Compila o código MPI
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm

for processes in 40 42 44 46 48 50 52 54 56 58 60 62 64; do
    echo "Running with -np $processes"
    mpirun --oversubscribe -np $processes ./mandelbrot_mpi
done

echo "Job $SLURM_JOB_ID finished at $(date)"