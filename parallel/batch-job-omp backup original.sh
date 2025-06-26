#!/bin/bash
#SBATCH --job-name=omp_test_cases   # Job name
#SBATCH --nodes=1                   # Ensure all tasks are on one node
#SBATCH --ntasks=1                  # Only one process (OpenMP uses threads, not tasks)
#SBATCH --cpus-per-task=16          # Max CPUs available for testing
#SBATCH --time=01:00:00             # Max total job runtime
#SBATCH --output=output_%j.log      # Log file (one for the whole job, %j is the job ID)
#SBATCH --exclusive                 # Allocate the node exclusively (comment out for shared access)
##SBATCH --mail-type=ALL             # Send email for all job events (start, end, fail)
##SBATCH --mail-user=example@edu.pucrs.br # Email address for notifications

# Compile code
gcc parallel/mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm

# Run test cases
THREADS=8
echo "Running with OMP_NUM_THREADS=$THREADS"
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=16
echo "Running with OMP_NUM_THREADS=$THREADS"
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp
