EXECS = matmul_blas

all: $(EXECS)

matmul_blas : matmul_blas.c 
	gcc -o $@ $< -lopenblas
clean: 
	rm -rf $(EXECS)

.phony: all
