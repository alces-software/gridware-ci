wget http://packages.alces-software.com.s3.amazonaws.com/gridware/%24test/mpi_hello.c
mpicc mpi_hello.c
mpirun -np 2 ./a.out
