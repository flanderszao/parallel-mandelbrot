#!/bin/bash
#SBATCH --job-name=omp_test_cases
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END                # E-mail no início e fim
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Compila o código
gcc parallel/mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm

echo "Running with OMP_NUM_THREADS=$THREADS"
export OMP_NUM_THREADS=1
./mandelbrot_omp

echo "Job $SLURM_JOB_ID finished at $(date)"