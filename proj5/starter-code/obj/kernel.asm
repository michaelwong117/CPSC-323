
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 5b 05 00 00       	call   4061e <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 20 12 00 00       	call   41398 <hardware_init>
    pageinfo_init();
   40178:	e8 c8 08 00 00       	call   40a45 <pageinfo_init>
    console_clear();
   4017d:	e8 f8 34 00 00       	call   4367a <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 fc 16 00 00       	call   41888 <timer_init>


    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 20 e0 04 00       	mov    $0x4e020,%edi
   4019b:	e8 f1 2b 00 00       	call   42d91 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 03          	shl    $0x3,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 05          	shl    $0x5,%rax
   401bd:	48 8d 90 20 e0 04 00 	lea    0x4e020(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 03          	shl    $0x3,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 05          	shl    $0x5,%rax
   401dd:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "fork") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be a0 36 04 00       	mov    $0x436a0,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 f7 2b 00 00       	call   42e02 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 d1 00 00 00       	call   402ef <process_setup>
   4021e:	e9 c2 00 00 00       	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 29                	je     40253 <kernel+0xec>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be a5 36 04 00       	mov    $0x436a5,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 c7 2b 00 00       	call   42e02 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 14                	jne    40253 <kernel+0xec>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 a1 00 00 00       	call   402ef <process_setup>
   4024e:	e9 92 00 00 00       	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "test") == 0) {
   40253:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40258:	74 26                	je     40280 <kernel+0x119>
   4025a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025e:	be ae 36 04 00       	mov    $0x436ae,%esi
   40263:	48 89 c7             	mov    %rax,%rdi
   40266:	e8 97 2b 00 00       	call   42e02 <strcmp>
   4026b:	85 c0                	test   %eax,%eax
   4026d:	75 11                	jne    40280 <kernel+0x119>
        process_setup(1, 6);
   4026f:	be 06 00 00 00       	mov    $0x6,%esi
   40274:	bf 01 00 00 00       	mov    $0x1,%edi
   40279:	e8 71 00 00 00       	call   402ef <process_setup>
   4027e:	eb 65                	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "test2") == 0) {
   40280:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40285:	74 39                	je     402c0 <kernel+0x159>
   40287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4028b:	be b3 36 04 00       	mov    $0x436b3,%esi
   40290:	48 89 c7             	mov    %rax,%rdi
   40293:	e8 6a 2b 00 00       	call   42e02 <strcmp>
   40298:	85 c0                	test   %eax,%eax
   4029a:	75 24                	jne    402c0 <kernel+0x159>
        for (pid_t i = 1; i <= 2; ++i) {
   4029c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a3:	eb 13                	jmp    402b8 <kernel+0x151>
            process_setup(i, 6);
   402a5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a8:	be 06 00 00 00       	mov    $0x6,%esi
   402ad:	89 c7                	mov    %eax,%edi
   402af:	e8 3b 00 00 00       	call   402ef <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b8:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402bc:	7e e7                	jle    402a5 <kernel+0x13e>
   402be:	eb 25                	jmp    402e5 <kernel+0x17e>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   402c0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   402c7:	eb 16                	jmp    402df <kernel+0x178>
            process_setup(i, i - 1);
   402c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402cc:	8d 50 ff             	lea    -0x1(%rax),%edx
   402cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402d2:	89 d6                	mov    %edx,%esi
   402d4:	89 c7                	mov    %eax,%edi
   402d6:	e8 14 00 00 00       	call   402ef <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   402db:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   402df:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   402e3:	7e e4                	jle    402c9 <kernel+0x162>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   402e5:	bf 00 e1 04 00       	mov    $0x4e100,%edi
   402ea:	e8 f9 06 00 00       	call   409e8 <run>

00000000000402ef <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402ef:	55                   	push   %rbp
   402f0:	48 89 e5             	mov    %rsp,%rbp
   402f3:	48 83 ec 20          	sub    $0x20,%rsp
   402f7:	89 7d ec             	mov    %edi,-0x14(%rbp)
   402fa:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   402fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40300:	48 63 d0             	movslq %eax,%rdx
   40303:	48 89 d0             	mov    %rdx,%rax
   40306:	48 c1 e0 03          	shl    $0x3,%rax
   4030a:	48 29 d0             	sub    %rdx,%rax
   4030d:	48 c1 e0 05          	shl    $0x5,%rax
   40311:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   40317:	be 00 00 00 00       	mov    $0x0,%esi
   4031c:	48 89 c7             	mov    %rax,%rdi
   4031f:	e8 f6 17 00 00       	call   41b1a <process_init>
    processes[pid].p_pagetable = kernel_pagetable;
   40324:	48 8b 15 d5 0c 01 00 	mov    0x10cd5(%rip),%rdx        # 51000 <kernel_pagetable>
   4032b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4032e:	48 63 c8             	movslq %eax,%rcx
   40331:	48 89 c8             	mov    %rcx,%rax
   40334:	48 c1 e0 03          	shl    $0x3,%rax
   40338:	48 29 c8             	sub    %rcx,%rax
   4033b:	48 c1 e0 05          	shl    $0x5,%rax
   4033f:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40345:	48 89 10             	mov    %rdx,(%rax)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount;
   40348:	48 8b 05 b1 0c 01 00 	mov    0x10cb1(%rip),%rax        # 51000 <kernel_pagetable>
   4034f:	48 c1 e8 0c          	shr    $0xc,%rax
   40353:	89 c2                	mov    %eax,%edx
   40355:	48 63 c2             	movslq %edx,%rax
   40358:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   4035f:	00 
   40360:	83 c0 01             	add    $0x1,%eax
   40363:	89 c1                	mov    %eax,%ecx
   40365:	48 63 c2             	movslq %edx,%rax
   40368:	88 8c 00 41 ee 04 00 	mov    %cl,0x4ee41(%rax,%rax,1)
    int r = program_load(&processes[pid], program_number, NULL);
   4036f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40372:	48 63 d0             	movslq %eax,%rdx
   40375:	48 89 d0             	mov    %rdx,%rax
   40378:	48 c1 e0 03          	shl    $0x3,%rax
   4037c:	48 29 d0             	sub    %rdx,%rax
   4037f:	48 c1 e0 05          	shl    $0x5,%rax
   40383:	48 8d 88 20 e0 04 00 	lea    0x4e020(%rax),%rcx
   4038a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4038d:	ba 00 00 00 00       	mov    $0x0,%edx
   40392:	89 c6                	mov    %eax,%esi
   40394:	48 89 cf             	mov    %rcx,%rdi
   40397:	e8 53 26 00 00       	call   429ef <program_load>
   4039c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   4039f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   403a3:	79 14                	jns    403b9 <process_setup+0xca>
   403a5:	ba b9 36 04 00       	mov    $0x436b9,%edx
   403aa:	be 82 00 00 00       	mov    $0x82,%esi
   403af:	bf c0 36 04 00       	mov    $0x436c0,%edi
   403b4:	e8 1e 1f 00 00       	call   422d7 <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   403b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403bc:	83 c0 04             	add    $0x4,%eax
   403bf:	c1 e0 12             	shl    $0x12,%eax
   403c2:	48 63 d0             	movslq %eax,%rdx
   403c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403c8:	48 63 c8             	movslq %eax,%rcx
   403cb:	48 89 c8             	mov    %rcx,%rax
   403ce:	48 c1 e0 03          	shl    $0x3,%rax
   403d2:	48 29 c8             	sub    %rcx,%rax
   403d5:	48 c1 e0 05          	shl    $0x5,%rax
   403d9:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   403df:	48 89 10             	mov    %rdx,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   403e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403e5:	48 63 d0             	movslq %eax,%rdx
   403e8:	48 89 d0             	mov    %rdx,%rax
   403eb:	48 c1 e0 03          	shl    $0x3,%rax
   403ef:	48 29 d0             	sub    %rdx,%rax
   403f2:	48 c1 e0 05          	shl    $0x5,%rax
   403f6:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   403fc:	48 8b 00             	mov    (%rax),%rax
   403ff:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40405:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   40409:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4040c:	0f be d0             	movsbl %al,%edx
   4040f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40413:	89 d6                	mov    %edx,%esi
   40415:	48 89 c7             	mov    %rax,%rdi
   40418:	e8 5b 00 00 00       	call   40478 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   4041d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40420:	48 63 d0             	movslq %eax,%rdx
   40423:	48 89 d0             	mov    %rdx,%rax
   40426:	48 c1 e0 03          	shl    $0x3,%rax
   4042a:	48 29 d0             	sub    %rdx,%rax
   4042d:	48 c1 e0 05          	shl    $0x5,%rax
   40431:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40437:	48 8b 00             	mov    (%rax),%rax
   4043a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4043e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40442:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40448:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4044d:	48 89 c7             	mov    %rax,%rdi
   40450:	e8 81 21 00 00       	call   425d6 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   40455:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40458:	48 63 d0             	movslq %eax,%rdx
   4045b:	48 89 d0             	mov    %rdx,%rax
   4045e:	48 c1 e0 03          	shl    $0x3,%rax
   40462:	48 29 d0             	sub    %rdx,%rax
   40465:	48 c1 e0 05          	shl    $0x5,%rax
   40469:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4046f:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   40475:	90                   	nop
   40476:	c9                   	leave  
   40477:	c3                   	ret    

0000000000040478 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40478:	55                   	push   %rbp
   40479:	48 89 e5             	mov    %rsp,%rbp
   4047c:	48 83 ec 10          	sub    $0x10,%rsp
   40480:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40484:	89 f0                	mov    %esi,%eax
   40486:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40489:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4048d:	25 ff 0f 00 00       	and    $0xfff,%eax
   40492:	48 85 c0             	test   %rax,%rax
   40495:	75 20                	jne    404b7 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   40497:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4049e:	00 
   4049f:	77 16                	ja     404b7 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   404a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404a5:	48 c1 e8 0c          	shr    $0xc,%rax
   404a9:	48 98                	cltq   
   404ab:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   404b2:	00 
   404b3:	84 c0                	test   %al,%al
   404b5:	74 07                	je     404be <assign_physical_page+0x46>
        return -1;
   404b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404bc:	eb 2c                	jmp    404ea <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   404be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404c2:	48 c1 e8 0c          	shr    $0xc,%rax
   404c6:	48 98                	cltq   
   404c8:	c6 84 00 41 ee 04 00 	movb   $0x1,0x4ee41(%rax,%rax,1)
   404cf:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   404d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404d4:	48 c1 e8 0c          	shr    $0xc,%rax
   404d8:	48 98                	cltq   
   404da:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   404de:	88 94 00 40 ee 04 00 	mov    %dl,0x4ee40(%rax,%rax,1)
        return 0;
   404e5:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   404ea:	c9                   	leave  
   404eb:	c3                   	ret    

00000000000404ec <syscall_mapping>:

void syscall_mapping(proc* p){
   404ec:	55                   	push   %rbp
   404ed:	48 89 e5             	mov    %rsp,%rbp
   404f0:	48 83 ec 70          	sub    $0x70,%rsp
   404f4:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   404f8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   404fc:	48 8b 40 38          	mov    0x38(%rax),%rax
   40500:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40504:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40508:	48 8b 40 30          	mov    0x30(%rax),%rax
   4050c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40510:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40514:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4051b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4051f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40523:	48 89 ce             	mov    %rcx,%rsi
   40526:	48 89 c7             	mov    %rax,%rdi
   40529:	e8 ca 23 00 00       	call   428f8 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4052e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40531:	48 98                	cltq   
   40533:	83 e0 06             	and    $0x6,%eax
   40536:	48 83 f8 06          	cmp    $0x6,%rax
   4053a:	75 73                	jne    405af <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   4053c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40540:	48 83 c0 17          	add    $0x17,%rax
   40544:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40548:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4054c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40553:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40557:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4055b:	48 89 ce             	mov    %rcx,%rsi
   4055e:	48 89 c7             	mov    %rax,%rdi
   40561:	e8 92 23 00 00       	call   428f8 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40566:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40569:	48 98                	cltq   
   4056b:	83 e0 03             	and    $0x3,%eax
   4056e:	48 83 f8 03          	cmp    $0x3,%rax
   40572:	75 3e                	jne    405b2 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40574:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40578:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4057f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40583:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40587:	48 89 ce             	mov    %rcx,%rsi
   4058a:	48 89 c7             	mov    %rax,%rdi
   4058d:	e8 66 23 00 00       	call   428f8 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40596:	48 89 c1             	mov    %rax,%rcx
   40599:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4059d:	ba 18 00 00 00       	mov    $0x18,%edx
   405a2:	48 89 c6             	mov    %rax,%rsi
   405a5:	48 89 cf             	mov    %rcx,%rdi
   405a8:	e8 7b 27 00 00       	call   42d28 <memcpy>
   405ad:	eb 04                	jmp    405b3 <syscall_mapping+0xc7>
	return;
   405af:	90                   	nop
   405b0:	eb 01                	jmp    405b3 <syscall_mapping+0xc7>
	return;
   405b2:	90                   	nop
}
   405b3:	c9                   	leave  
   405b4:	c3                   	ret    

00000000000405b5 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405b5:	55                   	push   %rbp
   405b6:	48 89 e5             	mov    %rsp,%rbp
   405b9:	48 83 ec 18          	sub    $0x18,%rsp
   405bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   405c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405c5:	48 8b 40 38          	mov    0x38(%rax),%rax
   405c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   405cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405d0:	75 14                	jne    405e6 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   405d2:	0f b6 05 27 4a 00 00 	movzbl 0x4a27(%rip),%eax        # 45000 <disp_global>
   405d9:	84 c0                	test   %al,%al
   405db:	0f 94 c0             	sete   %al
   405de:	88 05 1c 4a 00 00    	mov    %al,0x4a1c(%rip)        # 45000 <disp_global>
   405e4:	eb 36                	jmp    4061c <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   405e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405ea:	78 2f                	js     4061b <syscall_mem_tog+0x66>
   405ec:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   405f0:	7f 29                	jg     4061b <syscall_mem_tog+0x66>
   405f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405f6:	8b 00                	mov    (%rax),%eax
   405f8:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   405fb:	75 1e                	jne    4061b <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   405fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40601:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40608:	84 c0                	test   %al,%al
   4060a:	0f 94 c0             	sete   %al
   4060d:	89 c2                	mov    %eax,%edx
   4060f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40613:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   40619:	eb 01                	jmp    4061c <syscall_mem_tog+0x67>
            return;
   4061b:	90                   	nop
    }
}
   4061c:	c9                   	leave  
   4061d:	c3                   	ret    

000000000004061e <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   4061e:	55                   	push   %rbp
   4061f:	48 89 e5             	mov    %rsp,%rbp
   40622:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   40629:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40630:	48 8b 05 c9 d9 00 00 	mov    0xd9c9(%rip),%rax        # 4e000 <current>
   40637:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   4063e:	48 83 c0 08          	add    $0x8,%rax
   40642:	48 89 d6             	mov    %rdx,%rsi
   40645:	ba 18 00 00 00       	mov    $0x18,%edx
   4064a:	48 89 c7             	mov    %rax,%rdi
   4064d:	48 89 d1             	mov    %rdx,%rcx
   40650:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40653:	48 8b 05 a6 09 01 00 	mov    0x109a6(%rip),%rax        # 51000 <kernel_pagetable>
   4065a:	48 89 c7             	mov    %rax,%rdi
   4065d:	e8 43 1e 00 00       	call   424a5 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40662:	8b 05 94 89 07 00    	mov    0x78994(%rip),%eax        # b8ffc <cursorpos>
   40668:	89 c7                	mov    %eax,%edi
   4066a:	e8 6a 15 00 00       	call   41bd9 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   4066f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40676:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4067d:	48 83 f8 0e          	cmp    $0xe,%rax
   40681:	74 14                	je     40697 <exception+0x79>
   40683:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4068a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40691:	48 83 f8 0d          	cmp    $0xd,%rax
   40695:	75 16                	jne    406ad <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40697:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4069e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406a5:	83 e0 04             	and    $0x4,%eax
   406a8:	48 85 c0             	test   %rax,%rax
   406ab:	74 1a                	je     406c7 <exception+0xa9>
    {
        check_virtual_memory();
   406ad:	e8 2a 07 00 00       	call   40ddc <check_virtual_memory>
        if(disp_global){
   406b2:	0f b6 05 47 49 00 00 	movzbl 0x4947(%rip),%eax        # 45000 <disp_global>
   406b9:	84 c0                	test   %al,%al
   406bb:	74 0a                	je     406c7 <exception+0xa9>
            memshow_physical();
   406bd:	e8 92 08 00 00       	call   40f54 <memshow_physical>
            memshow_virtual_animate();
   406c2:	e8 b8 0b 00 00       	call   4127f <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   406c7:	e8 ea 19 00 00       	call   420b6 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   406cc:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406d3:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406da:	48 83 e8 0e          	sub    $0xe,%rax
   406de:	48 83 f8 2a          	cmp    $0x2a,%rax
   406e2:	0f 87 55 02 00 00    	ja     4093d <exception+0x31f>
   406e8:	48 8b 04 c5 58 37 04 	mov    0x43758(,%rax,8),%rax
   406ef:	00 
   406f0:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   406f2:	48 8b 05 07 d9 00 00 	mov    0xd907(%rip),%rax        # 4e000 <current>
   406f9:	48 8b 40 38          	mov    0x38(%rax),%rax
   406fd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   40701:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40706:	75 0f                	jne    40717 <exception+0xf9>
		    panic(NULL);
   40708:	bf 00 00 00 00       	mov    $0x0,%edi
   4070d:	b8 00 00 00 00       	mov    $0x0,%eax
   40712:	e8 e0 1a 00 00       	call   421f7 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40717:	48 8b 05 e2 d8 00 00 	mov    0xd8e2(%rip),%rax        # 4e000 <current>
   4071e:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40725:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40729:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4072d:	48 89 ce             	mov    %rcx,%rsi
   40730:	48 89 c7             	mov    %rax,%rdi
   40733:	e8 c0 21 00 00       	call   428f8 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40738:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4073c:	48 89 c1             	mov    %rax,%rcx
   4073f:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40746:	ba a0 00 00 00       	mov    $0xa0,%edx
   4074b:	48 89 ce             	mov    %rcx,%rsi
   4074e:	48 89 c7             	mov    %rax,%rdi
   40751:	e8 d2 25 00 00       	call   42d28 <memcpy>
		panic(msg);
   40756:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4075d:	48 89 c7             	mov    %rax,%rdi
   40760:	b8 00 00 00 00       	mov    $0x0,%eax
   40765:	e8 8d 1a 00 00       	call   421f7 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4076a:	48 8b 05 8f d8 00 00 	mov    0xd88f(%rip),%rax        # 4e000 <current>
   40771:	8b 10                	mov    (%rax),%edx
   40773:	48 8b 05 86 d8 00 00 	mov    0xd886(%rip),%rax        # 4e000 <current>
   4077a:	48 63 d2             	movslq %edx,%rdx
   4077d:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40781:	e9 c7 01 00 00       	jmp    4094d <exception+0x32f>

    case INT_SYS_YIELD:
        schedule();
   40786:	e8 eb 01 00 00       	call   40976 <schedule>
        break;                  /* will not be reached */
   4078b:	e9 bd 01 00 00       	jmp    4094d <exception+0x32f>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   40790:	48 8b 05 69 d8 00 00 	mov    0xd869(%rip),%rax        # 4e000 <current>
   40797:	48 8b 40 38          	mov    0x38(%rax),%rax
   4079b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        int r = assign_physical_page(addr, current->p_pid);
   4079f:	48 8b 05 5a d8 00 00 	mov    0xd85a(%rip),%rax        # 4e000 <current>
   407a6:	8b 00                	mov    (%rax),%eax
   407a8:	0f be d0             	movsbl %al,%edx
   407ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407af:	89 d6                	mov    %edx,%esi
   407b1:	48 89 c7             	mov    %rax,%rdi
   407b4:	e8 bf fc ff ff       	call   40478 <assign_physical_page>
   407b9:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   407bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   407c0:	78 29                	js     407eb <exception+0x1cd>
            virtual_memory_map(current->p_pagetable, addr, addr,
   407c2:	48 8b 05 37 d8 00 00 	mov    0xd837(%rip),%rax        # 4e000 <current>
   407c9:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   407d0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407d4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   407d8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   407de:	b9 00 10 00 00       	mov    $0x1000,%ecx
   407e3:	48 89 c7             	mov    %rax,%rdi
   407e6:	e8 eb 1d 00 00       	call   425d6 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   407eb:	48 8b 05 0e d8 00 00 	mov    0xd80e(%rip),%rax        # 4e000 <current>
   407f2:	8b 55 f4             	mov    -0xc(%rbp),%edx
   407f5:	48 63 d2             	movslq %edx,%rdx
   407f8:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   407fc:	e9 4c 01 00 00       	jmp    4094d <exception+0x32f>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40801:	48 8b 05 f8 d7 00 00 	mov    0xd7f8(%rip),%rax        # 4e000 <current>
   40808:	48 89 c7             	mov    %rax,%rdi
   4080b:	e8 dc fc ff ff       	call   404ec <syscall_mapping>
            break;
   40810:	e9 38 01 00 00       	jmp    4094d <exception+0x32f>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40815:	48 8b 05 e4 d7 00 00 	mov    0xd7e4(%rip),%rax        # 4e000 <current>
   4081c:	48 89 c7             	mov    %rax,%rdi
   4081f:	e8 91 fd ff ff       	call   405b5 <syscall_mem_tog>
	    break;
   40824:	e9 24 01 00 00       	jmp    4094d <exception+0x32f>
	}

    case INT_TIMER:
        ++ticks;
   40829:	8b 05 f1 e5 00 00    	mov    0xe5f1(%rip),%eax        # 4ee20 <ticks>
   4082f:	83 c0 01             	add    $0x1,%eax
   40832:	89 05 e8 e5 00 00    	mov    %eax,0xe5e8(%rip)        # 4ee20 <ticks>
        schedule();
   40838:	e8 39 01 00 00       	call   40976 <schedule>
        break;                  /* will not be reached */
   4083d:	e9 0b 01 00 00       	jmp    4094d <exception+0x32f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40842:	0f 20 d0             	mov    %cr2,%rax
   40845:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   40849:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   4084d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40851:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40858:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4085f:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40862:	48 85 c0             	test   %rax,%rax
   40865:	74 07                	je     4086e <exception+0x250>
   40867:	b8 c9 36 04 00       	mov    $0x436c9,%eax
   4086c:	eb 05                	jmp    40873 <exception+0x255>
   4086e:	b8 cf 36 04 00       	mov    $0x436cf,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40873:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40877:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4087e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40885:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40888:	48 85 c0             	test   %rax,%rax
   4088b:	74 07                	je     40894 <exception+0x276>
   4088d:	b8 d4 36 04 00       	mov    $0x436d4,%eax
   40892:	eb 05                	jmp    40899 <exception+0x27b>
   40894:	b8 e7 36 04 00       	mov    $0x436e7,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40899:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   4089d:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408a4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408ab:	83 e0 04             	and    $0x4,%eax
   408ae:	48 85 c0             	test   %rax,%rax
   408b1:	75 2f                	jne    408e2 <exception+0x2c4>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   408b3:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408ba:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   408c1:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   408c5:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   408c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   408cd:	49 89 f0             	mov    %rsi,%r8
   408d0:	48 89 c6             	mov    %rax,%rsi
   408d3:	bf f8 36 04 00       	mov    $0x436f8,%edi
   408d8:	b8 00 00 00 00       	mov    $0x0,%eax
   408dd:	e8 15 19 00 00       	call   421f7 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   408e2:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408e9:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   408f0:	48 8b 05 09 d7 00 00 	mov    0xd709(%rip),%rax        # 4e000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   408f7:	8b 00                	mov    (%rax),%eax
   408f9:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   408fd:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40901:	52                   	push   %rdx
   40902:	ff 75 d0             	push   -0x30(%rbp)
   40905:	49 89 f1             	mov    %rsi,%r9
   40908:	49 89 c8             	mov    %rcx,%r8
   4090b:	89 c1                	mov    %eax,%ecx
   4090d:	ba 28 37 04 00       	mov    $0x43728,%edx
   40912:	be 00 0c 00 00       	mov    $0xc00,%esi
   40917:	bf 80 07 00 00       	mov    $0x780,%edi
   4091c:	b8 00 00 00 00       	mov    $0x0,%eax
   40921:	e8 a0 2c 00 00       	call   435c6 <console_printf>
   40926:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4092a:	48 8b 05 cf d6 00 00 	mov    0xd6cf(%rip),%rax        # 4e000 <current>
   40931:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40938:	00 00 00 
        break;
   4093b:	eb 10                	jmp    4094d <exception+0x32f>
    }

    default:
        default_exception(current);
   4093d:	48 8b 05 bc d6 00 00 	mov    0xd6bc(%rip),%rax        # 4e000 <current>
   40944:	48 89 c7             	mov    %rax,%rdi
   40947:	e8 bb 19 00 00       	call   42307 <default_exception>
        break;                  /* will not be reached */
   4094c:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4094d:	48 8b 05 ac d6 00 00 	mov    0xd6ac(%rip),%rax        # 4e000 <current>
   40954:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4095a:	83 f8 01             	cmp    $0x1,%eax
   4095d:	75 0f                	jne    4096e <exception+0x350>
        run(current);
   4095f:	48 8b 05 9a d6 00 00 	mov    0xd69a(%rip),%rax        # 4e000 <current>
   40966:	48 89 c7             	mov    %rax,%rdi
   40969:	e8 7a 00 00 00       	call   409e8 <run>
    } else {
        schedule();
   4096e:	e8 03 00 00 00       	call   40976 <schedule>
    }
}
   40973:	90                   	nop
   40974:	c9                   	leave  
   40975:	c3                   	ret    

