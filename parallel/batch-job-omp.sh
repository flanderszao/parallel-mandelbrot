#!/bin/bash
#SBATCH --job-name=omp_test_cases
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32                   # Ajuste para incluir Hyper-Threading (16 cores físicos x 2)
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log
#SBATCH --exclusive
#SBATCH --mail-type=BEGIN,END                # E-mail no início e fim
#SBATCH --mail-user=v.rafael02@edu.pucrs.br

# Detecta informações do sistema
PHYSICAL_CORES=$(lscpu | grep "Core(s) per socket" | awk '{print $4}')
SOCKETS=$(lscpu | grep "Socket(s)" | awk '{print $2}')
TOTAL_PHYSICAL_CORES=$((PHYSICAL_CORES * SOCKETS))
LOGICAL_CORES=$(nproc)

echo "Sistema detectado:"
echo "  Núcleos físicos por socket: $PHYSICAL_CORES"
echo "  Sockets: $SOCKETS" 
echo "  Total de núcleos físicos: $TOTAL_PHYSICAL_CORES"
echo "  Total de núcleos lógicos (com HT): $LOGICAL_CORES"
echo ""

# Compila o código
gcc parallel/mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm

echo "===== Teste SEM Hyper-Threading (núcleos físicos) ====="
# Testa apenas com núcleos físicos, de 2 em 2
for THREADS in $(seq 2 2 $TOTAL_PHYSICAL_CORES); do
    echo "Running with OMP_NUM_THREADS=$THREADS (physical cores)"
    export OMP_NUM_THREADS=$THREADS
    ./mandelbrot_omp
done

echo ""
echo "===== Teste COM Hyper-Threading (oversubscribe) ====="
# Testa com Hyper-Threading (oversubscribe), de 2 em 2
START_HT=$((TOTAL_PHYSICAL_CORES + 2))
for THREADS in $(seq $START_HT 2 $LOGICAL_CORES); do
    echo "Running with OMP_NUM_THREADS=$THREADS (with Hyper-Threading)"
    export OMP_NUM_THREADS=$THREADS
    ./mandelbrot_omp
done

echo "Job $SLURM_JOB_ID finished at $(date)"