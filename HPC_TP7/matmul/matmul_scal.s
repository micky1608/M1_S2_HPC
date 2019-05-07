	.file	"matmul.c"
	.text
	.p2align 4,,15
	.type	matmul._omp_fn.0, @function
matmul._omp_fn.0:
.LFB25:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movl	24(%rdi), %ebx
	movq	%rdi, 24(%rsp)
	call	omp_get_num_threads@PLT
	movl	%eax, %ebp
	call	omp_get_thread_num@PLT
	movl	%eax, %r11d
	movl	%ebx, %eax
	cltd
	idivl	%ebp
	cmpl	%edx, %r11d
	jl	.L2
.L12:
	imull	%eax, %r11d
	addl	%edx, %r11d
	leal	(%rax,%r11), %r12d
	cmpl	%r12d, %r11d
	jge	.L22
	movq	24(%rsp), %rax
	leal	-1(%rbx), %esi
	movl	%r11d, %ebp
	xorl	%edx, %edx
	movq	%rsi, 8(%rsp)
	imull	%ebx, %ebp
	movq	(%rax), %r13
	movq	8(%rax), %rdi
	movq	16(%rax), %r14
	movl	32(%rax), %eax
	leaq	4(%r13), %rsi
	movq	%rdi, (%rsp)
	movslq	%ebx, %rdi
	movq	%rsi, 16(%rsp)
	salq	$2, %rdi
	leaq	4(%r14), %r15
	.p2align 4,,10
	.p2align 3
.L7:
	testl	%ebx, %ebx
	jle	.L13
	movq	8(%rsp), %rsi
	movslq	%ebp, %rax
	movq	(%rsp), %r8
	leaq	0(,%rax,4), %r9
	addq	%rax, %rsi
	leaq	(%r14,%r9), %rcx
	addq	%r13, %r9
	salq	$2, %rsi
	leaq	(%r15,%rsi), %r10
	addq	16(%rsp), %rsi
	.p2align 4,,10
	.p2align 3
.L9:
	vmovss	(%rcx), %xmm1
	movq	%r8, %rdx
	movq	%r9, %rax
	.p2align 4,,10
	.p2align 3
.L6:
	vmovss	(%rax), %xmm0
	vmulss	(%rdx), %xmm0, %xmm0
	addq	$4, %rax
	addq	%rdi, %rdx
	vaddss	%xmm0, %xmm1, %xmm1
	vmovss	%xmm1, (%rcx)
	cmpq	%rax, %rsi
	jne	.L6
	addq	$4, %rcx
	addq	$4, %r8
	cmpq	%rcx, %r10
	jne	.L9
	movl	%ebx, %eax
	movl	%ebx, %ecx
	movl	$1, %edx
.L5:
	addl	$1, %r11d
	addl	%ebx, %ebp
	cmpl	%r11d, %r12d
	jne	.L7
	movq	24(%rsp), %rbx
	movl	%ecx, 28(%rbx)
	testb	%dl, %dl
	je	.L22
	movl	%eax, 32(%rbx)
.L22:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L13:
	.cfi_restore_state
	xorl	%ecx, %ecx
	jmp	.L5
.L2:
	addl	$1, %eax
	xorl	%edx, %edx
	jmp	.L12
	.cfi_endproc
.LFE25:
	.size	matmul._omp_fn.0, .-matmul._omp_fn.0
	.p2align 4,,15
	.globl	my_gettimeofday
	.type	my_gettimeofday, @function
my_gettimeofday:
.LFB22:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	xorl	%esi, %esi
	leaq	16(%rsp), %rdi
	call	gettimeofday@PLT
	fildq	24(%rsp)
	fldt	.LC0(%rip)
	fmulp	%st, %st(1)
	fildq	16(%rsp)
	faddp	%st, %st(1)
	fstpl	8(%rsp)
	vmovsd	8(%rsp), %xmm0
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	my_gettimeofday, .-my_gettimeofday
	.p2align 4,,15
	.globl	matmul
	.type	matmul, @function
matmul:
.LFB23:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rsi, 8(%rsp)
	vmovq	8(%rsp), %xmm1
	leaq	16(%rsp), %rsi
	movq	%rcx, 32(%rsp)
	xorl	%ecx, %ecx
	vpinsrq	$1, %rdx, %xmm1, %xmm0
	movl	%edi, 40(%rsp)
	xorl	%edx, %edx
	leaq	matmul._omp_fn.0(%rip), %rdi
	vmovaps	%xmm0, 16(%rsp)
	movl	$0, 44(%rsp)
	movl	$0, 48(%rsp)
	call	GOMP_parallel@PLT
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	matmul, .-matmul
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"For n=%d: total computation time (with gettimeofday()) : %g s\n"
	.align 8
.LC10:
	.string	"For n=%d: performance = %g Gflop/s \n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC11:
	.string	"%+e  "
.LC12:
	.string	"Error while allocating C.\n"
.LC13:
	.string	"Error while allocating B.\n"
