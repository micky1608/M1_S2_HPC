#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

double wtime()
{
	struct timeval ts;
	gettimeofday(&ts, NULL);
	return (double)ts.tv_sec + ts.tv_usec / 1E6;
}

int main(int argc , char *argv[]) {
    if(argc != 2) {
        perror("argv[1] : Nb iteration !!!\n");
        exit(-1);
    }

    double start = wtime();

    double pi=0;
    int N = atoi(argv[1]);

    #pragma omp parallel for reduction(+:pi)
    for(int i=0 ; i<= N; i++) {
        pi += 4/(1 + (i*1.0/N)*(i*1.0/N));
    }

    pi /= N;

    printf("Fin calcul : %.8f\n",pi);

    double end = wtime();

    printf("Temps d'execution : %.4f s\n",end-start);
}