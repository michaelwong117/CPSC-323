
.globl foo
foo:
pushq %rbp
movq %rsp, %rbp
subq $80, %rsp
movq %rdi, -8(%rbp)
movq %rsi, -16(%rbp)
movq -8(%rbp), %rax
movq $5, %rdx
addq %rdx, %rax
movq %rax, -24(%rbp)
movq -24(%rbp), %rax
movq -16(%rbp), %rdx
imulq %rdx, %rax
movq %rax, -32(%rbp)
movq -32(%rbp), %rax
addq $80, %rsp
popq  %rbp
retq
