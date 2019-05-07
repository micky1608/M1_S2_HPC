#include <stdio.h>
#include <mpi.h>
#include <string.h>
#include <unistd.h>

#define SIZE_H_N 50

int main(int argc , char *argv[]) {

    int rank;       /* rank of the process */
    int p;          /* number of processes */
    int source;     /* rank of the emitter */
    int dest;       /* rank of the receiver */
    int tag = 0;    /* tag of the message */

    char message[100];
    MPI_Status status;
    char hostname[SIZE_H_N];

    gethostname(hostname , SIZE_H_N);   /* Get the host name of the current processor */

    /* Initialisation */
    MPI_Init(&argc , &argv);
    MPI_Comm_rank(MPI_COMM_WORLD , &rank);
    MPI_Comm_size(MPI_COMM_WORLD , &p);

    if (rank != 0) {
        sprintf(message , "Coucou du processus #%d depuis %s !\n" , rank , hostname);
        dest = 0;
        MPI_Send(message , strlen(message)+1 , MPI_CHAR , dest , tag , MPI_COMM_WORLD);
    }
    else {
        for(source = 1 ; source < p ; source++) {
            MPI_Recv(message , 100 , MPI_CHAR , source , tag , MPI_COMM_WORLD , &status);
            printf("Sur %s, le processus #%d a recu le message : %s\n" , hostname , rank , message);
        }
    }

    MPI_Finalize();
}

