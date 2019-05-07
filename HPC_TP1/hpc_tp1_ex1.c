#include <stdio.h>
#include <mpi.h>


/**
 * MPI program to run with 2 processes.
 * Same code for both (SPMD)
 * @param argc
 * @param argv
 * @return
 */
int main(int argc , char *argv[]) {
    int rank , p , valeur , tag = 10;
    MPI_Status status;

    /* Initialisation */
    MPI_Init(&argc , &argv);
    MPI_Comm_size(MPI_COMM_WORLD , &p);
    MPI_Comm_rank(MPI_COMM_WORLD , &rank);

    if(rank == 1) {
        valeur = 18;
        MPI_Send(&valeur , 1 , MPI_INT , 0 , tag , MPI_COMM_WORLD);
    }
    else if (rank == 0) {
        MPI_Recv(&valeur , 1 , MPI_INT , 1 , tag , MPI_COMM_WORLD , &status);
        printf("J'ai recu la valeur %d du processus de rang 1\n",valeur);
    }

    MPI_Finalize();

    return 0;
}