0000000000040976 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40976:	55                   	push   %rbp
   40977:	48 89 e5             	mov    %rsp,%rbp
   4097a:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4097e:	48 8b 05 7b d6 00 00 	mov    0xd67b(%rip),%rax        # 4e000 <current>
   40985:	8b 00                	mov    (%rax),%eax
   40987:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   4098a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4098d:	83 c0 01             	add    $0x1,%eax
   40990:	99                   	cltd   
   40991:	c1 ea 1c             	shr    $0x1c,%edx
   40994:	01 d0                	add    %edx,%eax
   40996:	83 e0 0f             	and    $0xf,%eax
   40999:	29 d0                	sub    %edx,%eax
   4099b:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4099e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409a1:	48 63 d0             	movslq %eax,%rdx
   409a4:	48 89 d0             	mov    %rdx,%rax
   409a7:	48 c1 e0 03          	shl    $0x3,%rax
   409ab:	48 29 d0             	sub    %rdx,%rax
   409ae:	48 c1 e0 05          	shl    $0x5,%rax
   409b2:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   409b8:	8b 00                	mov    (%rax),%eax
   409ba:	83 f8 01             	cmp    $0x1,%eax
   409bd:	75 22                	jne    409e1 <schedule+0x6b>
            run(&processes[pid]);
   409bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409c2:	48 63 d0             	movslq %eax,%rdx
   409c5:	48 89 d0             	mov    %rdx,%rax
   409c8:	48 c1 e0 03          	shl    $0x3,%rax
   409cc:	48 29 d0             	sub    %rdx,%rax
   409cf:	48 c1 e0 05          	shl    $0x5,%rax
   409d3:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   409d9:	48 89 c7             	mov    %rax,%rdi
   409dc:	e8 07 00 00 00       	call   409e8 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   409e1:	e8 d0 16 00 00       	call   420b6 <check_keyboard>
        pid = (pid + 1) % NPROC;
   409e6:	eb a2                	jmp    4098a <schedule+0x14>

00000000000409e8 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   409e8:	55                   	push   %rbp
   409e9:	48 89 e5             	mov    %rsp,%rbp
   409ec:	48 83 ec 10          	sub    $0x10,%rsp
   409f0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   409f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409f8:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   409fe:	83 f8 01             	cmp    $0x1,%eax
   40a01:	74 14                	je     40a17 <run+0x2f>
   40a03:	ba b0 38 04 00       	mov    $0x438b0,%edx
   40a08:	be 57 01 00 00       	mov    $0x157,%esi
   40a0d:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40a12:	e8 c0 18 00 00       	call   422d7 <assert_fail>
    current = p;
   40a17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a1b:	48 89 05 de d5 00 00 	mov    %rax,0xd5de(%rip)        # 4e000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40a22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a26:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40a2d:	48 89 c7             	mov    %rax,%rdi
   40a30:	e8 70 1a 00 00       	call   424a5 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a39:	48 83 c0 08          	add    $0x8,%rax
   40a3d:	48 89 c7             	mov    %rax,%rdi
   40a40:	e8 7e f6 ff ff       	call   400c3 <exception_return>

0000000000040a45 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40a45:	55                   	push   %rbp
   40a46:	48 89 e5             	mov    %rsp,%rbp
   40a49:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40a4d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40a54:	00 
   40a55:	e9 81 00 00 00       	jmp    40adb <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40a5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a5e:	48 89 c7             	mov    %rax,%rdi
   40a61:	e8 ef 0e 00 00       	call   41955 <physical_memory_isreserved>
   40a66:	85 c0                	test   %eax,%eax
   40a68:	74 09                	je     40a73 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40a6a:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40a71:	eb 2f                	jmp    40aa2 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40a73:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40a7a:	00 
   40a7b:	76 0b                	jbe    40a88 <pageinfo_init+0x43>
   40a7d:	b8 08 70 05 00       	mov    $0x57008,%eax
   40a82:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40a86:	72 0a                	jb     40a92 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40a88:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40a8f:	00 
   40a90:	75 09                	jne    40a9b <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40a92:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40a99:	eb 07                	jmp    40aa2 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40a9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40aa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aa6:	48 c1 e8 0c          	shr    $0xc,%rax
   40aaa:	89 c1                	mov    %eax,%ecx
   40aac:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40aaf:	89 c2                	mov    %eax,%edx
   40ab1:	48 63 c1             	movslq %ecx,%rax
   40ab4:	88 94 00 40 ee 04 00 	mov    %dl,0x4ee40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40abb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40abf:	0f 95 c2             	setne  %dl
   40ac2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ac6:	48 c1 e8 0c          	shr    $0xc,%rax
   40aca:	48 98                	cltq   
   40acc:	88 94 00 41 ee 04 00 	mov    %dl,0x4ee41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40ad3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40ada:	00 
   40adb:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40ae2:	00 
   40ae3:	0f 86 71 ff ff ff    	jbe    40a5a <pageinfo_init+0x15>
    }
}
   40ae9:	90                   	nop
   40aea:	90                   	nop
   40aeb:	c9                   	leave  
   40aec:	c3                   	ret    

0000000000040aed <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40aed:	55                   	push   %rbp
   40aee:	48 89 e5             	mov    %rsp,%rbp
   40af1:	48 83 ec 50          	sub    $0x50,%rsp
   40af5:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40af9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40afd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b03:	48 89 c2             	mov    %rax,%rdx
   40b06:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b0a:	48 39 c2             	cmp    %rax,%rdx
   40b0d:	74 14                	je     40b23 <check_page_table_mappings+0x36>
   40b0f:	ba d0 38 04 00       	mov    $0x438d0,%edx
   40b14:	be 81 01 00 00       	mov    $0x181,%esi
   40b19:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40b1e:	e8 b4 17 00 00       	call   422d7 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40b23:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40b2a:	00 
   40b2b:	e9 9a 00 00 00       	jmp    40bca <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40b30:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40b34:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b38:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b3c:	48 89 ce             	mov    %rcx,%rsi
   40b3f:	48 89 c7             	mov    %rax,%rdi
   40b42:	e8 b1 1d 00 00       	call   428f8 <virtual_memory_lookup>
        if (vam.pa != va) {
   40b47:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b4b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b4f:	74 27                	je     40b78 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40b51:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b59:	49 89 d0             	mov    %rdx,%r8
   40b5c:	48 89 c1             	mov    %rax,%rcx
   40b5f:	ba ef 38 04 00       	mov    $0x438ef,%edx
   40b64:	be 00 c0 00 00       	mov    $0xc000,%esi
   40b69:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40b6e:	b8 00 00 00 00       	mov    $0x0,%eax
   40b73:	e8 4e 2a 00 00       	call   435c6 <console_printf>
        }
        assert(vam.pa == va);
   40b78:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b7c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b80:	74 14                	je     40b96 <check_page_table_mappings+0xa9>
   40b82:	ba f9 38 04 00       	mov    $0x438f9,%edx
   40b87:	be 8a 01 00 00       	mov    $0x18a,%esi
   40b8c:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40b91:	e8 41 17 00 00       	call   422d7 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40b96:	b8 00 50 04 00       	mov    $0x45000,%eax
   40b9b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b9f:	72 21                	jb     40bc2 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40ba1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40ba4:	48 98                	cltq   
   40ba6:	83 e0 02             	and    $0x2,%eax
   40ba9:	48 85 c0             	test   %rax,%rax
   40bac:	75 14                	jne    40bc2 <check_page_table_mappings+0xd5>
   40bae:	ba 06 39 04 00       	mov    $0x43906,%edx
   40bb3:	be 8c 01 00 00       	mov    $0x18c,%esi
   40bb8:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40bbd:	e8 15 17 00 00       	call   422d7 <assert_fail>
         va += PAGESIZE) {
   40bc2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40bc9:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40bca:	b8 08 70 05 00       	mov    $0x57008,%eax
   40bcf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bd3:	0f 82 57 ff ff ff    	jb     40b30 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40bd9:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40be0:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40be1:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40be5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40be9:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40bed:	48 89 ce             	mov    %rcx,%rsi
   40bf0:	48 89 c7             	mov    %rax,%rdi
   40bf3:	e8 00 1d 00 00       	call   428f8 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40bf8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40bfc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40c00:	74 14                	je     40c16 <check_page_table_mappings+0x129>
   40c02:	ba 17 39 04 00       	mov    $0x43917,%edx
   40c07:	be 93 01 00 00       	mov    $0x193,%esi
   40c0c:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40c11:	e8 c1 16 00 00       	call   422d7 <assert_fail>
    assert(vam.perm & PTE_W);
   40c16:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40c19:	48 98                	cltq   
   40c1b:	83 e0 02             	and    $0x2,%eax
   40c1e:	48 85 c0             	test   %rax,%rax
   40c21:	75 14                	jne    40c37 <check_page_table_mappings+0x14a>
   40c23:	ba 06 39 04 00       	mov    $0x43906,%edx
   40c28:	be 94 01 00 00       	mov    $0x194,%esi
   40c2d:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40c32:	e8 a0 16 00 00       	call   422d7 <assert_fail>
}
   40c37:	90                   	nop
   40c38:	c9                   	leave  
   40c39:	c3                   	ret    

0000000000040c3a <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40c3a:	55                   	push   %rbp
   40c3b:	48 89 e5             	mov    %rsp,%rbp
   40c3e:	48 83 ec 20          	sub    $0x20,%rsp
   40c42:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40c46:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40c49:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40c4c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40c4f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40c56:	48 8b 05 a3 03 01 00 	mov    0x103a3(%rip),%rax        # 51000 <kernel_pagetable>
   40c5d:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40c61:	75 67                	jne    40cca <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40c63:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40c6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40c71:	eb 51                	jmp    40cc4 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40c73:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c76:	48 63 d0             	movslq %eax,%rdx
   40c79:	48 89 d0             	mov    %rdx,%rax
   40c7c:	48 c1 e0 03          	shl    $0x3,%rax
   40c80:	48 29 d0             	sub    %rdx,%rax
   40c83:	48 c1 e0 05          	shl    $0x5,%rax
   40c87:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   40c8d:	8b 00                	mov    (%rax),%eax
   40c8f:	85 c0                	test   %eax,%eax
   40c91:	74 2d                	je     40cc0 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40c93:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c96:	48 63 d0             	movslq %eax,%rdx
   40c99:	48 89 d0             	mov    %rdx,%rax
   40c9c:	48 c1 e0 03          	shl    $0x3,%rax
   40ca0:	48 29 d0             	sub    %rdx,%rax
   40ca3:	48 c1 e0 05          	shl    $0x5,%rax
   40ca7:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40cad:	48 8b 10             	mov    (%rax),%rdx
   40cb0:	48 8b 05 49 03 01 00 	mov    0x10349(%rip),%rax        # 51000 <kernel_pagetable>
   40cb7:	48 39 c2             	cmp    %rax,%rdx
   40cba:	75 04                	jne    40cc0 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40cbc:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40cc0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40cc4:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40cc8:	7e a9                	jle    40c73 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40cca:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40ccd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cd4:	be 00 00 00 00       	mov    $0x0,%esi
   40cd9:	48 89 c7             	mov    %rax,%rdi
   40cdc:	e8 03 00 00 00       	call   40ce4 <check_page_table_ownership_level>
}
   40ce1:	90                   	nop
   40ce2:	c9                   	leave  
   40ce3:	c3                   	ret    

0000000000040ce4 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40ce4:	55                   	push   %rbp
   40ce5:	48 89 e5             	mov    %rsp,%rbp
   40ce8:	48 83 ec 30          	sub    $0x30,%rsp
   40cec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40cf0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40cf3:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40cf6:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40cf9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cfd:	48 c1 e8 0c          	shr    $0xc,%rax
   40d01:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40d06:	7e 14                	jle    40d1c <check_page_table_ownership_level+0x38>
   40d08:	ba 28 39 04 00       	mov    $0x43928,%edx
   40d0d:	be b1 01 00 00       	mov    $0x1b1,%esi
   40d12:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40d17:	e8 bb 15 00 00       	call   422d7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40d1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d20:	48 c1 e8 0c          	shr    $0xc,%rax
   40d24:	48 98                	cltq   
   40d26:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40d2d:	00 
   40d2e:	0f be c0             	movsbl %al,%eax
   40d31:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40d34:	74 14                	je     40d4a <check_page_table_ownership_level+0x66>
   40d36:	ba 40 39 04 00       	mov    $0x43940,%edx
   40d3b:	be b2 01 00 00       	mov    $0x1b2,%esi
   40d40:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40d45:	e8 8d 15 00 00       	call   422d7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40d4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d4e:	48 c1 e8 0c          	shr    $0xc,%rax
   40d52:	48 98                	cltq   
   40d54:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40d5b:	00 
   40d5c:	0f be c0             	movsbl %al,%eax
   40d5f:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40d62:	74 14                	je     40d78 <check_page_table_ownership_level+0x94>
   40d64:	ba 68 39 04 00       	mov    $0x43968,%edx
   40d69:	be b3 01 00 00       	mov    $0x1b3,%esi
   40d6e:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40d73:	e8 5f 15 00 00       	call   422d7 <assert_fail>
    if (level < 3) {
   40d78:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40d7c:	7f 5b                	jg     40dd9 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40d7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40d85:	eb 49                	jmp    40dd0 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40d87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d8b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d8e:	48 63 d2             	movslq %edx,%rdx
   40d91:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40d95:	48 85 c0             	test   %rax,%rax
   40d98:	74 32                	je     40dcc <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40d9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d9e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40da1:	48 63 d2             	movslq %edx,%rdx
   40da4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40da8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40dae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40db2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40db5:	8d 70 01             	lea    0x1(%rax),%esi
   40db8:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40dbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40dbf:	b9 01 00 00 00       	mov    $0x1,%ecx
   40dc4:	48 89 c7             	mov    %rax,%rdi
   40dc7:	e8 18 ff ff ff       	call   40ce4 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40dcc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40dd0:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40dd7:	7e ae                	jle    40d87 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40dd9:	90                   	nop
   40dda:	c9                   	leave  
   40ddb:	c3                   	ret    

0000000000040ddc <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40ddc:	55                   	push   %rbp
   40ddd:	48 89 e5             	mov    %rsp,%rbp
   40de0:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40de4:	8b 05 fe d2 00 00    	mov    0xd2fe(%rip),%eax        # 4e0e8 <processes+0xc8>
   40dea:	85 c0                	test   %eax,%eax
   40dec:	74 14                	je     40e02 <check_virtual_memory+0x26>
   40dee:	ba 98 39 04 00       	mov    $0x43998,%edx
   40df3:	be c6 01 00 00       	mov    $0x1c6,%esi
   40df8:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40dfd:	e8 d5 14 00 00       	call   422d7 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40e02:	48 8b 05 f7 01 01 00 	mov    0x101f7(%rip),%rax        # 51000 <kernel_pagetable>
   40e09:	48 89 c7             	mov    %rax,%rdi
   40e0c:	e8 dc fc ff ff       	call   40aed <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40e11:	48 8b 05 e8 01 01 00 	mov    0x101e8(%rip),%rax        # 51000 <kernel_pagetable>
   40e18:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40e1d:	48 89 c7             	mov    %rax,%rdi
   40e20:	e8 15 fe ff ff       	call   40c3a <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40e25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40e2c:	e9 9c 00 00 00       	jmp    40ecd <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40e31:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e34:	48 63 d0             	movslq %eax,%rdx
   40e37:	48 89 d0             	mov    %rdx,%rax
   40e3a:	48 c1 e0 03          	shl    $0x3,%rax
   40e3e:	48 29 d0             	sub    %rdx,%rax
   40e41:	48 c1 e0 05          	shl    $0x5,%rax
   40e45:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   40e4b:	8b 00                	mov    (%rax),%eax
   40e4d:	85 c0                	test   %eax,%eax
   40e4f:	74 78                	je     40ec9 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40e51:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e54:	48 63 d0             	movslq %eax,%rdx
   40e57:	48 89 d0             	mov    %rdx,%rax
   40e5a:	48 c1 e0 03          	shl    $0x3,%rax
   40e5e:	48 29 d0             	sub    %rdx,%rax
   40e61:	48 c1 e0 05          	shl    $0x5,%rax
   40e65:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40e6b:	48 8b 10             	mov    (%rax),%rdx
   40e6e:	48 8b 05 8b 01 01 00 	mov    0x1018b(%rip),%rax        # 51000 <kernel_pagetable>
   40e75:	48 39 c2             	cmp    %rax,%rdx
   40e78:	74 4f                	je     40ec9 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   40e7a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e7d:	48 63 d0             	movslq %eax,%rdx
   40e80:	48 89 d0             	mov    %rdx,%rax
   40e83:	48 c1 e0 03          	shl    $0x3,%rax
   40e87:	48 29 d0             	sub    %rdx,%rax
   40e8a:	48 c1 e0 05          	shl    $0x5,%rax
   40e8e:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40e94:	48 8b 00             	mov    (%rax),%rax
   40e97:	48 89 c7             	mov    %rax,%rdi
   40e9a:	e8 4e fc ff ff       	call   40aed <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40e9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ea2:	48 63 d0             	movslq %eax,%rdx
   40ea5:	48 89 d0             	mov    %rdx,%rax
   40ea8:	48 c1 e0 03          	shl    $0x3,%rax
   40eac:	48 29 d0             	sub    %rdx,%rax
   40eaf:	48 c1 e0 05          	shl    $0x5,%rax
   40eb3:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40eb9:	48 8b 00             	mov    (%rax),%rax
   40ebc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ebf:	89 d6                	mov    %edx,%esi
   40ec1:	48 89 c7             	mov    %rax,%rdi
   40ec4:	e8 71 fd ff ff       	call   40c3a <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40ec9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40ecd:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40ed1:	0f 8e 5a ff ff ff    	jle    40e31 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40ed7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40ede:	eb 67                	jmp    40f47 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40ee0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ee3:	48 98                	cltq   
   40ee5:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40eec:	00 
   40eed:	84 c0                	test   %al,%al
   40eef:	7e 52                	jle    40f43 <check_virtual_memory+0x167>
   40ef1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ef4:	48 98                	cltq   
   40ef6:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40efd:	00 
   40efe:	84 c0                	test   %al,%al
   40f00:	78 41                	js     40f43 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40f02:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f05:	48 98                	cltq   
   40f07:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40f0e:	00 
   40f0f:	0f be c0             	movsbl %al,%eax
   40f12:	48 63 d0             	movslq %eax,%rdx
   40f15:	48 89 d0             	mov    %rdx,%rax
   40f18:	48 c1 e0 03          	shl    $0x3,%rax
   40f1c:	48 29 d0             	sub    %rdx,%rax
   40f1f:	48 c1 e0 05          	shl    $0x5,%rax
   40f23:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   40f29:	8b 00                	mov    (%rax),%eax
   40f2b:	85 c0                	test   %eax,%eax
   40f2d:	75 14                	jne    40f43 <check_virtual_memory+0x167>
   40f2f:	ba b8 39 04 00       	mov    $0x439b8,%edx
   40f34:	be dd 01 00 00       	mov    $0x1dd,%esi
   40f39:	bf c0 36 04 00       	mov    $0x436c0,%edi
   40f3e:	e8 94 13 00 00       	call   422d7 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f43:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40f47:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40f4e:	7e 90                	jle    40ee0 <check_virtual_memory+0x104>
        }
    }
}
   40f50:	90                   	nop
   40f51:	90                   	nop
   40f52:	c9                   	leave  
   40f53:	c3                   	ret    

