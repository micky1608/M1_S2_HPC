EXECS =  ProduitTermeATerme_scal
CFLAGS= -O3 -mavx2 #-ffast-math
OUT=output.txt 

all: $(EXECS)

ProduitTermeATerme_scal: ProduitTermeATerme.c
	gcc -S $(CFLAGS) -o $@.s $< ; grep -i mul $@.s
	gcc $(CFLAGS) -o $@ $<

exec: all 
	rm -rf $(OUT)
	(for e in $(EXECS) ; do echo "Running $$e ..." ; echo "" >> $(OUT) ; echo "Running $$e ..." >> $(OUT) ; ./$$e $$N >> $(OUT) ; done)

clean: 
	rm -rf $(EXECS) *~ *.s 

.phony: all