.LC14:
	.string	"Error while allocating A.\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$2, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	$16, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	cmpl	$2, %edi
	je	.L60
.L30:
	leaq	56(%rsp), %rdi
	movq	%rbp, %rdx
	movl	$32, %esi
	call	posix_memalign@PLT
	testl	%eax, %eax
	je	.L61
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC14(%rip), %rdi
	call	fwrite@PLT
.L45:
	leaq	64(%rsp), %rdi
	movq	%rbp, %rdx
	movl	$32, %esi
	call	posix_memalign@PLT
	testl	%eax, %eax
	je	.L62
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC13(%rip), %rdi
	call	fwrite@PLT
.L44:
	leaq	72(%rsp), %rdi
	movq	%rbp, %rdx
	movl	$32, %esi
	call	posix_memalign@PLT
	testl	%eax, %eax
	je	.L63
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC12(%rip), %rdi
	call	fwrite@PLT
.L43:
	movslq	%r15d, %rax
	movq	%rax, 24(%rsp)
	testl	%r15d, %r15d
	jle	.L34
	movl	%r15d, %r9d
	movl	%r15d, %ebp
	vmovdqa	.LC2(%rip), %xmm7
	xorl	%edi, %edi
	shrl	$2, %r9d
	vmovdqa	.LC4(%rip), %xmm6
	vmovdqa	.LC5(%rip), %xmm5
	leaq	0(,%rax,4), %r14
	leal	-1(%r15), %r8d
	salq	$4, %r9
	andl	$-4, %ebp
	xorl	%r10d, %r10d
	vmovaps	.LC6(%rip), %xmm2
	vmovss	.LC3(%rip), %xmm3
	xorl	%r11d, %r11d
	.p2align 4,,10
	.p2align 3
.L35:
	cmpl	$2, %r8d
	jbe	.L47
	movl	%edi, (%rsp)
	vbroadcastss	(%rsp), %xmm4
	leaq	(%r12,%r10), %rsi
	xorl	%eax, %eax
	leaq	0(%r13,%r10), %rcx
	leaq	(%rbx,%r10), %rdx
	vmovdqa	%xmm7, %xmm1
	.p2align 4,,10
	.p2align 3
.L37:
	vpaddd	%xmm1, %xmm4, %xmm0
	vmovups	%xmm2, (%rcx,%rax)
	vpaddd	%xmm6, %xmm1, %xmm1
	vpaddd	%xmm5, %xmm0, %xmm0
	vmovups	%xmm2, (%rdx,%rax)
	vcvtdq2ps	%xmm0, %xmm0
	vdivps	%xmm0, %xmm2, %xmm0
	vmovups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	%r9, %rax
	jne	.L37
	movl	%ebp, %eax
	cmpl	%ebp, %r15d
	je	.L36
.L39:
	leal	1(%rdi,%rax), %ecx
	vxorps	%xmm0, %xmm0, %xmm0
	movslq	%eax, %rdx
	vcvtsi2ss	%ecx, %xmm0, %xmm0
	addq	%r11, %rdx
	leal	1(%rax), %ecx
	vmovss	%xmm3, 0(%r13,%rdx,4)
	vmovss	%xmm3, (%rbx,%rdx,4)
	vdivss	%xmm0, %xmm3, %xmm0
	vmovss	%xmm0, (%r12,%rdx,4)
	cmpl	%ecx, %r15d
	jle	.L36
	movslq	%ecx, %rdx
	vxorps	%xmm0, %xmm0, %xmm0
	leal	1(%rdi,%rcx), %ecx
	addl	$2, %eax
	vcvtsi2ss	%ecx, %xmm0, %xmm0
	addq	%r11, %rdx
	vmovss	%xmm3, 0(%r13,%rdx,4)
	vmovss	%xmm3, (%rbx,%rdx,4)
	vdivss	%xmm0, %xmm3, %xmm0
	vmovss	%xmm0, (%r12,%rdx,4)
	cmpl	%r15d, %eax
	jge	.L36
	movslq	%eax, %rdx
	vxorps	%xmm0, %xmm0, %xmm0
	leal	1(%rax,%rdi), %eax
	vcvtsi2ss	%eax, %xmm0, %xmm0
	addq	%r11, %rdx
	vmovss	%xmm3, 0(%r13,%rdx,4)
	vmovss	%xmm3, (%rbx,%rdx,4)
	vdivss	%xmm0, %xmm3, %xmm0
	vmovss	%xmm0, (%r12,%rdx,4)
.L36:
	addl	$1, %edi
	addq	24(%rsp), %r11
	addq	%r14, %r10
	cmpl	%edi, %r15d
	jne	.L35
.L34:
	leaq	80(%rsp), %r14
	xorl	%esi, %esi
	movl	$10, %ebp
	movq	%r14, %rdi
	call	gettimeofday@PLT
	fildq	88(%rsp)
	movq	%r12, (%rsp)
	vmovq	(%rsp), %xmm7
	fldt	.LC0(%rip)
	vpinsrq	$1, %r13, %xmm7, %xmm7
	vmovaps	%xmm7, (%rsp)
	fmulp	%st, %st(1)
	fildq	80(%rsp)
	faddp	%st, %st(1)
	fstpl	32(%rsp)
	.p2align 4,,10
	.p2align 3