0000000000040f54 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   40f54:	55                   	push   %rbp
   40f55:	48 89 e5             	mov    %rsp,%rbp
   40f58:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40f5c:	ba 26 3a 04 00       	mov    $0x43a26,%edx
   40f61:	be 00 0f 00 00       	mov    $0xf00,%esi
   40f66:	bf 20 00 00 00       	mov    $0x20,%edi
   40f6b:	b8 00 00 00 00       	mov    $0x0,%eax
   40f70:	e8 51 26 00 00       	call   435c6 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f7c:	e9 f4 00 00 00       	jmp    41075 <memshow_physical+0x121>
        if (pn % 64 == 0) {
   40f81:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f84:	83 e0 3f             	and    $0x3f,%eax
   40f87:	85 c0                	test   %eax,%eax
   40f89:	75 3e                	jne    40fc9 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40f8b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f8e:	c1 e0 0c             	shl    $0xc,%eax
   40f91:	89 c2                	mov    %eax,%edx
   40f93:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f96:	8d 48 3f             	lea    0x3f(%rax),%ecx
   40f99:	85 c0                	test   %eax,%eax
   40f9b:	0f 48 c1             	cmovs  %ecx,%eax
   40f9e:	c1 f8 06             	sar    $0x6,%eax
   40fa1:	8d 48 01             	lea    0x1(%rax),%ecx
   40fa4:	89 c8                	mov    %ecx,%eax
   40fa6:	c1 e0 02             	shl    $0x2,%eax
   40fa9:	01 c8                	add    %ecx,%eax
   40fab:	c1 e0 04             	shl    $0x4,%eax
   40fae:	83 c0 03             	add    $0x3,%eax
   40fb1:	89 d1                	mov    %edx,%ecx
   40fb3:	ba 36 3a 04 00       	mov    $0x43a36,%edx
   40fb8:	be 00 0f 00 00       	mov    $0xf00,%esi
   40fbd:	89 c7                	mov    %eax,%edi
   40fbf:	b8 00 00 00 00       	mov    $0x0,%eax
   40fc4:	e8 fd 25 00 00       	call   435c6 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   40fc9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fcc:	48 98                	cltq   
   40fce:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40fd5:	00 
   40fd6:	0f be c0             	movsbl %al,%eax
   40fd9:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   40fdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fdf:	48 98                	cltq   
   40fe1:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40fe8:	00 
   40fe9:	84 c0                	test   %al,%al
   40feb:	75 07                	jne    40ff4 <memshow_physical+0xa0>
            owner = PO_FREE;
   40fed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   40ff4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ff7:	83 c0 02             	add    $0x2,%eax
   40ffa:	48 98                	cltq   
   40ffc:	0f b7 84 00 00 3a 04 	movzwl 0x43a00(%rax,%rax,1),%eax
   41003:	00 
   41004:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41008:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4100b:	48 98                	cltq   
   4100d:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41014:	00 
   41015:	3c 01                	cmp    $0x1,%al
   41017:	7e 1a                	jle    41033 <memshow_physical+0xdf>
   41019:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4101e:	48 c1 e8 0c          	shr    $0xc,%rax
   41022:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41025:	74 0c                	je     41033 <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41027:	b8 53 00 00 00       	mov    $0x53,%eax
   4102c:	80 cc 0f             	or     $0xf,%ah
   4102f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41033:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41036:	8d 50 3f             	lea    0x3f(%rax),%edx
   41039:	85 c0                	test   %eax,%eax
   4103b:	0f 48 c2             	cmovs  %edx,%eax
   4103e:	c1 f8 06             	sar    $0x6,%eax
   41041:	8d 50 01             	lea    0x1(%rax),%edx
   41044:	89 d0                	mov    %edx,%eax
   41046:	c1 e0 02             	shl    $0x2,%eax
   41049:	01 d0                	add    %edx,%eax
   4104b:	c1 e0 04             	shl    $0x4,%eax
   4104e:	89 c1                	mov    %eax,%ecx
   41050:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41053:	99                   	cltd   
   41054:	c1 ea 1a             	shr    $0x1a,%edx
   41057:	01 d0                	add    %edx,%eax
   41059:	83 e0 3f             	and    $0x3f,%eax
   4105c:	29 d0                	sub    %edx,%eax
   4105e:	83 c0 0c             	add    $0xc,%eax
   41061:	01 c8                	add    %ecx,%eax
   41063:	48 98                	cltq   
   41065:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41069:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41070:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41071:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41075:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4107c:	0f 8e ff fe ff ff    	jle    40f81 <memshow_physical+0x2d>
    }
}
   41082:	90                   	nop
   41083:	90                   	nop
   41084:	c9                   	leave  
   41085:	c3                   	ret    

0000000000041086 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41086:	55                   	push   %rbp
   41087:	48 89 e5             	mov    %rsp,%rbp
   4108a:	48 83 ec 40          	sub    $0x40,%rsp
   4108e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41092:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41096:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4109a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   410a0:	48 89 c2             	mov    %rax,%rdx
   410a3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410a7:	48 39 c2             	cmp    %rax,%rdx
   410aa:	74 14                	je     410c0 <memshow_virtual+0x3a>
   410ac:	ba 40 3a 04 00       	mov    $0x43a40,%edx
   410b1:	be 0e 02 00 00       	mov    $0x20e,%esi
   410b6:	bf c0 36 04 00       	mov    $0x436c0,%edi
   410bb:	e8 17 12 00 00       	call   422d7 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   410c0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   410c4:	48 89 c1             	mov    %rax,%rcx
   410c7:	ba 6d 3a 04 00       	mov    $0x43a6d,%edx
   410cc:	be 00 0f 00 00       	mov    $0xf00,%esi
   410d1:	bf 3a 03 00 00       	mov    $0x33a,%edi
   410d6:	b8 00 00 00 00       	mov    $0x0,%eax
   410db:	e8 e6 24 00 00       	call   435c6 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   410e0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   410e7:	00 
   410e8:	e9 80 01 00 00       	jmp    4126d <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   410ed:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   410f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   410f5:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   410f9:	48 89 ce             	mov    %rcx,%rsi
   410fc:	48 89 c7             	mov    %rax,%rdi
   410ff:	e8 f4 17 00 00       	call   428f8 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41104:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41107:	85 c0                	test   %eax,%eax
   41109:	79 0b                	jns    41116 <memshow_virtual+0x90>
            color = ' ';
   4110b:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41111:	e9 d7 00 00 00       	jmp    411ed <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41116:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4111a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41120:	76 14                	jbe    41136 <memshow_virtual+0xb0>
   41122:	ba 8a 3a 04 00       	mov    $0x43a8a,%edx
   41127:	be 17 02 00 00       	mov    $0x217,%esi
   4112c:	bf c0 36 04 00       	mov    $0x436c0,%edi
   41131:	e8 a1 11 00 00       	call   422d7 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41136:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41139:	48 98                	cltq   
   4113b:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   41142:	00 
   41143:	0f be c0             	movsbl %al,%eax
   41146:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41149:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4114c:	48 98                	cltq   
   4114e:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41155:	00 
   41156:	84 c0                	test   %al,%al
   41158:	75 07                	jne    41161 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4115a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41161:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41164:	83 c0 02             	add    $0x2,%eax
   41167:	48 98                	cltq   
   41169:	0f b7 84 00 00 3a 04 	movzwl 0x43a00(%rax,%rax,1),%eax
   41170:	00 
   41171:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41175:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41178:	48 98                	cltq   
   4117a:	83 e0 04             	and    $0x4,%eax
   4117d:	48 85 c0             	test   %rax,%rax
   41180:	74 27                	je     411a9 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41182:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41186:	c1 e0 04             	shl    $0x4,%eax
   41189:	66 25 00 f0          	and    $0xf000,%ax
   4118d:	89 c2                	mov    %eax,%edx
   4118f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41193:	c1 f8 04             	sar    $0x4,%eax
   41196:	66 25 00 0f          	and    $0xf00,%ax
   4119a:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4119c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411a0:	0f b6 c0             	movzbl %al,%eax
   411a3:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411a5:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   411a9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   411ac:	48 98                	cltq   
   411ae:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   411b5:	00 
   411b6:	3c 01                	cmp    $0x1,%al
   411b8:	7e 33                	jle    411ed <memshow_virtual+0x167>
   411ba:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411bf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   411c3:	74 28                	je     411ed <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   411c5:	b8 53 00 00 00       	mov    $0x53,%eax
   411ca:	89 c2                	mov    %eax,%edx
   411cc:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411d0:	66 25 00 f0          	and    $0xf000,%ax
   411d4:	09 d0                	or     %edx,%eax
   411d6:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   411da:	8b 45 e0             	mov    -0x20(%rbp),%eax
   411dd:	48 98                	cltq   
   411df:	83 e0 04             	and    $0x4,%eax
   411e2:	48 85 c0             	test   %rax,%rax
   411e5:	75 06                	jne    411ed <memshow_virtual+0x167>
                    color = color | 0x0F00;
   411e7:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   411ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411f1:	48 c1 e8 0c          	shr    $0xc,%rax
   411f5:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   411f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   411fb:	83 e0 3f             	and    $0x3f,%eax
   411fe:	85 c0                	test   %eax,%eax
   41200:	75 34                	jne    41236 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41202:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41205:	c1 e8 06             	shr    $0x6,%eax
   41208:	89 c2                	mov    %eax,%edx
   4120a:	89 d0                	mov    %edx,%eax
   4120c:	c1 e0 02             	shl    $0x2,%eax
   4120f:	01 d0                	add    %edx,%eax
   41211:	c1 e0 04             	shl    $0x4,%eax
   41214:	05 73 03 00 00       	add    $0x373,%eax
   41219:	89 c7                	mov    %eax,%edi
   4121b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4121f:	48 89 c1             	mov    %rax,%rcx
   41222:	ba 36 3a 04 00       	mov    $0x43a36,%edx
   41227:	be 00 0f 00 00       	mov    $0xf00,%esi
   4122c:	b8 00 00 00 00       	mov    $0x0,%eax
   41231:	e8 90 23 00 00       	call   435c6 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41236:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41239:	c1 e8 06             	shr    $0x6,%eax
   4123c:	89 c2                	mov    %eax,%edx
   4123e:	89 d0                	mov    %edx,%eax
   41240:	c1 e0 02             	shl    $0x2,%eax
   41243:	01 d0                	add    %edx,%eax
   41245:	c1 e0 04             	shl    $0x4,%eax
   41248:	89 c2                	mov    %eax,%edx
   4124a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4124d:	83 e0 3f             	and    $0x3f,%eax
   41250:	01 d0                	add    %edx,%eax
   41252:	05 7c 03 00 00       	add    $0x37c,%eax
   41257:	89 c2                	mov    %eax,%edx
   41259:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4125d:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41264:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41265:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4126c:	00 
   4126d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41274:	00 
   41275:	0f 86 72 fe ff ff    	jbe    410ed <memshow_virtual+0x67>
    }
}
   4127b:	90                   	nop
   4127c:	90                   	nop
   4127d:	c9                   	leave  
   4127e:	c3                   	ret    

000000000004127f <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4127f:	55                   	push   %rbp
   41280:	48 89 e5             	mov    %rsp,%rbp
   41283:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41287:	8b 05 b3 df 00 00    	mov    0xdfb3(%rip),%eax        # 4f240 <last_ticks.1>
   4128d:	85 c0                	test   %eax,%eax
   4128f:	74 13                	je     412a4 <memshow_virtual_animate+0x25>
   41291:	8b 05 89 db 00 00    	mov    0xdb89(%rip),%eax        # 4ee20 <ticks>
   41297:	8b 15 a3 df 00 00    	mov    0xdfa3(%rip),%edx        # 4f240 <last_ticks.1>
   4129d:	29 d0                	sub    %edx,%eax
   4129f:	83 f8 31             	cmp    $0x31,%eax
   412a2:	76 2c                	jbe    412d0 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   412a4:	8b 05 76 db 00 00    	mov    0xdb76(%rip),%eax        # 4ee20 <ticks>
   412aa:	89 05 90 df 00 00    	mov    %eax,0xdf90(%rip)        # 4f240 <last_ticks.1>
        ++showing;
   412b0:	8b 05 4e 3d 00 00    	mov    0x3d4e(%rip),%eax        # 45004 <showing.0>
   412b6:	83 c0 01             	add    $0x1,%eax
   412b9:	89 05 45 3d 00 00    	mov    %eax,0x3d45(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   412bf:	eb 0f                	jmp    412d0 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   412c1:	8b 05 3d 3d 00 00    	mov    0x3d3d(%rip),%eax        # 45004 <showing.0>
   412c7:	83 c0 01             	add    $0x1,%eax
   412ca:	89 05 34 3d 00 00    	mov    %eax,0x3d34(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   412d0:	8b 05 2e 3d 00 00    	mov    0x3d2e(%rip),%eax        # 45004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   412d6:	83 f8 20             	cmp    $0x20,%eax
   412d9:	7f 2e                	jg     41309 <memshow_virtual_animate+0x8a>
   412db:	8b 05 23 3d 00 00    	mov    0x3d23(%rip),%eax        # 45004 <showing.0>
   412e1:	99                   	cltd   
   412e2:	c1 ea 1c             	shr    $0x1c,%edx
   412e5:	01 d0                	add    %edx,%eax
   412e7:	83 e0 0f             	and    $0xf,%eax
   412ea:	29 d0                	sub    %edx,%eax
   412ec:	48 63 d0             	movslq %eax,%rdx
   412ef:	48 89 d0             	mov    %rdx,%rax
   412f2:	48 c1 e0 03          	shl    $0x3,%rax
   412f6:	48 29 d0             	sub    %rdx,%rax
   412f9:	48 c1 e0 05          	shl    $0x5,%rax
   412fd:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41303:	8b 00                	mov    (%rax),%eax
   41305:	85 c0                	test   %eax,%eax
   41307:	74 b8                	je     412c1 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41309:	8b 05 f5 3c 00 00    	mov    0x3cf5(%rip),%eax        # 45004 <showing.0>
   4130f:	99                   	cltd   
   41310:	c1 ea 1c             	shr    $0x1c,%edx
   41313:	01 d0                	add    %edx,%eax
   41315:	83 e0 0f             	and    $0xf,%eax
   41318:	29 d0                	sub    %edx,%eax
   4131a:	89 05 e4 3c 00 00    	mov    %eax,0x3ce4(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41320:	8b 05 de 3c 00 00    	mov    0x3cde(%rip),%eax        # 45004 <showing.0>
   41326:	48 63 d0             	movslq %eax,%rdx
   41329:	48 89 d0             	mov    %rdx,%rax
   4132c:	48 c1 e0 03          	shl    $0x3,%rax
   41330:	48 29 d0             	sub    %rdx,%rax
   41333:	48 c1 e0 05          	shl    $0x5,%rax
   41337:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4133d:	8b 00                	mov    (%rax),%eax
   4133f:	85 c0                	test   %eax,%eax
   41341:	74 52                	je     41395 <memshow_virtual_animate+0x116>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41343:	8b 15 bb 3c 00 00    	mov    0x3cbb(%rip),%edx        # 45004 <showing.0>
   41349:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4134d:	89 d1                	mov    %edx,%ecx
   4134f:	ba a4 3a 04 00       	mov    $0x43aa4,%edx
   41354:	be 04 00 00 00       	mov    $0x4,%esi
   41359:	48 89 c7             	mov    %rax,%rdi
   4135c:	b8 00 00 00 00       	mov    $0x0,%eax
   41361:	e8 de 22 00 00       	call   43644 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41366:	8b 05 98 3c 00 00    	mov    0x3c98(%rip),%eax        # 45004 <showing.0>
   4136c:	48 63 d0             	movslq %eax,%rdx
   4136f:	48 89 d0             	mov    %rdx,%rax
   41372:	48 c1 e0 03          	shl    $0x3,%rax
   41376:	48 29 d0             	sub    %rdx,%rax
   41379:	48 c1 e0 05          	shl    $0x5,%rax
   4137d:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41383:	48 8b 00             	mov    (%rax),%rax
   41386:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4138a:	48 89 d6             	mov    %rdx,%rsi
   4138d:	48 89 c7             	mov    %rax,%rdi
   41390:	e8 f1 fc ff ff       	call   41086 <memshow_virtual>
    }
}
   41395:	90                   	nop
   41396:	c9                   	leave  
   41397:	c3                   	ret    

0000000000041398 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41398:	55                   	push   %rbp
   41399:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4139c:	e8 53 01 00 00       	call   414f4 <segments_init>
    interrupt_init();
   413a1:	e8 d4 03 00 00       	call   4177a <interrupt_init>
    virtual_memory_init();
   413a6:	e8 e7 0f 00 00       	call   42392 <virtual_memory_init>
}
   413ab:	90                   	nop
   413ac:	5d                   	pop    %rbp
   413ad:	c3                   	ret    

00000000000413ae <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   413ae:	55                   	push   %rbp
   413af:	48 89 e5             	mov    %rsp,%rbp
   413b2:	48 83 ec 18          	sub    $0x18,%rsp
   413b6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   413ba:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   413be:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   413c1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413c4:	48 98                	cltq   
   413c6:	48 c1 e0 2d          	shl    $0x2d,%rax
   413ca:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   413ce:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   413d5:	90 00 00 
   413d8:	48 09 c2             	or     %rax,%rdx
    *segment = type
   413db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413df:	48 89 10             	mov    %rdx,(%rax)
}
   413e2:	90                   	nop
   413e3:	c9                   	leave  
   413e4:	c3                   	ret    

00000000000413e5 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   413e5:	55                   	push   %rbp
   413e6:	48 89 e5             	mov    %rsp,%rbp
   413e9:	48 83 ec 28          	sub    $0x28,%rsp
   413ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   413f1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   413f5:	89 55 ec             	mov    %edx,-0x14(%rbp)
   413f8:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   413fc:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41400:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41404:	48 c1 e0 10          	shl    $0x10,%rax
   41408:	48 89 c2             	mov    %rax,%rdx
   4140b:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41412:	00 00 00 
   41415:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41418:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4141c:	48 c1 e0 20          	shl    $0x20,%rax
   41420:	48 89 c1             	mov    %rax,%rcx
   41423:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4142a:	00 00 ff 
   4142d:	48 21 c8             	and    %rcx,%rax
   41430:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41433:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41437:	48 83 e8 01          	sub    $0x1,%rax
   4143b:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4143e:	48 09 d0             	or     %rdx,%rax
        | type
   41441:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41445:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41448:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4144b:	48 98                	cltq   
   4144d:	48 c1 e0 2d          	shl    $0x2d,%rax
   41451:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41454:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4145b:	80 00 00 
   4145e:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41461:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41465:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41468:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4146c:	48 83 c0 08          	add    $0x8,%rax
   41470:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41474:	48 c1 ea 20          	shr    $0x20,%rdx
   41478:	48 89 10             	mov    %rdx,(%rax)
}
   4147b:	90                   	nop
   4147c:	c9                   	leave  
   4147d:	c3                   	ret    

000000000004147e <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4147e:	55                   	push   %rbp
   4147f:	48 89 e5             	mov    %rsp,%rbp
   41482:	48 83 ec 20          	sub    $0x20,%rsp
   41486:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4148a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4148e:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41491:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41495:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41499:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4149c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   414a0:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   414a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414a6:	48 98                	cltq   
   414a8:	48 c1 e0 2d          	shl    $0x2d,%rax
   414ac:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   414af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414b3:	48 c1 e0 20          	shl    $0x20,%rax
   414b7:	48 89 c1             	mov    %rax,%rcx
   414ba:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   414c1:	00 ff ff 
   414c4:	48 21 c8             	and    %rcx,%rax
   414c7:	48 09 c2             	or     %rax,%rdx
   414ca:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   414d1:	80 00 00 
   414d4:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   414d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414db:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   414de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414e2:	48 c1 e8 20          	shr    $0x20,%rax
   414e6:	48 89 c2             	mov    %rax,%rdx
   414e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414ed:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   414f1:	90                   	nop
   414f2:	c9                   	leave  
   414f3:	c3                   	ret    

