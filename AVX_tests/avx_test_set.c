
#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>

#define avx_set(x,d0,d1,d2,d3) (x = _mm256_setr_pd (d0, d1, d2, d3))
typedef __m256d avx;


int main(int argc , char *argv[]) {

    avx v;
    avx_set(v,0,1,2,3);

    printf("v : : %.2f %.2f %.2f %.2f\n", \
			((double*)&v)[0], ((double*)&v)[1], ((double*)&v)[2], ((double*)&v)[3]);

    

    
    return 0;
}


