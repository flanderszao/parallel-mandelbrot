#!/bin/bash
#SBATCH --job-name=mpi_test_cases            # Job name
#SBATCH --nodes=2                            # Specify the number of nodes
#SBATCH --ntasks=32                          # Max number of tasks (use mpirun --oversubscribe for more)
#SBATCH --cpus-per-task=1                    # Number of CPU per tasks
#SBATCH --time=01:00:00                      # Max total job runtime
#SBATCH --output=output_%j.log               # Log file (one for the whole job, %j is the job ID)
#SBATCH --error=error_%j.log                 # Error log file
#SBATCH --exclusive                          # Allocate the node exclusively (comment out for shared access)
#SBATCH --mail-type=BEGIN,END               # Envia e-mail no início e no fim
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

WORKDIR="/home/$USER/parallel-mandelbrot"
cd "$WORKDIR"

# Executa os testes com diferentes números de processos
for processes in 2 4 8 16 32 64; do
    echo "Running with -np $processes"
    if [ "$processes" -le 32 ]; then
        mpirun -np $processes ./mandelbrot_mpi
    else
        mpirun --oversubscribe -np $processes ./mandelbrot_mpi
    fi
done

echo "Job $SLURM_JOB_ID finished at $(date)"