EXECS = matmul_seq matmul

all: $(EXECS)

matmul_seq: matmul_seq.c
	gcc -o $@ $<

matmul : matmul.c 
	gcc -o $@ $< -fopenmp -mavx2
clean: 
	rm -rf $(EXECS)

.phony: all