00000000000414f4 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   414f4:	55                   	push   %rbp
   414f5:	48 89 e5             	mov    %rsp,%rbp
   414f8:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   414fc:	48 c7 05 59 dd 00 00 	movq   $0x0,0xdd59(%rip)        # 4f260 <segments>
   41503:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41507:	ba 00 00 00 00       	mov    $0x0,%edx
   4150c:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41513:	08 20 00 
   41516:	48 89 c6             	mov    %rax,%rsi
   41519:	bf 68 f2 04 00       	mov    $0x4f268,%edi
   4151e:	e8 8b fe ff ff       	call   413ae <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41523:	ba 03 00 00 00       	mov    $0x3,%edx
   41528:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4152f:	08 20 00 
   41532:	48 89 c6             	mov    %rax,%rsi
   41535:	bf 70 f2 04 00       	mov    $0x4f270,%edi
   4153a:	e8 6f fe ff ff       	call   413ae <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4153f:	ba 00 00 00 00       	mov    $0x0,%edx
   41544:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4154b:	02 00 00 
   4154e:	48 89 c6             	mov    %rax,%rsi
   41551:	bf 78 f2 04 00       	mov    $0x4f278,%edi
   41556:	e8 53 fe ff ff       	call   413ae <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4155b:	ba 03 00 00 00       	mov    $0x3,%edx
   41560:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41567:	02 00 00 
   4156a:	48 89 c6             	mov    %rax,%rsi
   4156d:	bf 80 f2 04 00       	mov    $0x4f280,%edi
   41572:	e8 37 fe ff ff       	call   413ae <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41577:	b8 a0 02 05 00       	mov    $0x502a0,%eax
   4157c:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41582:	48 89 c1             	mov    %rax,%rcx
   41585:	ba 00 00 00 00       	mov    $0x0,%edx
   4158a:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41591:	09 00 00 
   41594:	48 89 c6             	mov    %rax,%rsi
   41597:	bf 88 f2 04 00       	mov    $0x4f288,%edi
   4159c:	e8 44 fe ff ff       	call   413e5 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   415a1:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   415a7:	b8 60 f2 04 00       	mov    $0x4f260,%eax
   415ac:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   415b0:	ba 60 00 00 00       	mov    $0x60,%edx
   415b5:	be 00 00 00 00       	mov    $0x0,%esi
   415ba:	bf a0 02 05 00       	mov    $0x502a0,%edi
   415bf:	e8 cd 17 00 00       	call   42d91 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   415c4:	48 c7 05 d5 ec 00 00 	movq   $0x80000,0xecd5(%rip)        # 502a4 <kernel_task_descriptor+0x4>
   415cb:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   415cf:	ba 00 10 00 00       	mov    $0x1000,%edx
   415d4:	be 00 00 00 00       	mov    $0x0,%esi
   415d9:	bf a0 f2 04 00       	mov    $0x4f2a0,%edi
   415de:	e8 ae 17 00 00       	call   42d91 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   415e3:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   415ea:	eb 30                	jmp    4161c <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   415ec:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   415f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415f4:	48 c1 e0 04          	shl    $0x4,%rax
   415f8:	48 05 a0 f2 04 00    	add    $0x4f2a0,%rax
   415fe:	48 89 d1             	mov    %rdx,%rcx
   41601:	ba 00 00 00 00       	mov    $0x0,%edx
   41606:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4160d:	0e 00 00 
   41610:	48 89 c7             	mov    %rax,%rdi
   41613:	e8 66 fe ff ff       	call   4147e <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41618:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4161c:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41623:	76 c7                	jbe    415ec <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41625:	b8 36 00 04 00       	mov    $0x40036,%eax
   4162a:	48 89 c1             	mov    %rax,%rcx
   4162d:	ba 00 00 00 00       	mov    $0x0,%edx
   41632:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41639:	0e 00 00 
   4163c:	48 89 c6             	mov    %rax,%rsi
   4163f:	bf a0 f4 04 00       	mov    $0x4f4a0,%edi
   41644:	e8 35 fe ff ff       	call   4147e <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41649:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4164e:	48 89 c1             	mov    %rax,%rcx
   41651:	ba 00 00 00 00       	mov    $0x0,%edx
   41656:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4165d:	0e 00 00 
   41660:	48 89 c6             	mov    %rax,%rsi
   41663:	bf 70 f3 04 00       	mov    $0x4f370,%edi
   41668:	e8 11 fe ff ff       	call   4147e <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   4166d:	b8 32 00 04 00       	mov    $0x40032,%eax
   41672:	48 89 c1             	mov    %rax,%rcx
   41675:	ba 00 00 00 00       	mov    $0x0,%edx
   4167a:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41681:	0e 00 00 
   41684:	48 89 c6             	mov    %rax,%rsi
   41687:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   4168c:	e8 ed fd ff ff       	call   4147e <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41691:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41698:	eb 3e                	jmp    416d8 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   4169a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4169d:	83 e8 30             	sub    $0x30,%eax
   416a0:	89 c0                	mov    %eax,%eax
   416a2:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   416a9:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   416aa:	48 89 c2             	mov    %rax,%rdx
   416ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416b0:	48 c1 e0 04          	shl    $0x4,%rax
   416b4:	48 05 a0 f2 04 00    	add    $0x4f2a0,%rax
   416ba:	48 89 d1             	mov    %rdx,%rcx
   416bd:	ba 03 00 00 00       	mov    $0x3,%edx
   416c2:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   416c9:	0e 00 00 
   416cc:	48 89 c7             	mov    %rax,%rdi
   416cf:	e8 aa fd ff ff       	call   4147e <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   416d4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   416d8:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   416dc:	76 bc                	jbe    4169a <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   416de:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   416e4:	b8 a0 f2 04 00       	mov    $0x4f2a0,%eax
   416e9:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   416ed:	b8 28 00 00 00       	mov    $0x28,%eax
   416f2:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   416f6:	0f 00 d8             	ltr    %ax
   416f9:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   416fd:	0f 20 c0             	mov    %cr0,%rax
   41700:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41704:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41708:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4170b:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41712:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41715:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41718:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4171b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4171f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41723:	0f 22 c0             	mov    %rax,%cr0
}
   41726:	90                   	nop
    lcr0(cr0);
}
   41727:	90                   	nop
   41728:	c9                   	leave  
   41729:	c3                   	ret    

000000000004172a <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   4172a:	55                   	push   %rbp
   4172b:	48 89 e5             	mov    %rsp,%rbp
   4172e:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41732:	0f b7 05 c7 eb 00 00 	movzwl 0xebc7(%rip),%eax        # 50300 <interrupts_enabled>
   41739:	f7 d0                	not    %eax
   4173b:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   4173f:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41743:	0f b6 c0             	movzbl %al,%eax
   41746:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   4174d:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41750:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41754:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41757:	ee                   	out    %al,(%dx)
}
   41758:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41759:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4175d:	66 c1 e8 08          	shr    $0x8,%ax
   41761:	0f b6 c0             	movzbl %al,%eax
   41764:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4176b:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4176e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41772:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41775:	ee                   	out    %al,(%dx)
}
   41776:	90                   	nop
}
   41777:	90                   	nop
   41778:	c9                   	leave  
   41779:	c3                   	ret    

000000000004177a <interrupt_init>:

void interrupt_init(void) {
   4177a:	55                   	push   %rbp
   4177b:	48 89 e5             	mov    %rsp,%rbp
   4177e:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41782:	66 c7 05 75 eb 00 00 	movw   $0x0,0xeb75(%rip)        # 50300 <interrupts_enabled>
   41789:	00 00 
    interrupt_mask();
   4178b:	e8 9a ff ff ff       	call   4172a <interrupt_mask>
   41790:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41797:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4179b:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   4179f:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   417a2:	ee                   	out    %al,(%dx)
}
   417a3:	90                   	nop
   417a4:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   417ab:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417af:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   417b3:	8b 55 ac             	mov    -0x54(%rbp),%edx
   417b6:	ee                   	out    %al,(%dx)
}
   417b7:	90                   	nop
   417b8:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   417bf:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417c3:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   417c7:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   417ca:	ee                   	out    %al,(%dx)
}
   417cb:	90                   	nop
   417cc:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   417d3:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417d7:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   417db:	8b 55 bc             	mov    -0x44(%rbp),%edx
   417de:	ee                   	out    %al,(%dx)
}
   417df:	90                   	nop
   417e0:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   417e7:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417eb:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   417ef:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   417f2:	ee                   	out    %al,(%dx)
}
   417f3:	90                   	nop
   417f4:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   417fb:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417ff:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41803:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41806:	ee                   	out    %al,(%dx)
}
   41807:	90                   	nop
   41808:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   4180f:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41813:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41817:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   4181a:	ee                   	out    %al,(%dx)
}
   4181b:	90                   	nop
   4181c:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41823:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41827:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   4182b:	8b 55 dc             	mov    -0x24(%rbp),%edx
   4182e:	ee                   	out    %al,(%dx)
}
   4182f:	90                   	nop
   41830:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41837:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4183b:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   4183f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41842:	ee                   	out    %al,(%dx)
}
   41843:	90                   	nop
   41844:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   4184b:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4184f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41853:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41856:	ee                   	out    %al,(%dx)
}
   41857:	90                   	nop
   41858:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   4185f:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41863:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41867:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4186a:	ee                   	out    %al,(%dx)
}
   4186b:	90                   	nop
   4186c:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41873:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41877:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4187b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4187e:	ee                   	out    %al,(%dx)
}
   4187f:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41880:	e8 a5 fe ff ff       	call   4172a <interrupt_mask>
}
   41885:	90                   	nop
   41886:	c9                   	leave  
   41887:	c3                   	ret    

0000000000041888 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41888:	55                   	push   %rbp
   41889:	48 89 e5             	mov    %rsp,%rbp
   4188c:	48 83 ec 28          	sub    $0x28,%rsp
   41890:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41893:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41897:	0f 8e 9f 00 00 00    	jle    4193c <timer_init+0xb4>
   4189d:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   418a4:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418a8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   418ac:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418af:	ee                   	out    %al,(%dx)
}
   418b0:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   418b1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   418b4:	89 c2                	mov    %eax,%edx
   418b6:	c1 ea 1f             	shr    $0x1f,%edx
   418b9:	01 d0                	add    %edx,%eax
   418bb:	d1 f8                	sar    %eax
   418bd:	05 de 34 12 00       	add    $0x1234de,%eax
   418c2:	99                   	cltd   
   418c3:	f7 7d dc             	idivl  -0x24(%rbp)
   418c6:	89 c2                	mov    %eax,%edx
   418c8:	89 d0                	mov    %edx,%eax
   418ca:	c1 f8 1f             	sar    $0x1f,%eax
   418cd:	c1 e8 18             	shr    $0x18,%eax
   418d0:	89 c1                	mov    %eax,%ecx
   418d2:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   418d5:	0f b6 c0             	movzbl %al,%eax
   418d8:	29 c8                	sub    %ecx,%eax
   418da:	0f b6 c0             	movzbl %al,%eax
   418dd:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   418e4:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418e7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   418eb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   418ee:	ee                   	out    %al,(%dx)
}
   418ef:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   418f0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   418f3:	89 c2                	mov    %eax,%edx
   418f5:	c1 ea 1f             	shr    $0x1f,%edx
   418f8:	01 d0                	add    %edx,%eax
   418fa:	d1 f8                	sar    %eax
   418fc:	05 de 34 12 00       	add    $0x1234de,%eax
   41901:	99                   	cltd   
   41902:	f7 7d dc             	idivl  -0x24(%rbp)
   41905:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4190b:	85 c0                	test   %eax,%eax
   4190d:	0f 48 c2             	cmovs  %edx,%eax
   41910:	c1 f8 08             	sar    $0x8,%eax
   41913:	0f b6 c0             	movzbl %al,%eax
   41916:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4191d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41920:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41924:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41927:	ee                   	out    %al,(%dx)
}
   41928:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41929:	0f b7 05 d0 e9 00 00 	movzwl 0xe9d0(%rip),%eax        # 50300 <interrupts_enabled>
   41930:	83 c8 01             	or     $0x1,%eax
   41933:	66 89 05 c6 e9 00 00 	mov    %ax,0xe9c6(%rip)        # 50300 <interrupts_enabled>
   4193a:	eb 11                	jmp    4194d <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   4193c:	0f b7 05 bd e9 00 00 	movzwl 0xe9bd(%rip),%eax        # 50300 <interrupts_enabled>
   41943:	83 e0 fe             	and    $0xfffffffe,%eax
   41946:	66 89 05 b3 e9 00 00 	mov    %ax,0xe9b3(%rip)        # 50300 <interrupts_enabled>
    }
    interrupt_mask();
   4194d:	e8 d8 fd ff ff       	call   4172a <interrupt_mask>
}
   41952:	90                   	nop
   41953:	c9                   	leave  
   41954:	c3                   	ret    

0000000000041955 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41955:	55                   	push   %rbp
   41956:	48 89 e5             	mov    %rsp,%rbp
   41959:	48 83 ec 08          	sub    $0x8,%rsp
   4195d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41961:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41966:	74 14                	je     4197c <physical_memory_isreserved+0x27>
   41968:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   4196f:	00 
   41970:	76 11                	jbe    41983 <physical_memory_isreserved+0x2e>
   41972:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41979:	00 
   4197a:	77 07                	ja     41983 <physical_memory_isreserved+0x2e>
   4197c:	b8 01 00 00 00       	mov    $0x1,%eax
   41981:	eb 05                	jmp    41988 <physical_memory_isreserved+0x33>
   41983:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41988:	c9                   	leave  
   41989:	c3                   	ret    

000000000004198a <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   4198a:	55                   	push   %rbp
   4198b:	48 89 e5             	mov    %rsp,%rbp
   4198e:	48 83 ec 10          	sub    $0x10,%rsp
   41992:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41995:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41998:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4199b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4199e:	c1 e0 10             	shl    $0x10,%eax
   419a1:	89 c2                	mov    %eax,%edx
   419a3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419a6:	c1 e0 0b             	shl    $0xb,%eax
   419a9:	09 c2                	or     %eax,%edx
   419ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419ae:	c1 e0 08             	shl    $0x8,%eax
   419b1:	09 d0                	or     %edx,%eax
}
   419b3:	c9                   	leave  
   419b4:	c3                   	ret    

00000000000419b5 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   419b5:	55                   	push   %rbp
   419b6:	48 89 e5             	mov    %rsp,%rbp
   419b9:	48 83 ec 18          	sub    $0x18,%rsp
   419bd:	89 7d ec             	mov    %edi,-0x14(%rbp)
   419c0:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   419c3:	8b 55 ec             	mov    -0x14(%rbp),%edx
   419c6:	8b 45 e8             	mov    -0x18(%rbp),%eax
   419c9:	09 d0                	or     %edx,%eax
   419cb:	0d 00 00 00 80       	or     $0x80000000,%eax
   419d0:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   419d7:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   419da:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419dd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   419e0:	ef                   	out    %eax,(%dx)
}
   419e1:	90                   	nop
   419e2:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   419e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419ec:	89 c2                	mov    %eax,%edx
   419ee:	ed                   	in     (%dx),%eax
   419ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   419f2:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   419f5:	c9                   	leave  
   419f6:	c3                   	ret    

00000000000419f7 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   419f7:	55                   	push   %rbp
   419f8:	48 89 e5             	mov    %rsp,%rbp
   419fb:	48 83 ec 28          	sub    $0x28,%rsp
   419ff:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41a02:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41a05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41a0c:	eb 73                	jmp    41a81 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41a0e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41a15:	eb 60                	jmp    41a77 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41a17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41a1e:	eb 4a                	jmp    41a6a <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41a20:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a23:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41a26:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a29:	89 ce                	mov    %ecx,%esi
   41a2b:	89 c7                	mov    %eax,%edi
   41a2d:	e8 58 ff ff ff       	call   4198a <pci_make_configaddr>
   41a32:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41a35:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a38:	be 00 00 00 00       	mov    $0x0,%esi
   41a3d:	89 c7                	mov    %eax,%edi
   41a3f:	e8 71 ff ff ff       	call   419b5 <pci_config_readl>
   41a44:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41a47:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41a4a:	c1 e0 10             	shl    $0x10,%eax
   41a4d:	0b 45 dc             	or     -0x24(%rbp),%eax
   41a50:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41a53:	75 05                	jne    41a5a <pci_find_device+0x63>
                    return configaddr;
   41a55:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a58:	eb 35                	jmp    41a8f <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41a5a:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41a5e:	75 06                	jne    41a66 <pci_find_device+0x6f>
   41a60:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41a64:	74 0c                	je     41a72 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41a66:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41a6a:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41a6e:	75 b0                	jne    41a20 <pci_find_device+0x29>
   41a70:	eb 01                	jmp    41a73 <pci_find_device+0x7c>
                    break;
   41a72:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41a73:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41a77:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41a7b:	75 9a                	jne    41a17 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41a7d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a81:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41a88:	75 84                	jne    41a0e <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41a8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41a8f:	c9                   	leave  
   41a90:	c3                   	ret    

0000000000041a91 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41a91:	55                   	push   %rbp
   41a92:	48 89 e5             	mov    %rsp,%rbp
   41a95:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41a99:	be 13 71 00 00       	mov    $0x7113,%esi
   41a9e:	bf 86 80 00 00       	mov    $0x8086,%edi
   41aa3:	e8 4f ff ff ff       	call   419f7 <pci_find_device>
   41aa8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41aab:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41aaf:	78 30                	js     41ae1 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41ab1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ab4:	be 40 00 00 00       	mov    $0x40,%esi
   41ab9:	89 c7                	mov    %eax,%edi
   41abb:	e8 f5 fe ff ff       	call   419b5 <pci_config_readl>
   41ac0:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41ac5:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41ac8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41acb:	83 c0 04             	add    $0x4,%eax
   41ace:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41ad1:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41ad7:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41adb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ade:	66 ef                	out    %ax,(%dx)
}
   41ae0:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41ae1:	ba c0 3a 04 00       	mov    $0x43ac0,%edx
   41ae6:	be 00 c0 00 00       	mov    $0xc000,%esi
   41aeb:	bf 80 07 00 00       	mov    $0x780,%edi
   41af0:	b8 00 00 00 00       	mov    $0x0,%eax
   41af5:	e8 cc 1a 00 00       	call   435c6 <console_printf>
 spinloop: goto spinloop;
   41afa:	eb fe                	jmp    41afa <poweroff+0x69>

0000000000041afc <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41afc:	55                   	push   %rbp
   41afd:	48 89 e5             	mov    %rsp,%rbp
   41b00:	48 83 ec 10          	sub    $0x10,%rsp
   41b04:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41b0b:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b0f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b13:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b16:	ee                   	out    %al,(%dx)
}
   41b17:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41b18:	eb fe                	jmp    41b18 <reboot+0x1c>

0000000000041b1a <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41b1a:	55                   	push   %rbp
   41b1b:	48 89 e5             	mov    %rsp,%rbp
   41b1e:	48 83 ec 10          	sub    $0x10,%rsp
   41b22:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b26:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41b29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b2d:	48 83 c0 08          	add    $0x8,%rax
   41b31:	ba c0 00 00 00       	mov    $0xc0,%edx
   41b36:	be 00 00 00 00       	mov    $0x0,%esi
   41b3b:	48 89 c7             	mov    %rax,%rdi
   41b3e:	e8 4e 12 00 00       	call   42d91 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b47:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41b4e:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41b50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b54:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41b5b:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b63:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41b6a:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b72:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41b79:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b7f:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41b86:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41b8a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b8d:	83 e0 01             	and    $0x1,%eax
   41b90:	85 c0                	test   %eax,%eax
   41b92:	74 1c                	je     41bb0 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b98:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41b9f:	80 cc 30             	or     $0x30,%ah
   41ba2:	48 89 c2             	mov    %rax,%rdx
   41ba5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ba9:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41bb0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41bb3:	83 e0 02             	and    $0x2,%eax
   41bb6:	85 c0                	test   %eax,%eax
   41bb8:	74 1c                	je     41bd6 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41bba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bbe:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41bc5:	80 e4 fd             	and    $0xfd,%ah
   41bc8:	48 89 c2             	mov    %rax,%rdx
   41bcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bcf:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41bd6:	90                   	nop
   41bd7:	c9                   	leave  
   41bd8:	c3                   	ret    

0000000000041bd9 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41bd9:	55                   	push   %rbp
   41bda:	48 89 e5             	mov    %rsp,%rbp
   41bdd:	48 83 ec 28          	sub    $0x28,%rsp
   41be1:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41be4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41be8:	78 09                	js     41bf3 <console_show_cursor+0x1a>
   41bea:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41bf1:	7e 07                	jle    41bfa <console_show_cursor+0x21>
        cpos = 0;
   41bf3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41bfa:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41c01:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c05:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c09:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c0c:	ee                   	out    %al,(%dx)
}
   41c0d:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41c0e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c11:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c17:	85 c0                	test   %eax,%eax
   41c19:	0f 48 c2             	cmovs  %edx,%eax
   41c1c:	c1 f8 08             	sar    $0x8,%eax
   41c1f:	0f b6 c0             	movzbl %al,%eax
   41c22:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41c29:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c2c:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c30:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c33:	ee                   	out    %al,(%dx)
}
   41c34:	90                   	nop
   41c35:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41c3c:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c40:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c44:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c47:	ee                   	out    %al,(%dx)
}
   41c48:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41c49:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c4c:	99                   	cltd   
   41c4d:	c1 ea 18             	shr    $0x18,%edx
   41c50:	01 d0                	add    %edx,%eax
   41c52:	0f b6 c0             	movzbl %al,%eax
   41c55:	29 d0                	sub    %edx,%eax
   41c57:	0f b6 c0             	movzbl %al,%eax
   41c5a:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41c61:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c64:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c68:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c6b:	ee                   	out    %al,(%dx)
}
   41c6c:	90                   	nop
}
   41c6d:	90                   	nop
   41c6e:	c9                   	leave  
   41c6f:	c3                   	ret    

