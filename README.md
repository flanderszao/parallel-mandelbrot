# Parallel Implementation of Mandelbrot Fractals

This repository was forked from [abagali1/mandelbrot](https://github.com/abagali1/mandelbrot) and modified for use in my **"Fundamentals of Parallel and Distributed Processing"** class. The changes were made mainly to enable students to run parallel programs on our computer cluster, which uses the SLURM workload manager, and align the examples with the course objectives. By exploring this repository, students can gain hands-on experience executing and analyzing parallel computations in a real-world environment.

## Mandelbrot Fractals

Mandelbrot fractals are a class of mathematical objects that arise from the iterative application of a simple formula in complex numbers. Named after the mathematician Benoît B. Mandelbrot, these fractals are famous for their intricate and infinitely detailed structures. They are visualized as a set of points in the complex plane that remain bounded under repeated iteration of a specific equation.

![Mandelbrot Equation](https://latex.codecogs.com/png.latex?z_{n%2B1}%20=%20z_n^2%20+%20c)

This simple recursive formula gives rise to patterns that exhibit self-similarity, meaning smaller parts of the fractal resemble the whole. Mandelbrot fractals are not only visually captivating but also provide deep insights into chaos theory, complex dynamics, and mathematical beauty.


## Sequential Implementation


```bash
gcc mandelbrot.c -o mandelbrot_seq -lm
srun --nodes=1 --ntasks=1 ./mandelbrot_seq
```

Images are generated in .ppm format and stored in the `./output` directory. You can open them directly with compatible viewers using a command like:

```bash
open output/ms.ppm
```

Alternatively, convert them to other formats (e.g., .png) using ImageMagick:

```bash
convert output/ms.ppm output/ms.png
```

![mandelbrot](https://github.com/mvneves/parallel-mandelbrot/raw/master/output/readme.png)


## Parallel Implementation

OpenMP:
```bash
gcc parallel/mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm
srun --nodes=1 --ntasks=1 --cpus-per-task=8 ./mandelbrot_omp
```

Explanation:
- --nodes=1: Allocates one node.
- --ntasks=1: Executes a single task (process).
- --cpus-per-task=8: Allocates 8 cores for the task.

or as batch job
```bash
sbatch parallel/batch-job-omp.sh
```

MPI:
```bash
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm
srun --nodes=2 --ntasks=16 mandelbrot_mpi
```

Explanation:
- --nodes=2: Allocates two nodes.
- --ntasks=16: Executes 16 tasks (process), 8 per node.

or as batch job
```bash
sbatch parallel/batch-job-mpi.sh
```

Demonstration of set rendered in parallel
![mandelbrot](https://github.com/mvneves/parallel-mandelbrot/raw/master/parallel/parallel.gif)


## Other Variations

### Iterations
looks nice

```bash
mpicc iters/mandelbrot.c -o mandelbrot_iters -lm
srun --nodes=2 --ntasks=16 mandelbrot_iters
```

or as batch job
```bash
mpicc iters/mandelbrot.c -o iters/a.out -lm -Ofast 
sbatch iters/iter.sh
```

![mandelbrot](https://github.com/mvneves/parallel-mandelbrot/blob/master/iters/output.gif)

### Multibrot
variation of conventional mandelbrot equation
![Equation](https://latex.codecogs.com/png.latex?z_{n%2B1}%20=%20z_n^x%20+%20c)
where X varies.

in `multibrot/multibrot.c` set `MIN_POWER` and `MAX_POWER` to set range for X 

```bash
mpicc multibrot/multibrot.c -o multibrot -lm -Ofast
srun --nodes=2 --ntasks=16 multibrot
```

or as batch job
```bash
mpicc multibrot/multibrot.c -o multibrot/a.out -lm -Ofast
sbatch multibrot/multibrot.sh
```

[multibrot](https://github.com/mvneves/parallel-mandelbrot/blob/master/multibrot/output/output.mp4)

### Zoom (WIP)
hands down the coolest part

```bash
mpicc zoom/mandelbrot.c -o mandelbrot_zoom -lm
srun --nodes=2 --ntasks=16 mandelbrot_zoom
```
or batch job
```bash
mpicc zoom/mandelbrot.c -o zoom/a.out -lm -Ofast
sbatch zoom/zoom.sh
```

![mandelbrot-zoom](https://github.com/mvneves/parallel-mandelbrot/blob/master/zoom/zoom.gif)

