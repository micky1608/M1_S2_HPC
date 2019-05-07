#include <stdlib.h>
#include <stdio.h>

#include <omp.h>
#include <sys/time.h>

#define PROF 20

double my_gettimeofday(){
  struct timeval tmp_time;
  gettimeofday(&tmp_time, NULL);
  return tmp_time.tv_sec + (tmp_time.tv_usec * 1.0e-6L);
}

int fib(int n , int prof) {
  int i, j;
  if (n<2)
    return n;

  if(prof <=0) {
    i=fib(n-1 , 0);
    j=fib(n-2 , 0);
  }
  else {
    #pragma omp task shared(i)
    i=fib(n-1 , prof - 1);

    #pragma omp task shared(j)
    j=fib(n-2 , prof - 2);

    #pragma omp taskwait
  }

  return i+j;
}


///////////////////////////////////////////////////////////////////////
int main(int argc, char **argv)
{
  int i,j;
  double debut=0.0, fin=0.0;
  int n=45; /* default value -> roughly 10 seconds of computation */
  int res=0;

  /* Read 'n' on command line: */
  if (argc == 2){
    n = atoi(argv[1]);
  }

  /* Start timing */
  debut = my_gettimeofday();

  /* Do computation:  */
  #pragma omp parallel 
  { 
    #pragma omp single
    res=fib(n,PROF);
  }
  
     
  /* End timing */
  fin = my_gettimeofday();
  fprintf(stdout, " fib(%d)=%d\n", n, res);
  fprintf( stdout, "For n=%d: total computation time (with gettimeofday()) : %g s\n",
	   n, fin - debut);
      
  return 0;
}



