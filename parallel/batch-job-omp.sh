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

for THREADS in 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32; do
    echo "Running with OMP_NUM_THREADS=$THREADS"
    export OMP_NUM_THREADS=$THREADS
    ./mandelbrot_omp
done

echo "Job $SLURM_JOB_ID finished at $(date)"