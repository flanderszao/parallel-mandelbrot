#!/bin/bash
#SBATCH --job-name=mpi_test_cases
#SBATCH --nodes=2
#SBATCH --ntasks=64                        # Solicita até 64 tasks para cobrir todos os testes
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00                    # Limite máximo para 2 nós
#SBATCH --output=output_%j.log
#SBATCH --error=error_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END              # Envia e-mail no início e no fim
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

WORKDIR="/home/$USER/parallel-mandelbrot"
cd "$WORKDIR"

# Compila o código
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm

# Executa os testes com diferentes números de processos
for processes in 16 32 64; do
    echo "Running with -np $processes"
    if [ "$processes" -le 32 ]; then
        mpirun -np $processes ./mandelbrot_mpi
    else
        mpirun --oversubscribe -np $processes ./mandelbrot_mpi
    fi
done

echo "Job $SLURM_JOB_ID finished at $(date)"