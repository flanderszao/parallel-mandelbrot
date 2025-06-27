#!/bin/bash
#SBATCH --job-name=seq_test_case
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --output=output_seq_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Compila o código sequencial
gcc mandelbrot.c -o mandelbrot_seq -lm

echo "Running Mandelbrot sequencial"
srun --nodes=1 --ntasks=1 ./mandelbrot_seq

echo "Job $SLURM_JOB_ID finished at $(date)"