.L40:
	vmovdqa	(%rsp), %xmm7
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%r14, %rsi
	leaq	matmul._omp_fn.0(%rip), %rdi
	movq	%rbx, 96(%rsp)
	vmovaps	%xmm7, 80(%rsp)
	movl	%r15d, 104(%rsp)
	movl	$0, 108(%rsp)
	movl	$0, 112(%rsp)
	call	GOMP_parallel@PLT
	subl	$1, %ebp
	jne	.L40
	movq	%r14, %rdi
	xorl	%esi, %esi
	leaq	.LC11(%rip), %r14
	movq	%rbx, %rbp
	call	gettimeofday@PLT
	fildq	88(%rsp)
	movl	%r15d, %edx
	movq	stdout(%rip), %rdi
	leaq	.LC8(%rip), %rsi
	movl	$1, %eax
	fldt	.LC0(%rip)
	fmulp	%st, %st(1)
	fildq	80(%rsp)
	faddp	%st, %st(1)
	fstpl	40(%rsp)
	vmovsd	40(%rsp), %xmm1
	vsubsd	32(%rsp), %xmm1, %xmm1
	vdivsd	.LC7(%rip), %xmm1, %xmm1
	vmovapd	%xmm1, %xmm0
	vmovsd	%xmm1, (%rsp)
	call	fprintf@PLT
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovsd	(%rsp), %xmm1
	movl	%r15d, %edx
	vcvtsi2sd	%r15d, %xmm2, %xmm2
	movq	stdout(%rip), %rdi
	movl	$1, %eax
	leaq	.LC10(%rip), %rsi
	vaddsd	%xmm2, %xmm2, %xmm0
	vmulsd	%xmm2, %xmm0, %xmm0
	vmulsd	%xmm2, %xmm0, %xmm0
	vdivsd	%xmm1, %xmm0, %xmm0
	vdivsd	.LC9(%rip), %xmm0, %xmm0
	call	fprintf@PLT
	movq	24(%rsp), %rax
	movl	$2, 24(%rsp)
	salq	$2, %rax
	movq	%rax, (%rsp)
.L41:
	movq	%r14, %rdi
	vxorpd	%xmm0, %xmm0, %xmm0
	movl	$1, %eax
	vcvtss2sd	0(%rbp), %xmm0, %xmm0
	call	printf@PLT
	movq	%r14, %rdi
	vxorpd	%xmm0, %xmm0, %xmm0
	movl	$1, %eax
	vcvtss2sd	4(%rbp), %xmm0, %xmm0
	call	printf@PLT
	movl	$10, %edi
	call	putchar@PLT
	addq	(%rsp), %rbp
	cmpl	$1, 24(%rsp)
	jne	.L48
	movl	$10, %edi
	movl	$2, %ebp
	leaq	.LC11(%rip), %r14
	call	putchar@PLT
	leal	-2(%r15), %edx
	movl	%r15d, %r8d
	imull	%edx, %r8d
	movslq	%edx, %rdx
	movslq	%r8d, %rax
	addq	%rdx, %rax
	leaq	(%rbx,%rax,4), %r15
.L42:
	movq	%r14, %rdi
	vxorpd	%xmm0, %xmm0, %xmm0
	movl	$1, %eax
	vcvtss2sd	(%r15), %xmm0, %xmm0
	call	printf@PLT
	movq	%r14, %rdi
	vxorpd	%xmm0, %xmm0, %xmm0
	movl	$1, %eax
	vcvtss2sd	4(%r15), %xmm0, %xmm0
	call	printf@PLT
	movl	$10, %edi
	call	putchar@PLT
	addq	(%rsp), %r15
	cmpl	$1, %ebp
	je	.L64
	movl	$1, %ebp
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L48:
	movl	$1, 24(%rsp)
	jmp	.L41
.L64:
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	addq	$136, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L47:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L39
.L63:
	movq	72(%rsp), %rbx
	jmp	.L43
.L62:
	movq	64(%rsp), %r13
	jmp	.L44
.L61:
	movq	56(%rsp), %r12
	jmp	.L45
.L60:
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %r15d
	imull	%eax, %eax
	movslq	%eax, %rbp
	salq	$2, %rbp
	jmp	.L30
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	2943117750
	.long	2251799813
	.long	16363
	.long	0
	.align 16
.LC2:
	.long	0
	.long	1
	.long	2
	.long	3
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC3:
	.long	1065353216
	.section	.rodata.cst16
	.align 16
.LC4:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC5:
	.long	1
	.long	1
	.long	1
	.long	1
	.align 16
.LC6:
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC7:
	.long	0
	.long	1076101120
	.align 8
.LC9:
	.long	0
	.long	1104006501
	.ident	"GCC: (Debian 8.3.0-2) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
