	.file	"example7.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	$56, -8(%rbp)
	movq	$9, -16(%rbp)
	movq	$1, -24(%rbp)
	movq	$2, -32(%rbp)
	movq	-88(%rbp), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-96(%rbp), %rax
	imulq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-8(%rbp), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-16(%rbp), %rax
	imulq	-56(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cqto
	idivq	-24(%rbp)
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	foo, .-foo
	.ident	"GCC: (GNU) 11.2.1 20210728 (Red Hat 11.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
