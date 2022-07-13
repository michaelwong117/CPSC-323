	.file	"userex2.c"
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
	movq	$8, -8(%rbp)
	movq	$16, -16(%rbp)
	movq	$5, -24(%rbp)
	movq	$-2, -32(%rbp)
	movq	$2, -40(%rbp)
	movq	$31, -48(%rbp)
	movq	$29, -56(%rbp)
	movq	$5, -64(%rbp)
	movq	$80, -72(%rbp)
	movq	$-100, -80(%rbp)
	movq	-24(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	foo, .-foo
	.ident	"GCC: (GNU) 11.2.1 20210728 (Red Hat 11.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