0000000000041c70 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41c70:	55                   	push   %rbp
   41c71:	48 89 e5             	mov    %rsp,%rbp
   41c74:	48 83 ec 20          	sub    $0x20,%rsp
   41c78:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41c7f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c82:	89 c2                	mov    %eax,%edx
   41c84:	ec                   	in     (%dx),%al
   41c85:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41c88:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41c8c:	0f b6 c0             	movzbl %al,%eax
   41c8f:	83 e0 01             	and    $0x1,%eax
   41c92:	85 c0                	test   %eax,%eax
   41c94:	75 0a                	jne    41ca0 <keyboard_readc+0x30>
        return -1;
   41c96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41c9b:	e9 e7 01 00 00       	jmp    41e87 <keyboard_readc+0x217>
   41ca0:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41ca7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41caa:	89 c2                	mov    %eax,%edx
   41cac:	ec                   	in     (%dx),%al
   41cad:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41cb0:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41cb4:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41cb7:	0f b6 05 44 e6 00 00 	movzbl 0xe644(%rip),%eax        # 50302 <last_escape.2>
   41cbe:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41cc1:	c6 05 3a e6 00 00 00 	movb   $0x0,0xe63a(%rip)        # 50302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41cc8:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41ccc:	75 11                	jne    41cdf <keyboard_readc+0x6f>
        last_escape = 0x80;
   41cce:	c6 05 2d e6 00 00 80 	movb   $0x80,0xe62d(%rip)        # 50302 <last_escape.2>
        return 0;
   41cd5:	b8 00 00 00 00       	mov    $0x0,%eax
   41cda:	e9 a8 01 00 00       	jmp    41e87 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41cdf:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ce3:	84 c0                	test   %al,%al
   41ce5:	79 60                	jns    41d47 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41ce7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ceb:	83 e0 7f             	and    $0x7f,%eax
   41cee:	89 c2                	mov    %eax,%edx
   41cf0:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41cf4:	09 d0                	or     %edx,%eax
   41cf6:	48 98                	cltq   
   41cf8:	0f b6 80 e0 3a 04 00 	movzbl 0x43ae0(%rax),%eax
   41cff:	0f b6 c0             	movzbl %al,%eax
   41d02:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41d05:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41d0c:	7e 2f                	jle    41d3d <keyboard_readc+0xcd>
   41d0e:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41d15:	7f 26                	jg     41d3d <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41d17:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d1a:	2d fa 00 00 00       	sub    $0xfa,%eax
   41d1f:	ba 01 00 00 00       	mov    $0x1,%edx
   41d24:	89 c1                	mov    %eax,%ecx
   41d26:	d3 e2                	shl    %cl,%edx
   41d28:	89 d0                	mov    %edx,%eax
   41d2a:	f7 d0                	not    %eax
   41d2c:	89 c2                	mov    %eax,%edx
   41d2e:	0f b6 05 ce e5 00 00 	movzbl 0xe5ce(%rip),%eax        # 50303 <modifiers.1>
   41d35:	21 d0                	and    %edx,%eax
   41d37:	88 05 c6 e5 00 00    	mov    %al,0xe5c6(%rip)        # 50303 <modifiers.1>
        }
        return 0;
   41d3d:	b8 00 00 00 00       	mov    $0x0,%eax
   41d42:	e9 40 01 00 00       	jmp    41e87 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41d47:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d4b:	0a 45 fa             	or     -0x6(%rbp),%al
   41d4e:	0f b6 c0             	movzbl %al,%eax
   41d51:	48 98                	cltq   
   41d53:	0f b6 80 e0 3a 04 00 	movzbl 0x43ae0(%rax),%eax
   41d5a:	0f b6 c0             	movzbl %al,%eax
   41d5d:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41d60:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41d64:	7e 57                	jle    41dbd <keyboard_readc+0x14d>
   41d66:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41d6a:	7f 51                	jg     41dbd <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41d6c:	0f b6 05 90 e5 00 00 	movzbl 0xe590(%rip),%eax        # 50303 <modifiers.1>
   41d73:	0f b6 c0             	movzbl %al,%eax
   41d76:	83 e0 02             	and    $0x2,%eax
   41d79:	85 c0                	test   %eax,%eax
   41d7b:	74 09                	je     41d86 <keyboard_readc+0x116>
            ch -= 0x60;
   41d7d:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41d81:	e9 fd 00 00 00       	jmp    41e83 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41d86:	0f b6 05 76 e5 00 00 	movzbl 0xe576(%rip),%eax        # 50303 <modifiers.1>
   41d8d:	0f b6 c0             	movzbl %al,%eax
   41d90:	83 e0 01             	and    $0x1,%eax
   41d93:	85 c0                	test   %eax,%eax
   41d95:	0f 94 c2             	sete   %dl
   41d98:	0f b6 05 64 e5 00 00 	movzbl 0xe564(%rip),%eax        # 50303 <modifiers.1>
   41d9f:	0f b6 c0             	movzbl %al,%eax
   41da2:	83 e0 08             	and    $0x8,%eax
   41da5:	85 c0                	test   %eax,%eax
   41da7:	0f 94 c0             	sete   %al
   41daa:	31 d0                	xor    %edx,%eax
   41dac:	84 c0                	test   %al,%al
   41dae:	0f 84 cf 00 00 00    	je     41e83 <keyboard_readc+0x213>
            ch -= 0x20;
   41db4:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41db8:	e9 c6 00 00 00       	jmp    41e83 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41dbd:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41dc4:	7e 30                	jle    41df6 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41dc6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dc9:	2d fa 00 00 00       	sub    $0xfa,%eax
   41dce:	ba 01 00 00 00       	mov    $0x1,%edx
   41dd3:	89 c1                	mov    %eax,%ecx
   41dd5:	d3 e2                	shl    %cl,%edx
   41dd7:	89 d0                	mov    %edx,%eax
   41dd9:	89 c2                	mov    %eax,%edx
   41ddb:	0f b6 05 21 e5 00 00 	movzbl 0xe521(%rip),%eax        # 50303 <modifiers.1>
   41de2:	31 d0                	xor    %edx,%eax
   41de4:	88 05 19 e5 00 00    	mov    %al,0xe519(%rip)        # 50303 <modifiers.1>
        ch = 0;
   41dea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41df1:	e9 8e 00 00 00       	jmp    41e84 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41df6:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41dfd:	7e 2d                	jle    41e2c <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41dff:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e02:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e07:	ba 01 00 00 00       	mov    $0x1,%edx
   41e0c:	89 c1                	mov    %eax,%ecx
   41e0e:	d3 e2                	shl    %cl,%edx
   41e10:	89 d0                	mov    %edx,%eax
   41e12:	89 c2                	mov    %eax,%edx
   41e14:	0f b6 05 e8 e4 00 00 	movzbl 0xe4e8(%rip),%eax        # 50303 <modifiers.1>
   41e1b:	09 d0                	or     %edx,%eax
   41e1d:	88 05 e0 e4 00 00    	mov    %al,0xe4e0(%rip)        # 50303 <modifiers.1>
        ch = 0;
   41e23:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e2a:	eb 58                	jmp    41e84 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   41e2c:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41e30:	7e 31                	jle    41e63 <keyboard_readc+0x1f3>
   41e32:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   41e39:	7f 28                	jg     41e63 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   41e3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e3e:	8d 50 80             	lea    -0x80(%rax),%edx
   41e41:	0f b6 05 bb e4 00 00 	movzbl 0xe4bb(%rip),%eax        # 50303 <modifiers.1>
   41e48:	0f b6 c0             	movzbl %al,%eax
   41e4b:	83 e0 03             	and    $0x3,%eax
   41e4e:	48 98                	cltq   
   41e50:	48 63 d2             	movslq %edx,%rdx
   41e53:	0f b6 84 90 e0 3b 04 	movzbl 0x43be0(%rax,%rdx,4),%eax
   41e5a:	00 
   41e5b:	0f b6 c0             	movzbl %al,%eax
   41e5e:	89 45 fc             	mov    %eax,-0x4(%rbp)
   41e61:	eb 21                	jmp    41e84 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   41e63:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41e67:	7f 1b                	jg     41e84 <keyboard_readc+0x214>
   41e69:	0f b6 05 93 e4 00 00 	movzbl 0xe493(%rip),%eax        # 50303 <modifiers.1>
   41e70:	0f b6 c0             	movzbl %al,%eax
   41e73:	83 e0 02             	and    $0x2,%eax
   41e76:	85 c0                	test   %eax,%eax
   41e78:	74 0a                	je     41e84 <keyboard_readc+0x214>
        ch = 0;
   41e7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e81:	eb 01                	jmp    41e84 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   41e83:	90                   	nop
    }

    return ch;
   41e84:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   41e87:	c9                   	leave  
   41e88:	c3                   	ret    

0000000000041e89 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   41e89:	55                   	push   %rbp
   41e8a:	48 89 e5             	mov    %rsp,%rbp
   41e8d:	48 83 ec 20          	sub    $0x20,%rsp
   41e91:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41e98:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41e9b:	89 c2                	mov    %eax,%edx
   41e9d:	ec                   	in     (%dx),%al
   41e9e:	88 45 e3             	mov    %al,-0x1d(%rbp)
   41ea1:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   41ea8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41eab:	89 c2                	mov    %eax,%edx
   41ead:	ec                   	in     (%dx),%al
   41eae:	88 45 eb             	mov    %al,-0x15(%rbp)
   41eb1:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   41eb8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ebb:	89 c2                	mov    %eax,%edx
   41ebd:	ec                   	in     (%dx),%al
   41ebe:	88 45 f3             	mov    %al,-0xd(%rbp)
   41ec1:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   41ec8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ecb:	89 c2                	mov    %eax,%edx
   41ecd:	ec                   	in     (%dx),%al
   41ece:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   41ed1:	90                   	nop
   41ed2:	c9                   	leave  
   41ed3:	c3                   	ret    

0000000000041ed4 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   41ed4:	55                   	push   %rbp
   41ed5:	48 89 e5             	mov    %rsp,%rbp
   41ed8:	48 83 ec 40          	sub    $0x40,%rsp
   41edc:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41ee0:	89 f0                	mov    %esi,%eax
   41ee2:	89 55 c0             	mov    %edx,-0x40(%rbp)
   41ee5:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   41ee8:	8b 05 16 e4 00 00    	mov    0xe416(%rip),%eax        # 50304 <initialized.0>
   41eee:	85 c0                	test   %eax,%eax
   41ef0:	75 1e                	jne    41f10 <parallel_port_putc+0x3c>
   41ef2:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   41ef9:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41efd:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41f01:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41f04:	ee                   	out    %al,(%dx)
}
   41f05:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   41f06:	c7 05 f4 e3 00 00 01 	movl   $0x1,0xe3f4(%rip)        # 50304 <initialized.0>
   41f0d:	00 00 00 
    }

    for (int i = 0;
   41f10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f17:	eb 09                	jmp    41f22 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   41f19:	e8 6b ff ff ff       	call   41e89 <delay>
         ++i) {
   41f1e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   41f22:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   41f29:	7f 18                	jg     41f43 <parallel_port_putc+0x6f>
   41f2b:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f32:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f35:	89 c2                	mov    %eax,%edx
   41f37:	ec                   	in     (%dx),%al
   41f38:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f3b:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41f3f:	84 c0                	test   %al,%al
   41f41:	79 d6                	jns    41f19 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   41f43:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   41f47:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   41f4e:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f51:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   41f55:	8b 55 d8             	mov    -0x28(%rbp),%edx
   41f58:	ee                   	out    %al,(%dx)
}
   41f59:	90                   	nop
   41f5a:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   41f61:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f65:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   41f69:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41f6c:	ee                   	out    %al,(%dx)
}
   41f6d:	90                   	nop
   41f6e:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   41f75:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f79:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   41f7d:	8b 55 e8             	mov    -0x18(%rbp),%edx
   41f80:	ee                   	out    %al,(%dx)
}
   41f81:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   41f82:	90                   	nop
   41f83:	c9                   	leave  
   41f84:	c3                   	ret    

0000000000041f85 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   41f85:	55                   	push   %rbp
   41f86:	48 89 e5             	mov    %rsp,%rbp
   41f89:	48 83 ec 20          	sub    $0x20,%rsp
   41f8d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41f91:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   41f95:	48 c7 45 f8 d4 1e 04 	movq   $0x41ed4,-0x8(%rbp)
   41f9c:	00 
    printer_vprintf(&p, 0, format, val);
   41f9d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   41fa1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   41fa5:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   41fa9:	be 00 00 00 00       	mov    $0x0,%esi
   41fae:	48 89 c7             	mov    %rax,%rdi
   41fb1:	e8 ec 0e 00 00       	call   42ea2 <printer_vprintf>
}
   41fb6:	90                   	nop
   41fb7:	c9                   	leave  
   41fb8:	c3                   	ret    

0000000000041fb9 <log_printf>:

void log_printf(const char* format, ...) {
   41fb9:	55                   	push   %rbp
   41fba:	48 89 e5             	mov    %rsp,%rbp
   41fbd:	48 83 ec 60          	sub    $0x60,%rsp
   41fc1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   41fc5:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   41fc9:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   41fcd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   41fd1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   41fd5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   41fd9:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   41fe0:	48 8d 45 10          	lea    0x10(%rbp),%rax
   41fe4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   41fe8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41fec:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   41ff0:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   41ff4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   41ff8:	48 89 d6             	mov    %rdx,%rsi
   41ffb:	48 89 c7             	mov    %rax,%rdi
   41ffe:	e8 82 ff ff ff       	call   41f85 <log_vprintf>
    va_end(val);
}
   42003:	90                   	nop
   42004:	c9                   	leave  
   42005:	c3                   	ret    

0000000000042006 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42006:	55                   	push   %rbp
   42007:	48 89 e5             	mov    %rsp,%rbp
   4200a:	48 83 ec 40          	sub    $0x40,%rsp
   4200e:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42011:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42014:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42018:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4201c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42020:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42024:	48 8b 0a             	mov    (%rdx),%rcx
   42027:	48 89 08             	mov    %rcx,(%rax)
   4202a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4202e:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42032:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42036:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4203a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4203e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42042:	48 89 d6             	mov    %rdx,%rsi
   42045:	48 89 c7             	mov    %rax,%rdi
   42048:	e8 38 ff ff ff       	call   41f85 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4204d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42051:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42055:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42058:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4205b:	89 c7                	mov    %eax,%edi
   4205d:	e8 1f 15 00 00       	call   43581 <console_vprintf>
}
   42062:	c9                   	leave  
   42063:	c3                   	ret    

0000000000042064 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42064:	55                   	push   %rbp
   42065:	48 89 e5             	mov    %rsp,%rbp
   42068:	48 83 ec 60          	sub    $0x60,%rsp
   4206c:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4206f:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42072:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42076:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4207a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4207e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42082:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42089:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4208d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42091:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42095:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42099:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4209d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   420a1:	8b 75 a8             	mov    -0x58(%rbp),%esi
   420a4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   420a7:	89 c7                	mov    %eax,%edi
   420a9:	e8 58 ff ff ff       	call   42006 <error_vprintf>
   420ae:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   420b1:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   420b4:	c9                   	leave  
   420b5:	c3                   	ret    

00000000000420b6 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   420b6:	55                   	push   %rbp
   420b7:	48 89 e5             	mov    %rsp,%rbp
   420ba:	53                   	push   %rbx
   420bb:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   420bf:	e8 ac fb ff ff       	call   41c70 <keyboard_readc>
   420c4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   420c7:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   420cb:	74 1c                	je     420e9 <check_keyboard+0x33>
   420cd:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   420d1:	74 16                	je     420e9 <check_keyboard+0x33>
   420d3:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   420d7:	74 10                	je     420e9 <check_keyboard+0x33>
   420d9:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   420dd:	74 0a                	je     420e9 <check_keyboard+0x33>
   420df:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   420e3:	0f 85 e9 00 00 00    	jne    421d2 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   420e9:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   420f0:	00 
        memset(pt, 0, PAGESIZE * 3);
   420f1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   420f5:	ba 00 30 00 00       	mov    $0x3000,%edx
   420fa:	be 00 00 00 00       	mov    $0x0,%esi
   420ff:	48 89 c7             	mov    %rax,%rdi
   42102:	e8 8a 0c 00 00       	call   42d91 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42107:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4210b:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42112:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42116:	48 05 00 10 00 00    	add    $0x1000,%rax
   4211c:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42123:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42127:	48 05 00 20 00 00    	add    $0x2000,%rax
   4212d:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42134:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42138:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4213c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42140:	0f 22 d8             	mov    %rax,%cr3
}
   42143:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42144:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   4214b:	48 c7 45 e8 38 3c 04 	movq   $0x43c38,-0x18(%rbp)
   42152:	00 
        if (c == 'a') {
   42153:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42157:	75 0a                	jne    42163 <check_keyboard+0xad>
            argument = "allocator";
   42159:	48 c7 45 e8 3d 3c 04 	movq   $0x43c3d,-0x18(%rbp)
   42160:	00 
   42161:	eb 2e                	jmp    42191 <check_keyboard+0xdb>
        } else if (c == 'e') {
   42163:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42167:	75 0a                	jne    42173 <check_keyboard+0xbd>
            argument = "forkexit";
   42169:	48 c7 45 e8 47 3c 04 	movq   $0x43c47,-0x18(%rbp)
   42170:	00 
   42171:	eb 1e                	jmp    42191 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42173:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42177:	75 0a                	jne    42183 <check_keyboard+0xcd>
            argument = "test";
   42179:	48 c7 45 e8 50 3c 04 	movq   $0x43c50,-0x18(%rbp)
   42180:	00 
   42181:	eb 0e                	jmp    42191 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42183:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42187:	75 08                	jne    42191 <check_keyboard+0xdb>
            argument = "test2";
   42189:	48 c7 45 e8 55 3c 04 	movq   $0x43c55,-0x18(%rbp)
   42190:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42191:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42195:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42199:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4219e:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   421a2:	76 14                	jbe    421b8 <check_keyboard+0x102>
   421a4:	ba 5b 3c 04 00       	mov    $0x43c5b,%edx
   421a9:	be 5c 02 00 00       	mov    $0x25c,%esi
   421ae:	bf 77 3c 04 00       	mov    $0x43c77,%edi
   421b3:	e8 1f 01 00 00       	call   422d7 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   421b8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   421bc:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   421bf:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   421c3:	48 89 c3             	mov    %rax,%rbx
   421c6:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   421cb:	e9 30 de ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   421d0:	eb 11                	jmp    421e3 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   421d2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   421d6:	74 06                	je     421de <check_keyboard+0x128>
   421d8:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   421dc:	75 05                	jne    421e3 <check_keyboard+0x12d>
        poweroff();
   421de:	e8 ae f8 ff ff       	call   41a91 <poweroff>
    }
    return c;
   421e3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   421e6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   421ea:	c9                   	leave  
   421eb:	c3                   	ret    

00000000000421ec <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   421ec:	55                   	push   %rbp
   421ed:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   421f0:	e8 c1 fe ff ff       	call   420b6 <check_keyboard>
   421f5:	eb f9                	jmp    421f0 <fail+0x4>

00000000000421f7 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   421f7:	55                   	push   %rbp
   421f8:	48 89 e5             	mov    %rsp,%rbp
   421fb:	48 83 ec 60          	sub    $0x60,%rsp
   421ff:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42203:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42207:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4220b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4220f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42213:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42217:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4221e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42222:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42226:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4222a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4222e:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42233:	0f 84 80 00 00 00    	je     422b9 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42239:	ba 84 3c 04 00       	mov    $0x43c84,%edx
   4223e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42243:	bf 30 07 00 00       	mov    $0x730,%edi
   42248:	b8 00 00 00 00       	mov    $0x0,%eax
   4224d:	e8 12 fe ff ff       	call   42064 <error_printf>
   42252:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42255:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42259:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4225d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42260:	be 00 c0 00 00       	mov    $0xc000,%esi
   42265:	89 c7                	mov    %eax,%edi
   42267:	e8 9a fd ff ff       	call   42006 <error_vprintf>
   4226c:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4226f:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42272:	48 63 c1             	movslq %ecx,%rax
   42275:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4227c:	48 c1 e8 20          	shr    $0x20,%rax
   42280:	c1 f8 05             	sar    $0x5,%eax
   42283:	89 ce                	mov    %ecx,%esi
   42285:	c1 fe 1f             	sar    $0x1f,%esi
   42288:	29 f0                	sub    %esi,%eax
   4228a:	89 c2                	mov    %eax,%edx
   4228c:	89 d0                	mov    %edx,%eax
   4228e:	c1 e0 02             	shl    $0x2,%eax
   42291:	01 d0                	add    %edx,%eax
   42293:	c1 e0 04             	shl    $0x4,%eax
   42296:	29 c1                	sub    %eax,%ecx
   42298:	89 ca                	mov    %ecx,%edx
   4229a:	85 d2                	test   %edx,%edx
   4229c:	74 34                	je     422d2 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4229e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   422a1:	ba 8c 3c 04 00       	mov    $0x43c8c,%edx
   422a6:	be 00 c0 00 00       	mov    $0xc000,%esi
   422ab:	89 c7                	mov    %eax,%edi
   422ad:	b8 00 00 00 00       	mov    $0x0,%eax
   422b2:	e8 ad fd ff ff       	call   42064 <error_printf>
   422b7:	eb 19                	jmp    422d2 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   422b9:	ba 8e 3c 04 00       	mov    $0x43c8e,%edx
   422be:	be 00 c0 00 00       	mov    $0xc000,%esi
   422c3:	bf 30 07 00 00       	mov    $0x730,%edi
   422c8:	b8 00 00 00 00       	mov    $0x0,%eax
   422cd:	e8 92 fd ff ff       	call   42064 <error_printf>
    }

    va_end(val);
    fail();
   422d2:	e8 15 ff ff ff       	call   421ec <fail>

00000000000422d7 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   422d7:	55                   	push   %rbp
   422d8:	48 89 e5             	mov    %rsp,%rbp
   422db:	48 83 ec 20          	sub    $0x20,%rsp
   422df:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   422e3:	89 75 f4             	mov    %esi,-0xc(%rbp)
   422e6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   422ea:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   422ee:	8b 55 f4             	mov    -0xc(%rbp),%edx
   422f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422f5:	48 89 c6             	mov    %rax,%rsi
   422f8:	bf 94 3c 04 00       	mov    $0x43c94,%edi
   422fd:	b8 00 00 00 00       	mov    $0x0,%eax
   42302:	e8 f0 fe ff ff       	call   421f7 <panic>

0000000000042307 <default_exception>:
}

