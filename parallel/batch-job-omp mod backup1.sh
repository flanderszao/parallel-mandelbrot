#!/bin/bash
#SBATCH --job-name=omp_test_cases
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16                   # Ajuste conforme o número de CPUs físicos do nó
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END                # E-mail no início e fim
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Compila o código
gcc parallel/mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm

# Executa os testes variando o número de threads de 2 em 2
for THREADS in 2 4 6 8 10 12 14 16; do
    echo "Running with OMP_NUM_THREADS=$THREADS"
    export OMP_NUM_THREADS=$THREADS
    ./mandelbrot_omp
done

echo "Job $SLURM_JOB_ID finished at $(date)"