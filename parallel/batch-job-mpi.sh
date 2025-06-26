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

WORKDIR="/home/$USER/parallel-mandelbrot"
cd "$WORKDIR"

echo "===== Teste SEM Hyper-Threading (até 32 processos) ====="
for processes in 2 4 8 16 24 32; do
    echo "Running with -np $processes"
    mpirun -np $processes ./mandelbrot_mpi
done

echo "===== Teste COM Hyper-Threading (até 64 processos) ====="
for processes in 34 40 48 56 64; do
    echo "Running with -np $processes"
    mpirun -np $processes ./mandelbrot_mpi
done

echo "Job $SLURM_JOB_ID finished at $(date)"