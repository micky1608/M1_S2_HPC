/*
 * Universit� Pierre et Marie Curie
 *
 * Programme de multiplication de matrices carrees.
 */ 

#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include <sys/time.h>

#include <omp.h>
#include <immintrin.h>

#define TYPE float
#define AVX_REGISTER_SIZE 32  // in bytes 
#define VECT_SIZE AVX_REGISTER_SIZE/sizeof(TYPE)    // amount of elements of type TYPE in avx register 

double my_gettimeofday(){
  struct timeval tmp_time;
  gettimeofday(&tmp_time, NULL);
  return tmp_time.tv_sec + (tmp_time.tv_usec * 1.0e-6L);
}


#define REAL_T float 
#define NB_TIMES 10

#define THRESHOLD 32

/*** Matmul: ***/
/* C += A x B 
 * square matrices of order 'n'
 */
void matmul(int n, REAL_T *A, REAL_T *B, REAL_T *C){
  int i,j,k;

  for (i=0; i<n; i++){ 
    for (j=0; j<n; j++){
      for (k=0; k<n; k++){
	C[i*n+j] +=  A[i*n+k] *  B[k*n+j];  
      } /* for k */
    } /* for j */
  } /* for i */
}


/* 
  C += A*B
  Matrix are of size n such as n is a power of 2
*/
void matmul_block(int crow , int ccol , /* Upper left corner of C block*/
                  int arow , int acol , /* Upper left corner of A block*/
                  int brow , int bcol , /* Upper left corner of B block*/
                  int n ,               /* Size of blocks */
                  int stride ,          /* Stride fot whole matrix */
                  float *A , float *B , float *C) {

  if(n <= THRESHOLD && n >= 8) 
  {
    __m256 vA , vB , vC , vS;    // register of size 256 bits = 32 bytes

    float buffer[VECT_SIZE] __attribute__((aligned(32)));
    float *BT;

    if((BT = aligned_alloc(32 , n*n*sizeof(float))) == NULL) fprintf(stderr, "Error while allocating B transpose.\n");

    int r=0;
    for(int j=0 ; j<n ; j++) {
      for(int i=0 ; i<n ; i++) {
        BT[r] = B[stride*(brow+i) + bcol + j];
        r++;
      }
    } 
  
    for(int i=0 ; i<n ; i++) {
      for(int j=0 ; j<n ; j++) {
        for(int k=0 ; k<n ; k+=VECT_SIZE) {
          
          vA = _mm256_load_ps(&A[stride*(arow + i) + acol + k]);    // load elements of A in avx register 
          vB = _mm256_load_ps(&BT[j*n + k]);                        // load elements of B transpose in avx register 
          vS = _mm256_mul_ps(vA,vB);                                // vectorized multiplication
          _mm256_store_ps(buffer , vS);                             // retrieve the result

          for(int l=0 ; l<VECT_SIZE ; l++) C[stride*(crow + i) + ccol + j] += buffer[l];      
        }
      }
    }
    free(BT);
  }
  else 
  {
    #pragma omp parallel for collapse(2)
    for(int i=0 ; i<2 ; i++) {
      for(int j=0 ; j<2 ; j++) {
        matmul_block(crow + i*n/2 , ccol + j*n/2 , arow + i*n/2 , acol , brow , bcol + j*n/2 , n/2 , stride , A , B , C);
        matmul_block(crow + i*n/2 , ccol + j*n/2 , arow + i*n/2 , acol + n/2 , brow + n/2 , bcol + j*n/2 , n/2 , stride , A , B , C);
      }
    }
  }
}

/* For matrix of size n = 2^r */
void matmul_fast(int n , float *A , float *B , float *C) {
  matmul_block(0,0,0,0,0,0,n,n,A,B,C);
}



int main(int argc, char **argv)
{
  int i,j;
  double debut=0.0, fin=0.0;
  REAL_T *A, *B, *C;
  int n=2; /* default value */
  int nb=0;
  
  /* Read 'n' on command line: */
  if (argc == 2){
    n = atoi(argv[1]);
  }

  /* Allocate the matrices: */
  if ((A = (REAL_T *)aligned_alloc(32 , n*n*sizeof(REAL_T))) == NULL){
    fprintf(stderr, "Error while allocating A.\n");
  }
  if ((B = (REAL_T *)aligned_alloc(32 , n*n*sizeof(REAL_T))) == NULL){
    fprintf(stderr, "Error while allocating B.\n");
  }
  if ((C = (REAL_T *)aligned_alloc(32 , n*n*sizeof(REAL_T))) == NULL){
    fprintf(stderr, "Error while allocating C.\n");
  }


  /* Initialize the matrices */
  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++){
      *(A+i*n+j) = 1 / ((REAL_T) (i+j+1));
      *(B+i*n+j) = 1.0;
      *(C+i*n+j) = 1.0;
  }

/* **************************************************************** */
  // print the matrix

/*
  printf("A : \n");
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++){
      printf("%+e ",*(A + i*n+j));
    }
    printf("\n");
  }

  printf("B : \n");
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++){
      printf("%+e ",*(B + i*n+j));
    }
    printf("\n");
  }
 
*/
/* **************************************************************** */


  /* Start timing */
  debut = my_gettimeofday();
  for (nb=0; nb<NB_TIMES; nb++){
    /* Do matrix-product C=A*B+C */
    matmul_fast(n, A, B, C);
    //matmul(n, A, B, C);
    /* End timing */
  }
  fin = my_gettimeofday();

/*
  printf("C : \n");
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++){
      printf("%+e ",*(C + i*n+j));
    }
    printf("\n");
  }
*/

  fprintf( stdout, "For n=%d: total computation time (with gettimeofday()) : %g s\n",
	   n, (fin - debut)/NB_TIMES);
  fprintf( stdout, "For n=%d: performance = %g Gflop/s \n",
	   n, (((double) 2)*n*n*n / ((fin - debut)/NB_TIMES) )/ ((double) 1e9) ); /* 2n^3 flops */
      
  /* Print 2x2 top-left square of C : */
  for(i=0; i<2 ; i++){
    for(j=0; j<2 ; j++)
      printf("%+e  ", C[i*n+j]);
    printf("\n");
  }
  printf("\n");
  /* Print 2x2 bottom-right square of C : */
  for(i=n-2; i<n ; i++){
    for(j=n-2; j<n ; j++)
      printf("%+e  ", C[i*n+j]);
    printf("\n");
  }

  /* Free the matrices: */
  free(A); 
  free(B); 
  free(C);

  return 0;
}