void default_exception(proc* p){
   42307:	55                   	push   %rbp
   42308:	48 89 e5             	mov    %rsp,%rbp
   4230b:	48 83 ec 20          	sub    $0x20,%rsp
   4230f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42313:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42317:	48 83 c0 08          	add    $0x8,%rax
   4231b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4231f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42323:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4232a:	48 89 c6             	mov    %rax,%rsi
   4232d:	bf b2 3c 04 00       	mov    $0x43cb2,%edi
   42332:	b8 00 00 00 00       	mov    $0x0,%eax
   42337:	e8 bb fe ff ff       	call   421f7 <panic>

000000000004233c <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4233c:	55                   	push   %rbp
   4233d:	48 89 e5             	mov    %rsp,%rbp
   42340:	48 83 ec 10          	sub    $0x10,%rsp
   42344:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42348:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4234b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4234f:	78 06                	js     42357 <pageindex+0x1b>
   42351:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42355:	7e 14                	jle    4236b <pageindex+0x2f>
   42357:	ba d0 3c 04 00       	mov    $0x43cd0,%edx
   4235c:	be 1e 00 00 00       	mov    $0x1e,%esi
   42361:	bf e9 3c 04 00       	mov    $0x43ce9,%edi
   42366:	e8 6c ff ff ff       	call   422d7 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4236b:	b8 03 00 00 00       	mov    $0x3,%eax
   42370:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42373:	89 c2                	mov    %eax,%edx
   42375:	89 d0                	mov    %edx,%eax
   42377:	c1 e0 03             	shl    $0x3,%eax
   4237a:	01 d0                	add    %edx,%eax
   4237c:	83 c0 0c             	add    $0xc,%eax
   4237f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42383:	89 c1                	mov    %eax,%ecx
   42385:	48 d3 ea             	shr    %cl,%rdx
   42388:	48 89 d0             	mov    %rdx,%rax
   4238b:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42390:	c9                   	leave  
   42391:	c3                   	ret    

0000000000042392 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42392:	55                   	push   %rbp
   42393:	48 89 e5             	mov    %rsp,%rbp
   42396:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4239a:	48 c7 05 5b ec 00 00 	movq   $0x52000,0xec5b(%rip)        # 51000 <kernel_pagetable>
   423a1:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   423a5:	ba 00 50 00 00       	mov    $0x5000,%edx
   423aa:	be 00 00 00 00       	mov    $0x0,%esi
   423af:	bf 00 20 05 00       	mov    $0x52000,%edi
   423b4:	e8 d8 09 00 00       	call   42d91 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   423b9:	b8 00 30 05 00       	mov    $0x53000,%eax
   423be:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   423c2:	48 89 05 37 fc 00 00 	mov    %rax,0xfc37(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   423c9:	b8 00 40 05 00       	mov    $0x54000,%eax
   423ce:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   423d2:	48 89 05 27 0c 01 00 	mov    %rax,0x10c27(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   423d9:	b8 00 50 05 00       	mov    $0x55000,%eax
   423de:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   423e2:	48 89 05 17 1c 01 00 	mov    %rax,0x11c17(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   423e9:	b8 00 60 05 00       	mov    $0x56000,%eax
   423ee:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   423f2:	48 89 05 0f 1c 01 00 	mov    %rax,0x11c0f(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   423f9:	48 8b 05 00 ec 00 00 	mov    0xec00(%rip),%rax        # 51000 <kernel_pagetable>
   42400:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42406:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4240b:	ba 00 00 00 00       	mov    $0x0,%edx
   42410:	be 00 00 00 00       	mov    $0x0,%esi
   42415:	48 89 c7             	mov    %rax,%rdi
   42418:	e8 b9 01 00 00       	call   425d6 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4241d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42424:	00 
   42425:	eb 62                	jmp    42489 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42427:	48 8b 0d d2 eb 00 00 	mov    0xebd2(%rip),%rcx        # 51000 <kernel_pagetable>
   4242e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42432:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42436:	48 89 ce             	mov    %rcx,%rsi
   42439:	48 89 c7             	mov    %rax,%rdi
   4243c:	e8 b7 04 00 00       	call   428f8 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42445:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42449:	74 14                	je     4245f <virtual_memory_init+0xcd>
   4244b:	ba f2 3c 04 00       	mov    $0x43cf2,%edx
   42450:	be 2d 00 00 00       	mov    $0x2d,%esi
   42455:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   4245a:	e8 78 fe ff ff       	call   422d7 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4245f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42462:	48 98                	cltq   
   42464:	83 e0 03             	and    $0x3,%eax
   42467:	48 83 f8 03          	cmp    $0x3,%rax
   4246b:	74 14                	je     42481 <virtual_memory_init+0xef>
   4246d:	ba 08 3d 04 00       	mov    $0x43d08,%edx
   42472:	be 2e 00 00 00       	mov    $0x2e,%esi
   42477:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   4247c:	e8 56 fe ff ff       	call   422d7 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42481:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42488:	00 
   42489:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42490:	00 
   42491:	76 94                	jbe    42427 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42493:	48 8b 05 66 eb 00 00 	mov    0xeb66(%rip),%rax        # 51000 <kernel_pagetable>
   4249a:	48 89 c7             	mov    %rax,%rdi
   4249d:	e8 03 00 00 00       	call   424a5 <set_pagetable>
}
   424a2:	90                   	nop
   424a3:	c9                   	leave  
   424a4:	c3                   	ret    

00000000000424a5 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   424a5:	55                   	push   %rbp
   424a6:	48 89 e5             	mov    %rsp,%rbp
   424a9:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   424ad:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   424b1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   424b5:	25 ff 0f 00 00       	and    $0xfff,%eax
   424ba:	48 85 c0             	test   %rax,%rax
   424bd:	74 14                	je     424d3 <set_pagetable+0x2e>
   424bf:	ba 35 3d 04 00       	mov    $0x43d35,%edx
   424c4:	be 3d 00 00 00       	mov    $0x3d,%esi
   424c9:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   424ce:	e8 04 fe ff ff       	call   422d7 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   424d3:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   424d8:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   424dc:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   424e0:	48 89 ce             	mov    %rcx,%rsi
   424e3:	48 89 c7             	mov    %rax,%rdi
   424e6:	e8 0d 04 00 00       	call   428f8 <virtual_memory_lookup>
   424eb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   424ef:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   424f4:	48 39 d0             	cmp    %rdx,%rax
   424f7:	74 14                	je     4250d <set_pagetable+0x68>
   424f9:	ba 50 3d 04 00       	mov    $0x43d50,%edx
   424fe:	be 3f 00 00 00       	mov    $0x3f,%esi
   42503:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42508:	e8 ca fd ff ff       	call   422d7 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4250d:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42511:	48 8b 0d e8 ea 00 00 	mov    0xeae8(%rip),%rcx        # 51000 <kernel_pagetable>
   42518:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4251c:	48 89 ce             	mov    %rcx,%rsi
   4251f:	48 89 c7             	mov    %rax,%rdi
   42522:	e8 d1 03 00 00       	call   428f8 <virtual_memory_lookup>
   42527:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4252b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4252f:	48 39 c2             	cmp    %rax,%rdx
   42532:	74 14                	je     42548 <set_pagetable+0xa3>
   42534:	ba b8 3d 04 00       	mov    $0x43db8,%edx
   42539:	be 41 00 00 00       	mov    $0x41,%esi
   4253e:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42543:	e8 8f fd ff ff       	call   422d7 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42548:	48 8b 05 b1 ea 00 00 	mov    0xeab1(%rip),%rax        # 51000 <kernel_pagetable>
   4254f:	48 89 c2             	mov    %rax,%rdx
   42552:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42556:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4255a:	48 89 ce             	mov    %rcx,%rsi
   4255d:	48 89 c7             	mov    %rax,%rdi
   42560:	e8 93 03 00 00       	call   428f8 <virtual_memory_lookup>
   42565:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42569:	48 8b 15 90 ea 00 00 	mov    0xea90(%rip),%rdx        # 51000 <kernel_pagetable>
   42570:	48 39 d0             	cmp    %rdx,%rax
   42573:	74 14                	je     42589 <set_pagetable+0xe4>
   42575:	ba 18 3e 04 00       	mov    $0x43e18,%edx
   4257a:	be 43 00 00 00       	mov    $0x43,%esi
   4257f:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42584:	e8 4e fd ff ff       	call   422d7 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42589:	ba d6 25 04 00       	mov    $0x425d6,%edx
   4258e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42592:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42596:	48 89 ce             	mov    %rcx,%rsi
   42599:	48 89 c7             	mov    %rax,%rdi
   4259c:	e8 57 03 00 00       	call   428f8 <virtual_memory_lookup>
   425a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425a5:	ba d6 25 04 00       	mov    $0x425d6,%edx
   425aa:	48 39 d0             	cmp    %rdx,%rax
   425ad:	74 14                	je     425c3 <set_pagetable+0x11e>
   425af:	ba 80 3e 04 00       	mov    $0x43e80,%edx
   425b4:	be 45 00 00 00       	mov    $0x45,%esi
   425b9:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   425be:	e8 14 fd ff ff       	call   422d7 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   425c3:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   425c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   425cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425cf:	0f 22 d8             	mov    %rax,%cr3
}
   425d2:	90                   	nop
}
   425d3:	90                   	nop
   425d4:	c9                   	leave  
   425d5:	c3                   	ret    

00000000000425d6 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   425d6:	55                   	push   %rbp
   425d7:	48 89 e5             	mov    %rsp,%rbp
   425da:	48 83 ec 50          	sub    $0x50,%rsp
   425de:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   425e2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   425e6:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   425ea:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   425ee:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   425f2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   425f6:	25 ff 0f 00 00       	and    $0xfff,%eax
   425fb:	48 85 c0             	test   %rax,%rax
   425fe:	74 14                	je     42614 <virtual_memory_map+0x3e>
   42600:	ba e6 3e 04 00       	mov    $0x43ee6,%edx
   42605:	be 66 00 00 00       	mov    $0x66,%esi
   4260a:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   4260f:	e8 c3 fc ff ff       	call   422d7 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42614:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42618:	25 ff 0f 00 00       	and    $0xfff,%eax
   4261d:	48 85 c0             	test   %rax,%rax
   42620:	74 14                	je     42636 <virtual_memory_map+0x60>
   42622:	ba f9 3e 04 00       	mov    $0x43ef9,%edx
   42627:	be 67 00 00 00       	mov    $0x67,%esi
   4262c:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42631:	e8 a1 fc ff ff       	call   422d7 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42636:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4263a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4263e:	48 01 d0             	add    %rdx,%rax
   42641:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42645:	76 24                	jbe    4266b <virtual_memory_map+0x95>
   42647:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4264b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4264f:	48 01 d0             	add    %rdx,%rax
   42652:	48 85 c0             	test   %rax,%rax
   42655:	74 14                	je     4266b <virtual_memory_map+0x95>
   42657:	ba 0c 3f 04 00       	mov    $0x43f0c,%edx
   4265c:	be 68 00 00 00       	mov    $0x68,%esi
   42661:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42666:	e8 6c fc ff ff       	call   422d7 <assert_fail>
    if (perm & PTE_P) {
   4266b:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4266e:	48 98                	cltq   
   42670:	83 e0 01             	and    $0x1,%eax
   42673:	48 85 c0             	test   %rax,%rax
   42676:	74 6e                	je     426e6 <virtual_memory_map+0x110>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42678:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4267c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42681:	48 85 c0             	test   %rax,%rax
   42684:	74 14                	je     4269a <virtual_memory_map+0xc4>
   42686:	ba 2a 3f 04 00       	mov    $0x43f2a,%edx
   4268b:	be 6a 00 00 00       	mov    $0x6a,%esi
   42690:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42695:	e8 3d fc ff ff       	call   422d7 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4269a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4269e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   426a2:	48 01 d0             	add    %rdx,%rax
   426a5:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   426a9:	76 14                	jbe    426bf <virtual_memory_map+0xe9>
   426ab:	ba 3d 3f 04 00       	mov    $0x43f3d,%edx
   426b0:	be 6b 00 00 00       	mov    $0x6b,%esi
   426b5:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   426ba:	e8 18 fc ff ff       	call   422d7 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   426bf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   426c3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   426c7:	48 01 d0             	add    %rdx,%rax
   426ca:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   426d0:	76 14                	jbe    426e6 <virtual_memory_map+0x110>
   426d2:	ba 4b 3f 04 00       	mov    $0x43f4b,%edx
   426d7:	be 6c 00 00 00       	mov    $0x6c,%esi
   426dc:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   426e1:	e8 f1 fb ff ff       	call   422d7 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   426e6:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   426ea:	78 09                	js     426f5 <virtual_memory_map+0x11f>
   426ec:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   426f3:	7e 14                	jle    42709 <virtual_memory_map+0x133>
   426f5:	ba 67 3f 04 00       	mov    $0x43f67,%edx
   426fa:	be 6e 00 00 00       	mov    $0x6e,%esi
   426ff:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42704:	e8 ce fb ff ff       	call   422d7 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42709:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4270d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42712:	48 85 c0             	test   %rax,%rax
   42715:	74 14                	je     4272b <virtual_memory_map+0x155>
   42717:	ba 88 3f 04 00       	mov    $0x43f88,%edx
   4271c:	be 6f 00 00 00       	mov    $0x6f,%esi
   42721:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   42726:	e8 ac fb ff ff       	call   422d7 <assert_fail>

    int last_index123 = -1;
   4272b:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42732:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   42739:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4273a:	eb 74                	jmp    427b0 <virtual_memory_map+0x1da>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4273c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42740:	48 c1 e8 15          	shr    $0x15,%rax
   42744:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   42747:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4274a:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   4274d:	74 06                	je     42755 <virtual_memory_map+0x17f>
            // TODO
            // find pointer to last level pagetable for current va



            last_index123 = cur_index123;
   4274f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42752:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42755:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42758:	48 98                	cltq   
   4275a:	83 e0 01             	and    $0x1,%eax
   4275d:	48 85 c0             	test   %rax,%rax
   42760:	74 07                	je     42769 <virtual_memory_map+0x193>
   42762:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42767:	75 2f                	jne    42798 <virtual_memory_map+0x1c2>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
        } else if (l1pagetable) { // if page is NOT marked present
   42769:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4276e:	75 28                	jne    42798 <virtual_memory_map+0x1c2>
            // TODO
            // map to address 0 with `perm`
        } else if (perm & PTE_P) {
   42770:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42773:	48 98                	cltq   
   42775:	83 e0 01             	and    $0x1,%eax
   42778:	48 85 c0             	test   %rax,%rax
   4277b:	74 1b                	je     42798 <virtual_memory_map+0x1c2>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   4277d:	be 87 00 00 00       	mov    $0x87,%esi
   42782:	bf b0 3f 04 00       	mov    $0x43fb0,%edi
   42787:	b8 00 00 00 00       	mov    $0x0,%eax
   4278c:	e8 28 f8 ff ff       	call   41fb9 <log_printf>
            return -1;
   42791:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42796:	eb 24                	jmp    427bc <virtual_memory_map+0x1e6>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42798:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   4279f:	00 
   427a0:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   427a7:	00 
   427a8:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   427af:	00 
   427b0:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   427b5:	75 85                	jne    4273c <virtual_memory_map+0x166>
        }
    }
    return 0;
   427b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   427bc:	c9                   	leave  
   427bd:	c3                   	ret    

00000000000427be <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   427be:	55                   	push   %rbp
   427bf:	48 89 e5             	mov    %rsp,%rbp
   427c2:	48 83 ec 40          	sub    $0x40,%rsp
   427c6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   427ca:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   427ce:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   427d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   427d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   427d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   427e0:	e9 03 01 00 00       	jmp    428e8 <lookup_l1pagetable+0x12a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = 0; // replace this
   427e5:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
   427ec:	00 

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   427ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   427f1:	83 e0 01             	and    $0x1,%eax
   427f4:	48 85 c0             	test   %rax,%rax
   427f7:	75 63                	jne    4285c <lookup_l1pagetable+0x9e>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   427f9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   427fc:	8d 48 02             	lea    0x2(%rax),%ecx
   427ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42803:	25 ff 0f 00 00       	and    $0xfff,%eax
   42808:	48 89 c2             	mov    %rax,%rdx
   4280b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4280f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42815:	48 89 c6             	mov    %rax,%rsi
   42818:	bf f0 3f 04 00       	mov    $0x43ff0,%edi
   4281d:	b8 00 00 00 00       	mov    $0x0,%eax
   42822:	e8 92 f7 ff ff       	call   41fb9 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42827:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4282a:	48 98                	cltq   
   4282c:	83 e0 01             	and    $0x1,%eax
   4282f:	48 85 c0             	test   %rax,%rax
   42832:	75 0a                	jne    4283e <lookup_l1pagetable+0x80>
                return NULL;
   42834:	b8 00 00 00 00       	mov    $0x0,%eax
   42839:	e9 b8 00 00 00       	jmp    428f6 <lookup_l1pagetable+0x138>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4283e:	be ab 00 00 00       	mov    $0xab,%esi
   42843:	bf 58 40 04 00       	mov    $0x44058,%edi
   42848:	b8 00 00 00 00       	mov    $0x0,%eax
   4284d:	e8 67 f7 ff ff       	call   41fb9 <log_printf>
            return NULL;
   42852:	b8 00 00 00 00       	mov    $0x0,%eax
   42857:	e9 9a 00 00 00       	jmp    428f6 <lookup_l1pagetable+0x138>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4285c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42860:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42866:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4286c:	76 14                	jbe    42882 <lookup_l1pagetable+0xc4>
   4286e:	ba 98 40 04 00       	mov    $0x44098,%edx
   42873:	be b0 00 00 00       	mov    $0xb0,%esi
   42878:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   4287d:	e8 55 fa ff ff       	call   422d7 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42882:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42885:	48 98                	cltq   
   42887:	83 e0 02             	and    $0x2,%eax
   4288a:	48 85 c0             	test   %rax,%rax
   4288d:	74 20                	je     428af <lookup_l1pagetable+0xf1>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4288f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42893:	83 e0 02             	and    $0x2,%eax
   42896:	48 85 c0             	test   %rax,%rax
   42899:	75 14                	jne    428af <lookup_l1pagetable+0xf1>
   4289b:	ba b8 40 04 00       	mov    $0x440b8,%edx
   428a0:	be b2 00 00 00       	mov    $0xb2,%esi
   428a5:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   428aa:	e8 28 fa ff ff       	call   422d7 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   428af:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428b2:	48 98                	cltq   
   428b4:	83 e0 04             	and    $0x4,%eax
   428b7:	48 85 c0             	test   %rax,%rax
   428ba:	74 20                	je     428dc <lookup_l1pagetable+0x11e>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   428bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428c0:	83 e0 04             	and    $0x4,%eax
   428c3:	48 85 c0             	test   %rax,%rax
   428c6:	75 14                	jne    428dc <lookup_l1pagetable+0x11e>
   428c8:	ba c3 40 04 00       	mov    $0x440c3,%edx
   428cd:	be b5 00 00 00       	mov    $0xb5,%esi
   428d2:	bf 02 3d 04 00       	mov    $0x43d02,%edi
   428d7:	e8 fb f9 ff ff       	call   422d7 <assert_fail>
        }

        // TODO
        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   428dc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   428e3:	00 
    for (int i = 0; i <= 2; ++i) {
   428e4:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   428e8:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   428ec:	0f 8e f3 fe ff ff    	jle    427e5 <lookup_l1pagetable+0x27>
    }
    return pt;
   428f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   428f6:	c9                   	leave  
   428f7:	c3                   	ret    

00000000000428f8 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   428f8:	55                   	push   %rbp
   428f9:	48 89 e5             	mov    %rsp,%rbp
   428fc:	48 83 ec 50          	sub    $0x50,%rsp
   42900:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42904:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42908:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4290c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42910:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42914:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4291b:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4291c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42923:	eb 41                	jmp    42966 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42925:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42928:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4292c:	89 d6                	mov    %edx,%esi
   4292e:	48 89 c7             	mov    %rax,%rdi
   42931:	e8 06 fa ff ff       	call   4233c <pageindex>
   42936:	89 c2                	mov    %eax,%edx
   42938:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4293c:	48 63 d2             	movslq %edx,%rdx
   4293f:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42943:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42947:	83 e0 06             	and    $0x6,%eax
   4294a:	48 f7 d0             	not    %rax
   4294d:	48 21 d0             	and    %rdx,%rax
   42950:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42954:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42958:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4295e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42962:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42966:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4296a:	7f 0c                	jg     42978 <virtual_memory_lookup+0x80>
   4296c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42970:	83 e0 01             	and    $0x1,%eax
   42973:	48 85 c0             	test   %rax,%rax
   42976:	75 ad                	jne    42925 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42978:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   4297f:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42986:	ff 
   42987:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4298e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42992:	83 e0 01             	and    $0x1,%eax
   42995:	48 85 c0             	test   %rax,%rax
   42998:	74 34                	je     429ce <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   4299a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4299e:	48 c1 e8 0c          	shr    $0xc,%rax
   429a2:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   429a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   429a9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   429af:	48 89 c2             	mov    %rax,%rdx
   429b2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   429b6:	25 ff 0f 00 00       	and    $0xfff,%eax
   429bb:	48 09 d0             	or     %rdx,%rax
   429be:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   429c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   429c6:	25 ff 0f 00 00       	and    $0xfff,%eax
   429cb:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   429ce:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429d2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   429d6:	48 89 10             	mov    %rdx,(%rax)
   429d9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   429dd:	48 89 50 08          	mov    %rdx,0x8(%rax)
   429e1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   429e5:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   429e9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429ed:	c9                   	leave  
   429ee:	c3                   	ret    

00000000000429ef <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   429ef:	55                   	push   %rbp
   429f0:	48 89 e5             	mov    %rsp,%rbp
   429f3:	48 83 ec 40          	sub    $0x40,%rsp
   429f7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   429fb:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   429fe:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42a02:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42a09:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42a0d:	78 08                	js     42a17 <program_load+0x28>
   42a0f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42a12:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42a15:	7c 14                	jl     42a2b <program_load+0x3c>
   42a17:	ba d0 40 04 00       	mov    $0x440d0,%edx
   42a1c:	be 37 00 00 00       	mov    $0x37,%esi
   42a21:	bf 00 41 04 00       	mov    $0x44100,%edi
   42a26:	e8 ac f8 ff ff       	call   422d7 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42a2b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42a2e:	48 98                	cltq   
   42a30:	48 c1 e0 04          	shl    $0x4,%rax
   42a34:	48 05 20 50 04 00    	add    $0x45020,%rax
   42a3a:	48 8b 00             	mov    (%rax),%rax
   42a3d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42a41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a45:	8b 00                	mov    (%rax),%eax
   42a47:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42a4c:	74 14                	je     42a62 <program_load+0x73>
   42a4e:	ba 0b 41 04 00       	mov    $0x4410b,%edx
   42a53:	be 39 00 00 00       	mov    $0x39,%esi
   42a58:	bf 00 41 04 00       	mov    $0x44100,%edi
   42a5d:	e8 75 f8 ff ff       	call   422d7 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42a62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a66:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42a6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a6e:	48 01 d0             	add    %rdx,%rax
   42a71:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42a75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42a7c:	e9 94 00 00 00       	jmp    42b15 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42a81:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42a84:	48 63 d0             	movslq %eax,%rdx
   42a87:	48 89 d0             	mov    %rdx,%rax
   42a8a:	48 c1 e0 03          	shl    $0x3,%rax
   42a8e:	48 29 d0             	sub    %rdx,%rax
   42a91:	48 c1 e0 03          	shl    $0x3,%rax
   42a95:	48 89 c2             	mov    %rax,%rdx
   42a98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a9c:	48 01 d0             	add    %rdx,%rax
   42a9f:	8b 00                	mov    (%rax),%eax
   42aa1:	83 f8 01             	cmp    $0x1,%eax
   42aa4:	75 6b                	jne    42b11 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42aa6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42aa9:	48 63 d0             	movslq %eax,%rdx
   42aac:	48 89 d0             	mov    %rdx,%rax
   42aaf:	48 c1 e0 03          	shl    $0x3,%rax
   42ab3:	48 29 d0             	sub    %rdx,%rax
   42ab6:	48 c1 e0 03          	shl    $0x3,%rax
   42aba:	48 89 c2             	mov    %rax,%rdx
   42abd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ac1:	48 01 d0             	add    %rdx,%rax
   42ac4:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42ac8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42acc:	48 01 d0             	add    %rdx,%rax
   42acf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42ad3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42ad6:	48 63 d0             	movslq %eax,%rdx
   42ad9:	48 89 d0             	mov    %rdx,%rax
   42adc:	48 c1 e0 03          	shl    $0x3,%rax
   42ae0:	48 29 d0             	sub    %rdx,%rax
   42ae3:	48 c1 e0 03          	shl    $0x3,%rax
   42ae7:	48 89 c2             	mov    %rax,%rdx
   42aea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42aee:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42af2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42af6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42afa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42afe:	48 89 c7             	mov    %rax,%rdi
   42b01:	e8 3d 00 00 00       	call   42b43 <program_load_segment>
   42b06:	85 c0                	test   %eax,%eax
   42b08:	79 07                	jns    42b11 <program_load+0x122>
                return -1;
   42b0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42b0f:	eb 30                	jmp    42b41 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42b11:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42b15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b19:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42b1d:	0f b7 c0             	movzwl %ax,%eax
   42b20:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42b23:	0f 8c 58 ff ff ff    	jl     42a81 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42b29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b2d:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42b31:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b35:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42b3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42b41:	c9                   	leave  
   42b42:	c3                   	ret    

