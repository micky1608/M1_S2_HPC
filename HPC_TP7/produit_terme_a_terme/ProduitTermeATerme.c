#include <sys/time.h>
#include <stdio.h> 

#include <immintrin.h>

//#define N 128
//#define N 1024
//#define N 16384
//#define N 1048576
//#define N 16777216
#define N 134217728
#define NB_TIMES 1000000

#define TYPE float
#define REGISTER_SIZE 32
#define VECT_SIZE REGISTER_SIZE/sizeof(TYPE)
#define PAD N%(VECT_SIZE)

double my_gettimeofday(){
  struct timeval tmp_time;
  gettimeofday(&tmp_time, NULL);
  return tmp_time.tv_sec + (tmp_time.tv_usec * 1.0e-6L);
}

float A[N + PAD] __attribute__((aligned(32)));
float B[N + PAD] __attribute__((aligned(32)));
float C[N + PAD] __attribute__((aligned(32)));

int main(){
  printf("N : %d\n",N);
  printf("vect size : %d\n",VECT_SIZE);
  printf("pad : %d\n",PAD);

  int i,k;
  double start, stop;
  float res = 0.0; 

  for (i=0;i<N;i++){
    A[i]=1.0;
    B[i]=1.0;
    C[i]=0.0; 
  }

  for(i=N ; i<N+PAD ; i++) {
    A[i]=0.0;
    B[i]=0.0;
    C[i]=0.0; 
  }

  start = my_gettimeofday();

  __m256 vA , vB , vC;

    
  for (k=0; k<NB_TIMES;k++){
    for (i=0;i<N;i+=VECT_SIZE){
      vA = _mm256_load_ps(&A[i]);
      vB = _mm256_load_ps(&B[i]);

      vC = _mm256_mul_ps(vA, vB);

      _mm256_store_ps(&C[i] , vC);

      // C[i] = A[i]*B[i]; 
    }
    
  }

  stop = my_gettimeofday(); 
  fprintf(stdout, "C[0]=%f C[1]=%f C[4]=%f C[8]=%f C[N-1]=%f \n", 
	  C[0], C[1], C[4], C[8], C[N-1]); 

  fprintf(stdout, "Temps total de calcul : %g sec\n", stop - start);

  return 0; 
}

