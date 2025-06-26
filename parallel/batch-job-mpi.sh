#!/bin/bash
#SBATCH --job-name=mpi_test_cases
#SBATCH --nodes=2
#SBATCH --ntasks=64                   # Permite até 64 processos (HT em 2 nós)
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log
#SBATCH --error=error_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Compila o código MPI
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm

echo "===== Teste SEM Hyper-Threading (1 nó, até 16 processos) ====="
for processes in 2 4 6 8 10 12 14 16; do
    echo "Running with --ntasks=$processes (1 node)"
    srun --nodes=1 --ntasks=$processes ./mandelbrot_mpi
done

echo "===== Teste COM Hyper-Threading (até 64 processos) ====="
for processes in 34 40 48 56 64; do
    echo "Running with -np $processes"
    mpirun --oversubscribe -np $processes ./mandelbrot_mpi
done

echo "Job $SLURM_JOB_ID finished at $(date)"