0000000000042b43 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42b43:	55                   	push   %rbp
   42b44:	48 89 e5             	mov    %rsp,%rbp
   42b47:	48 83 ec 40          	sub    $0x40,%rsp
   42b4b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b4f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b53:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42b57:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42b5b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b5f:	48 8b 40 10          	mov    0x10(%rax),%rax
   42b63:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42b67:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b6b:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42b6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b73:	48 01 d0             	add    %rdx,%rax
   42b76:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42b7a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b7e:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42b82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b86:	48 01 d0             	add    %rdx,%rax
   42b89:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42b8d:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42b94:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42b95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b99:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42b9d:	eb 7c                	jmp    42c1b <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42b9f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ba3:	8b 00                	mov    (%rax),%eax
   42ba5:	0f be d0             	movsbl %al,%edx
   42ba8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bac:	89 d6                	mov    %edx,%esi
   42bae:	48 89 c7             	mov    %rax,%rdi
   42bb1:	e8 c2 d8 ff ff       	call   40478 <assign_physical_page>
   42bb6:	85 c0                	test   %eax,%eax
   42bb8:	78 2a                	js     42be4 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42bba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bbe:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42bc5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42bc9:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42bcd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42bd3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42bd8:	48 89 c7             	mov    %rax,%rdi
   42bdb:	e8 f6 f9 ff ff       	call   425d6 <virtual_memory_map>
   42be0:	85 c0                	test   %eax,%eax
   42be2:	79 2f                	jns    42c13 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42be4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42be8:	8b 00                	mov    (%rax),%eax
   42bea:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42bee:	49 89 d0             	mov    %rdx,%r8
   42bf1:	89 c1                	mov    %eax,%ecx
   42bf3:	ba 28 41 04 00       	mov    $0x44128,%edx
   42bf8:	be 00 c0 00 00       	mov    $0xc000,%esi
   42bfd:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42c02:	b8 00 00 00 00       	mov    $0x0,%eax
   42c07:	e8 ba 09 00 00       	call   435c6 <console_printf>
            return -1;
   42c0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c11:	eb 77                	jmp    42c8a <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42c13:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42c1a:	00 
   42c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c1f:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42c23:	0f 82 76 ff ff ff    	jb     42b9f <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42c29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c2d:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42c34:	48 89 c7             	mov    %rax,%rdi
   42c37:	e8 69 f8 ff ff       	call   424a5 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42c3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c40:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42c44:	48 89 c2             	mov    %rax,%rdx
   42c47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c4b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42c4f:	48 89 ce             	mov    %rcx,%rsi
   42c52:	48 89 c7             	mov    %rax,%rdi
   42c55:	e8 ce 00 00 00       	call   42d28 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42c5a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42c5e:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42c62:	48 89 c2             	mov    %rax,%rdx
   42c65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c69:	be 00 00 00 00       	mov    $0x0,%esi
   42c6e:	48 89 c7             	mov    %rax,%rdi
   42c71:	e8 1b 01 00 00       	call   42d91 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42c76:	48 8b 05 83 e3 00 00 	mov    0xe383(%rip),%rax        # 51000 <kernel_pagetable>
   42c7d:	48 89 c7             	mov    %rax,%rdi
   42c80:	e8 20 f8 ff ff       	call   424a5 <set_pagetable>
    return 0;
   42c85:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c8a:	c9                   	leave  
   42c8b:	c3                   	ret    

0000000000042c8c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   42c8c:	48 89 f9             	mov    %rdi,%rcx
   42c8f:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42c91:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   42c98:	00 
   42c99:	72 08                	jb     42ca3 <console_putc+0x17>
        cp->cursor = console;
   42c9b:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   42ca2:	00 
    }
    if (c == '\n') {
   42ca3:	40 80 fe 0a          	cmp    $0xa,%sil
   42ca7:	74 16                	je     42cbf <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   42ca9:	48 8b 41 08          	mov    0x8(%rcx),%rax
   42cad:	48 8d 50 02          	lea    0x2(%rax),%rdx
   42cb1:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   42cb5:	40 0f b6 f6          	movzbl %sil,%esi
   42cb9:	09 fe                	or     %edi,%esi
   42cbb:	66 89 30             	mov    %si,(%rax)
    }
}
   42cbe:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
   42cbf:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   42cc3:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   42cca:	4c 89 c6             	mov    %r8,%rsi
   42ccd:	48 d1 fe             	sar    %rsi
   42cd0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   42cd7:	66 66 66 
   42cda:	48 89 f0             	mov    %rsi,%rax
   42cdd:	48 f7 ea             	imul   %rdx
   42ce0:	48 c1 fa 05          	sar    $0x5,%rdx
   42ce4:	49 c1 f8 3f          	sar    $0x3f,%r8
   42ce8:	4c 29 c2             	sub    %r8,%rdx
   42ceb:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   42cef:	48 c1 e2 04          	shl    $0x4,%rdx
   42cf3:	89 f0                	mov    %esi,%eax
   42cf5:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   42cf7:	83 cf 20             	or     $0x20,%edi
   42cfa:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   42cfe:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   42d02:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   42d06:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   42d09:	83 c0 01             	add    $0x1,%eax
   42d0c:	83 f8 50             	cmp    $0x50,%eax
   42d0f:	75 e9                	jne    42cfa <console_putc+0x6e>
   42d11:	c3                   	ret    

0000000000042d12 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   42d12:	48 8b 47 08          	mov    0x8(%rdi),%rax
   42d16:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   42d1a:	73 0b                	jae    42d27 <string_putc+0x15>
        *sp->s++ = c;
   42d1c:	48 8d 50 01          	lea    0x1(%rax),%rdx
   42d20:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   42d24:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   42d27:	c3                   	ret    

0000000000042d28 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   42d28:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42d2b:	48 85 d2             	test   %rdx,%rdx
   42d2e:	74 17                	je     42d47 <memcpy+0x1f>
   42d30:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   42d35:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   42d3a:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42d3e:	48 83 c1 01          	add    $0x1,%rcx
   42d42:	48 39 d1             	cmp    %rdx,%rcx
   42d45:	75 ee                	jne    42d35 <memcpy+0xd>
}
   42d47:	c3                   	ret    

0000000000042d48 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   42d48:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   42d4b:	48 39 fe             	cmp    %rdi,%rsi
   42d4e:	72 1d                	jb     42d6d <memmove+0x25>
        while (n-- > 0) {
   42d50:	b9 00 00 00 00       	mov    $0x0,%ecx
   42d55:	48 85 d2             	test   %rdx,%rdx
   42d58:	74 12                	je     42d6c <memmove+0x24>
            *d++ = *s++;
   42d5a:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   42d5e:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   42d62:	48 83 c1 01          	add    $0x1,%rcx
   42d66:	48 39 ca             	cmp    %rcx,%rdx
   42d69:	75 ef                	jne    42d5a <memmove+0x12>
}
   42d6b:	c3                   	ret    
   42d6c:	c3                   	ret    
    if (s < d && s + n > d) {
   42d6d:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   42d71:	48 39 cf             	cmp    %rcx,%rdi
   42d74:	73 da                	jae    42d50 <memmove+0x8>
        while (n-- > 0) {
   42d76:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   42d7a:	48 85 d2             	test   %rdx,%rdx
   42d7d:	74 ec                	je     42d6b <memmove+0x23>
            *--d = *--s;
   42d7f:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   42d83:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   42d86:	48 83 e9 01          	sub    $0x1,%rcx
   42d8a:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   42d8e:	75 ef                	jne    42d7f <memmove+0x37>
   42d90:	c3                   	ret    

0000000000042d91 <memset>:
void* memset(void* v, int c, size_t n) {
   42d91:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42d94:	48 85 d2             	test   %rdx,%rdx
   42d97:	74 12                	je     42dab <memset+0x1a>
   42d99:	48 01 fa             	add    %rdi,%rdx
   42d9c:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   42d9f:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42da2:	48 83 c1 01          	add    $0x1,%rcx
   42da6:	48 39 ca             	cmp    %rcx,%rdx
   42da9:	75 f4                	jne    42d9f <memset+0xe>
}
   42dab:	c3                   	ret    

0000000000042dac <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   42dac:	80 3f 00             	cmpb   $0x0,(%rdi)
   42daf:	74 10                	je     42dc1 <strlen+0x15>
   42db1:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   42db6:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   42dba:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   42dbe:	75 f6                	jne    42db6 <strlen+0xa>
   42dc0:	c3                   	ret    
   42dc1:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42dc6:	c3                   	ret    

0000000000042dc7 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   42dc7:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42dca:	ba 00 00 00 00       	mov    $0x0,%edx
   42dcf:	48 85 f6             	test   %rsi,%rsi
   42dd2:	74 11                	je     42de5 <strnlen+0x1e>
   42dd4:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   42dd8:	74 0c                	je     42de6 <strnlen+0x1f>
        ++n;
   42dda:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42dde:	48 39 d0             	cmp    %rdx,%rax
   42de1:	75 f1                	jne    42dd4 <strnlen+0xd>
   42de3:	eb 04                	jmp    42de9 <strnlen+0x22>
   42de5:	c3                   	ret    
   42de6:	48 89 d0             	mov    %rdx,%rax
}
   42de9:	c3                   	ret    

0000000000042dea <strcpy>:
char* strcpy(char* dst, const char* src) {
   42dea:	48 89 f8             	mov    %rdi,%rax
   42ded:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   42df2:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   42df6:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   42df9:	48 83 c2 01          	add    $0x1,%rdx
   42dfd:	84 c9                	test   %cl,%cl
   42dff:	75 f1                	jne    42df2 <strcpy+0x8>
}
   42e01:	c3                   	ret    

0000000000042e02 <strcmp>:
    while (*a && *b && *a == *b) {
   42e02:	0f b6 07             	movzbl (%rdi),%eax
   42e05:	84 c0                	test   %al,%al
   42e07:	74 1a                	je     42e23 <strcmp+0x21>
   42e09:	0f b6 16             	movzbl (%rsi),%edx
   42e0c:	38 c2                	cmp    %al,%dl
   42e0e:	75 13                	jne    42e23 <strcmp+0x21>
   42e10:	84 d2                	test   %dl,%dl
   42e12:	74 0f                	je     42e23 <strcmp+0x21>
        ++a, ++b;
   42e14:	48 83 c7 01          	add    $0x1,%rdi
   42e18:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   42e1c:	0f b6 07             	movzbl (%rdi),%eax
   42e1f:	84 c0                	test   %al,%al
   42e21:	75 e6                	jne    42e09 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   42e23:	3a 06                	cmp    (%rsi),%al
   42e25:	0f 97 c0             	seta   %al
   42e28:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   42e2b:	83 d8 00             	sbb    $0x0,%eax
}
   42e2e:	c3                   	ret    

0000000000042e2f <strchr>:
    while (*s && *s != (char) c) {
   42e2f:	0f b6 07             	movzbl (%rdi),%eax
   42e32:	84 c0                	test   %al,%al
   42e34:	74 10                	je     42e46 <strchr+0x17>
   42e36:	40 38 f0             	cmp    %sil,%al
   42e39:	74 18                	je     42e53 <strchr+0x24>
        ++s;
   42e3b:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   42e3f:	0f b6 07             	movzbl (%rdi),%eax
   42e42:	84 c0                	test   %al,%al
   42e44:	75 f0                	jne    42e36 <strchr+0x7>
        return NULL;
   42e46:	40 84 f6             	test   %sil,%sil
   42e49:	b8 00 00 00 00       	mov    $0x0,%eax
   42e4e:	48 0f 44 c7          	cmove  %rdi,%rax
}
   42e52:	c3                   	ret    
   42e53:	48 89 f8             	mov    %rdi,%rax
   42e56:	c3                   	ret    

0000000000042e57 <rand>:
    if (!rand_seed_set) {
   42e57:	83 3d a6 41 01 00 00 	cmpl   $0x0,0x141a6(%rip)        # 57004 <rand_seed_set>
   42e5e:	74 1b                	je     42e7b <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   42e60:	69 05 96 41 01 00 0d 	imul   $0x19660d,0x14196(%rip),%eax        # 57000 <rand_seed>
   42e67:	66 19 00 
   42e6a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   42e6f:	89 05 8b 41 01 00    	mov    %eax,0x1418b(%rip)        # 57000 <rand_seed>
    return rand_seed & RAND_MAX;
   42e75:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   42e7a:	c3                   	ret    
    rand_seed = seed;
   42e7b:	c7 05 7b 41 01 00 9e 	movl   $0x30d4879e,0x1417b(%rip)        # 57000 <rand_seed>
   42e82:	87 d4 30 
    rand_seed_set = 1;
   42e85:	c7 05 75 41 01 00 01 	movl   $0x1,0x14175(%rip)        # 57004 <rand_seed_set>
   42e8c:	00 00 00 
}
   42e8f:	eb cf                	jmp    42e60 <rand+0x9>

0000000000042e91 <srand>:
    rand_seed = seed;
   42e91:	89 3d 69 41 01 00    	mov    %edi,0x14169(%rip)        # 57000 <rand_seed>
    rand_seed_set = 1;
   42e97:	c7 05 63 41 01 00 01 	movl   $0x1,0x14163(%rip)        # 57004 <rand_seed_set>
   42e9e:	00 00 00 
}
   42ea1:	c3                   	ret    

0000000000042ea2 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   42ea2:	55                   	push   %rbp
   42ea3:	48 89 e5             	mov    %rsp,%rbp
   42ea6:	41 57                	push   %r15
   42ea8:	41 56                	push   %r14
   42eaa:	41 55                	push   %r13
   42eac:	41 54                	push   %r12
   42eae:	53                   	push   %rbx
   42eaf:	48 83 ec 58          	sub    $0x58,%rsp
   42eb3:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   42eb7:	0f b6 02             	movzbl (%rdx),%eax
   42eba:	84 c0                	test   %al,%al
   42ebc:	0f 84 b0 06 00 00    	je     43572 <printer_vprintf+0x6d0>
   42ec2:	49 89 fe             	mov    %rdi,%r14
   42ec5:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   42ec8:	41 89 f7             	mov    %esi,%r15d
   42ecb:	e9 a4 04 00 00       	jmp    43374 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   42ed0:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   42ed5:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   42edb:	45 84 e4             	test   %r12b,%r12b
   42ede:	0f 84 82 06 00 00    	je     43566 <printer_vprintf+0x6c4>
        int flags = 0;
   42ee4:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   42eea:	41 0f be f4          	movsbl %r12b,%esi
   42eee:	bf 61 43 04 00       	mov    $0x44361,%edi
   42ef3:	e8 37 ff ff ff       	call   42e2f <strchr>
   42ef8:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   42efb:	48 85 c0             	test   %rax,%rax
   42efe:	74 55                	je     42f55 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   42f00:	48 81 e9 61 43 04 00 	sub    $0x44361,%rcx
   42f07:	b8 01 00 00 00       	mov    $0x1,%eax
   42f0c:	d3 e0                	shl    %cl,%eax
   42f0e:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   42f11:	48 83 c3 01          	add    $0x1,%rbx
   42f15:	44 0f b6 23          	movzbl (%rbx),%r12d
   42f19:	45 84 e4             	test   %r12b,%r12b
   42f1c:	75 cc                	jne    42eea <printer_vprintf+0x48>
   42f1e:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   42f22:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   42f28:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   42f2f:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   42f32:	0f 84 a9 00 00 00    	je     42fe1 <printer_vprintf+0x13f>
        int length = 0;
   42f38:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   42f3d:	0f b6 13             	movzbl (%rbx),%edx
   42f40:	8d 42 bd             	lea    -0x43(%rdx),%eax
   42f43:	3c 37                	cmp    $0x37,%al
   42f45:	0f 87 c4 04 00 00    	ja     4340f <printer_vprintf+0x56d>
   42f4b:	0f b6 c0             	movzbl %al,%eax
   42f4e:	ff 24 c5 70 41 04 00 	jmp    *0x44170(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   42f55:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   42f59:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   42f5e:	3c 08                	cmp    $0x8,%al
   42f60:	77 2f                	ja     42f91 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   42f62:	0f b6 03             	movzbl (%rbx),%eax
   42f65:	8d 50 d0             	lea    -0x30(%rax),%edx
   42f68:	80 fa 09             	cmp    $0x9,%dl
   42f6b:	77 5e                	ja     42fcb <printer_vprintf+0x129>
   42f6d:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   42f73:	48 83 c3 01          	add    $0x1,%rbx
   42f77:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   42f7c:	0f be c0             	movsbl %al,%eax
   42f7f:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   42f84:	0f b6 03             	movzbl (%rbx),%eax
   42f87:	8d 50 d0             	lea    -0x30(%rax),%edx
   42f8a:	80 fa 09             	cmp    $0x9,%dl
   42f8d:	76 e4                	jbe    42f73 <printer_vprintf+0xd1>
   42f8f:	eb 97                	jmp    42f28 <printer_vprintf+0x86>
        } else if (*format == '*') {
   42f91:	41 80 fc 2a          	cmp    $0x2a,%r12b
   42f95:	75 3f                	jne    42fd6 <printer_vprintf+0x134>
            width = va_arg(val, int);
   42f97:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42f9b:	8b 07                	mov    (%rdi),%eax
   42f9d:	83 f8 2f             	cmp    $0x2f,%eax
   42fa0:	77 17                	ja     42fb9 <printer_vprintf+0x117>
   42fa2:	89 c2                	mov    %eax,%edx
   42fa4:	48 03 57 10          	add    0x10(%rdi),%rdx
   42fa8:	83 c0 08             	add    $0x8,%eax
   42fab:	89 07                	mov    %eax,(%rdi)
   42fad:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   42fb0:	48 83 c3 01          	add    $0x1,%rbx
   42fb4:	e9 6f ff ff ff       	jmp    42f28 <printer_vprintf+0x86>
            width = va_arg(val, int);
   42fb9:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42fbd:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   42fc1:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42fc5:	48 89 41 08          	mov    %rax,0x8(%rcx)
   42fc9:	eb e2                	jmp    42fad <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   42fcb:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   42fd1:	e9 52 ff ff ff       	jmp    42f28 <printer_vprintf+0x86>
        int width = -1;
   42fd6:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   42fdc:	e9 47 ff ff ff       	jmp    42f28 <printer_vprintf+0x86>
            ++format;
   42fe1:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   42fe5:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   42fe9:	8d 48 d0             	lea    -0x30(%rax),%ecx
   42fec:	80 f9 09             	cmp    $0x9,%cl
   42fef:	76 13                	jbe    43004 <printer_vprintf+0x162>
            } else if (*format == '*') {
   42ff1:	3c 2a                	cmp    $0x2a,%al
   42ff3:	74 33                	je     43028 <printer_vprintf+0x186>
            ++format;
   42ff5:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   42ff8:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   42fff:	e9 34 ff ff ff       	jmp    42f38 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43004:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   43009:	48 83 c2 01          	add    $0x1,%rdx
   4300d:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   43010:	0f be c0             	movsbl %al,%eax
   43013:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43017:	0f b6 02             	movzbl (%rdx),%eax
   4301a:	8d 70 d0             	lea    -0x30(%rax),%esi
   4301d:	40 80 fe 09          	cmp    $0x9,%sil
   43021:	76 e6                	jbe    43009 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   43023:	48 89 d3             	mov    %rdx,%rbx
   43026:	eb 1c                	jmp    43044 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   43028:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4302c:	8b 07                	mov    (%rdi),%eax
   4302e:	83 f8 2f             	cmp    $0x2f,%eax
   43031:	77 23                	ja     43056 <printer_vprintf+0x1b4>
   43033:	89 c2                	mov    %eax,%edx
   43035:	48 03 57 10          	add    0x10(%rdi),%rdx
   43039:	83 c0 08             	add    $0x8,%eax
   4303c:	89 07                	mov    %eax,(%rdi)
   4303e:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43040:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   43044:	85 c9                	test   %ecx,%ecx
   43046:	b8 00 00 00 00       	mov    $0x0,%eax
   4304b:	0f 49 c1             	cmovns %ecx,%eax
   4304e:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43051:	e9 e2 fe ff ff       	jmp    42f38 <printer_vprintf+0x96>
                precision = va_arg(val, int);
   43056:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4305a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4305e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43062:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43066:	eb d6                	jmp    4303e <printer_vprintf+0x19c>
        switch (*format) {
   43068:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   4306d:	e9 f3 00 00 00       	jmp    43165 <printer_vprintf+0x2c3>
            ++format;
   43072:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   43076:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   4307b:	e9 bd fe ff ff       	jmp    42f3d <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43080:	85 c9                	test   %ecx,%ecx
   43082:	74 55                	je     430d9 <printer_vprintf+0x237>
   43084:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43088:	8b 07                	mov    (%rdi),%eax
   4308a:	83 f8 2f             	cmp    $0x2f,%eax
   4308d:	77 38                	ja     430c7 <printer_vprintf+0x225>
   4308f:	89 c2                	mov    %eax,%edx
   43091:	48 03 57 10          	add    0x10(%rdi),%rdx
   43095:	83 c0 08             	add    $0x8,%eax
   43098:	89 07                	mov    %eax,(%rdi)
   4309a:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4309d:	48 89 d0             	mov    %rdx,%rax
   430a0:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   430a4:	49 89 d0             	mov    %rdx,%r8
   430a7:	49 f7 d8             	neg    %r8
   430aa:	25 80 00 00 00       	and    $0x80,%eax
   430af:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   430b3:	0b 45 a8             	or     -0x58(%rbp),%eax
   430b6:	83 c8 60             	or     $0x60,%eax
   430b9:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   430bc:	41 bc 67 41 04 00    	mov    $0x44167,%r12d
            break;
   430c2:	e9 35 01 00 00       	jmp    431fc <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   430c7:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   430cb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   430cf:	48 8d 42 08          	lea    0x8(%rdx),%rax
   430d3:	48 89 41 08          	mov    %rax,0x8(%rcx)
   430d7:	eb c1                	jmp    4309a <printer_vprintf+0x1f8>
   430d9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   430dd:	8b 07                	mov    (%rdi),%eax
   430df:	83 f8 2f             	cmp    $0x2f,%eax
   430e2:	77 10                	ja     430f4 <printer_vprintf+0x252>
   430e4:	89 c2                	mov    %eax,%edx
   430e6:	48 03 57 10          	add    0x10(%rdi),%rdx
   430ea:	83 c0 08             	add    $0x8,%eax
   430ed:	89 07                	mov    %eax,(%rdi)
   430ef:	48 63 12             	movslq (%rdx),%rdx
   430f2:	eb a9                	jmp    4309d <printer_vprintf+0x1fb>
   430f4:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   430f8:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   430fc:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43100:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43104:	eb e9                	jmp    430ef <printer_vprintf+0x24d>
        int base = 10;
   43106:	be 0a 00 00 00       	mov    $0xa,%esi
   4310b:	eb 58                	jmp    43165 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4310d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43111:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43115:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43119:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4311d:	eb 60                	jmp    4317f <printer_vprintf+0x2dd>
   4311f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43123:	8b 07                	mov    (%rdi),%eax
   43125:	83 f8 2f             	cmp    $0x2f,%eax
   43128:	77 10                	ja     4313a <printer_vprintf+0x298>
   4312a:	89 c2                	mov    %eax,%edx
   4312c:	48 03 57 10          	add    0x10(%rdi),%rdx
   43130:	83 c0 08             	add    $0x8,%eax
   43133:	89 07                	mov    %eax,(%rdi)
   43135:	44 8b 02             	mov    (%rdx),%r8d
   43138:	eb 48                	jmp    43182 <printer_vprintf+0x2e0>
   4313a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4313e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43142:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43146:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4314a:	eb e9                	jmp    43135 <printer_vprintf+0x293>
   4314c:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   4314f:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   43156:	bf 50 43 04 00       	mov    $0x44350,%edi
   4315b:	e9 e2 02 00 00       	jmp    43442 <printer_vprintf+0x5a0>
            base = 16;
   43160:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43165:	85 c9                	test   %ecx,%ecx
   43167:	74 b6                	je     4311f <printer_vprintf+0x27d>
   43169:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4316d:	8b 01                	mov    (%rcx),%eax
   4316f:	83 f8 2f             	cmp    $0x2f,%eax
   43172:	77 99                	ja     4310d <printer_vprintf+0x26b>
   43174:	89 c2                	mov    %eax,%edx
   43176:	48 03 51 10          	add    0x10(%rcx),%rdx
   4317a:	83 c0 08             	add    $0x8,%eax
   4317d:	89 01                	mov    %eax,(%rcx)
   4317f:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43182:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43186:	85 f6                	test   %esi,%esi
   43188:	79 c2                	jns    4314c <printer_vprintf+0x2aa>
        base = -base;
   4318a:	41 89 f1             	mov    %esi,%r9d
   4318d:	f7 de                	neg    %esi
   4318f:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43196:	bf 30 43 04 00       	mov    $0x44330,%edi
   4319b:	e9 a2 02 00 00       	jmp    43442 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   431a0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   431a4:	8b 07                	mov    (%rdi),%eax
   431a6:	83 f8 2f             	cmp    $0x2f,%eax
   431a9:	77 1c                	ja     431c7 <printer_vprintf+0x325>
   431ab:	89 c2                	mov    %eax,%edx
   431ad:	48 03 57 10          	add    0x10(%rdi),%rdx
   431b1:	83 c0 08             	add    $0x8,%eax
   431b4:	89 07                	mov    %eax,(%rdi)
   431b6:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   431b9:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   431c0:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   431c5:	eb c3                	jmp    4318a <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   431c7:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   431cb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   431cf:	48 8d 42 08          	lea    0x8(%rdx),%rax
   431d3:	48 89 41 08          	mov    %rax,0x8(%rcx)
   431d7:	eb dd                	jmp    431b6 <printer_vprintf+0x314>
            data = va_arg(val, char*);
   431d9:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   431dd:	8b 01                	mov    (%rcx),%eax
   431df:	83 f8 2f             	cmp    $0x2f,%eax
   431e2:	0f 87 a5 01 00 00    	ja     4338d <printer_vprintf+0x4eb>
   431e8:	89 c2                	mov    %eax,%edx
   431ea:	48 03 51 10          	add    0x10(%rcx),%rdx
   431ee:	83 c0 08             	add    $0x8,%eax
   431f1:	89 01                	mov    %eax,(%rcx)
   431f3:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   431f6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   431fc:	8b 45 a8             	mov    -0x58(%rbp),%eax
   431ff:	83 e0 20             	and    $0x20,%eax
   43202:	89 45 8c             	mov    %eax,-0x74(%rbp)
   43205:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   4320b:	0f 85 21 02 00 00    	jne    43432 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43211:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43214:	89 45 88             	mov    %eax,-0x78(%rbp)
   43217:	83 e0 60             	and    $0x60,%eax
   4321a:	83 f8 60             	cmp    $0x60,%eax
   4321d:	0f 84 54 02 00 00    	je     43477 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43223:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43226:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43229:	48 c7 45 a0 67 41 04 	movq   $0x44167,-0x60(%rbp)
   43230:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43231:	83 f8 21             	cmp    $0x21,%eax
   43234:	0f 84 79 02 00 00    	je     434b3 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   4323a:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   4323d:	89 f8                	mov    %edi,%eax
   4323f:	f7 d0                	not    %eax
   43241:	c1 e8 1f             	shr    $0x1f,%eax
   43244:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43247:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   4324b:	0f 85 9e 02 00 00    	jne    434ef <printer_vprintf+0x64d>
   43251:	84 c0                	test   %al,%al
   43253:	0f 84 96 02 00 00    	je     434ef <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   43259:	48 63 f7             	movslq %edi,%rsi
   4325c:	4c 89 e7             	mov    %r12,%rdi
   4325f:	e8 63 fb ff ff       	call   42dc7 <strnlen>
   43264:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43267:	8b 45 88             	mov    -0x78(%rbp),%eax
   4326a:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   4326d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43274:	83 f8 22             	cmp    $0x22,%eax
   43277:	0f 84 aa 02 00 00    	je     43527 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   4327d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43281:	e8 26 fb ff ff       	call   42dac <strlen>
   43286:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43289:	03 55 98             	add    -0x68(%rbp),%edx
   4328c:	44 89 e9             	mov    %r13d,%ecx
   4328f:	29 d1                	sub    %edx,%ecx
   43291:	29 c1                	sub    %eax,%ecx
   43293:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   43296:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43299:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   4329d:	75 2d                	jne    432cc <printer_vprintf+0x42a>
   4329f:	85 c9                	test   %ecx,%ecx
   432a1:	7e 29                	jle    432cc <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   432a3:	44 89 fa             	mov    %r15d,%edx
   432a6:	be 20 00 00 00       	mov    $0x20,%esi
   432ab:	4c 89 f7             	mov    %r14,%rdi
   432ae:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   432b1:	41 83 ed 01          	sub    $0x1,%r13d
   432b5:	45 85 ed             	test   %r13d,%r13d
   432b8:	7f e9                	jg     432a3 <printer_vprintf+0x401>
   432ba:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   432bd:	85 ff                	test   %edi,%edi
   432bf:	b8 01 00 00 00       	mov    $0x1,%eax
   432c4:	0f 4f c7             	cmovg  %edi,%eax
   432c7:	29 c7                	sub    %eax,%edi
   432c9:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   432cc:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   432d0:	0f b6 07             	movzbl (%rdi),%eax
   432d3:	84 c0                	test   %al,%al
   432d5:	74 22                	je     432f9 <printer_vprintf+0x457>
   432d7:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   432db:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   432de:	0f b6 f0             	movzbl %al,%esi
   432e1:	44 89 fa             	mov    %r15d,%edx
   432e4:	4c 89 f7             	mov    %r14,%rdi
   432e7:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
   432ea:	48 83 c3 01          	add    $0x1,%rbx
   432ee:	0f b6 03             	movzbl (%rbx),%eax
   432f1:	84 c0                	test   %al,%al
   432f3:	75 e9                	jne    432de <printer_vprintf+0x43c>
   432f5:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   432f9:	8b 45 9c             	mov    -0x64(%rbp),%eax
   432fc:	85 c0                	test   %eax,%eax
   432fe:	7e 1d                	jle    4331d <printer_vprintf+0x47b>
   43300:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43304:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   43306:	44 89 fa             	mov    %r15d,%edx
   43309:	be 30 00 00 00       	mov    $0x30,%esi
   4330e:	4c 89 f7             	mov    %r14,%rdi
   43311:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
   43314:	83 eb 01             	sub    $0x1,%ebx
   43317:	75 ed                	jne    43306 <printer_vprintf+0x464>
   43319:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   4331d:	8b 45 98             	mov    -0x68(%rbp),%eax
   43320:	85 c0                	test   %eax,%eax
   43322:	7e 27                	jle    4334b <printer_vprintf+0x4a9>
   43324:	89 c0                	mov    %eax,%eax
   43326:	4c 01 e0             	add    %r12,%rax
   43329:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4332d:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43330:	41 0f b6 34 24       	movzbl (%r12),%esi
   43335:	44 89 fa             	mov    %r15d,%edx
   43338:	4c 89 f7             	mov    %r14,%rdi
   4333b:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
   4333e:	49 83 c4 01          	add    $0x1,%r12
   43342:	49 39 dc             	cmp    %rbx,%r12
   43345:	75 e9                	jne    43330 <printer_vprintf+0x48e>
   43347:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   4334b:	45 85 ed             	test   %r13d,%r13d
   4334e:	7e 14                	jle    43364 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43350:	44 89 fa             	mov    %r15d,%edx
   43353:	be 20 00 00 00       	mov    $0x20,%esi
   43358:	4c 89 f7             	mov    %r14,%rdi
   4335b:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
   4335e:	41 83 ed 01          	sub    $0x1,%r13d
   43362:	75 ec                	jne    43350 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   43364:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43368:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   4336c:	84 c0                	test   %al,%al
   4336e:	0f 84 fe 01 00 00    	je     43572 <printer_vprintf+0x6d0>
        if (*format != '%') {
   43374:	3c 25                	cmp    $0x25,%al
   43376:	0f 84 54 fb ff ff    	je     42ed0 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   4337c:	0f b6 f0             	movzbl %al,%esi
   4337f:	44 89 fa             	mov    %r15d,%edx
   43382:	4c 89 f7             	mov    %r14,%rdi
   43385:	41 ff 16             	call   *(%r14)
            continue;
   43388:	4c 89 e3             	mov    %r12,%rbx
   4338b:	eb d7                	jmp    43364 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   4338d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43391:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43395:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43399:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4339d:	e9 51 fe ff ff       	jmp    431f3 <printer_vprintf+0x351>
            color = va_arg(val, int);
   433a2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   433a6:	8b 07                	mov    (%rdi),%eax
   433a8:	83 f8 2f             	cmp    $0x2f,%eax
   433ab:	77 10                	ja     433bd <printer_vprintf+0x51b>
   433ad:	89 c2                	mov    %eax,%edx
   433af:	48 03 57 10          	add    0x10(%rdi),%rdx
   433b3:	83 c0 08             	add    $0x8,%eax
   433b6:	89 07                	mov    %eax,(%rdi)
   433b8:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   433bb:	eb a7                	jmp    43364 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   433bd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   433c1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   433c5:	48 8d 42 08          	lea    0x8(%rdx),%rax
   433c9:	48 89 41 08          	mov    %rax,0x8(%rcx)
   433cd:	eb e9                	jmp    433b8 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   433cf:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   433d3:	8b 01                	mov    (%rcx),%eax
   433d5:	83 f8 2f             	cmp    $0x2f,%eax
   433d8:	77 23                	ja     433fd <printer_vprintf+0x55b>
   433da:	89 c2                	mov    %eax,%edx
   433dc:	48 03 51 10          	add    0x10(%rcx),%rdx
   433e0:	83 c0 08             	add    $0x8,%eax
   433e3:	89 01                	mov    %eax,(%rcx)
   433e5:	8b 02                	mov    (%rdx),%eax
   433e7:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   433ea:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   433ee:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   433f2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   433f8:	e9 ff fd ff ff       	jmp    431fc <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   433fd:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43401:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43405:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43409:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4340d:	eb d6                	jmp    433e5 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   4340f:	84 d2                	test   %dl,%dl
   43411:	0f 85 39 01 00 00    	jne    43550 <printer_vprintf+0x6ae>
   43417:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   4341b:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   4341f:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   43423:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43427:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4342d:	e9 ca fd ff ff       	jmp    431fc <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   43432:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   43438:	bf 50 43 04 00       	mov    $0x44350,%edi
        if (flags & FLAG_NUMERIC) {
   4343d:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   43442:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   43446:	4c 89 c1             	mov    %r8,%rcx
   43449:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   4344d:	48 63 f6             	movslq %esi,%rsi
   43450:	49 83 ec 01          	sub    $0x1,%r12
   43454:	48 89 c8             	mov    %rcx,%rax
   43457:	ba 00 00 00 00       	mov    $0x0,%edx
   4345c:	48 f7 f6             	div    %rsi
   4345f:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   43463:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   43467:	48 89 ca             	mov    %rcx,%rdx
   4346a:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   4346d:	48 39 d6             	cmp    %rdx,%rsi
   43470:	76 de                	jbe    43450 <printer_vprintf+0x5ae>
   43472:	e9 9a fd ff ff       	jmp    43211 <printer_vprintf+0x36f>
                prefix = "-";
   43477:	48 c7 45 a0 64 41 04 	movq   $0x44164,-0x60(%rbp)
   4347e:	00 
            if (flags & FLAG_NEGATIVE) {
   4347f:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43482:	a8 80                	test   $0x80,%al
   43484:	0f 85 b0 fd ff ff    	jne    4323a <printer_vprintf+0x398>
                prefix = "+";
   4348a:	48 c7 45 a0 5f 41 04 	movq   $0x4415f,-0x60(%rbp)
   43491:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43492:	a8 10                	test   $0x10,%al
   43494:	0f 85 a0 fd ff ff    	jne    4323a <printer_vprintf+0x398>
                prefix = " ";
   4349a:	a8 08                	test   $0x8,%al
   4349c:	ba 67 41 04 00       	mov    $0x44167,%edx
   434a1:	b8 66 41 04 00       	mov    $0x44166,%eax
   434a6:	48 0f 44 c2          	cmove  %rdx,%rax
   434aa:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   434ae:	e9 87 fd ff ff       	jmp    4323a <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   434b3:	41 8d 41 10          	lea    0x10(%r9),%eax
   434b7:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   434bc:	0f 85 78 fd ff ff    	jne    4323a <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   434c2:	4d 85 c0             	test   %r8,%r8
   434c5:	75 0d                	jne    434d4 <printer_vprintf+0x632>
   434c7:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   434ce:	0f 84 66 fd ff ff    	je     4323a <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   434d4:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   434d8:	ba 68 41 04 00       	mov    $0x44168,%edx
   434dd:	b8 61 41 04 00       	mov    $0x44161,%eax
   434e2:	48 0f 44 c2          	cmove  %rdx,%rax
   434e6:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   434ea:	e9 4b fd ff ff       	jmp    4323a <printer_vprintf+0x398>
            len = strlen(data);
   434ef:	4c 89 e7             	mov    %r12,%rdi
   434f2:	e8 b5 f8 ff ff       	call   42dac <strlen>
   434f7:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   434fa:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   434fe:	0f 84 63 fd ff ff    	je     43267 <printer_vprintf+0x3c5>
   43504:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43508:	0f 84 59 fd ff ff    	je     43267 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   4350e:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   43511:	89 ca                	mov    %ecx,%edx
   43513:	29 c2                	sub    %eax,%edx
   43515:	39 c1                	cmp    %eax,%ecx
   43517:	b8 00 00 00 00       	mov    $0x0,%eax
   4351c:	0f 4e d0             	cmovle %eax,%edx
   4351f:	89 55 9c             	mov    %edx,-0x64(%rbp)
   43522:	e9 56 fd ff ff       	jmp    4327d <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   43527:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   4352b:	e8 7c f8 ff ff       	call   42dac <strlen>
   43530:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43533:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43536:	44 89 e9             	mov    %r13d,%ecx
   43539:	29 f9                	sub    %edi,%ecx
   4353b:	29 c1                	sub    %eax,%ecx
   4353d:	44 39 ea             	cmp    %r13d,%edx
   43540:	b8 00 00 00 00       	mov    $0x0,%eax
   43545:	0f 4d c8             	cmovge %eax,%ecx
   43548:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   4354b:	e9 2d fd ff ff       	jmp    4327d <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43550:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43553:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43557:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4355b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43561:	e9 96 fc ff ff       	jmp    431fc <printer_vprintf+0x35a>
        int flags = 0;
   43566:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   4356d:	e9 b0 f9 ff ff       	jmp    42f22 <printer_vprintf+0x80>
}
   43572:	48 83 c4 58          	add    $0x58,%rsp
   43576:	5b                   	pop    %rbx
   43577:	41 5c                	pop    %r12
   43579:	41 5d                	pop    %r13
   4357b:	41 5e                	pop    %r14
   4357d:	41 5f                	pop    %r15
   4357f:	5d                   	pop    %rbp
   43580:	c3                   	ret    

0000000000043581 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43581:	55                   	push   %rbp
   43582:	48 89 e5             	mov    %rsp,%rbp
   43585:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   43589:	48 c7 45 f0 8c 2c 04 	movq   $0x42c8c,-0x10(%rbp)
   43590:	00 
        cpos = 0;
   43591:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   43597:	b8 00 00 00 00       	mov    $0x0,%eax
   4359c:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   4359f:	48 63 ff             	movslq %edi,%rdi
   435a2:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   435a9:	00 
   435aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   435ae:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   435b2:	e8 eb f8 ff ff       	call   42ea2 <printer_vprintf>
    return cp.cursor - console;
   435b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435bb:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   435c1:	48 d1 f8             	sar    %rax
}
   435c4:	c9                   	leave  
   435c5:	c3                   	ret    

00000000000435c6 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   435c6:	55                   	push   %rbp
   435c7:	48 89 e5             	mov    %rsp,%rbp
   435ca:	48 83 ec 50          	sub    $0x50,%rsp
   435ce:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   435d2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   435d6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   435da:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   435e1:	48 8d 45 10          	lea    0x10(%rbp),%rax
   435e5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   435e9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   435ed:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   435f1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   435f5:	e8 87 ff ff ff       	call   43581 <console_vprintf>
}
   435fa:	c9                   	leave  
   435fb:	c3                   	ret    

00000000000435fc <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   435fc:	55                   	push   %rbp
   435fd:	48 89 e5             	mov    %rsp,%rbp
   43600:	53                   	push   %rbx
   43601:	48 83 ec 28          	sub    $0x28,%rsp
   43605:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   43608:	48 c7 45 d8 12 2d 04 	movq   $0x42d12,-0x28(%rbp)
   4360f:	00 
    sp.s = s;
   43610:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   43614:	48 85 f6             	test   %rsi,%rsi
   43617:	75 0b                	jne    43624 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   43619:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4361c:	29 d8                	sub    %ebx,%eax
}
   4361e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43622:	c9                   	leave  
   43623:	c3                   	ret    
        sp.end = s + size - 1;
   43624:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43629:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4362d:	be 00 00 00 00       	mov    $0x0,%esi
   43632:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43636:	e8 67 f8 ff ff       	call   42ea2 <printer_vprintf>
        *sp.s = 0;
   4363b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4363f:	c6 00 00             	movb   $0x0,(%rax)
   43642:	eb d5                	jmp    43619 <vsnprintf+0x1d>

0000000000043644 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43644:	55                   	push   %rbp
   43645:	48 89 e5             	mov    %rsp,%rbp
   43648:	48 83 ec 50          	sub    $0x50,%rsp
   4364c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43650:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43654:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43658:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4365f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43663:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43667:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4366b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   4366f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43673:	e8 84 ff ff ff       	call   435fc <vsnprintf>
    va_end(val);
    return n;
}
   43678:	c9                   	leave  
   43679:	c3                   	ret    

000000000004367a <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4367a:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4367f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   43684:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43689:	48 83 c0 02          	add    $0x2,%rax
   4368d:	48 39 d0             	cmp    %rdx,%rax
   43690:	75 f2                	jne    43684 <console_clear+0xa>
    }
    cursorpos = 0;
   43692:	c7 05 60 59 07 00 00 	movl   $0x0,0x75960(%rip)        # b8ffc <cursorpos>
   43699:	00 00 00 
}
   4369c:	c3                   	ret    
