
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
   400be:	e8 47 07 00 00       	call   4080a <exception>

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

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 cb 15 00 00       	call   41743 <hardware_init>
    pageinfo_init();
   40178:	e8 4f 0c 00 00       	call   40dcc <pageinfo_init>
    console_clear();
   4017d:	e8 77 3a 00 00       	call   43bf9 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 a7 1a 00 00       	call   41c33 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 10 05 00       	mov    $0x51000,%edi
   4019b:	e8 70 31 00 00       	call   43310 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 10 05 00 	lea    0x51000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be 86 47 04 00       	mov    $0x44786,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 76 31 00 00       	call   43381 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be 8d 47 04 00       	mov    $0x4478d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 46 31 00 00       	call   43381 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be 98 47 04 00       	mov    $0x44798,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 19 31 00 00       	call   43381 <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 6);
   4026c:	be 06 00 00 00       	mov    $0x6,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be 9d 47 04 00       	mov    $0x4479d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 ec 30 00 00       	call   43381 <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 6);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 06 00 00 00       	mov    $0x6,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 10 05 00       	mov    $0x510f0,%edi
   402d1:	e8 65 0a 00 00       	call   40d3b <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 10 05 00    	add    $0x51000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 ba 1b 00 00       	call   41ec5 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 02 3d 00 00       	call   44017 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba a8 47 04 00       	mov    $0x447a8,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40328:	e8 60 23 00 00       	call   4268d <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 10 05 00 	lea    0x51000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 10 40 00 00       	call   44365 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba d8 47 04 00       	mov    $0x447d8,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40368:	e8 20 23 00 00       	call   4268d <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 10 05 00    	add    $0x51000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 0e 40 00 00       	call   4439d <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 1f 05 00 	movb   $0x1,0x51f21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf 1a 01 00 	mov    0x11acf(%rip),%rax        # 51f00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 17 40 00 00       	call   44450 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba 1a 01 00 	mov    0x11aba(%rip),%rax        # 51f00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 e6 38 00 00       	call   43d35 <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b 1a 01 00 	mov    0x11a9b(%rip),%rax        # 51f00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 6e 42 00 00       	call   446e2 <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <syscall_mapping>:


void syscall_mapping(proc* p){
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 70          	sub    $0x70,%rsp
   4047e:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40482:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40486:	48 8b 40 48          	mov    0x48(%rax),%rax
   4048a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4048e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40492:	48 8b 40 40          	mov    0x40(%rax),%rax
   40496:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4049a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4049e:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404a5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   404a9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404ad:	48 89 ce             	mov    %rcx,%rsi
   404b0:	48 89 c7             	mov    %rax,%rdi
   404b3:	e8 97 28 00 00       	call   42d4f <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   404b8:	8b 45 e0             	mov    -0x20(%rbp),%eax
   404bb:	48 98                	cltq   
   404bd:	83 e0 06             	and    $0x6,%eax
   404c0:	48 83 f8 06          	cmp    $0x6,%rax
   404c4:	75 73                	jne    40539 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   404c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404ca:	48 83 c0 17          	add    $0x17,%rax
   404ce:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   404d2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   404d6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404dd:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   404e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   404e5:	48 89 ce             	mov    %rcx,%rsi
   404e8:	48 89 c7             	mov    %rax,%rdi
   404eb:	e8 5f 28 00 00       	call   42d4f <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   404f0:	8b 45 c8             	mov    -0x38(%rbp),%eax
   404f3:	48 98                	cltq   
   404f5:	83 e0 03             	and    $0x3,%eax
   404f8:	48 83 f8 03          	cmp    $0x3,%rax
   404fc:	75 3e                	jne    4053c <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   404fe:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40502:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40509:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4050d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40511:	48 89 ce             	mov    %rcx,%rsi
   40514:	48 89 c7             	mov    %rax,%rdi
   40517:	e8 33 28 00 00       	call   42d4f <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4051c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40520:	48 89 c1             	mov    %rax,%rcx
   40523:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40527:	ba 18 00 00 00       	mov    $0x18,%edx
   4052c:	48 89 c6             	mov    %rax,%rsi
   4052f:	48 89 cf             	mov    %rcx,%rdi
   40532:	e8 70 2d 00 00       	call   432a7 <memcpy>
   40537:	eb 04                	jmp    4053d <syscall_mapping+0xc7>
	return;
   40539:	90                   	nop
   4053a:	eb 01                	jmp    4053d <syscall_mapping+0xc7>
	return;
   4053c:	90                   	nop
}
   4053d:	c9                   	leave  
   4053e:	c3                   	ret    

000000000004053f <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4053f:	55                   	push   %rbp
   40540:	48 89 e5             	mov    %rsp,%rbp
   40543:	48 83 ec 18          	sub    $0x18,%rsp
   40547:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4054b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4054f:	48 8b 40 48          	mov    0x48(%rax),%rax
   40553:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40556:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4055a:	75 14                	jne    40570 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4055c:	0f b6 05 9d 5a 00 00 	movzbl 0x5a9d(%rip),%eax        # 46000 <disp_global>
   40563:	84 c0                	test   %al,%al
   40565:	0f 94 c0             	sete   %al
   40568:	88 05 92 5a 00 00    	mov    %al,0x5a92(%rip)        # 46000 <disp_global>
   4056e:	eb 36                	jmp    405a6 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40570:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40574:	78 2f                	js     405a5 <syscall_mem_tog+0x66>
   40576:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4057a:	7f 29                	jg     405a5 <syscall_mem_tog+0x66>
   4057c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40580:	8b 00                	mov    (%rax),%eax
   40582:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40585:	75 1e                	jne    405a5 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40587:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4058b:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40592:	84 c0                	test   %al,%al
   40594:	0f 94 c0             	sete   %al
   40597:	89 c2                	mov    %eax,%edx
   40599:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4059d:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   405a3:	eb 01                	jmp    405a6 <syscall_mem_tog+0x67>
            return;
   405a5:	90                   	nop
    }
}
   405a6:	c9                   	leave  
   405a7:	c3                   	ret    

00000000000405a8 <unassign_page>:

// unassigns the page at physical address addr
void unassign_page(uintptr_t addr, pid_t pid)
{
   405a8:	55                   	push   %rbp
   405a9:	48 89 e5             	mov    %rsp,%rbp
   405ac:	48 83 ec 10          	sub    $0x10,%rsp
   405b0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   405b4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    if (pageinfo[PAGENUMBER(addr)].owner == pid && pageinfo[PAGENUMBER(addr)].refcount == 1)
   405b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405bb:	48 c1 e8 0c          	shr    $0xc,%rax
   405bf:	48 98                	cltq   
   405c1:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   405c8:	00 
   405c9:	0f be c0             	movsbl %al,%eax
   405cc:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   405cf:	75 4e                	jne    4061f <unassign_page+0x77>
   405d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405d5:	48 c1 e8 0c          	shr    $0xc,%rax
   405d9:	48 98                	cltq   
   405db:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   405e2:	00 
   405e3:	3c 01                	cmp    $0x1,%al
   405e5:	75 38                	jne    4061f <unassign_page+0x77>
    { // page is solely owned
        // log_printf("CHANGE OWNER: physical addr %p has owner %d with refcount %d\n",
        //             addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);
        pageinfo[PAGENUMBER(addr)].owner = PO_FREE;
   405e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405eb:	48 c1 e8 0c          	shr    $0xc,%rax
   405ef:	48 98                	cltq   
   405f1:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   405f8:	00 
        pageinfo[PAGENUMBER(addr)].refcount--;
   405f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405fd:	48 c1 e8 0c          	shr    $0xc,%rax
   40601:	89 c2                	mov    %eax,%edx
   40603:	48 63 c2             	movslq %edx,%rax
   40606:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4060d:	00 
   4060e:	83 e8 01             	sub    $0x1,%eax
   40611:	89 c1                	mov    %eax,%ecx
   40613:	48 63 c2             	movslq %edx,%rax
   40616:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
    // log_printf("\nRESULT: physical addr %p has owner %d with refcount %d\n",
    // addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);

    // if the pimd is the same and refcount is 1
    // else if the refcount is greater than 1 and the owner is >= 0 ( meaning not the kernel or reserved)
}
   4061d:	eb 50                	jmp    4066f <unassign_page+0xc7>
    else if (pageinfo[PAGENUMBER(addr)].refcount > 1 && pageinfo[PAGENUMBER(addr)].owner > 0)
   4061f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40623:	48 c1 e8 0c          	shr    $0xc,%rax
   40627:	48 98                	cltq   
   40629:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   40630:	00 
   40631:	3c 01                	cmp    $0x1,%al
   40633:	7e 3a                	jle    4066f <unassign_page+0xc7>
   40635:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40639:	48 c1 e8 0c          	shr    $0xc,%rax
   4063d:	48 98                	cltq   
   4063f:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   40646:	00 
   40647:	84 c0                	test   %al,%al
   40649:	7e 24                	jle    4066f <unassign_page+0xc7>
        pageinfo[PAGENUMBER(addr)].refcount--;
   4064b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4064f:	48 c1 e8 0c          	shr    $0xc,%rax
   40653:	89 c2                	mov    %eax,%edx
   40655:	48 63 c2             	movslq %edx,%rax
   40658:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4065f:	00 
   40660:	83 e8 01             	sub    $0x1,%eax
   40663:	89 c1                	mov    %eax,%ecx
   40665:	48 63 c2             	movslq %edx,%rax
   40668:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
}
   4066f:	90                   	nop
   40670:	c9                   	leave  
   40671:	c3                   	ret    

0000000000040672 <virtual_memory_deallocate>:


void virtual_memory_deallocate(x86_64_pagetable* pagetable, uintptr_t va) 
{ // remap the virtual address to physical address -1 and change its permissions to 0
   40672:	55                   	push   %rbp
   40673:	48 89 e5             	mov    %rsp,%rbp
   40676:	48 83 ec 10          	sub    $0x10,%rsp
   4067a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4067e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  // when deallocating a page
    virtual_memory_map(pagetable, va, -1, PAGESIZE, 0);
   40682:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40686:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4068a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   40690:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40695:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
   4069c:	48 89 c7             	mov    %rax,%rdi
   4069f:	e8 e8 22 00 00       	call   4298c <virtual_memory_map>
}
   406a4:	90                   	nop
   406a5:	c9                   	leave  
   406a6:	c3                   	ret    

00000000000406a7 <change_brk_loc>:

// change the process p's brk position to new_brk
int change_brk_loc(proc * p, uintptr_t new_brk)
{
   406a7:	55                   	push   %rbp
   406a8:	48 89 e5             	mov    %rsp,%rbp
   406ab:	48 83 ec 60          	sub    $0x60,%rsp
   406af:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   406b3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
    // p->original_break is where the heap starts
    // p->program_break is the current break's position

    if (new_brk < p->original_break || MEMSIZE_VIRTUAL - PAGESIZE < new_brk)
   406b7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   406bb:	48 8b 40 10          	mov    0x10(%rax),%rax
   406bf:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
   406c3:	72 0a                	jb     406cf <change_brk_loc+0x28>
   406c5:	48 81 7d a0 00 f0 2f 	cmpq   $0x2ff000,-0x60(%rbp)
   406cc:	00 
   406cd:	76 0a                	jbe    406d9 <change_brk_loc+0x32>
    {  // the address is invalid
        return -1;
   406cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   406d4:	e9 2f 01 00 00       	jmp    40808 <change_brk_loc+0x161>
    }
    if (new_brk == p->program_break) return 0; // no change
   406d9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   406dd:	48 8b 40 08          	mov    0x8(%rax),%rax
   406e1:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
   406e5:	75 0a                	jne    406f1 <change_brk_loc+0x4a>
   406e7:	b8 00 00 00 00       	mov    $0x0,%eax
   406ec:	e9 17 01 00 00       	jmp    40808 <change_brk_loc+0x161>
    else if (new_brk < p->program_break)
   406f1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   406f5:	48 8b 40 08          	mov    0x8(%rax),%rax
   406f9:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
   406fd:	0f 83 e6 00 00 00    	jae    407e9 <change_brk_loc+0x142>
    { // unmapping of pages upon heap contraction
        
        uintptr_t rounded_brk = (uintptr_t) ROUNDUP((uint64_t) new_brk, PAGESIZE);
   40703:	48 c7 45 f0 00 10 00 	movq   $0x1000,-0x10(%rbp)
   4070a:	00 
   4070b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4070f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40713:	48 01 d0             	add    %rdx,%rax
   40716:	48 83 e8 01          	sub    $0x1,%rax
   4071a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4071e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40722:	ba 00 00 00 00       	mov    $0x0,%edx
   40727:	48 f7 75 f0          	divq   -0x10(%rbp)
   4072b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4072f:	48 29 d0             	sub    %rdx,%rax
   40732:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        // log_printf("The break pages from %d to %d are being deallocated\n",
        //                 p->program_break - p->original_break, rounded_brk - p->original_break);

        for (uintptr_t va = rounded_brk; va < p->program_break; va += PAGESIZE)
   40736:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4073a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4073e:	e9 86 00 00 00       	jmp    407c9 <change_brk_loc+0x122>
        {
            vamapping vmap = virtual_memory_lookup(p->p_pagetable, va);
   40743:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40747:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4074e:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   40752:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40756:	48 89 ce             	mov    %rcx,%rsi
   40759:	48 89 c7             	mov    %rax,%rdi
   4075c:	e8 ee 25 00 00       	call   42d4f <virtual_memory_lookup>

            // log_printf("virtual add: %p, physical address: %p, permissions: %p\n", 
            //             va, vmap.pa, vmap.perm);

            if (vmap.perm & PTE_P && vmap.pn >= 0)
   40761:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40764:	48 98                	cltq   
   40766:	83 e0 01             	and    $0x1,%eax
   40769:	48 85 c0             	test   %rax,%rax
   4076c:	74 53                	je     407c1 <change_brk_loc+0x11a>
   4076e:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40771:	85 c0                	test   %eax,%eax
   40773:	78 4c                	js     407c1 <change_brk_loc+0x11a>
            {
                unassign_page(vmap.pa, p->p_pid);
   40775:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40779:	8b 10                	mov    (%rax),%edx
   4077b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4077f:	89 d6                	mov    %edx,%esi
   40781:	48 89 c7             	mov    %rax,%rdi
   40784:	e8 1f fe ff ff       	call   405a8 <unassign_page>
                virtual_memory_deallocate(p->p_pagetable, va);
   40789:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4078d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40794:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40798:	48 89 d6             	mov    %rdx,%rsi
   4079b:	48 89 c7             	mov    %rax,%rdi
   4079e:	e8 cf fe ff ff       	call   40672 <virtual_memory_deallocate>

                vamapping check = virtual_memory_lookup(p->p_pagetable, va);
   407a3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   407a7:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   407ae:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   407b2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407b6:	48 89 ce             	mov    %rcx,%rsi
   407b9:	48 89 c7             	mov    %rax,%rdi
   407bc:	e8 8e 25 00 00       	call   42d4f <virtual_memory_lookup>
        for (uintptr_t va = rounded_brk; va < p->program_break; va += PAGESIZE)
   407c1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   407c8:	00 
   407c9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   407cd:	48 8b 40 08          	mov    0x8(%rax),%rax
   407d1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   407d5:	0f 82 68 ff ff ff    	jb     40743 <change_brk_loc+0x9c>
                // log_printf("new deallocated add: %p, physical add %p, permissions: %p\n", 
                //             va, check.pa, check.perm);

            }
        }
        p->program_break = new_brk; 
   407db:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   407df:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   407e3:	48 89 50 08          	mov    %rdx,0x8(%rax)
   407e7:	eb 1a                	jmp    40803 <change_brk_loc+0x15c>
    }
    else if (new_brk > p->program_break)
   407e9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   407ed:	48 8b 40 08          	mov    0x8(%rax),%rax
   407f1:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
   407f5:	76 0c                	jbe    40803 <change_brk_loc+0x15c>
    { // no change needed because we lazily allocate pages
        p->program_break = new_brk;  
   407f7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   407fb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   407ff:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }

    return 0;
   40803:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40808:	c9                   	leave  
   40809:	c3                   	ret    

000000000004080a <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   4080a:	55                   	push   %rbp
   4080b:	48 89 e5             	mov    %rsp,%rbp
   4080e:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   40815:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   4081c:	48 8b 05 dd 16 01 00 	mov    0x116dd(%rip),%rax        # 51f00 <current>
   40823:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   4082a:	48 83 c0 18          	add    $0x18,%rax
   4082e:	48 89 d6             	mov    %rdx,%rsi
   40831:	ba 18 00 00 00       	mov    $0x18,%edx
   40836:	48 89 c7             	mov    %rax,%rdi
   40839:	48 89 d1             	mov    %rdx,%rcx
   4083c:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4083f:	48 8b 05 ba 37 01 00 	mov    0x137ba(%rip),%rax        # 54000 <kernel_pagetable>
   40846:	48 89 c7             	mov    %rax,%rdi
   40849:	e8 0d 20 00 00       	call   4285b <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4084e:	8b 05 a8 87 07 00    	mov    0x787a8(%rip),%eax        # b8ffc <cursorpos>
   40854:	89 c7                	mov    %eax,%edi
   40856:	e8 34 17 00 00       	call   41f8f <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   4085b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40862:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40869:	48 83 f8 0e          	cmp    $0xe,%rax
   4086d:	74 14                	je     40883 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   4086f:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40876:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4087d:	48 83 f8 0d          	cmp    $0xd,%rax
   40881:	75 16                	jne    40899 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40883:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4088a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40891:	83 e0 04             	and    $0x4,%eax
   40894:	48 85 c0             	test   %rax,%rax
   40897:	74 1a                	je     408b3 <exception+0xa9>
        check_virtual_memory();
   40899:	e8 c5 08 00 00       	call   41163 <check_virtual_memory>
        if(disp_global){
   4089e:	0f b6 05 5b 57 00 00 	movzbl 0x575b(%rip),%eax        # 46000 <disp_global>
   408a5:	84 c0                	test   %al,%al
   408a7:	74 0a                	je     408b3 <exception+0xa9>
            memshow_physical();
   408a9:	e8 2d 0a 00 00       	call   412db <memshow_physical>
            memshow_virtual_animate();
   408ae:	e8 53 0d 00 00       	call   41606 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   408b3:	e8 b4 1b 00 00       	call   4246c <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408b8:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   408bf:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408c6:	48 83 e8 0e          	sub    $0xe,%rax
   408ca:	48 83 f8 2c          	cmp    $0x2c,%rax
   408ce:	0f 87 bc 03 00 00    	ja     40c90 <exception+0x486>
   408d4:	48 8b 04 c5 98 48 04 	mov    0x44898(,%rax,8),%rax
   408db:	00 
   408dc:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   408de:	48 8b 05 1b 16 01 00 	mov    0x1161b(%rip),%rax        # 51f00 <current>
   408e5:	48 8b 40 48          	mov    0x48(%rax),%rax
   408e9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                    if((void *)addr == NULL)
   408ed:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   408f2:	75 0f                	jne    40903 <exception+0xf9>
                        kernel_panic(NULL);
   408f4:	bf 00 00 00 00       	mov    $0x0,%edi
   408f9:	b8 00 00 00 00       	mov    $0x0,%eax
   408fe:	e8 aa 1c 00 00       	call   425ad <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40903:	48 8b 05 f6 15 01 00 	mov    0x115f6(%rip),%rax        # 51f00 <current>
   4090a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40911:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40915:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40919:	48 89 ce             	mov    %rcx,%rsi
   4091c:	48 89 c7             	mov    %rax,%rdi
   4091f:	e8 2b 24 00 00       	call   42d4f <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40924:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40928:	48 89 c1             	mov    %rax,%rcx
   4092b:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40932:	ba a0 00 00 00       	mov    $0xa0,%edx
   40937:	48 89 ce             	mov    %rcx,%rsi
   4093a:	48 89 c7             	mov    %rax,%rdi
   4093d:	e8 65 29 00 00       	call   432a7 <memcpy>
                    kernel_panic(msg);
   40942:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40949:	48 89 c7             	mov    %rax,%rdi
   4094c:	b8 00 00 00 00       	mov    $0x0,%eax
   40951:	e8 57 1c 00 00       	call   425ad <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   40956:	48 8b 05 a3 15 01 00 	mov    0x115a3(%rip),%rax        # 51f00 <current>
   4095d:	8b 10                	mov    (%rax),%edx
   4095f:	48 8b 05 9a 15 01 00 	mov    0x1159a(%rip),%rax        # 51f00 <current>
   40966:	48 63 d2             	movslq %edx,%rdx
   40969:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4096d:	e9 2e 03 00 00       	jmp    40ca0 <exception+0x496>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40972:	b8 00 00 00 00       	mov    $0x0,%eax
   40977:	e8 aa fa ff ff       	call   40426 <syscall_fork>
   4097c:	89 c2                	mov    %eax,%edx
   4097e:	48 8b 05 7b 15 01 00 	mov    0x1157b(%rip),%rax        # 51f00 <current>
   40985:	48 63 d2             	movslq %edx,%rdx
   40988:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4098c:	e9 0f 03 00 00       	jmp    40ca0 <exception+0x496>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40991:	48 8b 05 68 15 01 00 	mov    0x11568(%rip),%rax        # 51f00 <current>
   40998:	48 89 c7             	mov    %rax,%rdi
   4099b:	e8 d6 fa ff ff       	call   40476 <syscall_mapping>
                break;
   409a0:	e9 fb 02 00 00       	jmp    40ca0 <exception+0x496>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   409a5:	b8 00 00 00 00       	mov    $0x0,%eax
   409aa:	e8 8c fa ff ff       	call   4043b <syscall_exit>
                schedule();
   409af:	e8 15 03 00 00       	call   40cc9 <schedule>
                break;
   409b4:	e9 e7 02 00 00       	jmp    40ca0 <exception+0x496>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   409b9:	e8 0b 03 00 00       	call   40cc9 <schedule>
                break;                  /* will not be reached */
   409be:	e9 dd 02 00 00       	jmp    40ca0 <exception+0x496>
            }

        case INT_SYS_BRK:
            {
                // new_brk location at reg_rdi
                if (change_brk_loc(current, (uintptr_t) current->p_registers.reg_rdi) >= 0)
   409c3:	48 8b 05 36 15 01 00 	mov    0x11536(%rip),%rax        # 51f00 <current>
   409ca:	48 8b 50 48          	mov    0x48(%rax),%rdx
   409ce:	48 8b 05 2b 15 01 00 	mov    0x1152b(%rip),%rax        # 51f00 <current>
   409d5:	48 89 d6             	mov    %rdx,%rsi
   409d8:	48 89 c7             	mov    %rax,%rdi
   409db:	e8 c7 fc ff ff       	call   406a7 <change_brk_loc>
   409e0:	85 c0                	test   %eax,%eax
   409e2:	78 14                	js     409f8 <exception+0x1ee>
                {
                    // log_printf("successful change_brk_loc, return old_brk\n");
                    current->p_registers.reg_rax = 0; // successful change_brk_loc, return 0
   409e4:	48 8b 05 15 15 01 00 	mov    0x11515(%rip),%rax        # 51f00 <current>
   409eb:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   409f2:	00 
                else
                { // on error, return -1
                    // log_printf("error change_brk_loc in brk\n");
                    current->p_registers.reg_rax = -1;
                }     
                break;
   409f3:	e9 a8 02 00 00       	jmp    40ca0 <exception+0x496>
                    current->p_registers.reg_rax = -1;
   409f8:	48 8b 05 01 15 01 00 	mov    0x11501(%rip),%rax        # 51f00 <current>
   409ff:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40a06:	ff 
                break;
   40a07:	e9 94 02 00 00       	jmp    40ca0 <exception+0x496>
            }
        case INT_SYS_SBRK:
            {
                // increment at reg_rdi
                uintptr_t new_brk = current->program_break + (uintptr_t) current->p_registers.reg_rdi;
   40a0c:	48 8b 05 ed 14 01 00 	mov    0x114ed(%rip),%rax        # 51f00 <current>
   40a13:	48 8b 50 08          	mov    0x8(%rax),%rdx
   40a17:	48 8b 05 e2 14 01 00 	mov    0x114e2(%rip),%rax        # 51f00 <current>
   40a1e:	48 8b 40 48          	mov    0x48(%rax),%rax
   40a22:	48 01 d0             	add    %rdx,%rax
   40a25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
                uintptr_t old_brk = current->program_break;
   40a29:	48 8b 05 d0 14 01 00 	mov    0x114d0(%rip),%rax        # 51f00 <current>
   40a30:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a34:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                // new_brk location at reg_rdi
                if (change_brk_loc(current, new_brk) >= 0) 
   40a38:	48 8b 05 c1 14 01 00 	mov    0x114c1(%rip),%rax        # 51f00 <current>
   40a3f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40a43:	48 89 d6             	mov    %rdx,%rsi
   40a46:	48 89 c7             	mov    %rax,%rdi
   40a49:	e8 59 fc ff ff       	call   406a7 <change_brk_loc>
   40a4e:	85 c0                	test   %eax,%eax
   40a50:	78 14                	js     40a66 <exception+0x25c>
                { // successful change_brk_loc, return old_brk
                    // log_printf("successful change_brk_loc, return old_brk\n");
                    current->p_registers.reg_rax = old_brk; 
   40a52:	48 8b 05 a7 14 01 00 	mov    0x114a7(%rip),%rax        # 51f00 <current>
   40a59:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40a5d:	48 89 50 18          	mov    %rdx,0x18(%rax)
                else
                { // on error, return (void *) -1
                    // log_printf("error change_brk_loc in sbrk\n");
                    current->p_registers.reg_rax = (uintptr_t) -1;
                }
                break;
   40a61:	e9 3a 02 00 00       	jmp    40ca0 <exception+0x496>
                    current->p_registers.reg_rax = (uintptr_t) -1;
   40a66:	48 8b 05 93 14 01 00 	mov    0x11493(%rip),%rax        # 51f00 <current>
   40a6d:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40a74:	ff 
                break;
   40a75:	e9 26 02 00 00       	jmp    40ca0 <exception+0x496>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40a7a:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40a81:	48 8b 40 30          	mov    0x30(%rax),%rax
   40a85:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		syscall_page_alloc(addr);
   40a89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a8d:	48 89 c7             	mov    %rax,%rdi
   40a90:	e8 bd f9 ff ff       	call   40452 <syscall_page_alloc>
		break;
   40a95:	e9 06 02 00 00       	jmp    40ca0 <exception+0x496>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40a9a:	48 8b 05 5f 14 01 00 	mov    0x1145f(%rip),%rax        # 51f00 <current>
   40aa1:	48 89 c7             	mov    %rax,%rdi
   40aa4:	e8 96 fa ff ff       	call   4053f <syscall_mem_tog>
                break;
   40aa9:	e9 f2 01 00 00       	jmp    40ca0 <exception+0x496>
            }

        case INT_TIMER:
            {
                ++ticks;
   40aae:	8b 05 6c 18 01 00    	mov    0x1186c(%rip),%eax        # 52320 <ticks>
   40ab4:	83 c0 01             	add    $0x1,%eax
   40ab7:	89 05 63 18 01 00    	mov    %eax,0x11863(%rip)        # 52320 <ticks>
                schedule();
   40abd:	e8 07 02 00 00       	call   40cc9 <schedule>
                break;                  /* will not be reached */
   40ac2:	e9 d9 01 00 00       	jmp    40ca0 <exception+0x496>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40ac7:	0f 20 d0             	mov    %cr2,%rax
   40aca:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    return val;
   40ace:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   40ad2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

                const char* operation = reg->reg_err & PFERR_WRITE
   40ad6:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40add:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ae4:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40ae7:	48 85 c0             	test   %rax,%rax
   40aea:	74 07                	je     40af3 <exception+0x2e9>
   40aec:	b8 0b 48 04 00       	mov    $0x4480b,%eax
   40af1:	eb 05                	jmp    40af8 <exception+0x2ee>
   40af3:	b8 11 48 04 00       	mov    $0x44811,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40af8:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40afc:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b03:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b0a:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40b0d:	48 85 c0             	test   %rax,%rax
   40b10:	74 07                	je     40b19 <exception+0x30f>
   40b12:	b8 16 48 04 00       	mov    $0x44816,%eax
   40b17:	eb 05                	jmp    40b1e <exception+0x314>
   40b19:	b8 29 48 04 00       	mov    $0x44829,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40b1e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

                if (strcmp(operation, "write") == 0)
   40b22:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40b26:	be 0b 48 04 00       	mov    $0x4480b,%esi
   40b2b:	48 89 c7             	mov    %rax,%rdi
   40b2e:	e8 4e 28 00 00       	call   43381 <strcmp>
   40b33:	85 c0                	test   %eax,%eax
   40b35:	0f 85 ab 00 00 00    	jne    40be6 <exception+0x3dc>
                {
                    if (strcmp(problem, "missing page") == 0)
   40b3b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b3f:	be 29 48 04 00       	mov    $0x44829,%esi
   40b44:	48 89 c7             	mov    %rax,%rdi
   40b47:	e8 35 28 00 00       	call   43381 <strcmp>
   40b4c:	85 c0                	test   %eax,%eax
   40b4e:	0f 85 92 00 00 00    	jne    40be6 <exception+0x3dc>
                    { // trying to write a missing page, need to page alloc
                        // log_printf("found write missing page!\n");
                        uintptr_t rounded_addr = ROUNDDOWN(addr, PAGESIZE);
   40b54:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40b58:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   40b5c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40b60:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b66:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
                        uintptr_t page_addr = (uintptr_t) palloc(current->p_pid);
   40b6a:	48 8b 05 8f 13 01 00 	mov    0x1138f(%rip),%rax        # 51f00 <current>
   40b71:	8b 00                	mov    (%rax),%eax
   40b73:	89 c7                	mov    %eax,%edi
   40b75:	e8 a2 30 00 00       	call   43c1c <palloc>
   40b7a:	48 89 45 b0          	mov    %rax,-0x50(%rbp)

                        if (page_addr == (uintptr_t) NULL)
   40b7e:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   40b83:	75 0f                	jne    40b94 <exception+0x38a>
                        { // not enough physical memory to palloc, exit
                            // log_printf("not enough physical memory to palloc, exit\n");
                            syscall_exit();
   40b85:	b8 00 00 00 00       	mov    $0x0,%eax
   40b8a:	e8 ac f8 ff ff       	call   4043b <syscall_exit>
                            break;
   40b8f:	e9 0c 01 00 00       	jmp    40ca0 <exception+0x496>
                        }
                        if (virtual_memory_map(current->p_pagetable, rounded_addr, 
   40b94:	48 8b 05 65 13 01 00 	mov    0x11365(%rip),%rax        # 51f00 <current>
   40b9b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40ba2:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   40ba6:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   40baa:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40bb0:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40bb5:	48 89 c7             	mov    %rax,%rdi
   40bb8:	e8 cf 1d 00 00       	call   4298c <virtual_memory_map>
   40bbd:	85 c0                	test   %eax,%eax
   40bbf:	79 0f                	jns    40bd0 <exception+0x3c6>
                            page_addr, PAGESIZE, PTE_P | PTE_U | PTE_W) < 0)
                        { // failed mapping, exit
                            // log_printf("failed mapping, exit\n");
                            syscall_exit();
   40bc1:	b8 00 00 00 00       	mov    $0x0,%eax
   40bc6:	e8 70 f8 ff ff       	call   4043b <syscall_exit>
                            break;
   40bcb:	e9 d0 00 00 00       	jmp    40ca0 <exception+0x496>
                        }
                        // otherwise, successful mapping of missing page
                        current->p_state = P_RUNNABLE;
   40bd0:	48 8b 05 29 13 01 00 	mov    0x11329(%rip),%rax        # 51f00 <current>
   40bd7:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40bde:	00 00 00 
                        // log_printf("set to runnable, break!\n");
                        break;
   40be1:	e9 ba 00 00 00       	jmp    40ca0 <exception+0x496>
                        
                    }
                }
                

                if (!(reg->reg_err & PFERR_USER)) {
   40be6:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40bed:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40bf4:	83 e0 04             	and    $0x4,%eax
   40bf7:	48 85 c0             	test   %rax,%rax
   40bfa:	75 2f                	jne    40c2b <exception+0x421>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40bfc:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c03:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40c0a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40c0e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40c12:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c16:	49 89 f0             	mov    %rsi,%r8
   40c19:	48 89 c6             	mov    %rax,%rsi
   40c1c:	bf 38 48 04 00       	mov    $0x44838,%edi
   40c21:	b8 00 00 00 00       	mov    $0x0,%eax
   40c26:	e8 82 19 00 00       	call   425ad <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   40c2b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c32:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40c39:	48 8b 05 c0 12 01 00 	mov    0x112c0(%rip),%rax        # 51f00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40c40:	8b 00                	mov    (%rax),%eax
   40c42:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40c46:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40c4a:	52                   	push   %rdx
   40c4b:	ff 75 c8             	push   -0x38(%rbp)
   40c4e:	49 89 f1             	mov    %rsi,%r9
   40c51:	49 89 c8             	mov    %rcx,%r8
   40c54:	89 c1                	mov    %eax,%ecx
   40c56:	ba 68 48 04 00       	mov    $0x44868,%edx
   40c5b:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c60:	bf 80 07 00 00       	mov    $0x780,%edi
   40c65:	b8 00 00 00 00       	mov    $0x0,%eax
   40c6a:	e8 d6 2e 00 00       	call   43b45 <console_printf>
   40c6f:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   40c73:	48 8b 05 86 12 01 00 	mov    0x11286(%rip),%rax        # 51f00 <current>
   40c7a:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40c81:	00 00 00 
                syscall_exit();
   40c84:	b8 00 00 00 00       	mov    $0x0,%eax
   40c89:	e8 ad f7 ff ff       	call   4043b <syscall_exit>
                break;
   40c8e:	eb 10                	jmp    40ca0 <exception+0x496>
            }

        default:
            default_exception(current);
   40c90:	48 8b 05 69 12 01 00 	mov    0x11269(%rip),%rax        # 51f00 <current>
   40c97:	48 89 c7             	mov    %rax,%rdi
   40c9a:	e8 1e 1a 00 00       	call   426bd <default_exception>
            break;                  /* will not be reached */
   40c9f:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40ca0:	48 8b 05 59 12 01 00 	mov    0x11259(%rip),%rax        # 51f00 <current>
   40ca7:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40cad:	83 f8 01             	cmp    $0x1,%eax
   40cb0:	75 0f                	jne    40cc1 <exception+0x4b7>
        run(current);
   40cb2:	48 8b 05 47 12 01 00 	mov    0x11247(%rip),%rax        # 51f00 <current>
   40cb9:	48 89 c7             	mov    %rax,%rdi
   40cbc:	e8 7a 00 00 00       	call   40d3b <run>
    } else {
        schedule();
   40cc1:	e8 03 00 00 00       	call   40cc9 <schedule>
    }
}
   40cc6:	90                   	nop
   40cc7:	c9                   	leave  
   40cc8:	c3                   	ret    

0000000000040cc9 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40cc9:	55                   	push   %rbp
   40cca:	48 89 e5             	mov    %rsp,%rbp
   40ccd:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40cd1:	48 8b 05 28 12 01 00 	mov    0x11228(%rip),%rax        # 51f00 <current>
   40cd8:	8b 00                	mov    (%rax),%eax
   40cda:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40cdd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ce0:	83 c0 01             	add    $0x1,%eax
   40ce3:	99                   	cltd   
   40ce4:	c1 ea 1c             	shr    $0x1c,%edx
   40ce7:	01 d0                	add    %edx,%eax
   40ce9:	83 e0 0f             	and    $0xf,%eax
   40cec:	29 d0                	sub    %edx,%eax
   40cee:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40cf1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cf4:	48 63 d0             	movslq %eax,%rdx
   40cf7:	48 89 d0             	mov    %rdx,%rax
   40cfa:	48 c1 e0 04          	shl    $0x4,%rax
   40cfe:	48 29 d0             	sub    %rdx,%rax
   40d01:	48 c1 e0 04          	shl    $0x4,%rax
   40d05:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40d0b:	8b 00                	mov    (%rax),%eax
   40d0d:	83 f8 01             	cmp    $0x1,%eax
   40d10:	75 22                	jne    40d34 <schedule+0x6b>
            run(&processes[pid]);
   40d12:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d15:	48 63 d0             	movslq %eax,%rdx
   40d18:	48 89 d0             	mov    %rdx,%rax
   40d1b:	48 c1 e0 04          	shl    $0x4,%rax
   40d1f:	48 29 d0             	sub    %rdx,%rax
   40d22:	48 c1 e0 04          	shl    $0x4,%rax
   40d26:	48 05 00 10 05 00    	add    $0x51000,%rax
   40d2c:	48 89 c7             	mov    %rax,%rdi
   40d2f:	e8 07 00 00 00       	call   40d3b <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d34:	e8 33 17 00 00       	call   4246c <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d39:	eb a2                	jmp    40cdd <schedule+0x14>

0000000000040d3b <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d3b:	55                   	push   %rbp
   40d3c:	48 89 e5             	mov    %rsp,%rbp
   40d3f:	48 83 ec 10          	sub    $0x10,%rsp
   40d43:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d4b:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40d51:	83 f8 01             	cmp    $0x1,%eax
   40d54:	74 14                	je     40d6a <run+0x2f>
   40d56:	ba 00 4a 04 00       	mov    $0x44a00,%edx
   40d5b:	be f5 01 00 00       	mov    $0x1f5,%esi
   40d60:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40d65:	e8 23 19 00 00       	call   4268d <assert_fail>
    current = p;
   40d6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d6e:	48 89 05 8b 11 01 00 	mov    %rax,0x1118b(%rip)        # 51f00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40d75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d79:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40d7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d7f:	8b 00                	mov    (%rax),%eax
   40d81:	83 c0 02             	add    $0x2,%eax
   40d84:	48 98                	cltq   
   40d86:	0f b7 84 00 60 47 04 	movzwl 0x44760(%rax,%rax,1),%eax
   40d8d:	00 
    console_printf(CPOS(24, 79),
   40d8e:	0f b7 c0             	movzwl %ax,%eax
   40d91:	89 d1                	mov    %edx,%ecx
   40d93:	ba 19 4a 04 00       	mov    $0x44a19,%edx
   40d98:	89 c6                	mov    %eax,%esi
   40d9a:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d9f:	b8 00 00 00 00       	mov    $0x0,%eax
   40da4:	e8 9c 2d 00 00       	call   43b45 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40da9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dad:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40db4:	48 89 c7             	mov    %rax,%rdi
   40db7:	e8 9f 1a 00 00       	call   4285b <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc0:	48 83 c0 18          	add    $0x18,%rax
   40dc4:	48 89 c7             	mov    %rax,%rdi
   40dc7:	e8 f7 f2 ff ff       	call   400c3 <exception_return>

0000000000040dcc <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40dcc:	55                   	push   %rbp
   40dcd:	48 89 e5             	mov    %rsp,%rbp
   40dd0:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40dd4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40ddb:	00 
   40ddc:	e9 81 00 00 00       	jmp    40e62 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40de1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40de5:	48 89 c7             	mov    %rax,%rdi
   40de8:	e8 13 0f 00 00       	call   41d00 <physical_memory_isreserved>
   40ded:	85 c0                	test   %eax,%eax
   40def:	74 09                	je     40dfa <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40df1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40df8:	eb 2f                	jmp    40e29 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40dfa:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40e01:	00 
   40e02:	76 0b                	jbe    40e0f <pageinfo_init+0x43>
   40e04:	b8 10 a0 05 00       	mov    $0x5a010,%eax
   40e09:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e0d:	72 0a                	jb     40e19 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40e0f:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40e16:	00 
   40e17:	75 09                	jne    40e22 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40e19:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40e20:	eb 07                	jmp    40e29 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40e22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e2d:	48 c1 e8 0c          	shr    $0xc,%rax
   40e31:	89 c1                	mov    %eax,%ecx
   40e33:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e36:	89 c2                	mov    %eax,%edx
   40e38:	48 63 c1             	movslq %ecx,%rax
   40e3b:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e42:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e46:	0f 95 c2             	setne  %dl
   40e49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e4d:	48 c1 e8 0c          	shr    $0xc,%rax
   40e51:	48 98                	cltq   
   40e53:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e5a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e61:	00 
   40e62:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e69:	00 
   40e6a:	0f 86 71 ff ff ff    	jbe    40de1 <pageinfo_init+0x15>
    }
}
   40e70:	90                   	nop
   40e71:	90                   	nop
   40e72:	c9                   	leave  
   40e73:	c3                   	ret    

0000000000040e74 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e74:	55                   	push   %rbp
   40e75:	48 89 e5             	mov    %rsp,%rbp
   40e78:	48 83 ec 50          	sub    $0x50,%rsp
   40e7c:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e80:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e84:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40e8a:	48 89 c2             	mov    %rax,%rdx
   40e8d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e91:	48 39 c2             	cmp    %rax,%rdx
   40e94:	74 14                	je     40eaa <check_page_table_mappings+0x36>
   40e96:	ba 20 4a 04 00       	mov    $0x44a20,%edx
   40e9b:	be 23 02 00 00       	mov    $0x223,%esi
   40ea0:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40ea5:	e8 e3 17 00 00       	call   4268d <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40eaa:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40eb1:	00 
   40eb2:	e9 9a 00 00 00       	jmp    40f51 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40eb7:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ebb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ebf:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ec3:	48 89 ce             	mov    %rcx,%rsi
   40ec6:	48 89 c7             	mov    %rax,%rdi
   40ec9:	e8 81 1e 00 00       	call   42d4f <virtual_memory_lookup>
        if (vam.pa != va) {
   40ece:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ed2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ed6:	74 27                	je     40eff <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ed8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40edc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ee0:	49 89 d0             	mov    %rdx,%r8
   40ee3:	48 89 c1             	mov    %rax,%rcx
   40ee6:	ba 3f 4a 04 00       	mov    $0x44a3f,%edx
   40eeb:	be 00 c0 00 00       	mov    $0xc000,%esi
   40ef0:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40ef5:	b8 00 00 00 00       	mov    $0x0,%eax
   40efa:	e8 46 2c 00 00       	call   43b45 <console_printf>
        }
        assert(vam.pa == va);
   40eff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f03:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f07:	74 14                	je     40f1d <check_page_table_mappings+0xa9>
   40f09:	ba 49 4a 04 00       	mov    $0x44a49,%edx
   40f0e:	be 2c 02 00 00       	mov    $0x22c,%esi
   40f13:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40f18:	e8 70 17 00 00       	call   4268d <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f1d:	b8 00 60 04 00       	mov    $0x46000,%eax
   40f22:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f26:	72 21                	jb     40f49 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40f28:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f2b:	48 98                	cltq   
   40f2d:	83 e0 02             	and    $0x2,%eax
   40f30:	48 85 c0             	test   %rax,%rax
   40f33:	75 14                	jne    40f49 <check_page_table_mappings+0xd5>
   40f35:	ba 56 4a 04 00       	mov    $0x44a56,%edx
   40f3a:	be 2e 02 00 00       	mov    $0x22e,%esi
   40f3f:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40f44:	e8 44 17 00 00       	call   4268d <assert_fail>
         va += PAGESIZE) {
   40f49:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f50:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f51:	b8 10 a0 05 00       	mov    $0x5a010,%eax
   40f56:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f5a:	0f 82 57 ff ff ff    	jb     40eb7 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f60:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f67:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f68:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f6c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f70:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f74:	48 89 ce             	mov    %rcx,%rsi
   40f77:	48 89 c7             	mov    %rax,%rdi
   40f7a:	e8 d0 1d 00 00       	call   42d4f <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40f7f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40f83:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40f87:	74 14                	je     40f9d <check_page_table_mappings+0x129>
   40f89:	ba 67 4a 04 00       	mov    $0x44a67,%edx
   40f8e:	be 35 02 00 00       	mov    $0x235,%esi
   40f93:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40f98:	e8 f0 16 00 00       	call   4268d <assert_fail>
    assert(vam.perm & PTE_W);
   40f9d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40fa0:	48 98                	cltq   
   40fa2:	83 e0 02             	and    $0x2,%eax
   40fa5:	48 85 c0             	test   %rax,%rax
   40fa8:	75 14                	jne    40fbe <check_page_table_mappings+0x14a>
   40faa:	ba 56 4a 04 00       	mov    $0x44a56,%edx
   40faf:	be 36 02 00 00       	mov    $0x236,%esi
   40fb4:	bf c8 47 04 00       	mov    $0x447c8,%edi
   40fb9:	e8 cf 16 00 00       	call   4268d <assert_fail>
}
   40fbe:	90                   	nop
   40fbf:	c9                   	leave  
   40fc0:	c3                   	ret    

0000000000040fc1 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40fc1:	55                   	push   %rbp
   40fc2:	48 89 e5             	mov    %rsp,%rbp
   40fc5:	48 83 ec 20          	sub    $0x20,%rsp
   40fc9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fcd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40fd0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40fd3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40fd6:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40fdd:	48 8b 05 1c 30 01 00 	mov    0x1301c(%rip),%rax        # 54000 <kernel_pagetable>
   40fe4:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40fe8:	75 67                	jne    41051 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40fea:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ff1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ff8:	eb 51                	jmp    4104b <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40ffa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ffd:	48 63 d0             	movslq %eax,%rdx
   41000:	48 89 d0             	mov    %rdx,%rax
   41003:	48 c1 e0 04          	shl    $0x4,%rax
   41007:	48 29 d0             	sub    %rdx,%rax
   4100a:	48 c1 e0 04          	shl    $0x4,%rax
   4100e:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   41014:	8b 00                	mov    (%rax),%eax
   41016:	85 c0                	test   %eax,%eax
   41018:	74 2d                	je     41047 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4101a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4101d:	48 63 d0             	movslq %eax,%rdx
   41020:	48 89 d0             	mov    %rdx,%rax
   41023:	48 c1 e0 04          	shl    $0x4,%rax
   41027:	48 29 d0             	sub    %rdx,%rax
   4102a:	48 c1 e0 04          	shl    $0x4,%rax
   4102e:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41034:	48 8b 10             	mov    (%rax),%rdx
   41037:	48 8b 05 c2 2f 01 00 	mov    0x12fc2(%rip),%rax        # 54000 <kernel_pagetable>
   4103e:	48 39 c2             	cmp    %rax,%rdx
   41041:	75 04                	jne    41047 <check_page_table_ownership+0x86>
                ++expected_refcount;
   41043:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41047:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4104b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   4104f:	7e a9                	jle    40ffa <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41051:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41054:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41057:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4105b:	be 00 00 00 00       	mov    $0x0,%esi
   41060:	48 89 c7             	mov    %rax,%rdi
   41063:	e8 03 00 00 00       	call   4106b <check_page_table_ownership_level>
}
   41068:	90                   	nop
   41069:	c9                   	leave  
   4106a:	c3                   	ret    

000000000004106b <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4106b:	55                   	push   %rbp
   4106c:	48 89 e5             	mov    %rsp,%rbp
   4106f:	48 83 ec 30          	sub    $0x30,%rsp
   41073:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41077:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4107a:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4107d:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41080:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41084:	48 c1 e8 0c          	shr    $0xc,%rax
   41088:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   4108d:	7e 14                	jle    410a3 <check_page_table_ownership_level+0x38>
   4108f:	ba 78 4a 04 00       	mov    $0x44a78,%edx
   41094:	be 53 02 00 00       	mov    $0x253,%esi
   41099:	bf c8 47 04 00       	mov    $0x447c8,%edi
   4109e:	e8 ea 15 00 00       	call   4268d <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410a7:	48 c1 e8 0c          	shr    $0xc,%rax
   410ab:	48 98                	cltq   
   410ad:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   410b4:	00 
   410b5:	0f be c0             	movsbl %al,%eax
   410b8:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   410bb:	74 14                	je     410d1 <check_page_table_ownership_level+0x66>
   410bd:	ba 90 4a 04 00       	mov    $0x44a90,%edx
   410c2:	be 54 02 00 00       	mov    $0x254,%esi
   410c7:	bf c8 47 04 00       	mov    $0x447c8,%edi
   410cc:	e8 bc 15 00 00       	call   4268d <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   410d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410d5:	48 c1 e8 0c          	shr    $0xc,%rax
   410d9:	48 98                	cltq   
   410db:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   410e2:	00 
   410e3:	0f be c0             	movsbl %al,%eax
   410e6:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   410e9:	74 14                	je     410ff <check_page_table_ownership_level+0x94>
   410eb:	ba b8 4a 04 00       	mov    $0x44ab8,%edx
   410f0:	be 55 02 00 00       	mov    $0x255,%esi
   410f5:	bf c8 47 04 00       	mov    $0x447c8,%edi
   410fa:	e8 8e 15 00 00       	call   4268d <assert_fail>
    if (level < 3) {
   410ff:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41103:	7f 5b                	jg     41160 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41105:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4110c:	eb 49                	jmp    41157 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   4110e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41112:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41115:	48 63 d2             	movslq %edx,%rdx
   41118:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4111c:	48 85 c0             	test   %rax,%rax
   4111f:	74 32                	je     41153 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41121:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41125:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41128:	48 63 d2             	movslq %edx,%rdx
   4112b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4112f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41135:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41139:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4113c:	8d 70 01             	lea    0x1(%rax),%esi
   4113f:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41142:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41146:	b9 01 00 00 00       	mov    $0x1,%ecx
   4114b:	48 89 c7             	mov    %rax,%rdi
   4114e:	e8 18 ff ff ff       	call   4106b <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41153:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41157:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4115e:	7e ae                	jle    4110e <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41160:	90                   	nop
   41161:	c9                   	leave  
   41162:	c3                   	ret    

0000000000041163 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41163:	55                   	push   %rbp
   41164:	48 89 e5             	mov    %rsp,%rbp
   41167:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4116b:	8b 05 67 ff 00 00    	mov    0xff67(%rip),%eax        # 510d8 <processes+0xd8>
   41171:	85 c0                	test   %eax,%eax
   41173:	74 14                	je     41189 <check_virtual_memory+0x26>
   41175:	ba e8 4a 04 00       	mov    $0x44ae8,%edx
   4117a:	be 68 02 00 00       	mov    $0x268,%esi
   4117f:	bf c8 47 04 00       	mov    $0x447c8,%edi
   41184:	e8 04 15 00 00       	call   4268d <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41189:	48 8b 05 70 2e 01 00 	mov    0x12e70(%rip),%rax        # 54000 <kernel_pagetable>
   41190:	48 89 c7             	mov    %rax,%rdi
   41193:	e8 dc fc ff ff       	call   40e74 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41198:	48 8b 05 61 2e 01 00 	mov    0x12e61(%rip),%rax        # 54000 <kernel_pagetable>
   4119f:	be ff ff ff ff       	mov    $0xffffffff,%esi
   411a4:	48 89 c7             	mov    %rax,%rdi
   411a7:	e8 15 fe ff ff       	call   40fc1 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   411ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411b3:	e9 9c 00 00 00       	jmp    41254 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   411b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411bb:	48 63 d0             	movslq %eax,%rdx
   411be:	48 89 d0             	mov    %rdx,%rax
   411c1:	48 c1 e0 04          	shl    $0x4,%rax
   411c5:	48 29 d0             	sub    %rdx,%rax
   411c8:	48 c1 e0 04          	shl    $0x4,%rax
   411cc:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   411d2:	8b 00                	mov    (%rax),%eax
   411d4:	85 c0                	test   %eax,%eax
   411d6:	74 78                	je     41250 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   411d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411db:	48 63 d0             	movslq %eax,%rdx
   411de:	48 89 d0             	mov    %rdx,%rax
   411e1:	48 c1 e0 04          	shl    $0x4,%rax
   411e5:	48 29 d0             	sub    %rdx,%rax
   411e8:	48 c1 e0 04          	shl    $0x4,%rax
   411ec:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   411f2:	48 8b 10             	mov    (%rax),%rdx
   411f5:	48 8b 05 04 2e 01 00 	mov    0x12e04(%rip),%rax        # 54000 <kernel_pagetable>
   411fc:	48 39 c2             	cmp    %rax,%rdx
   411ff:	74 4f                	je     41250 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41201:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41204:	48 63 d0             	movslq %eax,%rdx
   41207:	48 89 d0             	mov    %rdx,%rax
   4120a:	48 c1 e0 04          	shl    $0x4,%rax
   4120e:	48 29 d0             	sub    %rdx,%rax
   41211:	48 c1 e0 04          	shl    $0x4,%rax
   41215:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   4121b:	48 8b 00             	mov    (%rax),%rax
   4121e:	48 89 c7             	mov    %rax,%rdi
   41221:	e8 4e fc ff ff       	call   40e74 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41226:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41229:	48 63 d0             	movslq %eax,%rdx
   4122c:	48 89 d0             	mov    %rdx,%rax
   4122f:	48 c1 e0 04          	shl    $0x4,%rax
   41233:	48 29 d0             	sub    %rdx,%rax
   41236:	48 c1 e0 04          	shl    $0x4,%rax
   4123a:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41240:	48 8b 00             	mov    (%rax),%rax
   41243:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41246:	89 d6                	mov    %edx,%esi
   41248:	48 89 c7             	mov    %rax,%rdi
   4124b:	e8 71 fd ff ff       	call   40fc1 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41250:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41254:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41258:	0f 8e 5a ff ff ff    	jle    411b8 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4125e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41265:	eb 67                	jmp    412ce <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41267:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4126a:	48 98                	cltq   
   4126c:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41273:	00 
   41274:	84 c0                	test   %al,%al
   41276:	7e 52                	jle    412ca <check_virtual_memory+0x167>
   41278:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4127b:	48 98                	cltq   
   4127d:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   41284:	00 
   41285:	84 c0                	test   %al,%al
   41287:	78 41                	js     412ca <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41289:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4128c:	48 98                	cltq   
   4128e:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   41295:	00 
   41296:	0f be c0             	movsbl %al,%eax
   41299:	48 63 d0             	movslq %eax,%rdx
   4129c:	48 89 d0             	mov    %rdx,%rax
   4129f:	48 c1 e0 04          	shl    $0x4,%rax
   412a3:	48 29 d0             	sub    %rdx,%rax
   412a6:	48 c1 e0 04          	shl    $0x4,%rax
   412aa:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   412b0:	8b 00                	mov    (%rax),%eax
   412b2:	85 c0                	test   %eax,%eax
   412b4:	75 14                	jne    412ca <check_virtual_memory+0x167>
   412b6:	ba 08 4b 04 00       	mov    $0x44b08,%edx
   412bb:	be 7f 02 00 00       	mov    $0x27f,%esi
   412c0:	bf c8 47 04 00       	mov    $0x447c8,%edi
   412c5:	e8 c3 13 00 00       	call   4268d <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412ca:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   412ce:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   412d5:	7e 90                	jle    41267 <check_virtual_memory+0x104>
        }
    }
}
   412d7:	90                   	nop
   412d8:	90                   	nop
   412d9:	c9                   	leave  
   412da:	c3                   	ret    

00000000000412db <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   412db:	55                   	push   %rbp
   412dc:	48 89 e5             	mov    %rsp,%rbp
   412df:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   412e3:	ba 38 4b 04 00       	mov    $0x44b38,%edx
   412e8:	be 00 0f 00 00       	mov    $0xf00,%esi
   412ed:	bf 20 00 00 00       	mov    $0x20,%edi
   412f2:	b8 00 00 00 00       	mov    $0x0,%eax
   412f7:	e8 49 28 00 00       	call   43b45 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41303:	e9 f4 00 00 00       	jmp    413fc <memshow_physical+0x121>
        if (pn % 64 == 0) {
   41308:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4130b:	83 e0 3f             	and    $0x3f,%eax
   4130e:	85 c0                	test   %eax,%eax
   41310:	75 3e                	jne    41350 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41312:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41315:	c1 e0 0c             	shl    $0xc,%eax
   41318:	89 c2                	mov    %eax,%edx
   4131a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4131d:	8d 48 3f             	lea    0x3f(%rax),%ecx
   41320:	85 c0                	test   %eax,%eax
   41322:	0f 48 c1             	cmovs  %ecx,%eax
   41325:	c1 f8 06             	sar    $0x6,%eax
   41328:	8d 48 01             	lea    0x1(%rax),%ecx
   4132b:	89 c8                	mov    %ecx,%eax
   4132d:	c1 e0 02             	shl    $0x2,%eax
   41330:	01 c8                	add    %ecx,%eax
   41332:	c1 e0 04             	shl    $0x4,%eax
   41335:	83 c0 03             	add    $0x3,%eax
   41338:	89 d1                	mov    %edx,%ecx
   4133a:	ba 48 4b 04 00       	mov    $0x44b48,%edx
   4133f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41344:	89 c7                	mov    %eax,%edi
   41346:	b8 00 00 00 00       	mov    $0x0,%eax
   4134b:	e8 f5 27 00 00       	call   43b45 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41350:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41353:	48 98                	cltq   
   41355:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   4135c:	00 
   4135d:	0f be c0             	movsbl %al,%eax
   41360:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41363:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41366:	48 98                	cltq   
   41368:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4136f:	00 
   41370:	84 c0                	test   %al,%al
   41372:	75 07                	jne    4137b <memshow_physical+0xa0>
            owner = PO_FREE;
   41374:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4137b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4137e:	83 c0 02             	add    $0x2,%eax
   41381:	48 98                	cltq   
   41383:	0f b7 84 00 60 47 04 	movzwl 0x44760(%rax,%rax,1),%eax
   4138a:	00 
   4138b:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4138f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41392:	48 98                	cltq   
   41394:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4139b:	00 
   4139c:	3c 01                	cmp    $0x1,%al
   4139e:	7e 1a                	jle    413ba <memshow_physical+0xdf>
   413a0:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   413a5:	48 c1 e8 0c          	shr    $0xc,%rax
   413a9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   413ac:	74 0c                	je     413ba <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   413ae:	b8 53 00 00 00       	mov    $0x53,%eax
   413b3:	80 cc 0f             	or     $0xf,%ah
   413b6:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   413ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413bd:	8d 50 3f             	lea    0x3f(%rax),%edx
   413c0:	85 c0                	test   %eax,%eax
   413c2:	0f 48 c2             	cmovs  %edx,%eax
   413c5:	c1 f8 06             	sar    $0x6,%eax
   413c8:	8d 50 01             	lea    0x1(%rax),%edx
   413cb:	89 d0                	mov    %edx,%eax
   413cd:	c1 e0 02             	shl    $0x2,%eax
   413d0:	01 d0                	add    %edx,%eax
   413d2:	c1 e0 04             	shl    $0x4,%eax
   413d5:	89 c1                	mov    %eax,%ecx
   413d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413da:	99                   	cltd   
   413db:	c1 ea 1a             	shr    $0x1a,%edx
   413de:	01 d0                	add    %edx,%eax
   413e0:	83 e0 3f             	and    $0x3f,%eax
   413e3:	29 d0                	sub    %edx,%eax
   413e5:	83 c0 0c             	add    $0xc,%eax
   413e8:	01 c8                	add    %ecx,%eax
   413ea:	48 98                	cltq   
   413ec:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   413f0:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   413f7:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413f8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   413fc:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41403:	0f 8e ff fe ff ff    	jle    41308 <memshow_physical+0x2d>
    }
}
   41409:	90                   	nop
   4140a:	90                   	nop
   4140b:	c9                   	leave  
   4140c:	c3                   	ret    

000000000004140d <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   4140d:	55                   	push   %rbp
   4140e:	48 89 e5             	mov    %rsp,%rbp
   41411:	48 83 ec 40          	sub    $0x40,%rsp
   41415:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41419:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4141d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41421:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41427:	48 89 c2             	mov    %rax,%rdx
   4142a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4142e:	48 39 c2             	cmp    %rax,%rdx
   41431:	74 14                	je     41447 <memshow_virtual+0x3a>
   41433:	ba 50 4b 04 00       	mov    $0x44b50,%edx
   41438:	be b0 02 00 00       	mov    $0x2b0,%esi
   4143d:	bf c8 47 04 00       	mov    $0x447c8,%edi
   41442:	e8 46 12 00 00       	call   4268d <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41447:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4144b:	48 89 c1             	mov    %rax,%rcx
   4144e:	ba 7d 4b 04 00       	mov    $0x44b7d,%edx
   41453:	be 00 0f 00 00       	mov    $0xf00,%esi
   41458:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4145d:	b8 00 00 00 00       	mov    $0x0,%eax
   41462:	e8 de 26 00 00       	call   43b45 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41467:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4146e:	00 
   4146f:	e9 80 01 00 00       	jmp    415f4 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41474:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41478:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4147c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41480:	48 89 ce             	mov    %rcx,%rsi
   41483:	48 89 c7             	mov    %rax,%rdi
   41486:	e8 c4 18 00 00       	call   42d4f <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4148b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4148e:	85 c0                	test   %eax,%eax
   41490:	79 0b                	jns    4149d <memshow_virtual+0x90>
            color = ' ';
   41492:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41498:	e9 d7 00 00 00       	jmp    41574 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4149d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   414a1:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   414a7:	76 14                	jbe    414bd <memshow_virtual+0xb0>
   414a9:	ba 9a 4b 04 00       	mov    $0x44b9a,%edx
   414ae:	be b9 02 00 00       	mov    $0x2b9,%esi
   414b3:	bf c8 47 04 00       	mov    $0x447c8,%edi
   414b8:	e8 d0 11 00 00       	call   4268d <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   414bd:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414c0:	48 98                	cltq   
   414c2:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   414c9:	00 
   414ca:	0f be c0             	movsbl %al,%eax
   414cd:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   414d0:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414d3:	48 98                	cltq   
   414d5:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   414dc:	00 
   414dd:	84 c0                	test   %al,%al
   414df:	75 07                	jne    414e8 <memshow_virtual+0xdb>
                owner = PO_FREE;
   414e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   414e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   414eb:	83 c0 02             	add    $0x2,%eax
   414ee:	48 98                	cltq   
   414f0:	0f b7 84 00 60 47 04 	movzwl 0x44760(%rax,%rax,1),%eax
   414f7:	00 
   414f8:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   414fc:	8b 45 e0             	mov    -0x20(%rbp),%eax
   414ff:	48 98                	cltq   
   41501:	83 e0 04             	and    $0x4,%eax
   41504:	48 85 c0             	test   %rax,%rax
   41507:	74 27                	je     41530 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41509:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4150d:	c1 e0 04             	shl    $0x4,%eax
   41510:	66 25 00 f0          	and    $0xf000,%ax
   41514:	89 c2                	mov    %eax,%edx
   41516:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4151a:	c1 f8 04             	sar    $0x4,%eax
   4151d:	66 25 00 0f          	and    $0xf00,%ax
   41521:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41523:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41527:	0f b6 c0             	movzbl %al,%eax
   4152a:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4152c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41530:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41533:	48 98                	cltq   
   41535:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4153c:	00 
   4153d:	3c 01                	cmp    $0x1,%al
   4153f:	7e 33                	jle    41574 <memshow_virtual+0x167>
   41541:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41546:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4154a:	74 28                	je     41574 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   4154c:	b8 53 00 00 00       	mov    $0x53,%eax
   41551:	89 c2                	mov    %eax,%edx
   41553:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41557:	66 25 00 f0          	and    $0xf000,%ax
   4155b:	09 d0                	or     %edx,%eax
   4155d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41561:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41564:	48 98                	cltq   
   41566:	83 e0 04             	and    $0x4,%eax
   41569:	48 85 c0             	test   %rax,%rax
   4156c:	75 06                	jne    41574 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   4156e:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41574:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41578:	48 c1 e8 0c          	shr    $0xc,%rax
   4157c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   4157f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41582:	83 e0 3f             	and    $0x3f,%eax
   41585:	85 c0                	test   %eax,%eax
   41587:	75 34                	jne    415bd <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41589:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4158c:	c1 e8 06             	shr    $0x6,%eax
   4158f:	89 c2                	mov    %eax,%edx
   41591:	89 d0                	mov    %edx,%eax
   41593:	c1 e0 02             	shl    $0x2,%eax
   41596:	01 d0                	add    %edx,%eax
   41598:	c1 e0 04             	shl    $0x4,%eax
   4159b:	05 73 03 00 00       	add    $0x373,%eax
   415a0:	89 c7                	mov    %eax,%edi
   415a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415a6:	48 89 c1             	mov    %rax,%rcx
   415a9:	ba 48 4b 04 00       	mov    $0x44b48,%edx
   415ae:	be 00 0f 00 00       	mov    $0xf00,%esi
   415b3:	b8 00 00 00 00       	mov    $0x0,%eax
   415b8:	e8 88 25 00 00       	call   43b45 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   415bd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415c0:	c1 e8 06             	shr    $0x6,%eax
   415c3:	89 c2                	mov    %eax,%edx
   415c5:	89 d0                	mov    %edx,%eax
   415c7:	c1 e0 02             	shl    $0x2,%eax
   415ca:	01 d0                	add    %edx,%eax
   415cc:	c1 e0 04             	shl    $0x4,%eax
   415cf:	89 c2                	mov    %eax,%edx
   415d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415d4:	83 e0 3f             	and    $0x3f,%eax
   415d7:	01 d0                	add    %edx,%eax
   415d9:	05 7c 03 00 00       	add    $0x37c,%eax
   415de:	89 c2                	mov    %eax,%edx
   415e0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415e4:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   415eb:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   415ec:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   415f3:	00 
   415f4:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   415fb:	00 
   415fc:	0f 86 72 fe ff ff    	jbe    41474 <memshow_virtual+0x67>
    }
}
   41602:	90                   	nop
   41603:	90                   	nop
   41604:	c9                   	leave  
   41605:	c3                   	ret    

0000000000041606 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41606:	55                   	push   %rbp
   41607:	48 89 e5             	mov    %rsp,%rbp
   4160a:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4160e:	8b 05 10 0d 01 00    	mov    0x10d10(%rip),%eax        # 52324 <last_ticks.1>
   41614:	85 c0                	test   %eax,%eax
   41616:	74 13                	je     4162b <memshow_virtual_animate+0x25>
   41618:	8b 05 02 0d 01 00    	mov    0x10d02(%rip),%eax        # 52320 <ticks>
   4161e:	8b 15 00 0d 01 00    	mov    0x10d00(%rip),%edx        # 52324 <last_ticks.1>
   41624:	29 d0                	sub    %edx,%eax
   41626:	83 f8 31             	cmp    $0x31,%eax
   41629:	76 2c                	jbe    41657 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   4162b:	8b 05 ef 0c 01 00    	mov    0x10cef(%rip),%eax        # 52320 <ticks>
   41631:	89 05 ed 0c 01 00    	mov    %eax,0x10ced(%rip)        # 52324 <last_ticks.1>
        ++showing;
   41637:	8b 05 c7 49 00 00    	mov    0x49c7(%rip),%eax        # 46004 <showing.0>
   4163d:	83 c0 01             	add    $0x1,%eax
   41640:	89 05 be 49 00 00    	mov    %eax,0x49be(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41646:	eb 0f                	jmp    41657 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41648:	8b 05 b6 49 00 00    	mov    0x49b6(%rip),%eax        # 46004 <showing.0>
   4164e:	83 c0 01             	add    $0x1,%eax
   41651:	89 05 ad 49 00 00    	mov    %eax,0x49ad(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41657:	8b 05 a7 49 00 00    	mov    0x49a7(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   4165d:	83 f8 20             	cmp    $0x20,%eax
   41660:	7f 2e                	jg     41690 <memshow_virtual_animate+0x8a>
   41662:	8b 05 9c 49 00 00    	mov    0x499c(%rip),%eax        # 46004 <showing.0>
   41668:	99                   	cltd   
   41669:	c1 ea 1c             	shr    $0x1c,%edx
   4166c:	01 d0                	add    %edx,%eax
   4166e:	83 e0 0f             	and    $0xf,%eax
   41671:	29 d0                	sub    %edx,%eax
   41673:	48 63 d0             	movslq %eax,%rdx
   41676:	48 89 d0             	mov    %rdx,%rax
   41679:	48 c1 e0 04          	shl    $0x4,%rax
   4167d:	48 29 d0             	sub    %rdx,%rax
   41680:	48 c1 e0 04          	shl    $0x4,%rax
   41684:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4168a:	8b 00                	mov    (%rax),%eax
   4168c:	85 c0                	test   %eax,%eax
   4168e:	74 b8                	je     41648 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41690:	8b 05 6e 49 00 00    	mov    0x496e(%rip),%eax        # 46004 <showing.0>
   41696:	99                   	cltd   
   41697:	c1 ea 1c             	shr    $0x1c,%edx
   4169a:	01 d0                	add    %edx,%eax
   4169c:	83 e0 0f             	and    $0xf,%eax
   4169f:	29 d0                	sub    %edx,%eax
   416a1:	89 05 5d 49 00 00    	mov    %eax,0x495d(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   416a7:	8b 05 57 49 00 00    	mov    0x4957(%rip),%eax        # 46004 <showing.0>
   416ad:	48 63 d0             	movslq %eax,%rdx
   416b0:	48 89 d0             	mov    %rdx,%rax
   416b3:	48 c1 e0 04          	shl    $0x4,%rax
   416b7:	48 29 d0             	sub    %rdx,%rax
   416ba:	48 c1 e0 04          	shl    $0x4,%rax
   416be:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   416c4:	8b 00                	mov    (%rax),%eax
   416c6:	85 c0                	test   %eax,%eax
   416c8:	74 76                	je     41740 <memshow_virtual_animate+0x13a>
   416ca:	8b 05 34 49 00 00    	mov    0x4934(%rip),%eax        # 46004 <showing.0>
   416d0:	48 63 d0             	movslq %eax,%rdx
   416d3:	48 89 d0             	mov    %rdx,%rax
   416d6:	48 c1 e0 04          	shl    $0x4,%rax
   416da:	48 29 d0             	sub    %rdx,%rax
   416dd:	48 c1 e0 04          	shl    $0x4,%rax
   416e1:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   416e7:	0f b6 00             	movzbl (%rax),%eax
   416ea:	84 c0                	test   %al,%al
   416ec:	74 52                	je     41740 <memshow_virtual_animate+0x13a>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   416ee:	8b 15 10 49 00 00    	mov    0x4910(%rip),%edx        # 46004 <showing.0>
   416f4:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   416f8:	89 d1                	mov    %edx,%ecx
   416fa:	ba b4 4b 04 00       	mov    $0x44bb4,%edx
   416ff:	be 04 00 00 00       	mov    $0x4,%esi
   41704:	48 89 c7             	mov    %rax,%rdi
   41707:	b8 00 00 00 00       	mov    $0x0,%eax
   4170c:	e8 b2 24 00 00       	call   43bc3 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41711:	8b 05 ed 48 00 00    	mov    0x48ed(%rip),%eax        # 46004 <showing.0>
   41717:	48 63 d0             	movslq %eax,%rdx
   4171a:	48 89 d0             	mov    %rdx,%rax
   4171d:	48 c1 e0 04          	shl    $0x4,%rax
   41721:	48 29 d0             	sub    %rdx,%rax
   41724:	48 c1 e0 04          	shl    $0x4,%rax
   41728:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   4172e:	48 8b 00             	mov    (%rax),%rax
   41731:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41735:	48 89 d6             	mov    %rdx,%rsi
   41738:	48 89 c7             	mov    %rax,%rdi
   4173b:	e8 cd fc ff ff       	call   4140d <memshow_virtual>
    }
}
   41740:	90                   	nop
   41741:	c9                   	leave  
   41742:	c3                   	ret    

0000000000041743 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41743:	55                   	push   %rbp
   41744:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41747:	e8 53 01 00 00       	call   4189f <segments_init>
    interrupt_init();
   4174c:	e8 d4 03 00 00       	call   41b25 <interrupt_init>
    virtual_memory_init();
   41751:	e8 f2 0f 00 00       	call   42748 <virtual_memory_init>
}
   41756:	90                   	nop
   41757:	5d                   	pop    %rbp
   41758:	c3                   	ret    

0000000000041759 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41759:	55                   	push   %rbp
   4175a:	48 89 e5             	mov    %rsp,%rbp
   4175d:	48 83 ec 18          	sub    $0x18,%rsp
   41761:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41765:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41769:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   4176c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4176f:	48 98                	cltq   
   41771:	48 c1 e0 2d          	shl    $0x2d,%rax
   41775:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41779:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41780:	90 00 00 
   41783:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41786:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4178a:	48 89 10             	mov    %rdx,(%rax)
}
   4178d:	90                   	nop
   4178e:	c9                   	leave  
   4178f:	c3                   	ret    

0000000000041790 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41790:	55                   	push   %rbp
   41791:	48 89 e5             	mov    %rsp,%rbp
   41794:	48 83 ec 28          	sub    $0x28,%rsp
   41798:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4179c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417a0:	89 55 ec             	mov    %edx,-0x14(%rbp)
   417a3:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   417a7:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   417ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417af:	48 c1 e0 10          	shl    $0x10,%rax
   417b3:	48 89 c2             	mov    %rax,%rdx
   417b6:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   417bd:	00 00 00 
   417c0:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   417c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417c7:	48 c1 e0 20          	shl    $0x20,%rax
   417cb:	48 89 c1             	mov    %rax,%rcx
   417ce:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   417d5:	00 00 ff 
   417d8:	48 21 c8             	and    %rcx,%rax
   417db:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   417de:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   417e2:	48 83 e8 01          	sub    $0x1,%rax
   417e6:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   417e9:	48 09 d0             	or     %rdx,%rax
        | type
   417ec:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   417f0:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   417f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417f6:	48 98                	cltq   
   417f8:	48 c1 e0 2d          	shl    $0x2d,%rax
   417fc:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   417ff:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41806:	80 00 00 
   41809:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4180c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41810:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41813:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41817:	48 83 c0 08          	add    $0x8,%rax
   4181b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4181f:	48 c1 ea 20          	shr    $0x20,%rdx
   41823:	48 89 10             	mov    %rdx,(%rax)
}
   41826:	90                   	nop
   41827:	c9                   	leave  
   41828:	c3                   	ret    

0000000000041829 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41829:	55                   	push   %rbp
   4182a:	48 89 e5             	mov    %rsp,%rbp
   4182d:	48 83 ec 20          	sub    $0x20,%rsp
   41831:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41835:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41839:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4183c:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41840:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41844:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41847:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   4184b:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   4184e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41851:	48 98                	cltq   
   41853:	48 c1 e0 2d          	shl    $0x2d,%rax
   41857:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4185a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4185e:	48 c1 e0 20          	shl    $0x20,%rax
   41862:	48 89 c1             	mov    %rax,%rcx
   41865:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4186c:	00 ff ff 
   4186f:	48 21 c8             	and    %rcx,%rax
   41872:	48 09 c2             	or     %rax,%rdx
   41875:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4187c:	80 00 00 
   4187f:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41882:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41886:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41889:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4188d:	48 c1 e8 20          	shr    $0x20,%rax
   41891:	48 89 c2             	mov    %rax,%rdx
   41894:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41898:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4189c:	90                   	nop
   4189d:	c9                   	leave  
   4189e:	c3                   	ret    

000000000004189f <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   4189f:	55                   	push   %rbp
   418a0:	48 89 e5             	mov    %rsp,%rbp
   418a3:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   418a7:	48 c7 05 8e 0a 01 00 	movq   $0x0,0x10a8e(%rip)        # 52340 <segments>
   418ae:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   418b2:	ba 00 00 00 00       	mov    $0x0,%edx
   418b7:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   418be:	08 20 00 
   418c1:	48 89 c6             	mov    %rax,%rsi
   418c4:	bf 48 23 05 00       	mov    $0x52348,%edi
   418c9:	e8 8b fe ff ff       	call   41759 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   418ce:	ba 03 00 00 00       	mov    $0x3,%edx
   418d3:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   418da:	08 20 00 
   418dd:	48 89 c6             	mov    %rax,%rsi
   418e0:	bf 50 23 05 00       	mov    $0x52350,%edi
   418e5:	e8 6f fe ff ff       	call   41759 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   418ea:	ba 00 00 00 00       	mov    $0x0,%edx
   418ef:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   418f6:	02 00 00 
   418f9:	48 89 c6             	mov    %rax,%rsi
   418fc:	bf 58 23 05 00       	mov    $0x52358,%edi
   41901:	e8 53 fe ff ff       	call   41759 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41906:	ba 03 00 00 00       	mov    $0x3,%edx
   4190b:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41912:	02 00 00 
   41915:	48 89 c6             	mov    %rax,%rsi
   41918:	bf 60 23 05 00       	mov    $0x52360,%edi
   4191d:	e8 37 fe ff ff       	call   41759 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41922:	b8 80 33 05 00       	mov    $0x53380,%eax
   41927:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   4192d:	48 89 c1             	mov    %rax,%rcx
   41930:	ba 00 00 00 00       	mov    $0x0,%edx
   41935:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4193c:	09 00 00 
   4193f:	48 89 c6             	mov    %rax,%rsi
   41942:	bf 68 23 05 00       	mov    $0x52368,%edi
   41947:	e8 44 fe ff ff       	call   41790 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4194c:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41952:	b8 40 23 05 00       	mov    $0x52340,%eax
   41957:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4195b:	ba 60 00 00 00       	mov    $0x60,%edx
   41960:	be 00 00 00 00       	mov    $0x0,%esi
   41965:	bf 80 33 05 00       	mov    $0x53380,%edi
   4196a:	e8 a1 19 00 00       	call   43310 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   4196f:	48 c7 05 0a 1a 01 00 	movq   $0x80000,0x11a0a(%rip)        # 53384 <kernel_task_descriptor+0x4>
   41976:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4197a:	ba 00 10 00 00       	mov    $0x1000,%edx
   4197f:	be 00 00 00 00       	mov    $0x0,%esi
   41984:	bf 80 23 05 00       	mov    $0x52380,%edi
   41989:	e8 82 19 00 00       	call   43310 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4198e:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41995:	eb 30                	jmp    419c7 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41997:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4199c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4199f:	48 c1 e0 04          	shl    $0x4,%rax
   419a3:	48 05 80 23 05 00    	add    $0x52380,%rax
   419a9:	48 89 d1             	mov    %rdx,%rcx
   419ac:	ba 00 00 00 00       	mov    $0x0,%edx
   419b1:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419b8:	0e 00 00 
   419bb:	48 89 c7             	mov    %rax,%rdi
   419be:	e8 66 fe ff ff       	call   41829 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   419c3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   419c7:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   419ce:	76 c7                	jbe    41997 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   419d0:	b8 36 00 04 00       	mov    $0x40036,%eax
   419d5:	48 89 c1             	mov    %rax,%rcx
   419d8:	ba 00 00 00 00       	mov    $0x0,%edx
   419dd:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   419e4:	0e 00 00 
   419e7:	48 89 c6             	mov    %rax,%rsi
   419ea:	bf 80 25 05 00       	mov    $0x52580,%edi
   419ef:	e8 35 fe ff ff       	call   41829 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   419f4:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   419f9:	48 89 c1             	mov    %rax,%rcx
   419fc:	ba 00 00 00 00       	mov    $0x0,%edx
   41a01:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a08:	0e 00 00 
   41a0b:	48 89 c6             	mov    %rax,%rsi
   41a0e:	bf 50 24 05 00       	mov    $0x52450,%edi
   41a13:	e8 11 fe ff ff       	call   41829 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41a18:	b8 32 00 04 00       	mov    $0x40032,%eax
   41a1d:	48 89 c1             	mov    %rax,%rcx
   41a20:	ba 00 00 00 00       	mov    $0x0,%edx
   41a25:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a2c:	0e 00 00 
   41a2f:	48 89 c6             	mov    %rax,%rsi
   41a32:	bf 60 24 05 00       	mov    $0x52460,%edi
   41a37:	e8 ed fd ff ff       	call   41829 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41a3c:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41a43:	eb 3e                	jmp    41a83 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41a45:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a48:	83 e8 30             	sub    $0x30,%eax
   41a4b:	89 c0                	mov    %eax,%eax
   41a4d:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41a54:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41a55:	48 89 c2             	mov    %rax,%rdx
   41a58:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a5b:	48 c1 e0 04          	shl    $0x4,%rax
   41a5f:	48 05 80 23 05 00    	add    $0x52380,%rax
   41a65:	48 89 d1             	mov    %rdx,%rcx
   41a68:	ba 03 00 00 00       	mov    $0x3,%edx
   41a6d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a74:	0e 00 00 
   41a77:	48 89 c7             	mov    %rax,%rdi
   41a7a:	e8 aa fd ff ff       	call   41829 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41a7f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41a83:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41a87:	76 bc                	jbe    41a45 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41a89:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41a8f:	b8 80 23 05 00       	mov    $0x52380,%eax
   41a94:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41a98:	b8 28 00 00 00       	mov    $0x28,%eax
   41a9d:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41aa1:	0f 00 d8             	ltr    %ax
   41aa4:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41aa8:	0f 20 c0             	mov    %cr0,%rax
   41aab:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41aaf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41ab3:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41ab6:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41abd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ac0:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41ac3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ac6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41aca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41ace:	0f 22 c0             	mov    %rax,%cr0
}
   41ad1:	90                   	nop
    lcr0(cr0);
}
   41ad2:	90                   	nop
   41ad3:	c9                   	leave  
   41ad4:	c3                   	ret    

0000000000041ad5 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41ad5:	55                   	push   %rbp
   41ad6:	48 89 e5             	mov    %rsp,%rbp
   41ad9:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41add:	0f b7 05 fc 18 01 00 	movzwl 0x118fc(%rip),%eax        # 533e0 <interrupts_enabled>
   41ae4:	f7 d0                	not    %eax
   41ae6:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41aea:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41aee:	0f b6 c0             	movzbl %al,%eax
   41af1:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41af8:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41afb:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41aff:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41b02:	ee                   	out    %al,(%dx)
}
   41b03:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41b04:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b08:	66 c1 e8 08          	shr    $0x8,%ax
   41b0c:	0f b6 c0             	movzbl %al,%eax
   41b0f:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41b16:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b19:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41b1d:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41b20:	ee                   	out    %al,(%dx)
}
   41b21:	90                   	nop
}
   41b22:	90                   	nop
   41b23:	c9                   	leave  
   41b24:	c3                   	ret    

0000000000041b25 <interrupt_init>:

void interrupt_init(void) {
   41b25:	55                   	push   %rbp
   41b26:	48 89 e5             	mov    %rsp,%rbp
   41b29:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41b2d:	66 c7 05 aa 18 01 00 	movw   $0x0,0x118aa(%rip)        # 533e0 <interrupts_enabled>
   41b34:	00 00 
    interrupt_mask();
   41b36:	e8 9a ff ff ff       	call   41ad5 <interrupt_mask>
   41b3b:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41b42:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b46:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41b4a:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41b4d:	ee                   	out    %al,(%dx)
}
   41b4e:	90                   	nop
   41b4f:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41b56:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b5a:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41b5e:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41b61:	ee                   	out    %al,(%dx)
}
   41b62:	90                   	nop
   41b63:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41b6a:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b6e:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41b72:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41b75:	ee                   	out    %al,(%dx)
}
   41b76:	90                   	nop
   41b77:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41b7e:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b82:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41b86:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41b89:	ee                   	out    %al,(%dx)
}
   41b8a:	90                   	nop
   41b8b:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41b92:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b96:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41b9a:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41b9d:	ee                   	out    %al,(%dx)
}
   41b9e:	90                   	nop
   41b9f:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41ba6:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41baa:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41bae:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41bb1:	ee                   	out    %al,(%dx)
}
   41bb2:	90                   	nop
   41bb3:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41bba:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bbe:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41bc2:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41bc5:	ee                   	out    %al,(%dx)
}
   41bc6:	90                   	nop
   41bc7:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41bce:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bd2:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41bd6:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41bd9:	ee                   	out    %al,(%dx)
}
   41bda:	90                   	nop
   41bdb:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41be2:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41be6:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41bea:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41bed:	ee                   	out    %al,(%dx)
}
   41bee:	90                   	nop
   41bef:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41bf6:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bfa:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41bfe:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c01:	ee                   	out    %al,(%dx)
}
   41c02:	90                   	nop
   41c03:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41c0a:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c0e:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c12:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c15:	ee                   	out    %al,(%dx)
}
   41c16:	90                   	nop
   41c17:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41c1e:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c22:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c26:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c29:	ee                   	out    %al,(%dx)
}
   41c2a:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41c2b:	e8 a5 fe ff ff       	call   41ad5 <interrupt_mask>
}
   41c30:	90                   	nop
   41c31:	c9                   	leave  
   41c32:	c3                   	ret    

0000000000041c33 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41c33:	55                   	push   %rbp
   41c34:	48 89 e5             	mov    %rsp,%rbp
   41c37:	48 83 ec 28          	sub    $0x28,%rsp
   41c3b:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41c3e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c42:	0f 8e 9f 00 00 00    	jle    41ce7 <timer_init+0xb4>
   41c48:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41c4f:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c53:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c57:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c5a:	ee                   	out    %al,(%dx)
}
   41c5b:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41c5c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c5f:	89 c2                	mov    %eax,%edx
   41c61:	c1 ea 1f             	shr    $0x1f,%edx
   41c64:	01 d0                	add    %edx,%eax
   41c66:	d1 f8                	sar    %eax
   41c68:	05 de 34 12 00       	add    $0x1234de,%eax
   41c6d:	99                   	cltd   
   41c6e:	f7 7d dc             	idivl  -0x24(%rbp)
   41c71:	89 c2                	mov    %eax,%edx
   41c73:	89 d0                	mov    %edx,%eax
   41c75:	c1 f8 1f             	sar    $0x1f,%eax
   41c78:	c1 e8 18             	shr    $0x18,%eax
   41c7b:	89 c1                	mov    %eax,%ecx
   41c7d:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41c80:	0f b6 c0             	movzbl %al,%eax
   41c83:	29 c8                	sub    %ecx,%eax
   41c85:	0f b6 c0             	movzbl %al,%eax
   41c88:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41c8f:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c92:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c96:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c99:	ee                   	out    %al,(%dx)
}
   41c9a:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41c9b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c9e:	89 c2                	mov    %eax,%edx
   41ca0:	c1 ea 1f             	shr    $0x1f,%edx
   41ca3:	01 d0                	add    %edx,%eax
   41ca5:	d1 f8                	sar    %eax
   41ca7:	05 de 34 12 00       	add    $0x1234de,%eax
   41cac:	99                   	cltd   
   41cad:	f7 7d dc             	idivl  -0x24(%rbp)
   41cb0:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41cb6:	85 c0                	test   %eax,%eax
   41cb8:	0f 48 c2             	cmovs  %edx,%eax
   41cbb:	c1 f8 08             	sar    $0x8,%eax
   41cbe:	0f b6 c0             	movzbl %al,%eax
   41cc1:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41cc8:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ccb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ccf:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cd2:	ee                   	out    %al,(%dx)
}
   41cd3:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41cd4:	0f b7 05 05 17 01 00 	movzwl 0x11705(%rip),%eax        # 533e0 <interrupts_enabled>
   41cdb:	83 c8 01             	or     $0x1,%eax
   41cde:	66 89 05 fb 16 01 00 	mov    %ax,0x116fb(%rip)        # 533e0 <interrupts_enabled>
   41ce5:	eb 11                	jmp    41cf8 <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41ce7:	0f b7 05 f2 16 01 00 	movzwl 0x116f2(%rip),%eax        # 533e0 <interrupts_enabled>
   41cee:	83 e0 fe             	and    $0xfffffffe,%eax
   41cf1:	66 89 05 e8 16 01 00 	mov    %ax,0x116e8(%rip)        # 533e0 <interrupts_enabled>
    }
    interrupt_mask();
   41cf8:	e8 d8 fd ff ff       	call   41ad5 <interrupt_mask>
}
   41cfd:	90                   	nop
   41cfe:	c9                   	leave  
   41cff:	c3                   	ret    

0000000000041d00 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41d00:	55                   	push   %rbp
   41d01:	48 89 e5             	mov    %rsp,%rbp
   41d04:	48 83 ec 08          	sub    $0x8,%rsp
   41d08:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41d0c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41d11:	74 14                	je     41d27 <physical_memory_isreserved+0x27>
   41d13:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41d1a:	00 
   41d1b:	76 11                	jbe    41d2e <physical_memory_isreserved+0x2e>
   41d1d:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41d24:	00 
   41d25:	77 07                	ja     41d2e <physical_memory_isreserved+0x2e>
   41d27:	b8 01 00 00 00       	mov    $0x1,%eax
   41d2c:	eb 05                	jmp    41d33 <physical_memory_isreserved+0x33>
   41d2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41d33:	c9                   	leave  
   41d34:	c3                   	ret    

0000000000041d35 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41d35:	55                   	push   %rbp
   41d36:	48 89 e5             	mov    %rsp,%rbp
   41d39:	48 83 ec 10          	sub    $0x10,%rsp
   41d3d:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41d40:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41d43:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41d46:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d49:	c1 e0 10             	shl    $0x10,%eax
   41d4c:	89 c2                	mov    %eax,%edx
   41d4e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d51:	c1 e0 0b             	shl    $0xb,%eax
   41d54:	09 c2                	or     %eax,%edx
   41d56:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d59:	c1 e0 08             	shl    $0x8,%eax
   41d5c:	09 d0                	or     %edx,%eax
}
   41d5e:	c9                   	leave  
   41d5f:	c3                   	ret    

0000000000041d60 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41d60:	55                   	push   %rbp
   41d61:	48 89 e5             	mov    %rsp,%rbp
   41d64:	48 83 ec 18          	sub    $0x18,%rsp
   41d68:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41d6b:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41d6e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d71:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41d74:	09 d0                	or     %edx,%eax
   41d76:	0d 00 00 00 80       	or     $0x80000000,%eax
   41d7b:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41d82:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41d85:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d88:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d8b:	ef                   	out    %eax,(%dx)
}
   41d8c:	90                   	nop
   41d8d:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41d94:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d97:	89 c2                	mov    %eax,%edx
   41d99:	ed                   	in     (%dx),%eax
   41d9a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41d9d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41da0:	c9                   	leave  
   41da1:	c3                   	ret    

0000000000041da2 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41da2:	55                   	push   %rbp
   41da3:	48 89 e5             	mov    %rsp,%rbp
   41da6:	48 83 ec 28          	sub    $0x28,%rsp
   41daa:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41dad:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41db0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41db7:	eb 73                	jmp    41e2c <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41db9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41dc0:	eb 60                	jmp    41e22 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41dc2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41dc9:	eb 4a                	jmp    41e15 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41dcb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dce:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41dd1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dd4:	89 ce                	mov    %ecx,%esi
   41dd6:	89 c7                	mov    %eax,%edi
   41dd8:	e8 58 ff ff ff       	call   41d35 <pci_make_configaddr>
   41ddd:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41de0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41de3:	be 00 00 00 00       	mov    $0x0,%esi
   41de8:	89 c7                	mov    %eax,%edi
   41dea:	e8 71 ff ff ff       	call   41d60 <pci_config_readl>
   41def:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41df2:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41df5:	c1 e0 10             	shl    $0x10,%eax
   41df8:	0b 45 dc             	or     -0x24(%rbp),%eax
   41dfb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41dfe:	75 05                	jne    41e05 <pci_find_device+0x63>
                    return configaddr;
   41e00:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e03:	eb 35                	jmp    41e3a <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41e05:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41e09:	75 06                	jne    41e11 <pci_find_device+0x6f>
   41e0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41e0f:	74 0c                	je     41e1d <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41e11:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41e15:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41e19:	75 b0                	jne    41dcb <pci_find_device+0x29>
   41e1b:	eb 01                	jmp    41e1e <pci_find_device+0x7c>
                    break;
   41e1d:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41e1e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41e22:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41e26:	75 9a                	jne    41dc2 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41e28:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41e2c:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41e33:	75 84                	jne    41db9 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41e35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41e3a:	c9                   	leave  
   41e3b:	c3                   	ret    

0000000000041e3c <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41e3c:	55                   	push   %rbp
   41e3d:	48 89 e5             	mov    %rsp,%rbp
   41e40:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41e44:	be 13 71 00 00       	mov    $0x7113,%esi
   41e49:	bf 86 80 00 00       	mov    $0x8086,%edi
   41e4e:	e8 4f ff ff ff       	call   41da2 <pci_find_device>
   41e53:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41e56:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41e5a:	78 30                	js     41e8c <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41e5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e5f:	be 40 00 00 00       	mov    $0x40,%esi
   41e64:	89 c7                	mov    %eax,%edi
   41e66:	e8 f5 fe ff ff       	call   41d60 <pci_config_readl>
   41e6b:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41e70:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41e73:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e76:	83 c0 04             	add    $0x4,%eax
   41e79:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41e7c:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41e82:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41e86:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e89:	66 ef                	out    %ax,(%dx)
}
   41e8b:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41e8c:	ba c0 4b 04 00       	mov    $0x44bc0,%edx
   41e91:	be 00 c0 00 00       	mov    $0xc000,%esi
   41e96:	bf 80 07 00 00       	mov    $0x780,%edi
   41e9b:	b8 00 00 00 00       	mov    $0x0,%eax
   41ea0:	e8 a0 1c 00 00       	call   43b45 <console_printf>
 spinloop: goto spinloop;
   41ea5:	eb fe                	jmp    41ea5 <poweroff+0x69>

0000000000041ea7 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41ea7:	55                   	push   %rbp
   41ea8:	48 89 e5             	mov    %rsp,%rbp
   41eab:	48 83 ec 10          	sub    $0x10,%rsp
   41eaf:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41eb6:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eba:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ebe:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ec1:	ee                   	out    %al,(%dx)
}
   41ec2:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41ec3:	eb fe                	jmp    41ec3 <reboot+0x1c>

0000000000041ec5 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41ec5:	55                   	push   %rbp
   41ec6:	48 89 e5             	mov    %rsp,%rbp
   41ec9:	48 83 ec 10          	sub    $0x10,%rsp
   41ecd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ed1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41ed4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ed8:	48 83 c0 18          	add    $0x18,%rax
   41edc:	ba c0 00 00 00       	mov    $0xc0,%edx
   41ee1:	be 00 00 00 00       	mov    $0x0,%esi
   41ee6:	48 89 c7             	mov    %rax,%rdi
   41ee9:	e8 22 14 00 00       	call   43310 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41eee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ef2:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41ef9:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41efb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eff:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41f06:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f0e:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41f15:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41f19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f1d:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41f24:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41f26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f2a:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41f31:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41f35:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f38:	83 e0 01             	and    $0x1,%eax
   41f3b:	85 c0                	test   %eax,%eax
   41f3d:	74 1c                	je     41f5b <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41f3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f43:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41f4a:	80 cc 30             	or     $0x30,%ah
   41f4d:	48 89 c2             	mov    %rax,%rdx
   41f50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f54:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41f5b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f5e:	83 e0 02             	and    $0x2,%eax
   41f61:	85 c0                	test   %eax,%eax
   41f63:	74 1c                	je     41f81 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41f65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f69:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41f70:	80 e4 fd             	and    $0xfd,%ah
   41f73:	48 89 c2             	mov    %rax,%rdx
   41f76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f7a:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41f81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f85:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41f8c:	90                   	nop
   41f8d:	c9                   	leave  
   41f8e:	c3                   	ret    

0000000000041f8f <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41f8f:	55                   	push   %rbp
   41f90:	48 89 e5             	mov    %rsp,%rbp
   41f93:	48 83 ec 28          	sub    $0x28,%rsp
   41f97:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41f9a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41f9e:	78 09                	js     41fa9 <console_show_cursor+0x1a>
   41fa0:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41fa7:	7e 07                	jle    41fb0 <console_show_cursor+0x21>
        cpos = 0;
   41fa9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41fb0:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41fb7:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fbb:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41fbf:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41fc2:	ee                   	out    %al,(%dx)
}
   41fc3:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41fc4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41fc7:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41fcd:	85 c0                	test   %eax,%eax
   41fcf:	0f 48 c2             	cmovs  %edx,%eax
   41fd2:	c1 f8 08             	sar    $0x8,%eax
   41fd5:	0f b6 c0             	movzbl %al,%eax
   41fd8:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41fdf:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fe2:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41fe6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41fe9:	ee                   	out    %al,(%dx)
}
   41fea:	90                   	nop
   41feb:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41ff2:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff6:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ffa:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ffd:	ee                   	out    %al,(%dx)
}
   41ffe:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41fff:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42002:	99                   	cltd   
   42003:	c1 ea 18             	shr    $0x18,%edx
   42006:	01 d0                	add    %edx,%eax
   42008:	0f b6 c0             	movzbl %al,%eax
   4200b:	29 d0                	sub    %edx,%eax
   4200d:	0f b6 c0             	movzbl %al,%eax
   42010:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42017:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4201a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4201e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42021:	ee                   	out    %al,(%dx)
}
   42022:	90                   	nop
}
   42023:	90                   	nop
   42024:	c9                   	leave  
   42025:	c3                   	ret    

0000000000042026 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42026:	55                   	push   %rbp
   42027:	48 89 e5             	mov    %rsp,%rbp
   4202a:	48 83 ec 20          	sub    $0x20,%rsp
   4202e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42035:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42038:	89 c2                	mov    %eax,%edx
   4203a:	ec                   	in     (%dx),%al
   4203b:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4203e:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42042:	0f b6 c0             	movzbl %al,%eax
   42045:	83 e0 01             	and    $0x1,%eax
   42048:	85 c0                	test   %eax,%eax
   4204a:	75 0a                	jne    42056 <keyboard_readc+0x30>
        return -1;
   4204c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42051:	e9 e7 01 00 00       	jmp    4223d <keyboard_readc+0x217>
   42056:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4205d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42060:	89 c2                	mov    %eax,%edx
   42062:	ec                   	in     (%dx),%al
   42063:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42066:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4206a:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   4206d:	0f b6 05 6e 13 01 00 	movzbl 0x1136e(%rip),%eax        # 533e2 <last_escape.2>
   42074:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42077:	c6 05 64 13 01 00 00 	movb   $0x0,0x11364(%rip)        # 533e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   4207e:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42082:	75 11                	jne    42095 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42084:	c6 05 57 13 01 00 80 	movb   $0x80,0x11357(%rip)        # 533e2 <last_escape.2>
        return 0;
   4208b:	b8 00 00 00 00       	mov    $0x0,%eax
   42090:	e9 a8 01 00 00       	jmp    4223d <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42095:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42099:	84 c0                	test   %al,%al
   4209b:	79 60                	jns    420fd <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   4209d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420a1:	83 e0 7f             	and    $0x7f,%eax
   420a4:	89 c2                	mov    %eax,%edx
   420a6:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   420aa:	09 d0                	or     %edx,%eax
   420ac:	48 98                	cltq   
   420ae:	0f b6 80 e0 4b 04 00 	movzbl 0x44be0(%rax),%eax
   420b5:	0f b6 c0             	movzbl %al,%eax
   420b8:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   420bb:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   420c2:	7e 2f                	jle    420f3 <keyboard_readc+0xcd>
   420c4:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   420cb:	7f 26                	jg     420f3 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   420cd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420d0:	2d fa 00 00 00       	sub    $0xfa,%eax
   420d5:	ba 01 00 00 00       	mov    $0x1,%edx
   420da:	89 c1                	mov    %eax,%ecx
   420dc:	d3 e2                	shl    %cl,%edx
   420de:	89 d0                	mov    %edx,%eax
   420e0:	f7 d0                	not    %eax
   420e2:	89 c2                	mov    %eax,%edx
   420e4:	0f b6 05 f8 12 01 00 	movzbl 0x112f8(%rip),%eax        # 533e3 <modifiers.1>
   420eb:	21 d0                	and    %edx,%eax
   420ed:	88 05 f0 12 01 00    	mov    %al,0x112f0(%rip)        # 533e3 <modifiers.1>
        }
        return 0;
   420f3:	b8 00 00 00 00       	mov    $0x0,%eax
   420f8:	e9 40 01 00 00       	jmp    4223d <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   420fd:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42101:	0a 45 fa             	or     -0x6(%rbp),%al
   42104:	0f b6 c0             	movzbl %al,%eax
   42107:	48 98                	cltq   
   42109:	0f b6 80 e0 4b 04 00 	movzbl 0x44be0(%rax),%eax
   42110:	0f b6 c0             	movzbl %al,%eax
   42113:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42116:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4211a:	7e 57                	jle    42173 <keyboard_readc+0x14d>
   4211c:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42120:	7f 51                	jg     42173 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42122:	0f b6 05 ba 12 01 00 	movzbl 0x112ba(%rip),%eax        # 533e3 <modifiers.1>
   42129:	0f b6 c0             	movzbl %al,%eax
   4212c:	83 e0 02             	and    $0x2,%eax
   4212f:	85 c0                	test   %eax,%eax
   42131:	74 09                	je     4213c <keyboard_readc+0x116>
            ch -= 0x60;
   42133:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42137:	e9 fd 00 00 00       	jmp    42239 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4213c:	0f b6 05 a0 12 01 00 	movzbl 0x112a0(%rip),%eax        # 533e3 <modifiers.1>
   42143:	0f b6 c0             	movzbl %al,%eax
   42146:	83 e0 01             	and    $0x1,%eax
   42149:	85 c0                	test   %eax,%eax
   4214b:	0f 94 c2             	sete   %dl
   4214e:	0f b6 05 8e 12 01 00 	movzbl 0x1128e(%rip),%eax        # 533e3 <modifiers.1>
   42155:	0f b6 c0             	movzbl %al,%eax
   42158:	83 e0 08             	and    $0x8,%eax
   4215b:	85 c0                	test   %eax,%eax
   4215d:	0f 94 c0             	sete   %al
   42160:	31 d0                	xor    %edx,%eax
   42162:	84 c0                	test   %al,%al
   42164:	0f 84 cf 00 00 00    	je     42239 <keyboard_readc+0x213>
            ch -= 0x20;
   4216a:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4216e:	e9 c6 00 00 00       	jmp    42239 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42173:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4217a:	7e 30                	jle    421ac <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4217c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4217f:	2d fa 00 00 00       	sub    $0xfa,%eax
   42184:	ba 01 00 00 00       	mov    $0x1,%edx
   42189:	89 c1                	mov    %eax,%ecx
   4218b:	d3 e2                	shl    %cl,%edx
   4218d:	89 d0                	mov    %edx,%eax
   4218f:	89 c2                	mov    %eax,%edx
   42191:	0f b6 05 4b 12 01 00 	movzbl 0x1124b(%rip),%eax        # 533e3 <modifiers.1>
   42198:	31 d0                	xor    %edx,%eax
   4219a:	88 05 43 12 01 00    	mov    %al,0x11243(%rip)        # 533e3 <modifiers.1>
        ch = 0;
   421a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421a7:	e9 8e 00 00 00       	jmp    4223a <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   421ac:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   421b3:	7e 2d                	jle    421e2 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   421b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421b8:	2d fa 00 00 00       	sub    $0xfa,%eax
   421bd:	ba 01 00 00 00       	mov    $0x1,%edx
   421c2:	89 c1                	mov    %eax,%ecx
   421c4:	d3 e2                	shl    %cl,%edx
   421c6:	89 d0                	mov    %edx,%eax
   421c8:	89 c2                	mov    %eax,%edx
   421ca:	0f b6 05 12 12 01 00 	movzbl 0x11212(%rip),%eax        # 533e3 <modifiers.1>
   421d1:	09 d0                	or     %edx,%eax
   421d3:	88 05 0a 12 01 00    	mov    %al,0x1120a(%rip)        # 533e3 <modifiers.1>
        ch = 0;
   421d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421e0:	eb 58                	jmp    4223a <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   421e2:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   421e6:	7e 31                	jle    42219 <keyboard_readc+0x1f3>
   421e8:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   421ef:	7f 28                	jg     42219 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   421f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421f4:	8d 50 80             	lea    -0x80(%rax),%edx
   421f7:	0f b6 05 e5 11 01 00 	movzbl 0x111e5(%rip),%eax        # 533e3 <modifiers.1>
   421fe:	0f b6 c0             	movzbl %al,%eax
   42201:	83 e0 03             	and    $0x3,%eax
   42204:	48 98                	cltq   
   42206:	48 63 d2             	movslq %edx,%rdx
   42209:	0f b6 84 90 e0 4c 04 	movzbl 0x44ce0(%rax,%rdx,4),%eax
   42210:	00 
   42211:	0f b6 c0             	movzbl %al,%eax
   42214:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42217:	eb 21                	jmp    4223a <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42219:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4221d:	7f 1b                	jg     4223a <keyboard_readc+0x214>
   4221f:	0f b6 05 bd 11 01 00 	movzbl 0x111bd(%rip),%eax        # 533e3 <modifiers.1>
   42226:	0f b6 c0             	movzbl %al,%eax
   42229:	83 e0 02             	and    $0x2,%eax
   4222c:	85 c0                	test   %eax,%eax
   4222e:	74 0a                	je     4223a <keyboard_readc+0x214>
        ch = 0;
   42230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42237:	eb 01                	jmp    4223a <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42239:	90                   	nop
    }

    return ch;
   4223a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4223d:	c9                   	leave  
   4223e:	c3                   	ret    

000000000004223f <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4223f:	55                   	push   %rbp
   42240:	48 89 e5             	mov    %rsp,%rbp
   42243:	48 83 ec 20          	sub    $0x20,%rsp
   42247:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4224e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42251:	89 c2                	mov    %eax,%edx
   42253:	ec                   	in     (%dx),%al
   42254:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42257:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4225e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42261:	89 c2                	mov    %eax,%edx
   42263:	ec                   	in     (%dx),%al
   42264:	88 45 eb             	mov    %al,-0x15(%rbp)
   42267:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4226e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42271:	89 c2                	mov    %eax,%edx
   42273:	ec                   	in     (%dx),%al
   42274:	88 45 f3             	mov    %al,-0xd(%rbp)
   42277:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4227e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42281:	89 c2                	mov    %eax,%edx
   42283:	ec                   	in     (%dx),%al
   42284:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42287:	90                   	nop
   42288:	c9                   	leave  
   42289:	c3                   	ret    

000000000004228a <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4228a:	55                   	push   %rbp
   4228b:	48 89 e5             	mov    %rsp,%rbp
   4228e:	48 83 ec 40          	sub    $0x40,%rsp
   42292:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42296:	89 f0                	mov    %esi,%eax
   42298:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4229b:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4229e:	8b 05 40 11 01 00    	mov    0x11140(%rip),%eax        # 533e4 <initialized.0>
   422a4:	85 c0                	test   %eax,%eax
   422a6:	75 1e                	jne    422c6 <parallel_port_putc+0x3c>
   422a8:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   422af:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422b3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   422b7:	8b 55 f8             	mov    -0x8(%rbp),%edx
   422ba:	ee                   	out    %al,(%dx)
}
   422bb:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   422bc:	c7 05 1e 11 01 00 01 	movl   $0x1,0x1111e(%rip)        # 533e4 <initialized.0>
   422c3:	00 00 00 
    }

    for (int i = 0;
   422c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422cd:	eb 09                	jmp    422d8 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   422cf:	e8 6b ff ff ff       	call   4223f <delay>
         ++i) {
   422d4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   422d8:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   422df:	7f 18                	jg     422f9 <parallel_port_putc+0x6f>
   422e1:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   422e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   422eb:	89 c2                	mov    %eax,%edx
   422ed:	ec                   	in     (%dx),%al
   422ee:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   422f1:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   422f5:	84 c0                	test   %al,%al
   422f7:	79 d6                	jns    422cf <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   422f9:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   422fd:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42304:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42307:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   4230b:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4230e:	ee                   	out    %al,(%dx)
}
   4230f:	90                   	nop
   42310:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42317:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4231b:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4231f:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42322:	ee                   	out    %al,(%dx)
}
   42323:	90                   	nop
   42324:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   4232b:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4232f:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42333:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42336:	ee                   	out    %al,(%dx)
}
   42337:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42338:	90                   	nop
   42339:	c9                   	leave  
   4233a:	c3                   	ret    

000000000004233b <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   4233b:	55                   	push   %rbp
   4233c:	48 89 e5             	mov    %rsp,%rbp
   4233f:	48 83 ec 20          	sub    $0x20,%rsp
   42343:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42347:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   4234b:	48 c7 45 f8 8a 22 04 	movq   $0x4228a,-0x8(%rbp)
   42352:	00 
    printer_vprintf(&p, 0, format, val);
   42353:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42357:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4235b:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4235f:	be 00 00 00 00       	mov    $0x0,%esi
   42364:	48 89 c7             	mov    %rax,%rdi
   42367:	e8 b5 10 00 00       	call   43421 <printer_vprintf>
}
   4236c:	90                   	nop
   4236d:	c9                   	leave  
   4236e:	c3                   	ret    

000000000004236f <log_printf>:

void log_printf(const char* format, ...) {
   4236f:	55                   	push   %rbp
   42370:	48 89 e5             	mov    %rsp,%rbp
   42373:	48 83 ec 60          	sub    $0x60,%rsp
   42377:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4237b:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4237f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42383:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42387:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4238b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4238f:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42396:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4239a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4239e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423a2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   423a6:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   423aa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   423ae:	48 89 d6             	mov    %rdx,%rsi
   423b1:	48 89 c7             	mov    %rax,%rdi
   423b4:	e8 82 ff ff ff       	call   4233b <log_vprintf>
    va_end(val);
}
   423b9:	90                   	nop
   423ba:	c9                   	leave  
   423bb:	c3                   	ret    

00000000000423bc <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   423bc:	55                   	push   %rbp
   423bd:	48 89 e5             	mov    %rsp,%rbp
   423c0:	48 83 ec 40          	sub    $0x40,%rsp
   423c4:	89 7d dc             	mov    %edi,-0x24(%rbp)
   423c7:	89 75 d8             	mov    %esi,-0x28(%rbp)
   423ca:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   423ce:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   423d2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   423d6:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   423da:	48 8b 0a             	mov    (%rdx),%rcx
   423dd:	48 89 08             	mov    %rcx,(%rax)
   423e0:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   423e4:	48 89 48 08          	mov    %rcx,0x8(%rax)
   423e8:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   423ec:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   423f0:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   423f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   423f8:	48 89 d6             	mov    %rdx,%rsi
   423fb:	48 89 c7             	mov    %rax,%rdi
   423fe:	e8 38 ff ff ff       	call   4233b <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42403:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42407:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4240b:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4240e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42411:	89 c7                	mov    %eax,%edi
   42413:	e8 e8 16 00 00       	call   43b00 <console_vprintf>
}
   42418:	c9                   	leave  
   42419:	c3                   	ret    

000000000004241a <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4241a:	55                   	push   %rbp
   4241b:	48 89 e5             	mov    %rsp,%rbp
   4241e:	48 83 ec 60          	sub    $0x60,%rsp
   42422:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42425:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42428:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4242c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42430:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42434:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42438:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4243f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42443:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42447:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4244b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4244f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42453:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42457:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4245a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4245d:	89 c7                	mov    %eax,%edi
   4245f:	e8 58 ff ff ff       	call   423bc <error_vprintf>
   42464:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42467:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4246a:	c9                   	leave  
   4246b:	c3                   	ret    

000000000004246c <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4246c:	55                   	push   %rbp
   4246d:	48 89 e5             	mov    %rsp,%rbp
   42470:	53                   	push   %rbx
   42471:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42475:	e8 ac fb ff ff       	call   42026 <keyboard_readc>
   4247a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4247d:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42481:	74 1c                	je     4249f <check_keyboard+0x33>
   42483:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42487:	74 16                	je     4249f <check_keyboard+0x33>
   42489:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4248d:	74 10                	je     4249f <check_keyboard+0x33>
   4248f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42493:	74 0a                	je     4249f <check_keyboard+0x33>
   42495:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42499:	0f 85 e9 00 00 00    	jne    42588 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4249f:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   424a6:	00 
        memset(pt, 0, PAGESIZE * 3);
   424a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   424ab:	ba 00 30 00 00       	mov    $0x3000,%edx
   424b0:	be 00 00 00 00       	mov    $0x0,%esi
   424b5:	48 89 c7             	mov    %rax,%rdi
   424b8:	e8 53 0e 00 00       	call   43310 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   424bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   424c1:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   424c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   424cc:	48 05 00 10 00 00    	add    $0x1000,%rax
   424d2:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   424d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   424dd:	48 05 00 20 00 00    	add    $0x2000,%rax
   424e3:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   424ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   424ee:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   424f2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   424f6:	0f 22 d8             	mov    %rax,%cr3
}
   424f9:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   424fa:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42501:	48 c7 45 e8 38 4d 04 	movq   $0x44d38,-0x18(%rbp)
   42508:	00 
        if (c == 'a') {
   42509:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4250d:	75 0a                	jne    42519 <check_keyboard+0xad>
            argument = "allocator";
   4250f:	48 c7 45 e8 3f 4d 04 	movq   $0x44d3f,-0x18(%rbp)
   42516:	00 
   42517:	eb 2e                	jmp    42547 <check_keyboard+0xdb>
        } else if (c == 'c') {
   42519:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4251d:	75 0a                	jne    42529 <check_keyboard+0xbd>
            argument = "alloctests";
   4251f:	48 c7 45 e8 49 4d 04 	movq   $0x44d49,-0x18(%rbp)
   42526:	00 
   42527:	eb 1e                	jmp    42547 <check_keyboard+0xdb>
        } else if(c == 't'){
   42529:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4252d:	75 0a                	jne    42539 <check_keyboard+0xcd>
            argument = "test";
   4252f:	48 c7 45 e8 54 4d 04 	movq   $0x44d54,-0x18(%rbp)
   42536:	00 
   42537:	eb 0e                	jmp    42547 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42539:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4253d:	75 08                	jne    42547 <check_keyboard+0xdb>
            argument = "test2";
   4253f:	48 c7 45 e8 59 4d 04 	movq   $0x44d59,-0x18(%rbp)
   42546:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42547:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4254b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4254f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42554:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42558:	76 14                	jbe    4256e <check_keyboard+0x102>
   4255a:	ba 5f 4d 04 00       	mov    $0x44d5f,%edx
   4255f:	be 5c 02 00 00       	mov    $0x25c,%esi
   42564:	bf 7b 4d 04 00       	mov    $0x44d7b,%edi
   42569:	e8 1f 01 00 00       	call   4268d <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   4256e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42572:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42575:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42579:	48 89 c3             	mov    %rax,%rbx
   4257c:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42581:	e9 7a da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42586:	eb 11                	jmp    42599 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42588:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   4258c:	74 06                	je     42594 <check_keyboard+0x128>
   4258e:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42592:	75 05                	jne    42599 <check_keyboard+0x12d>
        poweroff();
   42594:	e8 a3 f8 ff ff       	call   41e3c <poweroff>
    }
    return c;
   42599:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   4259c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   425a0:	c9                   	leave  
   425a1:	c3                   	ret    

00000000000425a2 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   425a2:	55                   	push   %rbp
   425a3:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   425a6:	e8 c1 fe ff ff       	call   4246c <check_keyboard>
   425ab:	eb f9                	jmp    425a6 <fail+0x4>

00000000000425ad <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   425ad:	55                   	push   %rbp
   425ae:	48 89 e5             	mov    %rsp,%rbp
   425b1:	48 83 ec 60          	sub    $0x60,%rsp
   425b5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   425b9:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   425bd:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   425c1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   425c5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   425c9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425cd:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   425d4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425d8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   425dc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425e0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   425e4:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   425e9:	0f 84 80 00 00 00    	je     4266f <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   425ef:	ba 88 4d 04 00       	mov    $0x44d88,%edx
   425f4:	be 00 c0 00 00       	mov    $0xc000,%esi
   425f9:	bf 30 07 00 00       	mov    $0x730,%edi
   425fe:	b8 00 00 00 00       	mov    $0x0,%eax
   42603:	e8 12 fe ff ff       	call   4241a <error_printf>
   42608:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   4260b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4260f:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42613:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42616:	be 00 c0 00 00       	mov    $0xc000,%esi
   4261b:	89 c7                	mov    %eax,%edi
   4261d:	e8 9a fd ff ff       	call   423bc <error_vprintf>
   42622:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42625:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42628:	48 63 c1             	movslq %ecx,%rax
   4262b:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42632:	48 c1 e8 20          	shr    $0x20,%rax
   42636:	c1 f8 05             	sar    $0x5,%eax
   42639:	89 ce                	mov    %ecx,%esi
   4263b:	c1 fe 1f             	sar    $0x1f,%esi
   4263e:	29 f0                	sub    %esi,%eax
   42640:	89 c2                	mov    %eax,%edx
   42642:	89 d0                	mov    %edx,%eax
   42644:	c1 e0 02             	shl    $0x2,%eax
   42647:	01 d0                	add    %edx,%eax
   42649:	c1 e0 04             	shl    $0x4,%eax
   4264c:	29 c1                	sub    %eax,%ecx
   4264e:	89 ca                	mov    %ecx,%edx
   42650:	85 d2                	test   %edx,%edx
   42652:	74 34                	je     42688 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42654:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42657:	ba 90 4d 04 00       	mov    $0x44d90,%edx
   4265c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42661:	89 c7                	mov    %eax,%edi
   42663:	b8 00 00 00 00       	mov    $0x0,%eax
   42668:	e8 ad fd ff ff       	call   4241a <error_printf>
   4266d:	eb 19                	jmp    42688 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4266f:	ba 92 4d 04 00       	mov    $0x44d92,%edx
   42674:	be 00 c0 00 00       	mov    $0xc000,%esi
   42679:	bf 30 07 00 00       	mov    $0x730,%edi
   4267e:	b8 00 00 00 00       	mov    $0x0,%eax
   42683:	e8 92 fd ff ff       	call   4241a <error_printf>
    }

    va_end(val);
    fail();
   42688:	e8 15 ff ff ff       	call   425a2 <fail>

000000000004268d <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   4268d:	55                   	push   %rbp
   4268e:	48 89 e5             	mov    %rsp,%rbp
   42691:	48 83 ec 20          	sub    $0x20,%rsp
   42695:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42699:	89 75 f4             	mov    %esi,-0xc(%rbp)
   4269c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   426a0:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   426a4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   426a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426ab:	48 89 c6             	mov    %rax,%rsi
   426ae:	bf 98 4d 04 00       	mov    $0x44d98,%edi
   426b3:	b8 00 00 00 00       	mov    $0x0,%eax
   426b8:	e8 f0 fe ff ff       	call   425ad <kernel_panic>

00000000000426bd <default_exception>:
}

void default_exception(proc* p){
   426bd:	55                   	push   %rbp
   426be:	48 89 e5             	mov    %rsp,%rbp
   426c1:	48 83 ec 20          	sub    $0x20,%rsp
   426c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   426c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426cd:	48 83 c0 18          	add    $0x18,%rax
   426d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   426d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426d9:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   426e0:	48 89 c6             	mov    %rax,%rsi
   426e3:	bf b6 4d 04 00       	mov    $0x44db6,%edi
   426e8:	b8 00 00 00 00       	mov    $0x0,%eax
   426ed:	e8 bb fe ff ff       	call   425ad <kernel_panic>

00000000000426f2 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   426f2:	55                   	push   %rbp
   426f3:	48 89 e5             	mov    %rsp,%rbp
   426f6:	48 83 ec 10          	sub    $0x10,%rsp
   426fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   426fe:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42701:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42705:	78 06                	js     4270d <pageindex+0x1b>
   42707:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   4270b:	7e 14                	jle    42721 <pageindex+0x2f>
   4270d:	ba d0 4d 04 00       	mov    $0x44dd0,%edx
   42712:	be 1e 00 00 00       	mov    $0x1e,%esi
   42717:	bf e9 4d 04 00       	mov    $0x44de9,%edi
   4271c:	e8 6c ff ff ff       	call   4268d <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42721:	b8 03 00 00 00       	mov    $0x3,%eax
   42726:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42729:	89 c2                	mov    %eax,%edx
   4272b:	89 d0                	mov    %edx,%eax
   4272d:	c1 e0 03             	shl    $0x3,%eax
   42730:	01 d0                	add    %edx,%eax
   42732:	83 c0 0c             	add    $0xc,%eax
   42735:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42739:	89 c1                	mov    %eax,%ecx
   4273b:	48 d3 ea             	shr    %cl,%rdx
   4273e:	48 89 d0             	mov    %rdx,%rax
   42741:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42746:	c9                   	leave  
   42747:	c3                   	ret    

0000000000042748 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42748:	55                   	push   %rbp
   42749:	48 89 e5             	mov    %rsp,%rbp
   4274c:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42750:	48 c7 05 a5 18 01 00 	movq   $0x55000,0x118a5(%rip)        # 54000 <kernel_pagetable>
   42757:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   4275b:	ba 00 50 00 00       	mov    $0x5000,%edx
   42760:	be 00 00 00 00       	mov    $0x0,%esi
   42765:	bf 00 50 05 00       	mov    $0x55000,%edi
   4276a:	e8 a1 0b 00 00       	call   43310 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4276f:	b8 00 60 05 00       	mov    $0x56000,%eax
   42774:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42778:	48 89 05 81 28 01 00 	mov    %rax,0x12881(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4277f:	b8 00 70 05 00       	mov    $0x57000,%eax
   42784:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42788:	48 89 05 71 38 01 00 	mov    %rax,0x13871(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4278f:	b8 00 80 05 00       	mov    $0x58000,%eax
   42794:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42798:	48 89 05 61 48 01 00 	mov    %rax,0x14861(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4279f:	b8 00 90 05 00       	mov    $0x59000,%eax
   427a4:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   427a8:	48 89 05 59 48 01 00 	mov    %rax,0x14859(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   427af:	48 8b 05 4a 18 01 00 	mov    0x1184a(%rip),%rax        # 54000 <kernel_pagetable>
   427b6:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   427bc:	b9 00 00 20 00       	mov    $0x200000,%ecx
   427c1:	ba 00 00 00 00       	mov    $0x0,%edx
   427c6:	be 00 00 00 00       	mov    $0x0,%esi
   427cb:	48 89 c7             	mov    %rax,%rdi
   427ce:	e8 b9 01 00 00       	call   4298c <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   427d3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   427da:	00 
   427db:	eb 62                	jmp    4283f <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   427dd:	48 8b 0d 1c 18 01 00 	mov    0x1181c(%rip),%rcx        # 54000 <kernel_pagetable>
   427e4:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   427e8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   427ec:	48 89 ce             	mov    %rcx,%rsi
   427ef:	48 89 c7             	mov    %rax,%rdi
   427f2:	e8 58 05 00 00       	call   42d4f <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   427f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   427fb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   427ff:	74 14                	je     42815 <virtual_memory_init+0xcd>
   42801:	ba f2 4d 04 00       	mov    $0x44df2,%edx
   42806:	be 2d 00 00 00       	mov    $0x2d,%esi
   4280b:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42810:	e8 78 fe ff ff       	call   4268d <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42815:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42818:	48 98                	cltq   
   4281a:	83 e0 03             	and    $0x3,%eax
   4281d:	48 83 f8 03          	cmp    $0x3,%rax
   42821:	74 14                	je     42837 <virtual_memory_init+0xef>
   42823:	ba 08 4e 04 00       	mov    $0x44e08,%edx
   42828:	be 2e 00 00 00       	mov    $0x2e,%esi
   4282d:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42832:	e8 56 fe ff ff       	call   4268d <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42837:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4283e:	00 
   4283f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42846:	00 
   42847:	76 94                	jbe    427dd <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42849:	48 8b 05 b0 17 01 00 	mov    0x117b0(%rip),%rax        # 54000 <kernel_pagetable>
   42850:	48 89 c7             	mov    %rax,%rdi
   42853:	e8 03 00 00 00       	call   4285b <set_pagetable>
}
   42858:	90                   	nop
   42859:	c9                   	leave  
   4285a:	c3                   	ret    

000000000004285b <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   4285b:	55                   	push   %rbp
   4285c:	48 89 e5             	mov    %rsp,%rbp
   4285f:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42863:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42867:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4286b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42870:	48 85 c0             	test   %rax,%rax
   42873:	74 14                	je     42889 <set_pagetable+0x2e>
   42875:	ba 35 4e 04 00       	mov    $0x44e35,%edx
   4287a:	be 3d 00 00 00       	mov    $0x3d,%esi
   4287f:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42884:	e8 04 fe ff ff       	call   4268d <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42889:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4288e:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42892:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42896:	48 89 ce             	mov    %rcx,%rsi
   42899:	48 89 c7             	mov    %rax,%rdi
   4289c:	e8 ae 04 00 00       	call   42d4f <virtual_memory_lookup>
   428a1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   428a5:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   428aa:	48 39 d0             	cmp    %rdx,%rax
   428ad:	74 14                	je     428c3 <set_pagetable+0x68>
   428af:	ba 50 4e 04 00       	mov    $0x44e50,%edx
   428b4:	be 3f 00 00 00       	mov    $0x3f,%esi
   428b9:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   428be:	e8 ca fd ff ff       	call   4268d <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   428c3:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   428c7:	48 8b 0d 32 17 01 00 	mov    0x11732(%rip),%rcx        # 54000 <kernel_pagetable>
   428ce:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   428d2:	48 89 ce             	mov    %rcx,%rsi
   428d5:	48 89 c7             	mov    %rax,%rdi
   428d8:	e8 72 04 00 00       	call   42d4f <virtual_memory_lookup>
   428dd:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   428e1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428e5:	48 39 c2             	cmp    %rax,%rdx
   428e8:	74 14                	je     428fe <set_pagetable+0xa3>
   428ea:	ba b8 4e 04 00       	mov    $0x44eb8,%edx
   428ef:	be 41 00 00 00       	mov    $0x41,%esi
   428f4:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   428f9:	e8 8f fd ff ff       	call   4268d <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   428fe:	48 8b 05 fb 16 01 00 	mov    0x116fb(%rip),%rax        # 54000 <kernel_pagetable>
   42905:	48 89 c2             	mov    %rax,%rdx
   42908:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   4290c:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42910:	48 89 ce             	mov    %rcx,%rsi
   42913:	48 89 c7             	mov    %rax,%rdi
   42916:	e8 34 04 00 00       	call   42d4f <virtual_memory_lookup>
   4291b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4291f:	48 8b 15 da 16 01 00 	mov    0x116da(%rip),%rdx        # 54000 <kernel_pagetable>
   42926:	48 39 d0             	cmp    %rdx,%rax
   42929:	74 14                	je     4293f <set_pagetable+0xe4>
   4292b:	ba 18 4f 04 00       	mov    $0x44f18,%edx
   42930:	be 43 00 00 00       	mov    $0x43,%esi
   42935:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   4293a:	e8 4e fd ff ff       	call   4268d <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   4293f:	ba 8c 29 04 00       	mov    $0x4298c,%edx
   42944:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42948:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4294c:	48 89 ce             	mov    %rcx,%rsi
   4294f:	48 89 c7             	mov    %rax,%rdi
   42952:	e8 f8 03 00 00       	call   42d4f <virtual_memory_lookup>
   42957:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4295b:	ba 8c 29 04 00       	mov    $0x4298c,%edx
   42960:	48 39 d0             	cmp    %rdx,%rax
   42963:	74 14                	je     42979 <set_pagetable+0x11e>
   42965:	ba 80 4f 04 00       	mov    $0x44f80,%edx
   4296a:	be 45 00 00 00       	mov    $0x45,%esi
   4296f:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42974:	e8 14 fd ff ff       	call   4268d <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42979:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4297d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42985:	0f 22 d8             	mov    %rax,%cr3
}
   42988:	90                   	nop
}
   42989:	90                   	nop
   4298a:	c9                   	leave  
   4298b:	c3                   	ret    

000000000004298c <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4298c:	55                   	push   %rbp
   4298d:	48 89 e5             	mov    %rsp,%rbp
   42990:	53                   	push   %rbx
   42991:	48 83 ec 58          	sub    $0x58,%rsp
   42995:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42999:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4299d:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   429a1:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   429a5:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   429a9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429ad:	25 ff 0f 00 00       	and    $0xfff,%eax
   429b2:	48 85 c0             	test   %rax,%rax
   429b5:	74 14                	je     429cb <virtual_memory_map+0x3f>
   429b7:	ba e6 4f 04 00       	mov    $0x44fe6,%edx
   429bc:	be 66 00 00 00       	mov    $0x66,%esi
   429c1:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   429c6:	e8 c2 fc ff ff       	call   4268d <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   429cb:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429cf:	25 ff 0f 00 00       	and    $0xfff,%eax
   429d4:	48 85 c0             	test   %rax,%rax
   429d7:	74 14                	je     429ed <virtual_memory_map+0x61>
   429d9:	ba f9 4f 04 00       	mov    $0x44ff9,%edx
   429de:	be 67 00 00 00       	mov    $0x67,%esi
   429e3:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   429e8:	e8 a0 fc ff ff       	call   4268d <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   429ed:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   429f1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429f5:	48 01 d0             	add    %rdx,%rax
   429f8:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   429fc:	76 24                	jbe    42a22 <virtual_memory_map+0x96>
   429fe:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a02:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a06:	48 01 d0             	add    %rdx,%rax
   42a09:	48 85 c0             	test   %rax,%rax
   42a0c:	74 14                	je     42a22 <virtual_memory_map+0x96>
   42a0e:	ba 0c 50 04 00       	mov    $0x4500c,%edx
   42a13:	be 68 00 00 00       	mov    $0x68,%esi
   42a18:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42a1d:	e8 6b fc ff ff       	call   4268d <assert_fail>
    if (perm & PTE_P) {
   42a22:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a25:	48 98                	cltq   
   42a27:	83 e0 01             	and    $0x1,%eax
   42a2a:	48 85 c0             	test   %rax,%rax
   42a2d:	74 6e                	je     42a9d <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42a2f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a33:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a38:	48 85 c0             	test   %rax,%rax
   42a3b:	74 14                	je     42a51 <virtual_memory_map+0xc5>
   42a3d:	ba 2a 50 04 00       	mov    $0x4502a,%edx
   42a42:	be 6a 00 00 00       	mov    $0x6a,%esi
   42a47:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42a4c:	e8 3c fc ff ff       	call   4268d <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42a51:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42a55:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a59:	48 01 d0             	add    %rdx,%rax
   42a5c:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42a60:	76 14                	jbe    42a76 <virtual_memory_map+0xea>
   42a62:	ba 3d 50 04 00       	mov    $0x4503d,%edx
   42a67:	be 6b 00 00 00       	mov    $0x6b,%esi
   42a6c:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42a71:	e8 17 fc ff ff       	call   4268d <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42a76:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42a7a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a7e:	48 01 d0             	add    %rdx,%rax
   42a81:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42a87:	76 14                	jbe    42a9d <virtual_memory_map+0x111>
   42a89:	ba 4b 50 04 00       	mov    $0x4504b,%edx
   42a8e:	be 6c 00 00 00       	mov    $0x6c,%esi
   42a93:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42a98:	e8 f0 fb ff ff       	call   4268d <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42a9d:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42aa1:	78 09                	js     42aac <virtual_memory_map+0x120>
   42aa3:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42aaa:	7e 14                	jle    42ac0 <virtual_memory_map+0x134>
   42aac:	ba 67 50 04 00       	mov    $0x45067,%edx
   42ab1:	be 6e 00 00 00       	mov    $0x6e,%esi
   42ab6:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42abb:	e8 cd fb ff ff       	call   4268d <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42ac0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ac4:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ac9:	48 85 c0             	test   %rax,%rax
   42acc:	74 14                	je     42ae2 <virtual_memory_map+0x156>
   42ace:	ba 88 50 04 00       	mov    $0x45088,%edx
   42ad3:	be 6f 00 00 00       	mov    $0x6f,%esi
   42ad8:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42add:	e8 ab fb ff ff       	call   4268d <assert_fail>

    int last_index123 = -1;
   42ae2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42ae9:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42af0:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42af1:	e9 e1 00 00 00       	jmp    42bd7 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42af6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42afa:	48 c1 e8 15          	shr    $0x15,%rax
   42afe:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42b01:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b04:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42b07:	74 20                	je     42b29 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42b09:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42b0c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42b10:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b14:	48 89 ce             	mov    %rcx,%rsi
   42b17:	48 89 c7             	mov    %rax,%rdi
   42b1a:	e8 ce 00 00 00       	call   42bed <lookup_l4pagetable>
   42b1f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42b23:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b26:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42b29:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b2c:	48 98                	cltq   
   42b2e:	83 e0 01             	and    $0x1,%eax
   42b31:	48 85 c0             	test   %rax,%rax
   42b34:	74 34                	je     42b6a <virtual_memory_map+0x1de>
   42b36:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42b3b:	74 2d                	je     42b6a <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42b3d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b40:	48 63 d8             	movslq %eax,%rbx
   42b43:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b47:	be 03 00 00 00       	mov    $0x3,%esi
   42b4c:	48 89 c7             	mov    %rax,%rdi
   42b4f:	e8 9e fb ff ff       	call   426f2 <pageindex>
   42b54:	89 c2                	mov    %eax,%edx
   42b56:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42b5a:	48 89 d9             	mov    %rbx,%rcx
   42b5d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42b61:	48 63 d2             	movslq %edx,%rdx
   42b64:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42b68:	eb 55                	jmp    42bbf <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42b6a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42b6f:	74 26                	je     42b97 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42b71:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b75:	be 03 00 00 00       	mov    $0x3,%esi
   42b7a:	48 89 c7             	mov    %rax,%rdi
   42b7d:	e8 70 fb ff ff       	call   426f2 <pageindex>
   42b82:	89 c2                	mov    %eax,%edx
   42b84:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b87:	48 63 c8             	movslq %eax,%rcx
   42b8a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42b8e:	48 63 d2             	movslq %edx,%rdx
   42b91:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42b95:	eb 28                	jmp    42bbf <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42b97:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b9a:	48 98                	cltq   
   42b9c:	83 e0 01             	and    $0x1,%eax
   42b9f:	48 85 c0             	test   %rax,%rax
   42ba2:	74 1b                	je     42bbf <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ba4:	be 84 00 00 00       	mov    $0x84,%esi
   42ba9:	bf b0 50 04 00       	mov    $0x450b0,%edi
   42bae:	b8 00 00 00 00       	mov    $0x0,%eax
   42bb3:	e8 b7 f7 ff ff       	call   4236f <log_printf>
            return -1;
   42bb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42bbd:	eb 28                	jmp    42be7 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42bbf:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42bc6:	00 
   42bc7:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42bce:	00 
   42bcf:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42bd6:	00 
   42bd7:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42bdc:	0f 85 14 ff ff ff    	jne    42af6 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42be2:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42be7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42beb:	c9                   	leave  
   42bec:	c3                   	ret    

0000000000042bed <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42bed:	55                   	push   %rbp
   42bee:	48 89 e5             	mov    %rsp,%rbp
   42bf1:	48 83 ec 40          	sub    $0x40,%rsp
   42bf5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42bf9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42bfd:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c00:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c04:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42c08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42c0f:	e9 2b 01 00 00       	jmp    42d3f <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42c14:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42c17:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c1b:	89 d6                	mov    %edx,%esi
   42c1d:	48 89 c7             	mov    %rax,%rdi
   42c20:	e8 cd fa ff ff       	call   426f2 <pageindex>
   42c25:	89 c2                	mov    %eax,%edx
   42c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c2b:	48 63 d2             	movslq %edx,%rdx
   42c2e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42c32:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42c36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c3a:	83 e0 01             	and    $0x1,%eax
   42c3d:	48 85 c0             	test   %rax,%rax
   42c40:	75 63                	jne    42ca5 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42c42:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42c45:	8d 48 02             	lea    0x2(%rax),%ecx
   42c48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c4c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c51:	48 89 c2             	mov    %rax,%rdx
   42c54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c58:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c5e:	48 89 c6             	mov    %rax,%rsi
   42c61:	bf f0 50 04 00       	mov    $0x450f0,%edi
   42c66:	b8 00 00 00 00       	mov    $0x0,%eax
   42c6b:	e8 ff f6 ff ff       	call   4236f <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42c70:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c73:	48 98                	cltq   
   42c75:	83 e0 01             	and    $0x1,%eax
   42c78:	48 85 c0             	test   %rax,%rax
   42c7b:	75 0a                	jne    42c87 <lookup_l4pagetable+0x9a>
                return NULL;
   42c7d:	b8 00 00 00 00       	mov    $0x0,%eax
   42c82:	e9 c6 00 00 00       	jmp    42d4d <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c87:	be a7 00 00 00       	mov    $0xa7,%esi
   42c8c:	bf 58 51 04 00       	mov    $0x45158,%edi
   42c91:	b8 00 00 00 00       	mov    $0x0,%eax
   42c96:	e8 d4 f6 ff ff       	call   4236f <log_printf>
            return NULL;
   42c9b:	b8 00 00 00 00       	mov    $0x0,%eax
   42ca0:	e9 a8 00 00 00       	jmp    42d4d <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42ca5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ca9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42caf:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42cb5:	76 14                	jbe    42ccb <lookup_l4pagetable+0xde>
   42cb7:	ba 98 51 04 00       	mov    $0x45198,%edx
   42cbc:	be ac 00 00 00       	mov    $0xac,%esi
   42cc1:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42cc6:	e8 c2 f9 ff ff       	call   4268d <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42ccb:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42cce:	48 98                	cltq   
   42cd0:	83 e0 02             	and    $0x2,%eax
   42cd3:	48 85 c0             	test   %rax,%rax
   42cd6:	74 20                	je     42cf8 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42cd8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cdc:	83 e0 02             	and    $0x2,%eax
   42cdf:	48 85 c0             	test   %rax,%rax
   42ce2:	75 14                	jne    42cf8 <lookup_l4pagetable+0x10b>
   42ce4:	ba b8 51 04 00       	mov    $0x451b8,%edx
   42ce9:	be ae 00 00 00       	mov    $0xae,%esi
   42cee:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42cf3:	e8 95 f9 ff ff       	call   4268d <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42cf8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42cfb:	48 98                	cltq   
   42cfd:	83 e0 04             	and    $0x4,%eax
   42d00:	48 85 c0             	test   %rax,%rax
   42d03:	74 20                	je     42d25 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42d05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d09:	83 e0 04             	and    $0x4,%eax
   42d0c:	48 85 c0             	test   %rax,%rax
   42d0f:	75 14                	jne    42d25 <lookup_l4pagetable+0x138>
   42d11:	ba c3 51 04 00       	mov    $0x451c3,%edx
   42d16:	be b1 00 00 00       	mov    $0xb1,%esi
   42d1b:	bf 02 4e 04 00       	mov    $0x44e02,%edi
   42d20:	e8 68 f9 ff ff       	call   4268d <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42d25:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42d2c:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42d2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d31:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42d3b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42d3f:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42d43:	0f 8e cb fe ff ff    	jle    42c14 <lookup_l4pagetable+0x27>
    }
    return pt;
   42d49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42d4d:	c9                   	leave  
   42d4e:	c3                   	ret    

0000000000042d4f <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42d4f:	55                   	push   %rbp
   42d50:	48 89 e5             	mov    %rsp,%rbp
   42d53:	48 83 ec 50          	sub    $0x50,%rsp
   42d57:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42d5b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42d5f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42d63:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42d6b:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42d72:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42d73:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42d7a:	eb 41                	jmp    42dbd <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42d7c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42d7f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d83:	89 d6                	mov    %edx,%esi
   42d85:	48 89 c7             	mov    %rax,%rdi
   42d88:	e8 65 f9 ff ff       	call   426f2 <pageindex>
   42d8d:	89 c2                	mov    %eax,%edx
   42d8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d93:	48 63 d2             	movslq %edx,%rdx
   42d96:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42d9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d9e:	83 e0 06             	and    $0x6,%eax
   42da1:	48 f7 d0             	not    %rax
   42da4:	48 21 d0             	and    %rdx,%rax
   42da7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42dab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42daf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42db5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42db9:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42dbd:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42dc1:	7f 0c                	jg     42dcf <virtual_memory_lookup+0x80>
   42dc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dc7:	83 e0 01             	and    $0x1,%eax
   42dca:	48 85 c0             	test   %rax,%rax
   42dcd:	75 ad                	jne    42d7c <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42dcf:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42dd6:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42ddd:	ff 
   42dde:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42de5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42de9:	83 e0 01             	and    $0x1,%eax
   42dec:	48 85 c0             	test   %rax,%rax
   42def:	74 34                	je     42e25 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42df1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42df5:	48 c1 e8 0c          	shr    $0xc,%rax
   42df9:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42dfc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e00:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e06:	48 89 c2             	mov    %rax,%rdx
   42e09:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e0d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e12:	48 09 d0             	or     %rdx,%rax
   42e15:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42e19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e1d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e22:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42e25:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e29:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42e2d:	48 89 10             	mov    %rdx,(%rax)
   42e30:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42e34:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42e38:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e3c:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42e40:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e44:	c9                   	leave  
   42e45:	c3                   	ret    

0000000000042e46 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42e46:	55                   	push   %rbp
   42e47:	48 89 e5             	mov    %rsp,%rbp
   42e4a:	48 83 ec 50          	sub    $0x50,%rsp
   42e4e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e52:	89 75 c4             	mov    %esi,-0x3c(%rbp)
   42e55:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42e59:	c7 45 f4 07 00 00 00 	movl   $0x7,-0xc(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42e60:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   42e64:	78 08                	js     42e6e <program_load+0x28>
   42e66:	8b 45 c4             	mov    -0x3c(%rbp),%eax
   42e69:	3b 45 f4             	cmp    -0xc(%rbp),%eax
   42e6c:	7c 14                	jl     42e82 <program_load+0x3c>
   42e6e:	ba d0 51 04 00       	mov    $0x451d0,%edx
   42e73:	be 38 00 00 00       	mov    $0x38,%esi
   42e78:	bf 00 52 04 00       	mov    $0x45200,%edi
   42e7d:	e8 0b f8 ff ff       	call   4268d <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42e82:	8b 45 c4             	mov    -0x3c(%rbp),%eax
   42e85:	48 98                	cltq   
   42e87:	48 c1 e0 04          	shl    $0x4,%rax
   42e8b:	48 05 20 60 04 00    	add    $0x46020,%rax
   42e91:	48 8b 00             	mov    (%rax),%rax
   42e94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42e98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e9c:	8b 00                	mov    (%rax),%eax
   42e9e:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42ea3:	74 14                	je     42eb9 <program_load+0x73>
   42ea5:	ba 0b 52 04 00       	mov    $0x4520b,%edx
   42eaa:	be 3a 00 00 00       	mov    $0x3a,%esi
   42eaf:	bf 00 52 04 00       	mov    $0x45200,%edi
   42eb4:	e8 d4 f7 ff ff       	call   4268d <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42eb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ebd:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42ec1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec5:	48 01 d0             	add    %rdx,%rax
   42ec8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42ecc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42ed3:	e9 b8 00 00 00       	jmp    42f90 <program_load+0x14a>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42ed8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42edb:	48 63 d0             	movslq %eax,%rdx
   42ede:	48 89 d0             	mov    %rdx,%rax
   42ee1:	48 c1 e0 03          	shl    $0x3,%rax
   42ee5:	48 29 d0             	sub    %rdx,%rax
   42ee8:	48 c1 e0 03          	shl    $0x3,%rax
   42eec:	48 89 c2             	mov    %rax,%rdx
   42eef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ef3:	48 01 d0             	add    %rdx,%rax
   42ef6:	8b 00                	mov    (%rax),%eax
   42ef8:	83 f8 01             	cmp    $0x1,%eax
   42efb:	0f 85 8b 00 00 00    	jne    42f8c <program_load+0x146>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42f01:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f04:	48 63 d0             	movslq %eax,%rdx
   42f07:	48 89 d0             	mov    %rdx,%rax
   42f0a:	48 c1 e0 03          	shl    $0x3,%rax
   42f0e:	48 29 d0             	sub    %rdx,%rax
   42f11:	48 c1 e0 03          	shl    $0x3,%rax
   42f15:	48 89 c2             	mov    %rax,%rdx
   42f18:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f1c:	48 01 d0             	add    %rdx,%rax
   42f1f:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42f23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f27:	48 01 d0             	add    %rdx,%rax
   42f2a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            
            int is_last_program;
            if (i == eh->e_phnum - 1)
   42f2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f32:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42f36:	0f b7 c0             	movzwl %ax,%eax
   42f39:	83 e8 01             	sub    $0x1,%eax
   42f3c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42f3f:	75 07                	jne    42f48 <program_load+0x102>
            { // if we're at the last program to be loaded
                is_last_program = 1;
   42f41:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
            }
            if (program_load_segment(p, &ph[i], pdata, allocator, is_last_program) < 0) {
   42f48:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f4b:	48 63 d0             	movslq %eax,%rdx
   42f4e:	48 89 d0             	mov    %rdx,%rax
   42f51:	48 c1 e0 03          	shl    $0x3,%rax
   42f55:	48 29 d0             	sub    %rdx,%rax
   42f58:	48 c1 e0 03          	shl    $0x3,%rax
   42f5c:	48 89 c2             	mov    %rax,%rdx
   42f5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f63:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42f67:	8b 7d f8             	mov    -0x8(%rbp),%edi
   42f6a:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   42f6e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42f72:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f76:	41 89 f8             	mov    %edi,%r8d
   42f79:	48 89 c7             	mov    %rax,%rdi
   42f7c:	e8 3d 00 00 00       	call   42fbe <program_load_segment>
   42f81:	85 c0                	test   %eax,%eax
   42f83:	79 07                	jns    42f8c <program_load+0x146>
                return -1;
   42f85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f8a:	eb 30                	jmp    42fbc <program_load+0x176>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f8c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42f90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f94:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42f98:	0f b7 c0             	movzwl %ax,%eax
   42f9b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42f9e:	0f 8c 34 ff ff ff    	jl     42ed8 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42fa4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fa8:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42fac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42fb0:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42fb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42fbc:	c9                   	leave  
   42fbd:	c3                   	ret    

0000000000042fbe <program_load_segment>:
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void),
                                int is_last_program) {
   42fbe:	55                   	push   %rbp
   42fbf:	48 89 e5             	mov    %rsp,%rbp
   42fc2:	48 81 ec a0 00 00 00 	sub    $0xa0,%rsp
   42fc9:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
   42fcd:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
   42fd1:	48 89 95 78 ff ff ff 	mov    %rdx,-0x88(%rbp)
   42fd8:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
   42fdf:	44 89 85 6c ff ff ff 	mov    %r8d,-0x94(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42fe6:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42fea:	48 8b 40 10          	mov    0x10(%rax),%rax
   42fee:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42ff2:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42ff6:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42ffa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ffe:	48 01 d0             	add    %rdx,%rax
   43001:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43005:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43009:	48 8b 50 28          	mov    0x28(%rax),%rdx
   4300d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43011:	48 01 d0             	add    %rdx,%rax
   43014:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43018:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   4301f:	ff 

    if (is_last_program) // if we are at the last program, we need to mark
   43020:	83 bd 6c ff ff ff 00 	cmpl   $0x0,-0x94(%rbp)
   43027:	74 7a                	je     430a3 <program_load_segment+0xe5>
    { // the start of the heap after all the data segments
        p->original_break = ROUNDUP(end_mem, PAGESIZE);
   43029:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   43030:	00 
   43031:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43035:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43039:	48 01 d0             	add    %rdx,%rax
   4303c:	48 83 e8 01          	sub    $0x1,%rax
   43040:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   43044:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43048:	ba 00 00 00 00       	mov    $0x0,%edx
   4304d:	48 f7 75 d0          	divq   -0x30(%rbp)
   43051:	48 89 d1             	mov    %rdx,%rcx
   43054:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43058:	48 29 c8             	sub    %rcx,%rax
   4305b:	48 89 c2             	mov    %rax,%rdx
   4305e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43062:	48 89 50 10          	mov    %rdx,0x10(%rax)
        p->program_break = ROUNDUP(end_mem, PAGESIZE);
   43066:	48 c7 45 c0 00 10 00 	movq   $0x1000,-0x40(%rbp)
   4306d:	00 
   4306e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43072:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43076:	48 01 d0             	add    %rdx,%rax
   43079:	48 83 e8 01          	sub    $0x1,%rax
   4307d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43081:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43085:	ba 00 00 00 00       	mov    $0x0,%edx
   4308a:	48 f7 75 c0          	divq   -0x40(%rbp)
   4308e:	48 89 d1             	mov    %rdx,%rcx
   43091:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43095:	48 29 c8             	sub    %rcx,%rax
   43098:	48 89 c2             	mov    %rax,%rdx
   4309b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4309f:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    
    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   430ab:	eb 7c                	jmp    43129 <program_load_segment+0x16b>
        uintptr_t pa = (uintptr_t) palloc(p->p_pid);
   430ad:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430b1:	8b 00                	mov    (%rax),%eax
   430b3:	89 c7                	mov    %eax,%edi
   430b5:	e8 62 0b 00 00       	call   43c1c <palloc>
   430ba:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   430be:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   430c3:	74 2a                	je     430ef <program_load_segment+0x131>
   430c5:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430c9:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430d0:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   430d4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   430d8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   430de:	b9 00 10 00 00       	mov    $0x1000,%ecx
   430e3:	48 89 c7             	mov    %rax,%rdi
   430e6:	e8 a1 f8 ff ff       	call   4298c <virtual_memory_map>
   430eb:	85 c0                	test   %eax,%eax
   430ed:	79 32                	jns    43121 <program_load_segment+0x163>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   430ef:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430f3:	8b 00                	mov    (%rax),%eax
   430f5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   430f9:	49 89 d0             	mov    %rdx,%r8
   430fc:	89 c1                	mov    %eax,%ecx
   430fe:	ba 28 52 04 00       	mov    $0x45228,%edx
   43103:	be 00 c0 00 00       	mov    $0xc000,%esi
   43108:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4310d:	b8 00 00 00 00       	mov    $0x0,%eax
   43112:	e8 2e 0a 00 00       	call   43b45 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   43117:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4311c:	e9 e8 00 00 00       	jmp    43209 <program_load_segment+0x24b>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43121:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43128:	00 
   43129:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4312d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43131:	0f 82 76 ff ff ff    	jb     430ad <program_load_segment+0xef>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43137:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4313b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43142:	48 89 c7             	mov    %rax,%rdi
   43145:	e8 11 f7 ff ff       	call   4285b <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   4314a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4314e:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43152:	48 89 c2             	mov    %rax,%rdx
   43155:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43159:	48 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%rcx
   43160:	48 89 ce             	mov    %rcx,%rsi
   43163:	48 89 c7             	mov    %rax,%rdi
   43166:	e8 3c 01 00 00       	call   432a7 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   4316b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4316f:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43173:	48 89 c2             	mov    %rax,%rdx
   43176:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4317a:	be 00 00 00 00       	mov    $0x0,%esi
   4317f:	48 89 c7             	mov    %rax,%rdi
   43182:	e8 89 01 00 00       	call   43310 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43187:	48 8b 05 72 0e 01 00 	mov    0x10e72(%rip),%rax        # 54000 <kernel_pagetable>
   4318e:	48 89 c7             	mov    %rax,%rdi
   43191:	e8 c5 f6 ff ff       	call   4285b <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43196:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   4319a:	8b 40 04             	mov    0x4(%rax),%eax
   4319d:	83 e0 02             	and    $0x2,%eax
   431a0:	85 c0                	test   %eax,%eax
   431a2:	75 60                	jne    43204 <program_load_segment+0x246>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   431ac:	eb 4c                	jmp    431fa <program_load_segment+0x23c>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   431ae:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431b2:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   431b9:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   431bd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   431c1:	48 89 ce             	mov    %rcx,%rsi
   431c4:	48 89 c7             	mov    %rax,%rdi
   431c7:	e8 83 fb ff ff       	call   42d4f <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   431cc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   431d0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431d4:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   431db:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   431df:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   431e5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   431ea:	48 89 c7             	mov    %rax,%rdi
   431ed:	e8 9a f7 ff ff       	call   4298c <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431f2:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   431f9:	00 
   431fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431fe:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43202:	72 aa                	jb     431ae <program_load_segment+0x1f0>
                    PTE_P | PTE_U);
        }
    }
    return 0;
   43204:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43209:	c9                   	leave  
   4320a:	c3                   	ret    

000000000004320b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4320b:	48 89 f9             	mov    %rdi,%rcx
   4320e:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43210:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   43217:	00 
   43218:	72 08                	jb     43222 <console_putc+0x17>
        cp->cursor = console;
   4321a:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   43221:	00 
    }
    if (c == '\n') {
   43222:	40 80 fe 0a          	cmp    $0xa,%sil
   43226:	74 16                	je     4323e <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   43228:	48 8b 41 08          	mov    0x8(%rcx),%rax
   4322c:	48 8d 50 02          	lea    0x2(%rax),%rdx
   43230:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   43234:	40 0f b6 f6          	movzbl %sil,%esi
   43238:	09 fe                	or     %edi,%esi
   4323a:	66 89 30             	mov    %si,(%rax)
    }
}
   4323d:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
   4323e:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   43242:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   43249:	4c 89 c6             	mov    %r8,%rsi
   4324c:	48 d1 fe             	sar    %rsi
   4324f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43256:	66 66 66 
   43259:	48 89 f0             	mov    %rsi,%rax
   4325c:	48 f7 ea             	imul   %rdx
   4325f:	48 c1 fa 05          	sar    $0x5,%rdx
   43263:	49 c1 f8 3f          	sar    $0x3f,%r8
   43267:	4c 29 c2             	sub    %r8,%rdx
   4326a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   4326e:	48 c1 e2 04          	shl    $0x4,%rdx
   43272:	89 f0                	mov    %esi,%eax
   43274:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   43276:	83 cf 20             	or     $0x20,%edi
   43279:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4327d:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   43281:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   43285:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   43288:	83 c0 01             	add    $0x1,%eax
   4328b:	83 f8 50             	cmp    $0x50,%eax
   4328e:	75 e9                	jne    43279 <console_putc+0x6e>
   43290:	c3                   	ret    

0000000000043291 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   43291:	48 8b 47 08          	mov    0x8(%rdi),%rax
   43295:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   43299:	73 0b                	jae    432a6 <string_putc+0x15>
        *sp->s++ = c;
   4329b:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4329f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   432a3:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   432a6:	c3                   	ret    

00000000000432a7 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   432a7:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   432aa:	48 85 d2             	test   %rdx,%rdx
   432ad:	74 17                	je     432c6 <memcpy+0x1f>
   432af:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   432b4:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   432b9:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   432bd:	48 83 c1 01          	add    $0x1,%rcx
   432c1:	48 39 d1             	cmp    %rdx,%rcx
   432c4:	75 ee                	jne    432b4 <memcpy+0xd>
}
   432c6:	c3                   	ret    

00000000000432c7 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   432c7:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   432ca:	48 39 fe             	cmp    %rdi,%rsi
   432cd:	72 1d                	jb     432ec <memmove+0x25>
        while (n-- > 0) {
   432cf:	b9 00 00 00 00       	mov    $0x0,%ecx
   432d4:	48 85 d2             	test   %rdx,%rdx
   432d7:	74 12                	je     432eb <memmove+0x24>
            *d++ = *s++;
   432d9:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   432dd:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   432e1:	48 83 c1 01          	add    $0x1,%rcx
   432e5:	48 39 ca             	cmp    %rcx,%rdx
   432e8:	75 ef                	jne    432d9 <memmove+0x12>
}
   432ea:	c3                   	ret    
   432eb:	c3                   	ret    
    if (s < d && s + n > d) {
   432ec:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   432f0:	48 39 cf             	cmp    %rcx,%rdi
   432f3:	73 da                	jae    432cf <memmove+0x8>
        while (n-- > 0) {
   432f5:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   432f9:	48 85 d2             	test   %rdx,%rdx
   432fc:	74 ec                	je     432ea <memmove+0x23>
            *--d = *--s;
   432fe:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   43302:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   43305:	48 83 e9 01          	sub    $0x1,%rcx
   43309:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   4330d:	75 ef                	jne    432fe <memmove+0x37>
   4330f:	c3                   	ret    

0000000000043310 <memset>:
void* memset(void* v, int c, size_t n) {
   43310:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43313:	48 85 d2             	test   %rdx,%rdx
   43316:	74 12                	je     4332a <memset+0x1a>
   43318:	48 01 fa             	add    %rdi,%rdx
   4331b:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   4331e:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43321:	48 83 c1 01          	add    $0x1,%rcx
   43325:	48 39 ca             	cmp    %rcx,%rdx
   43328:	75 f4                	jne    4331e <memset+0xe>
}
   4332a:	c3                   	ret    

000000000004332b <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   4332b:	80 3f 00             	cmpb   $0x0,(%rdi)
   4332e:	74 10                	je     43340 <strlen+0x15>
   43330:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   43335:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   43339:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   4333d:	75 f6                	jne    43335 <strlen+0xa>
   4333f:	c3                   	ret    
   43340:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43345:	c3                   	ret    

0000000000043346 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   43346:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43349:	ba 00 00 00 00       	mov    $0x0,%edx
   4334e:	48 85 f6             	test   %rsi,%rsi
   43351:	74 11                	je     43364 <strnlen+0x1e>
   43353:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   43357:	74 0c                	je     43365 <strnlen+0x1f>
        ++n;
   43359:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4335d:	48 39 d0             	cmp    %rdx,%rax
   43360:	75 f1                	jne    43353 <strnlen+0xd>
   43362:	eb 04                	jmp    43368 <strnlen+0x22>
   43364:	c3                   	ret    
   43365:	48 89 d0             	mov    %rdx,%rax
}
   43368:	c3                   	ret    

0000000000043369 <strcpy>:
char* strcpy(char* dst, const char* src) {
   43369:	48 89 f8             	mov    %rdi,%rax
   4336c:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   43371:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   43375:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   43378:	48 83 c2 01          	add    $0x1,%rdx
   4337c:	84 c9                	test   %cl,%cl
   4337e:	75 f1                	jne    43371 <strcpy+0x8>
}
   43380:	c3                   	ret    

0000000000043381 <strcmp>:
    while (*a && *b && *a == *b) {
   43381:	0f b6 07             	movzbl (%rdi),%eax
   43384:	84 c0                	test   %al,%al
   43386:	74 1a                	je     433a2 <strcmp+0x21>
   43388:	0f b6 16             	movzbl (%rsi),%edx
   4338b:	38 c2                	cmp    %al,%dl
   4338d:	75 13                	jne    433a2 <strcmp+0x21>
   4338f:	84 d2                	test   %dl,%dl
   43391:	74 0f                	je     433a2 <strcmp+0x21>
        ++a, ++b;
   43393:	48 83 c7 01          	add    $0x1,%rdi
   43397:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   4339b:	0f b6 07             	movzbl (%rdi),%eax
   4339e:	84 c0                	test   %al,%al
   433a0:	75 e6                	jne    43388 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   433a2:	3a 06                	cmp    (%rsi),%al
   433a4:	0f 97 c0             	seta   %al
   433a7:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   433aa:	83 d8 00             	sbb    $0x0,%eax
}
   433ad:	c3                   	ret    

00000000000433ae <strchr>:
    while (*s && *s != (char) c) {
   433ae:	0f b6 07             	movzbl (%rdi),%eax
   433b1:	84 c0                	test   %al,%al
   433b3:	74 10                	je     433c5 <strchr+0x17>
   433b5:	40 38 f0             	cmp    %sil,%al
   433b8:	74 18                	je     433d2 <strchr+0x24>
        ++s;
   433ba:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   433be:	0f b6 07             	movzbl (%rdi),%eax
   433c1:	84 c0                	test   %al,%al
   433c3:	75 f0                	jne    433b5 <strchr+0x7>
        return NULL;
   433c5:	40 84 f6             	test   %sil,%sil
   433c8:	b8 00 00 00 00       	mov    $0x0,%eax
   433cd:	48 0f 44 c7          	cmove  %rdi,%rax
}
   433d1:	c3                   	ret    
   433d2:	48 89 f8             	mov    %rdi,%rax
   433d5:	c3                   	ret    

00000000000433d6 <rand>:
    if (!rand_seed_set) {
   433d6:	83 3d 27 6c 01 00 00 	cmpl   $0x0,0x16c27(%rip)        # 5a004 <rand_seed_set>
   433dd:	74 1b                	je     433fa <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   433df:	69 05 17 6c 01 00 0d 	imul   $0x19660d,0x16c17(%rip),%eax        # 5a000 <rand_seed>
   433e6:	66 19 00 
   433e9:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   433ee:	89 05 0c 6c 01 00    	mov    %eax,0x16c0c(%rip)        # 5a000 <rand_seed>
    return rand_seed & RAND_MAX;
   433f4:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   433f9:	c3                   	ret    
    rand_seed = seed;
   433fa:	c7 05 fc 6b 01 00 9e 	movl   $0x30d4879e,0x16bfc(%rip)        # 5a000 <rand_seed>
   43401:	87 d4 30 
    rand_seed_set = 1;
   43404:	c7 05 f6 6b 01 00 01 	movl   $0x1,0x16bf6(%rip)        # 5a004 <rand_seed_set>
   4340b:	00 00 00 
}
   4340e:	eb cf                	jmp    433df <rand+0x9>

0000000000043410 <srand>:
    rand_seed = seed;
   43410:	89 3d ea 6b 01 00    	mov    %edi,0x16bea(%rip)        # 5a000 <rand_seed>
    rand_seed_set = 1;
   43416:	c7 05 e4 6b 01 00 01 	movl   $0x1,0x16be4(%rip)        # 5a004 <rand_seed_set>
   4341d:	00 00 00 
}
   43420:	c3                   	ret    

0000000000043421 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43421:	55                   	push   %rbp
   43422:	48 89 e5             	mov    %rsp,%rbp
   43425:	41 57                	push   %r15
   43427:	41 56                	push   %r14
   43429:	41 55                	push   %r13
   4342b:	41 54                	push   %r12
   4342d:	53                   	push   %rbx
   4342e:	48 83 ec 58          	sub    $0x58,%rsp
   43432:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   43436:	0f b6 02             	movzbl (%rdx),%eax
   43439:	84 c0                	test   %al,%al
   4343b:	0f 84 b0 06 00 00    	je     43af1 <printer_vprintf+0x6d0>
   43441:	49 89 fe             	mov    %rdi,%r14
   43444:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   43447:	41 89 f7             	mov    %esi,%r15d
   4344a:	e9 a4 04 00 00       	jmp    438f3 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   4344f:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   43454:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   4345a:	45 84 e4             	test   %r12b,%r12b
   4345d:	0f 84 82 06 00 00    	je     43ae5 <printer_vprintf+0x6c4>
        int flags = 0;
   43463:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   43469:	41 0f be f4          	movsbl %r12b,%esi
   4346d:	bf 61 54 04 00       	mov    $0x45461,%edi
   43472:	e8 37 ff ff ff       	call   433ae <strchr>
   43477:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   4347a:	48 85 c0             	test   %rax,%rax
   4347d:	74 55                	je     434d4 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   4347f:	48 81 e9 61 54 04 00 	sub    $0x45461,%rcx
   43486:	b8 01 00 00 00       	mov    $0x1,%eax
   4348b:	d3 e0                	shl    %cl,%eax
   4348d:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   43490:	48 83 c3 01          	add    $0x1,%rbx
   43494:	44 0f b6 23          	movzbl (%rbx),%r12d
   43498:	45 84 e4             	test   %r12b,%r12b
   4349b:	75 cc                	jne    43469 <printer_vprintf+0x48>
   4349d:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   434a1:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   434a7:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   434ae:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   434b1:	0f 84 a9 00 00 00    	je     43560 <printer_vprintf+0x13f>
        int length = 0;
   434b7:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   434bc:	0f b6 13             	movzbl (%rbx),%edx
   434bf:	8d 42 bd             	lea    -0x43(%rdx),%eax
   434c2:	3c 37                	cmp    $0x37,%al
   434c4:	0f 87 c4 04 00 00    	ja     4398e <printer_vprintf+0x56d>
   434ca:	0f b6 c0             	movzbl %al,%eax
   434cd:	ff 24 c5 70 52 04 00 	jmp    *0x45270(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   434d4:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   434d8:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   434dd:	3c 08                	cmp    $0x8,%al
   434df:	77 2f                	ja     43510 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   434e1:	0f b6 03             	movzbl (%rbx),%eax
   434e4:	8d 50 d0             	lea    -0x30(%rax),%edx
   434e7:	80 fa 09             	cmp    $0x9,%dl
   434ea:	77 5e                	ja     4354a <printer_vprintf+0x129>
   434ec:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   434f2:	48 83 c3 01          	add    $0x1,%rbx
   434f6:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   434fb:	0f be c0             	movsbl %al,%eax
   434fe:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43503:	0f b6 03             	movzbl (%rbx),%eax
   43506:	8d 50 d0             	lea    -0x30(%rax),%edx
   43509:	80 fa 09             	cmp    $0x9,%dl
   4350c:	76 e4                	jbe    434f2 <printer_vprintf+0xd1>
   4350e:	eb 97                	jmp    434a7 <printer_vprintf+0x86>
        } else if (*format == '*') {
   43510:	41 80 fc 2a          	cmp    $0x2a,%r12b
   43514:	75 3f                	jne    43555 <printer_vprintf+0x134>
            width = va_arg(val, int);
   43516:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4351a:	8b 07                	mov    (%rdi),%eax
   4351c:	83 f8 2f             	cmp    $0x2f,%eax
   4351f:	77 17                	ja     43538 <printer_vprintf+0x117>
   43521:	89 c2                	mov    %eax,%edx
   43523:	48 03 57 10          	add    0x10(%rdi),%rdx
   43527:	83 c0 08             	add    $0x8,%eax
   4352a:	89 07                	mov    %eax,(%rdi)
   4352c:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   4352f:	48 83 c3 01          	add    $0x1,%rbx
   43533:	e9 6f ff ff ff       	jmp    434a7 <printer_vprintf+0x86>
            width = va_arg(val, int);
   43538:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4353c:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43540:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43544:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43548:	eb e2                	jmp    4352c <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4354a:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   43550:	e9 52 ff ff ff       	jmp    434a7 <printer_vprintf+0x86>
        int width = -1;
   43555:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   4355b:	e9 47 ff ff ff       	jmp    434a7 <printer_vprintf+0x86>
            ++format;
   43560:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   43564:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43568:	8d 48 d0             	lea    -0x30(%rax),%ecx
   4356b:	80 f9 09             	cmp    $0x9,%cl
   4356e:	76 13                	jbe    43583 <printer_vprintf+0x162>
            } else if (*format == '*') {
   43570:	3c 2a                	cmp    $0x2a,%al
   43572:	74 33                	je     435a7 <printer_vprintf+0x186>
            ++format;
   43574:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   43577:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   4357e:	e9 34 ff ff ff       	jmp    434b7 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43583:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   43588:	48 83 c2 01          	add    $0x1,%rdx
   4358c:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   4358f:	0f be c0             	movsbl %al,%eax
   43592:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43596:	0f b6 02             	movzbl (%rdx),%eax
   43599:	8d 70 d0             	lea    -0x30(%rax),%esi
   4359c:	40 80 fe 09          	cmp    $0x9,%sil
   435a0:	76 e6                	jbe    43588 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   435a2:	48 89 d3             	mov    %rdx,%rbx
   435a5:	eb 1c                	jmp    435c3 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   435a7:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435ab:	8b 07                	mov    (%rdi),%eax
   435ad:	83 f8 2f             	cmp    $0x2f,%eax
   435b0:	77 23                	ja     435d5 <printer_vprintf+0x1b4>
   435b2:	89 c2                	mov    %eax,%edx
   435b4:	48 03 57 10          	add    0x10(%rdi),%rdx
   435b8:	83 c0 08             	add    $0x8,%eax
   435bb:	89 07                	mov    %eax,(%rdi)
   435bd:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   435bf:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   435c3:	85 c9                	test   %ecx,%ecx
   435c5:	b8 00 00 00 00       	mov    $0x0,%eax
   435ca:	0f 49 c1             	cmovns %ecx,%eax
   435cd:	89 45 9c             	mov    %eax,-0x64(%rbp)
   435d0:	e9 e2 fe ff ff       	jmp    434b7 <printer_vprintf+0x96>
                precision = va_arg(val, int);
   435d5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435d9:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   435dd:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435e1:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435e5:	eb d6                	jmp    435bd <printer_vprintf+0x19c>
        switch (*format) {
   435e7:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   435ec:	e9 f3 00 00 00       	jmp    436e4 <printer_vprintf+0x2c3>
            ++format;
   435f1:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   435f5:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   435fa:	e9 bd fe ff ff       	jmp    434bc <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   435ff:	85 c9                	test   %ecx,%ecx
   43601:	74 55                	je     43658 <printer_vprintf+0x237>
   43603:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43607:	8b 07                	mov    (%rdi),%eax
   43609:	83 f8 2f             	cmp    $0x2f,%eax
   4360c:	77 38                	ja     43646 <printer_vprintf+0x225>
   4360e:	89 c2                	mov    %eax,%edx
   43610:	48 03 57 10          	add    0x10(%rdi),%rdx
   43614:	83 c0 08             	add    $0x8,%eax
   43617:	89 07                	mov    %eax,(%rdi)
   43619:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4361c:	48 89 d0             	mov    %rdx,%rax
   4361f:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   43623:	49 89 d0             	mov    %rdx,%r8
   43626:	49 f7 d8             	neg    %r8
   43629:	25 80 00 00 00       	and    $0x80,%eax
   4362e:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43632:	0b 45 a8             	or     -0x58(%rbp),%eax
   43635:	83 c8 60             	or     $0x60,%eax
   43638:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   4363b:	41 bc 67 52 04 00    	mov    $0x45267,%r12d
            break;
   43641:	e9 35 01 00 00       	jmp    4377b <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43646:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4364a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4364e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43652:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43656:	eb c1                	jmp    43619 <printer_vprintf+0x1f8>
   43658:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4365c:	8b 07                	mov    (%rdi),%eax
   4365e:	83 f8 2f             	cmp    $0x2f,%eax
   43661:	77 10                	ja     43673 <printer_vprintf+0x252>
   43663:	89 c2                	mov    %eax,%edx
   43665:	48 03 57 10          	add    0x10(%rdi),%rdx
   43669:	83 c0 08             	add    $0x8,%eax
   4366c:	89 07                	mov    %eax,(%rdi)
   4366e:	48 63 12             	movslq (%rdx),%rdx
   43671:	eb a9                	jmp    4361c <printer_vprintf+0x1fb>
   43673:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43677:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   4367b:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4367f:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43683:	eb e9                	jmp    4366e <printer_vprintf+0x24d>
        int base = 10;
   43685:	be 0a 00 00 00       	mov    $0xa,%esi
   4368a:	eb 58                	jmp    436e4 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4368c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43690:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43694:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43698:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4369c:	eb 60                	jmp    436fe <printer_vprintf+0x2dd>
   4369e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   436a2:	8b 07                	mov    (%rdi),%eax
   436a4:	83 f8 2f             	cmp    $0x2f,%eax
   436a7:	77 10                	ja     436b9 <printer_vprintf+0x298>
   436a9:	89 c2                	mov    %eax,%edx
   436ab:	48 03 57 10          	add    0x10(%rdi),%rdx
   436af:	83 c0 08             	add    $0x8,%eax
   436b2:	89 07                	mov    %eax,(%rdi)
   436b4:	44 8b 02             	mov    (%rdx),%r8d
   436b7:	eb 48                	jmp    43701 <printer_vprintf+0x2e0>
   436b9:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   436bd:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   436c1:	48 8d 42 08          	lea    0x8(%rdx),%rax
   436c5:	48 89 41 08          	mov    %rax,0x8(%rcx)
   436c9:	eb e9                	jmp    436b4 <printer_vprintf+0x293>
   436cb:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   436ce:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   436d5:	bf 50 54 04 00       	mov    $0x45450,%edi
   436da:	e9 e2 02 00 00       	jmp    439c1 <printer_vprintf+0x5a0>
            base = 16;
   436df:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   436e4:	85 c9                	test   %ecx,%ecx
   436e6:	74 b6                	je     4369e <printer_vprintf+0x27d>
   436e8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   436ec:	8b 01                	mov    (%rcx),%eax
   436ee:	83 f8 2f             	cmp    $0x2f,%eax
   436f1:	77 99                	ja     4368c <printer_vprintf+0x26b>
   436f3:	89 c2                	mov    %eax,%edx
   436f5:	48 03 51 10          	add    0x10(%rcx),%rdx
   436f9:	83 c0 08             	add    $0x8,%eax
   436fc:	89 01                	mov    %eax,(%rcx)
   436fe:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43701:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43705:	85 f6                	test   %esi,%esi
   43707:	79 c2                	jns    436cb <printer_vprintf+0x2aa>
        base = -base;
   43709:	41 89 f1             	mov    %esi,%r9d
   4370c:	f7 de                	neg    %esi
   4370e:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43715:	bf 30 54 04 00       	mov    $0x45430,%edi
   4371a:	e9 a2 02 00 00       	jmp    439c1 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   4371f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43723:	8b 07                	mov    (%rdi),%eax
   43725:	83 f8 2f             	cmp    $0x2f,%eax
   43728:	77 1c                	ja     43746 <printer_vprintf+0x325>
   4372a:	89 c2                	mov    %eax,%edx
   4372c:	48 03 57 10          	add    0x10(%rdi),%rdx
   43730:	83 c0 08             	add    $0x8,%eax
   43733:	89 07                	mov    %eax,(%rdi)
   43735:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43738:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   4373f:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43744:	eb c3                	jmp    43709 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   43746:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4374a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4374e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43752:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43756:	eb dd                	jmp    43735 <printer_vprintf+0x314>
            data = va_arg(val, char*);
   43758:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4375c:	8b 01                	mov    (%rcx),%eax
   4375e:	83 f8 2f             	cmp    $0x2f,%eax
   43761:	0f 87 a5 01 00 00    	ja     4390c <printer_vprintf+0x4eb>
   43767:	89 c2                	mov    %eax,%edx
   43769:	48 03 51 10          	add    0x10(%rcx),%rdx
   4376d:	83 c0 08             	add    $0x8,%eax
   43770:	89 01                	mov    %eax,(%rcx)
   43772:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   43775:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   4377b:	8b 45 a8             	mov    -0x58(%rbp),%eax
   4377e:	83 e0 20             	and    $0x20,%eax
   43781:	89 45 8c             	mov    %eax,-0x74(%rbp)
   43784:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   4378a:	0f 85 21 02 00 00    	jne    439b1 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43790:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43793:	89 45 88             	mov    %eax,-0x78(%rbp)
   43796:	83 e0 60             	and    $0x60,%eax
   43799:	83 f8 60             	cmp    $0x60,%eax
   4379c:	0f 84 54 02 00 00    	je     439f6 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   437a2:	8b 45 a8             	mov    -0x58(%rbp),%eax
   437a5:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   437a8:	48 c7 45 a0 67 52 04 	movq   $0x45267,-0x60(%rbp)
   437af:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   437b0:	83 f8 21             	cmp    $0x21,%eax
   437b3:	0f 84 79 02 00 00    	je     43a32 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   437b9:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   437bc:	89 f8                	mov    %edi,%eax
   437be:	f7 d0                	not    %eax
   437c0:	c1 e8 1f             	shr    $0x1f,%eax
   437c3:	89 45 84             	mov    %eax,-0x7c(%rbp)
   437c6:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   437ca:	0f 85 9e 02 00 00    	jne    43a6e <printer_vprintf+0x64d>
   437d0:	84 c0                	test   %al,%al
   437d2:	0f 84 96 02 00 00    	je     43a6e <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   437d8:	48 63 f7             	movslq %edi,%rsi
   437db:	4c 89 e7             	mov    %r12,%rdi
   437de:	e8 63 fb ff ff       	call   43346 <strnlen>
   437e3:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   437e6:	8b 45 88             	mov    -0x78(%rbp),%eax
   437e9:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   437ec:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   437f3:	83 f8 22             	cmp    $0x22,%eax
   437f6:	0f 84 aa 02 00 00    	je     43aa6 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   437fc:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43800:	e8 26 fb ff ff       	call   4332b <strlen>
   43805:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43808:	03 55 98             	add    -0x68(%rbp),%edx
   4380b:	44 89 e9             	mov    %r13d,%ecx
   4380e:	29 d1                	sub    %edx,%ecx
   43810:	29 c1                	sub    %eax,%ecx
   43812:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   43815:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43818:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   4381c:	75 2d                	jne    4384b <printer_vprintf+0x42a>
   4381e:	85 c9                	test   %ecx,%ecx
   43820:	7e 29                	jle    4384b <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   43822:	44 89 fa             	mov    %r15d,%edx
   43825:	be 20 00 00 00       	mov    $0x20,%esi
   4382a:	4c 89 f7             	mov    %r14,%rdi
   4382d:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43830:	41 83 ed 01          	sub    $0x1,%r13d
   43834:	45 85 ed             	test   %r13d,%r13d
   43837:	7f e9                	jg     43822 <printer_vprintf+0x401>
   43839:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   4383c:	85 ff                	test   %edi,%edi
   4383e:	b8 01 00 00 00       	mov    $0x1,%eax
   43843:	0f 4f c7             	cmovg  %edi,%eax
   43846:	29 c7                	sub    %eax,%edi
   43848:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   4384b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   4384f:	0f b6 07             	movzbl (%rdi),%eax
   43852:	84 c0                	test   %al,%al
   43854:	74 22                	je     43878 <printer_vprintf+0x457>
   43856:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4385a:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   4385d:	0f b6 f0             	movzbl %al,%esi
   43860:	44 89 fa             	mov    %r15d,%edx
   43863:	4c 89 f7             	mov    %r14,%rdi
   43866:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
   43869:	48 83 c3 01          	add    $0x1,%rbx
   4386d:	0f b6 03             	movzbl (%rbx),%eax
   43870:	84 c0                	test   %al,%al
   43872:	75 e9                	jne    4385d <printer_vprintf+0x43c>
   43874:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43878:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4387b:	85 c0                	test   %eax,%eax
   4387d:	7e 1d                	jle    4389c <printer_vprintf+0x47b>
   4387f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43883:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   43885:	44 89 fa             	mov    %r15d,%edx
   43888:	be 30 00 00 00       	mov    $0x30,%esi
   4388d:	4c 89 f7             	mov    %r14,%rdi
   43890:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
   43893:	83 eb 01             	sub    $0x1,%ebx
   43896:	75 ed                	jne    43885 <printer_vprintf+0x464>
   43898:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   4389c:	8b 45 98             	mov    -0x68(%rbp),%eax
   4389f:	85 c0                	test   %eax,%eax
   438a1:	7e 27                	jle    438ca <printer_vprintf+0x4a9>
   438a3:	89 c0                	mov    %eax,%eax
   438a5:	4c 01 e0             	add    %r12,%rax
   438a8:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   438ac:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   438af:	41 0f b6 34 24       	movzbl (%r12),%esi
   438b4:	44 89 fa             	mov    %r15d,%edx
   438b7:	4c 89 f7             	mov    %r14,%rdi
   438ba:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
   438bd:	49 83 c4 01          	add    $0x1,%r12
   438c1:	49 39 dc             	cmp    %rbx,%r12
   438c4:	75 e9                	jne    438af <printer_vprintf+0x48e>
   438c6:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   438ca:	45 85 ed             	test   %r13d,%r13d
   438cd:	7e 14                	jle    438e3 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   438cf:	44 89 fa             	mov    %r15d,%edx
   438d2:	be 20 00 00 00       	mov    $0x20,%esi
   438d7:	4c 89 f7             	mov    %r14,%rdi
   438da:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
   438dd:	41 83 ed 01          	sub    $0x1,%r13d
   438e1:	75 ec                	jne    438cf <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   438e3:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   438e7:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   438eb:	84 c0                	test   %al,%al
   438ed:	0f 84 fe 01 00 00    	je     43af1 <printer_vprintf+0x6d0>
        if (*format != '%') {
   438f3:	3c 25                	cmp    $0x25,%al
   438f5:	0f 84 54 fb ff ff    	je     4344f <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   438fb:	0f b6 f0             	movzbl %al,%esi
   438fe:	44 89 fa             	mov    %r15d,%edx
   43901:	4c 89 f7             	mov    %r14,%rdi
   43904:	41 ff 16             	call   *(%r14)
            continue;
   43907:	4c 89 e3             	mov    %r12,%rbx
   4390a:	eb d7                	jmp    438e3 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   4390c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43910:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43914:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43918:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4391c:	e9 51 fe ff ff       	jmp    43772 <printer_vprintf+0x351>
            color = va_arg(val, int);
   43921:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43925:	8b 07                	mov    (%rdi),%eax
   43927:	83 f8 2f             	cmp    $0x2f,%eax
   4392a:	77 10                	ja     4393c <printer_vprintf+0x51b>
   4392c:	89 c2                	mov    %eax,%edx
   4392e:	48 03 57 10          	add    0x10(%rdi),%rdx
   43932:	83 c0 08             	add    $0x8,%eax
   43935:	89 07                	mov    %eax,(%rdi)
   43937:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   4393a:	eb a7                	jmp    438e3 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   4393c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43940:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43944:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43948:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4394c:	eb e9                	jmp    43937 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   4394e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43952:	8b 01                	mov    (%rcx),%eax
   43954:	83 f8 2f             	cmp    $0x2f,%eax
   43957:	77 23                	ja     4397c <printer_vprintf+0x55b>
   43959:	89 c2                	mov    %eax,%edx
   4395b:	48 03 51 10          	add    0x10(%rcx),%rdx
   4395f:	83 c0 08             	add    $0x8,%eax
   43962:	89 01                	mov    %eax,(%rcx)
   43964:	8b 02                	mov    (%rdx),%eax
   43966:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43969:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   4396d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43971:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43977:	e9 ff fd ff ff       	jmp    4377b <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   4397c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43980:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43984:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43988:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4398c:	eb d6                	jmp    43964 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   4398e:	84 d2                	test   %dl,%dl
   43990:	0f 85 39 01 00 00    	jne    43acf <printer_vprintf+0x6ae>
   43996:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   4399a:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   4399e:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   439a2:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   439a6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   439ac:	e9 ca fd ff ff       	jmp    4377b <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   439b1:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   439b7:	bf 50 54 04 00       	mov    $0x45450,%edi
        if (flags & FLAG_NUMERIC) {
   439bc:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   439c1:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   439c5:	4c 89 c1             	mov    %r8,%rcx
   439c8:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   439cc:	48 63 f6             	movslq %esi,%rsi
   439cf:	49 83 ec 01          	sub    $0x1,%r12
   439d3:	48 89 c8             	mov    %rcx,%rax
   439d6:	ba 00 00 00 00       	mov    $0x0,%edx
   439db:	48 f7 f6             	div    %rsi
   439de:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   439e2:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   439e6:	48 89 ca             	mov    %rcx,%rdx
   439e9:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   439ec:	48 39 d6             	cmp    %rdx,%rsi
   439ef:	76 de                	jbe    439cf <printer_vprintf+0x5ae>
   439f1:	e9 9a fd ff ff       	jmp    43790 <printer_vprintf+0x36f>
                prefix = "-";
   439f6:	48 c7 45 a0 64 52 04 	movq   $0x45264,-0x60(%rbp)
   439fd:	00 
            if (flags & FLAG_NEGATIVE) {
   439fe:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43a01:	a8 80                	test   $0x80,%al
   43a03:	0f 85 b0 fd ff ff    	jne    437b9 <printer_vprintf+0x398>
                prefix = "+";
   43a09:	48 c7 45 a0 5f 52 04 	movq   $0x4525f,-0x60(%rbp)
   43a10:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43a11:	a8 10                	test   $0x10,%al
   43a13:	0f 85 a0 fd ff ff    	jne    437b9 <printer_vprintf+0x398>
                prefix = " ";
   43a19:	a8 08                	test   $0x8,%al
   43a1b:	ba 67 52 04 00       	mov    $0x45267,%edx
   43a20:	b8 66 52 04 00       	mov    $0x45266,%eax
   43a25:	48 0f 44 c2          	cmove  %rdx,%rax
   43a29:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43a2d:	e9 87 fd ff ff       	jmp    437b9 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   43a32:	41 8d 41 10          	lea    0x10(%r9),%eax
   43a36:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   43a3b:	0f 85 78 fd ff ff    	jne    437b9 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   43a41:	4d 85 c0             	test   %r8,%r8
   43a44:	75 0d                	jne    43a53 <printer_vprintf+0x632>
   43a46:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   43a4d:	0f 84 66 fd ff ff    	je     437b9 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   43a53:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   43a57:	ba 68 52 04 00       	mov    $0x45268,%edx
   43a5c:	b8 61 52 04 00       	mov    $0x45261,%eax
   43a61:	48 0f 44 c2          	cmove  %rdx,%rax
   43a65:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43a69:	e9 4b fd ff ff       	jmp    437b9 <printer_vprintf+0x398>
            len = strlen(data);
   43a6e:	4c 89 e7             	mov    %r12,%rdi
   43a71:	e8 b5 f8 ff ff       	call   4332b <strlen>
   43a76:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43a79:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43a7d:	0f 84 63 fd ff ff    	je     437e6 <printer_vprintf+0x3c5>
   43a83:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43a87:	0f 84 59 fd ff ff    	je     437e6 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   43a8d:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   43a90:	89 ca                	mov    %ecx,%edx
   43a92:	29 c2                	sub    %eax,%edx
   43a94:	39 c1                	cmp    %eax,%ecx
   43a96:	b8 00 00 00 00       	mov    $0x0,%eax
   43a9b:	0f 4e d0             	cmovle %eax,%edx
   43a9e:	89 55 9c             	mov    %edx,-0x64(%rbp)
   43aa1:	e9 56 fd ff ff       	jmp    437fc <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   43aa6:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43aaa:	e8 7c f8 ff ff       	call   4332b <strlen>
   43aaf:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43ab2:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43ab5:	44 89 e9             	mov    %r13d,%ecx
   43ab8:	29 f9                	sub    %edi,%ecx
   43aba:	29 c1                	sub    %eax,%ecx
   43abc:	44 39 ea             	cmp    %r13d,%edx
   43abf:	b8 00 00 00 00       	mov    $0x0,%eax
   43ac4:	0f 4d c8             	cmovge %eax,%ecx
   43ac7:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   43aca:	e9 2d fd ff ff       	jmp    437fc <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43acf:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43ad2:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43ad6:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43ada:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43ae0:	e9 96 fc ff ff       	jmp    4377b <printer_vprintf+0x35a>
        int flags = 0;
   43ae5:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   43aec:	e9 b0 f9 ff ff       	jmp    434a1 <printer_vprintf+0x80>
}
   43af1:	48 83 c4 58          	add    $0x58,%rsp
   43af5:	5b                   	pop    %rbx
   43af6:	41 5c                	pop    %r12
   43af8:	41 5d                	pop    %r13
   43afa:	41 5e                	pop    %r14
   43afc:	41 5f                	pop    %r15
   43afe:	5d                   	pop    %rbp
   43aff:	c3                   	ret    

0000000000043b00 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43b00:	55                   	push   %rbp
   43b01:	48 89 e5             	mov    %rsp,%rbp
   43b04:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   43b08:	48 c7 45 f0 0b 32 04 	movq   $0x4320b,-0x10(%rbp)
   43b0f:	00 
        cpos = 0;
   43b10:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   43b16:	b8 00 00 00 00       	mov    $0x0,%eax
   43b1b:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   43b1e:	48 63 ff             	movslq %edi,%rdi
   43b21:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   43b28:	00 
   43b29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43b2d:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   43b31:	e8 eb f8 ff ff       	call   43421 <printer_vprintf>
    return cp.cursor - console;
   43b36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b3a:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43b40:	48 d1 f8             	sar    %rax
}
   43b43:	c9                   	leave  
   43b44:	c3                   	ret    

0000000000043b45 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   43b45:	55                   	push   %rbp
   43b46:	48 89 e5             	mov    %rsp,%rbp
   43b49:	48 83 ec 50          	sub    $0x50,%rsp
   43b4d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43b51:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43b55:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   43b59:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43b60:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43b64:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43b68:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43b6c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43b70:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43b74:	e8 87 ff ff ff       	call   43b00 <console_vprintf>
}
   43b79:	c9                   	leave  
   43b7a:	c3                   	ret    

0000000000043b7b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43b7b:	55                   	push   %rbp
   43b7c:	48 89 e5             	mov    %rsp,%rbp
   43b7f:	53                   	push   %rbx
   43b80:	48 83 ec 28          	sub    $0x28,%rsp
   43b84:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   43b87:	48 c7 45 d8 91 32 04 	movq   $0x43291,-0x28(%rbp)
   43b8e:	00 
    sp.s = s;
   43b8f:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   43b93:	48 85 f6             	test   %rsi,%rsi
   43b96:	75 0b                	jne    43ba3 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   43b98:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43b9b:	29 d8                	sub    %ebx,%eax
}
   43b9d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43ba1:	c9                   	leave  
   43ba2:	c3                   	ret    
        sp.end = s + size - 1;
   43ba3:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43ba8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43bac:	be 00 00 00 00       	mov    $0x0,%esi
   43bb1:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43bb5:	e8 67 f8 ff ff       	call   43421 <printer_vprintf>
        *sp.s = 0;
   43bba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bbe:	c6 00 00             	movb   $0x0,(%rax)
   43bc1:	eb d5                	jmp    43b98 <vsnprintf+0x1d>

0000000000043bc3 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43bc3:	55                   	push   %rbp
   43bc4:	48 89 e5             	mov    %rsp,%rbp
   43bc7:	48 83 ec 50          	sub    $0x50,%rsp
   43bcb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43bcf:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43bd3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43bd7:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43bde:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43be2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43be6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43bea:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   43bee:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43bf2:	e8 84 ff ff ff       	call   43b7b <vsnprintf>
    va_end(val);
    return n;
}
   43bf7:	c9                   	leave  
   43bf8:	c3                   	ret    

0000000000043bf9 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43bf9:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   43bfe:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   43c03:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43c08:	48 83 c0 02          	add    $0x2,%rax
   43c0c:	48 39 d0             	cmp    %rdx,%rax
   43c0f:	75 f2                	jne    43c03 <console_clear+0xa>
    }
    cursorpos = 0;
   43c11:	c7 05 e1 53 07 00 00 	movl   $0x0,0x753e1(%rip)        # b8ffc <cursorpos>
   43c18:	00 00 00 
}
   43c1b:	c3                   	ret    

0000000000043c1c <palloc>:
   43c1c:	55                   	push   %rbp
   43c1d:	48 89 e5             	mov    %rsp,%rbp
   43c20:	48 83 ec 20          	sub    $0x20,%rsp
   43c24:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43c27:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43c2e:	00 
   43c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c33:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c37:	e9 95 00 00 00       	jmp    43cd1 <palloc+0xb5>
   43c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c40:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c44:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43c4b:	00 
   43c4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c50:	48 c1 e8 0c          	shr    $0xc,%rax
   43c54:	48 98                	cltq   
   43c56:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   43c5d:	00 
   43c5e:	84 c0                	test   %al,%al
   43c60:	75 6f                	jne    43cd1 <palloc+0xb5>
   43c62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c66:	48 c1 e8 0c          	shr    $0xc,%rax
   43c6a:	48 98                	cltq   
   43c6c:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43c73:	00 
   43c74:	84 c0                	test   %al,%al
   43c76:	75 59                	jne    43cd1 <palloc+0xb5>
   43c78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c7c:	48 c1 e8 0c          	shr    $0xc,%rax
   43c80:	89 c2                	mov    %eax,%edx
   43c82:	48 63 c2             	movslq %edx,%rax
   43c85:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43c8c:	00 
   43c8d:	83 c0 01             	add    $0x1,%eax
   43c90:	89 c1                	mov    %eax,%ecx
   43c92:	48 63 c2             	movslq %edx,%rax
   43c95:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
   43c9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ca0:	48 c1 e8 0c          	shr    $0xc,%rax
   43ca4:	89 c1                	mov    %eax,%ecx
   43ca6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ca9:	89 c2                	mov    %eax,%edx
   43cab:	48 63 c1             	movslq %ecx,%rax
   43cae:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
   43cb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cb9:	ba 00 10 00 00       	mov    $0x1000,%edx
   43cbe:	be cc 00 00 00       	mov    $0xcc,%esi
   43cc3:	48 89 c7             	mov    %rax,%rdi
   43cc6:	e8 45 f6 ff ff       	call   43310 <memset>
   43ccb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ccf:	eb 2c                	jmp    43cfd <palloc+0xe1>
   43cd1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43cd8:	00 
   43cd9:	0f 86 5d ff ff ff    	jbe    43c3c <palloc+0x20>
   43cdf:	ba 68 54 04 00       	mov    $0x45468,%edx
   43ce4:	be 00 0c 00 00       	mov    $0xc00,%esi
   43ce9:	bf 80 07 00 00       	mov    $0x780,%edi
   43cee:	b8 00 00 00 00       	mov    $0x0,%eax
   43cf3:	e8 4d fe ff ff       	call   43b45 <console_printf>
   43cf8:	b8 00 00 00 00       	mov    $0x0,%eax
   43cfd:	c9                   	leave  
   43cfe:	c3                   	ret    

0000000000043cff <palloc_target>:
   43cff:	55                   	push   %rbp
   43d00:	48 89 e5             	mov    %rsp,%rbp
   43d03:	48 8b 05 fe 62 01 00 	mov    0x162fe(%rip),%rax        # 5a008 <palloc_target_proc>
   43d0a:	48 85 c0             	test   %rax,%rax
   43d0d:	75 14                	jne    43d23 <palloc_target+0x24>
   43d0f:	ba 81 54 04 00       	mov    $0x45481,%edx
   43d14:	be 27 00 00 00       	mov    $0x27,%esi
   43d19:	bf 9c 54 04 00       	mov    $0x4549c,%edi
   43d1e:	e8 6a e9 ff ff       	call   4268d <assert_fail>
   43d23:	48 8b 05 de 62 01 00 	mov    0x162de(%rip),%rax        # 5a008 <palloc_target_proc>
   43d2a:	8b 00                	mov    (%rax),%eax
   43d2c:	89 c7                	mov    %eax,%edi
   43d2e:	e8 e9 fe ff ff       	call   43c1c <palloc>
   43d33:	5d                   	pop    %rbp
   43d34:	c3                   	ret    

0000000000043d35 <process_free>:
   43d35:	55                   	push   %rbp
   43d36:	48 89 e5             	mov    %rsp,%rbp
   43d39:	48 83 ec 60          	sub    $0x60,%rsp
   43d3d:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43d40:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43d43:	48 63 d0             	movslq %eax,%rdx
   43d46:	48 89 d0             	mov    %rdx,%rax
   43d49:	48 c1 e0 04          	shl    $0x4,%rax
   43d4d:	48 29 d0             	sub    %rdx,%rax
   43d50:	48 c1 e0 04          	shl    $0x4,%rax
   43d54:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   43d5a:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43d60:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43d67:	00 
   43d68:	e9 ad 00 00 00       	jmp    43e1a <process_free+0xe5>
   43d6d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43d70:	48 63 d0             	movslq %eax,%rdx
   43d73:	48 89 d0             	mov    %rdx,%rax
   43d76:	48 c1 e0 04          	shl    $0x4,%rax
   43d7a:	48 29 d0             	sub    %rdx,%rax
   43d7d:	48 c1 e0 04          	shl    $0x4,%rax
   43d81:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   43d87:	48 8b 08             	mov    (%rax),%rcx
   43d8a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43d8e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d92:	48 89 ce             	mov    %rcx,%rsi
   43d95:	48 89 c7             	mov    %rax,%rdi
   43d98:	e8 b2 ef ff ff       	call   42d4f <virtual_memory_lookup>
   43d9d:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43da0:	48 98                	cltq   
   43da2:	83 e0 01             	and    $0x1,%eax
   43da5:	48 85 c0             	test   %rax,%rax
   43da8:	74 68                	je     43e12 <process_free+0xdd>
   43daa:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43dad:	48 63 d0             	movslq %eax,%rdx
   43db0:	0f b6 94 12 21 1f 05 	movzbl 0x51f21(%rdx,%rdx,1),%edx
   43db7:	00 
   43db8:	83 ea 01             	sub    $0x1,%edx
   43dbb:	48 98                	cltq   
   43dbd:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
   43dc4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43dc7:	48 98                	cltq   
   43dc9:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43dd0:	00 
   43dd1:	84 c0                	test   %al,%al
   43dd3:	75 0f                	jne    43de4 <process_free+0xaf>
   43dd5:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43dd8:	48 98                	cltq   
   43dda:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43de1:	00 
   43de2:	eb 2e                	jmp    43e12 <process_free+0xdd>
   43de4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43de7:	48 98                	cltq   
   43de9:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   43df0:	00 
   43df1:	0f be c0             	movsbl %al,%eax
   43df4:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43df7:	75 19                	jne    43e12 <process_free+0xdd>
   43df9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43dfd:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43e00:	48 89 c6             	mov    %rax,%rsi
   43e03:	bf a8 54 04 00       	mov    $0x454a8,%edi
   43e08:	b8 00 00 00 00       	mov    $0x0,%eax
   43e0d:	e8 5d e5 ff ff       	call   4236f <log_printf>
   43e12:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43e19:	00 
   43e1a:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43e21:	00 
   43e22:	0f 86 45 ff ff ff    	jbe    43d6d <process_free+0x38>
   43e28:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43e2b:	48 63 d0             	movslq %eax,%rdx
   43e2e:	48 89 d0             	mov    %rdx,%rax
   43e31:	48 c1 e0 04          	shl    $0x4,%rax
   43e35:	48 29 d0             	sub    %rdx,%rax
   43e38:	48 c1 e0 04          	shl    $0x4,%rax
   43e3c:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   43e42:	48 8b 00             	mov    (%rax),%rax
   43e45:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43e49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e4d:	48 8b 00             	mov    (%rax),%rax
   43e50:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e56:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43e5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e5e:	48 8b 00             	mov    (%rax),%rax
   43e61:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e67:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43e6b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e6f:	48 8b 00             	mov    (%rax),%rax
   43e72:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e78:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43e7c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e80:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e84:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43e8a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43e8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e92:	48 c1 e8 0c          	shr    $0xc,%rax
   43e96:	48 98                	cltq   
   43e98:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43e9f:	00 
   43ea0:	3c 01                	cmp    $0x1,%al
   43ea2:	74 14                	je     43eb8 <process_free+0x183>
   43ea4:	ba e0 54 04 00       	mov    $0x454e0,%edx
   43ea9:	be 4f 00 00 00       	mov    $0x4f,%esi
   43eae:	bf 9c 54 04 00       	mov    $0x4549c,%edi
   43eb3:	e8 d5 e7 ff ff       	call   4268d <assert_fail>
   43eb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ebc:	48 c1 e8 0c          	shr    $0xc,%rax
   43ec0:	48 98                	cltq   
   43ec2:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43ec9:	00 
   43eca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ece:	48 c1 e8 0c          	shr    $0xc,%rax
   43ed2:	48 98                	cltq   
   43ed4:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43edb:	00 
   43edc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ee0:	48 c1 e8 0c          	shr    $0xc,%rax
   43ee4:	48 98                	cltq   
   43ee6:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43eed:	00 
   43eee:	3c 01                	cmp    $0x1,%al
   43ef0:	74 14                	je     43f06 <process_free+0x1d1>
   43ef2:	ba 08 55 04 00       	mov    $0x45508,%edx
   43ef7:	be 52 00 00 00       	mov    $0x52,%esi
   43efc:	bf 9c 54 04 00       	mov    $0x4549c,%edi
   43f01:	e8 87 e7 ff ff       	call   4268d <assert_fail>
   43f06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f0a:	48 c1 e8 0c          	shr    $0xc,%rax
   43f0e:	48 98                	cltq   
   43f10:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f17:	00 
   43f18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f1c:	48 c1 e8 0c          	shr    $0xc,%rax
   43f20:	48 98                	cltq   
   43f22:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f29:	00 
   43f2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f2e:	48 c1 e8 0c          	shr    $0xc,%rax
   43f32:	48 98                	cltq   
   43f34:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43f3b:	00 
   43f3c:	3c 01                	cmp    $0x1,%al
   43f3e:	74 14                	je     43f54 <process_free+0x21f>
   43f40:	ba 30 55 04 00       	mov    $0x45530,%edx
   43f45:	be 55 00 00 00       	mov    $0x55,%esi
   43f4a:	bf 9c 54 04 00       	mov    $0x4549c,%edi
   43f4f:	e8 39 e7 ff ff       	call   4268d <assert_fail>
   43f54:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f58:	48 c1 e8 0c          	shr    $0xc,%rax
   43f5c:	48 98                	cltq   
   43f5e:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f65:	00 
   43f66:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f6a:	48 c1 e8 0c          	shr    $0xc,%rax
   43f6e:	48 98                	cltq   
   43f70:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f77:	00 
   43f78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f7c:	48 c1 e8 0c          	shr    $0xc,%rax
   43f80:	48 98                	cltq   
   43f82:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43f89:	00 
   43f8a:	3c 01                	cmp    $0x1,%al
   43f8c:	74 14                	je     43fa2 <process_free+0x26d>
   43f8e:	ba 58 55 04 00       	mov    $0x45558,%edx
   43f93:	be 58 00 00 00       	mov    $0x58,%esi
   43f98:	bf 9c 54 04 00       	mov    $0x4549c,%edi
   43f9d:	e8 eb e6 ff ff       	call   4268d <assert_fail>
   43fa2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fa6:	48 c1 e8 0c          	shr    $0xc,%rax
   43faa:	48 98                	cltq   
   43fac:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43fb3:	00 
   43fb4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fb8:	48 c1 e8 0c          	shr    $0xc,%rax
   43fbc:	48 98                	cltq   
   43fbe:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43fc5:	00 
   43fc6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43fca:	48 c1 e8 0c          	shr    $0xc,%rax
   43fce:	48 98                	cltq   
   43fd0:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43fd7:	00 
   43fd8:	3c 01                	cmp    $0x1,%al
   43fda:	74 14                	je     43ff0 <process_free+0x2bb>
   43fdc:	ba 80 55 04 00       	mov    $0x45580,%edx
   43fe1:	be 5b 00 00 00       	mov    $0x5b,%esi
   43fe6:	bf 9c 54 04 00       	mov    $0x4549c,%edi
   43feb:	e8 9d e6 ff ff       	call   4268d <assert_fail>
   43ff0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43ff4:	48 c1 e8 0c          	shr    $0xc,%rax
   43ff8:	48 98                	cltq   
   43ffa:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44001:	00 
   44002:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44006:	48 c1 e8 0c          	shr    $0xc,%rax
   4400a:	48 98                	cltq   
   4400c:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44013:	00 
   44014:	90                   	nop
   44015:	c9                   	leave  
   44016:	c3                   	ret    

0000000000044017 <process_config_tables>:
   44017:	55                   	push   %rbp
   44018:	48 89 e5             	mov    %rsp,%rbp
   4401b:	48 83 ec 40          	sub    $0x40,%rsp
   4401f:	89 7d cc             	mov    %edi,-0x34(%rbp)
   44022:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44025:	89 c7                	mov    %eax,%edi
   44027:	e8 f0 fb ff ff       	call   43c1c <palloc>
   4402c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44030:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44033:	89 c7                	mov    %eax,%edi
   44035:	e8 e2 fb ff ff       	call   43c1c <palloc>
   4403a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4403e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   44041:	89 c7                	mov    %eax,%edi
   44043:	e8 d4 fb ff ff       	call   43c1c <palloc>
   44048:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4404c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4404f:	89 c7                	mov    %eax,%edi
   44051:	e8 c6 fb ff ff       	call   43c1c <palloc>
   44056:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4405a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4405d:	89 c7                	mov    %eax,%edi
   4405f:	e8 b8 fb ff ff       	call   43c1c <palloc>
   44064:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   44068:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4406d:	74 20                	je     4408f <process_config_tables+0x78>
   4406f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   44074:	74 19                	je     4408f <process_config_tables+0x78>
   44076:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4407b:	74 12                	je     4408f <process_config_tables+0x78>
   4407d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   44082:	74 0b                	je     4408f <process_config_tables+0x78>
   44084:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44089:	0f 85 e1 00 00 00    	jne    44170 <process_config_tables+0x159>
   4408f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   44094:	74 24                	je     440ba <process_config_tables+0xa3>
   44096:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4409a:	48 c1 e8 0c          	shr    $0xc,%rax
   4409e:	48 98                	cltq   
   440a0:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   440a7:	00 
   440a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440ac:	48 c1 e8 0c          	shr    $0xc,%rax
   440b0:	48 98                	cltq   
   440b2:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   440b9:	00 
   440ba:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   440bf:	74 24                	je     440e5 <process_config_tables+0xce>
   440c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440c5:	48 c1 e8 0c          	shr    $0xc,%rax
   440c9:	48 98                	cltq   
   440cb:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   440d2:	00 
   440d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440d7:	48 c1 e8 0c          	shr    $0xc,%rax
   440db:	48 98                	cltq   
   440dd:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   440e4:	00 
   440e5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   440ea:	74 24                	je     44110 <process_config_tables+0xf9>
   440ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440f0:	48 c1 e8 0c          	shr    $0xc,%rax
   440f4:	48 98                	cltq   
   440f6:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   440fd:	00 
   440fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44102:	48 c1 e8 0c          	shr    $0xc,%rax
   44106:	48 98                	cltq   
   44108:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   4410f:	00 
   44110:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   44115:	74 24                	je     4413b <process_config_tables+0x124>
   44117:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4411b:	48 c1 e8 0c          	shr    $0xc,%rax
   4411f:	48 98                	cltq   
   44121:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44128:	00 
   44129:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4412d:	48 c1 e8 0c          	shr    $0xc,%rax
   44131:	48 98                	cltq   
   44133:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   4413a:	00 
   4413b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44140:	74 24                	je     44166 <process_config_tables+0x14f>
   44142:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44146:	48 c1 e8 0c          	shr    $0xc,%rax
   4414a:	48 98                	cltq   
   4414c:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44153:	00 
   44154:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44158:	48 c1 e8 0c          	shr    $0xc,%rax
   4415c:	48 98                	cltq   
   4415e:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44165:	00 
   44166:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4416b:	e9 f3 01 00 00       	jmp    44363 <process_config_tables+0x34c>
   44170:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44174:	ba 00 10 00 00       	mov    $0x1000,%edx
   44179:	be 00 00 00 00       	mov    $0x0,%esi
   4417e:	48 89 c7             	mov    %rax,%rdi
   44181:	e8 8a f1 ff ff       	call   43310 <memset>
   44186:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4418a:	ba 00 10 00 00       	mov    $0x1000,%edx
   4418f:	be 00 00 00 00       	mov    $0x0,%esi
   44194:	48 89 c7             	mov    %rax,%rdi
   44197:	e8 74 f1 ff ff       	call   43310 <memset>
   4419c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441a0:	ba 00 10 00 00       	mov    $0x1000,%edx
   441a5:	be 00 00 00 00       	mov    $0x0,%esi
   441aa:	48 89 c7             	mov    %rax,%rdi
   441ad:	e8 5e f1 ff ff       	call   43310 <memset>
   441b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   441b6:	ba 00 10 00 00       	mov    $0x1000,%edx
   441bb:	be 00 00 00 00       	mov    $0x0,%esi
   441c0:	48 89 c7             	mov    %rax,%rdi
   441c3:	e8 48 f1 ff ff       	call   43310 <memset>
   441c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441cc:	ba 00 10 00 00       	mov    $0x1000,%edx
   441d1:	be 00 00 00 00       	mov    $0x0,%esi
   441d6:	48 89 c7             	mov    %rax,%rdi
   441d9:	e8 32 f1 ff ff       	call   43310 <memset>
   441de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441e2:	48 83 c8 07          	or     $0x7,%rax
   441e6:	48 89 c2             	mov    %rax,%rdx
   441e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441ed:	48 89 10             	mov    %rdx,(%rax)
   441f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441f4:	48 83 c8 07          	or     $0x7,%rax
   441f8:	48 89 c2             	mov    %rax,%rdx
   441fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441ff:	48 89 10             	mov    %rdx,(%rax)
   44202:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44206:	48 83 c8 07          	or     $0x7,%rax
   4420a:	48 89 c2             	mov    %rax,%rdx
   4420d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44211:	48 89 10             	mov    %rdx,(%rax)
   44214:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44218:	48 83 c8 07          	or     $0x7,%rax
   4421c:	48 89 c2             	mov    %rax,%rdx
   4421f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44223:	48 89 50 08          	mov    %rdx,0x8(%rax)
   44227:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4422b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44231:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   44237:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4423c:	ba 00 00 00 00       	mov    $0x0,%edx
   44241:	be 00 00 00 00       	mov    $0x0,%esi
   44246:	48 89 c7             	mov    %rax,%rdi
   44249:	e8 3e e7 ff ff       	call   4298c <virtual_memory_map>
   4424e:	85 c0                	test   %eax,%eax
   44250:	75 2f                	jne    44281 <process_config_tables+0x26a>
   44252:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   44257:	be 00 80 0b 00       	mov    $0xb8000,%esi
   4425c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44260:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44266:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4426c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44271:	48 89 c7             	mov    %rax,%rdi
   44274:	e8 13 e7 ff ff       	call   4298c <virtual_memory_map>
   44279:	85 c0                	test   %eax,%eax
   4427b:	0f 84 bb 00 00 00    	je     4433c <process_config_tables+0x325>
   44281:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44285:	48 c1 e8 0c          	shr    $0xc,%rax
   44289:	48 98                	cltq   
   4428b:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44292:	00 
   44293:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44297:	48 c1 e8 0c          	shr    $0xc,%rax
   4429b:	48 98                	cltq   
   4429d:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   442a4:	00 
   442a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442a9:	48 c1 e8 0c          	shr    $0xc,%rax
   442ad:	48 98                	cltq   
   442af:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   442b6:	00 
   442b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442bb:	48 c1 e8 0c          	shr    $0xc,%rax
   442bf:	48 98                	cltq   
   442c1:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   442c8:	00 
   442c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442cd:	48 c1 e8 0c          	shr    $0xc,%rax
   442d1:	48 98                	cltq   
   442d3:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   442da:	00 
   442db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442df:	48 c1 e8 0c          	shr    $0xc,%rax
   442e3:	48 98                	cltq   
   442e5:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   442ec:	00 
   442ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   442f1:	48 c1 e8 0c          	shr    $0xc,%rax
   442f5:	48 98                	cltq   
   442f7:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   442fe:	00 
   442ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44303:	48 c1 e8 0c          	shr    $0xc,%rax
   44307:	48 98                	cltq   
   44309:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44310:	00 
   44311:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44315:	48 c1 e8 0c          	shr    $0xc,%rax
   44319:	48 98                	cltq   
   4431b:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44322:	00 
   44323:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44327:	48 c1 e8 0c          	shr    $0xc,%rax
   4432b:	48 98                	cltq   
   4432d:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44334:	00 
   44335:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4433a:	eb 27                	jmp    44363 <process_config_tables+0x34c>
   4433c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4433f:	48 63 d0             	movslq %eax,%rdx
   44342:	48 89 d0             	mov    %rdx,%rax
   44345:	48 c1 e0 04          	shl    $0x4,%rax
   44349:	48 29 d0             	sub    %rdx,%rax
   4434c:	48 c1 e0 04          	shl    $0x4,%rax
   44350:	48 8d 90 e0 10 05 00 	lea    0x510e0(%rax),%rdx
   44357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4435b:	48 89 02             	mov    %rax,(%rdx)
   4435e:	b8 00 00 00 00       	mov    $0x0,%eax
   44363:	c9                   	leave  
   44364:	c3                   	ret    

0000000000044365 <process_load>:
   44365:	55                   	push   %rbp
   44366:	48 89 e5             	mov    %rsp,%rbp
   44369:	48 83 ec 20          	sub    $0x20,%rsp
   4436d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44371:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   44374:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44378:	48 89 05 89 5c 01 00 	mov    %rax,0x15c89(%rip)        # 5a008 <palloc_target_proc>
   4437f:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   44382:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44386:	ba ff 3c 04 00       	mov    $0x43cff,%edx
   4438b:	89 ce                	mov    %ecx,%esi
   4438d:	48 89 c7             	mov    %rax,%rdi
   44390:	e8 b1 ea ff ff       	call   42e46 <program_load>
   44395:	89 45 fc             	mov    %eax,-0x4(%rbp)
   44398:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4439b:	c9                   	leave  
   4439c:	c3                   	ret    

000000000004439d <process_setup_stack>:
   4439d:	55                   	push   %rbp
   4439e:	48 89 e5             	mov    %rsp,%rbp
   443a1:	48 83 ec 20          	sub    $0x20,%rsp
   443a5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443ad:	8b 00                	mov    (%rax),%eax
   443af:	89 c7                	mov    %eax,%edi
   443b1:	e8 66 f8 ff ff       	call   43c1c <palloc>
   443b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   443ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443be:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   443c5:	00 00 30 00 
   443c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443cd:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   443d4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   443d8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   443de:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   443e4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   443e9:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   443ee:	48 89 c7             	mov    %rax,%rdi
   443f1:	e8 96 e5 ff ff       	call   4298c <virtual_memory_map>
   443f6:	90                   	nop
   443f7:	c9                   	leave  
   443f8:	c3                   	ret    

00000000000443f9 <find_free_pid>:
   443f9:	55                   	push   %rbp
   443fa:	48 89 e5             	mov    %rsp,%rbp
   443fd:	48 83 ec 10          	sub    $0x10,%rsp
   44401:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44408:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   4440f:	eb 24                	jmp    44435 <find_free_pid+0x3c>
   44411:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44414:	48 63 d0             	movslq %eax,%rdx
   44417:	48 89 d0             	mov    %rdx,%rax
   4441a:	48 c1 e0 04          	shl    $0x4,%rax
   4441e:	48 29 d0             	sub    %rdx,%rax
   44421:	48 c1 e0 04          	shl    $0x4,%rax
   44425:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4442b:	8b 00                	mov    (%rax),%eax
   4442d:	85 c0                	test   %eax,%eax
   4442f:	74 0c                	je     4443d <find_free_pid+0x44>
   44431:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44435:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   44439:	7e d6                	jle    44411 <find_free_pid+0x18>
   4443b:	eb 01                	jmp    4443e <find_free_pid+0x45>
   4443d:	90                   	nop
   4443e:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   44442:	74 05                	je     44449 <find_free_pid+0x50>
   44444:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44447:	eb 05                	jmp    4444e <find_free_pid+0x55>
   44449:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4444e:	c9                   	leave  
   4444f:	c3                   	ret    

0000000000044450 <process_fork>:
   44450:	55                   	push   %rbp
   44451:	48 89 e5             	mov    %rsp,%rbp
   44454:	48 83 ec 40          	sub    $0x40,%rsp
   44458:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4445c:	b8 00 00 00 00       	mov    $0x0,%eax
   44461:	e8 93 ff ff ff       	call   443f9 <find_free_pid>
   44466:	89 45 f4             	mov    %eax,-0xc(%rbp)
   44469:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   4446d:	75 0a                	jne    44479 <process_fork+0x29>
   4446f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44474:	e9 67 02 00 00       	jmp    446e0 <process_fork+0x290>
   44479:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4447c:	48 63 d0             	movslq %eax,%rdx
   4447f:	48 89 d0             	mov    %rdx,%rax
   44482:	48 c1 e0 04          	shl    $0x4,%rax
   44486:	48 29 d0             	sub    %rdx,%rax
   44489:	48 c1 e0 04          	shl    $0x4,%rax
   4448d:	48 05 00 10 05 00    	add    $0x51000,%rax
   44493:	be 00 00 00 00       	mov    $0x0,%esi
   44498:	48 89 c7             	mov    %rax,%rdi
   4449b:	e8 25 da ff ff       	call   41ec5 <process_init>
   444a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   444a3:	89 c7                	mov    %eax,%edi
   444a5:	e8 6d fb ff ff       	call   44017 <process_config_tables>
   444aa:	83 f8 ff             	cmp    $0xffffffff,%eax
   444ad:	75 0a                	jne    444b9 <process_fork+0x69>
   444af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   444b4:	e9 27 02 00 00       	jmp    446e0 <process_fork+0x290>
   444b9:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   444c0:	00 
   444c1:	e9 79 01 00 00       	jmp    4463f <process_fork+0x1ef>
   444c6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   444ca:	8b 00                	mov    (%rax),%eax
   444cc:	48 63 d0             	movslq %eax,%rdx
   444cf:	48 89 d0             	mov    %rdx,%rax
   444d2:	48 c1 e0 04          	shl    $0x4,%rax
   444d6:	48 29 d0             	sub    %rdx,%rax
   444d9:	48 c1 e0 04          	shl    $0x4,%rax
   444dd:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   444e3:	48 8b 08             	mov    (%rax),%rcx
   444e6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   444ea:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   444ee:	48 89 ce             	mov    %rcx,%rsi
   444f1:	48 89 c7             	mov    %rax,%rdi
   444f4:	e8 56 e8 ff ff       	call   42d4f <virtual_memory_lookup>
   444f9:	8b 45 e0             	mov    -0x20(%rbp),%eax
   444fc:	48 98                	cltq   
   444fe:	83 e0 07             	and    $0x7,%eax
   44501:	48 83 f8 07          	cmp    $0x7,%rax
   44505:	0f 85 a1 00 00 00    	jne    445ac <process_fork+0x15c>
   4450b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4450e:	89 c7                	mov    %eax,%edi
   44510:	e8 07 f7 ff ff       	call   43c1c <palloc>
   44515:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   44519:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4451e:	75 14                	jne    44534 <process_fork+0xe4>
   44520:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44523:	89 c7                	mov    %eax,%edi
   44525:	e8 0b f8 ff ff       	call   43d35 <process_free>
   4452a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4452f:	e9 ac 01 00 00       	jmp    446e0 <process_fork+0x290>
   44534:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44538:	48 89 c1             	mov    %rax,%rcx
   4453b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4453f:	ba 00 10 00 00       	mov    $0x1000,%edx
   44544:	48 89 ce             	mov    %rcx,%rsi
   44547:	48 89 c7             	mov    %rax,%rdi
   4454a:	e8 58 ed ff ff       	call   432a7 <memcpy>
   4454f:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   44553:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44556:	48 63 d0             	movslq %eax,%rdx
   44559:	48 89 d0             	mov    %rdx,%rax
   4455c:	48 c1 e0 04          	shl    $0x4,%rax
   44560:	48 29 d0             	sub    %rdx,%rax
   44563:	48 c1 e0 04          	shl    $0x4,%rax
   44567:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   4456d:	48 8b 00             	mov    (%rax),%rax
   44570:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   44574:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4457a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44580:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44585:	48 89 fa             	mov    %rdi,%rdx
   44588:	48 89 c7             	mov    %rax,%rdi
   4458b:	e8 fc e3 ff ff       	call   4298c <virtual_memory_map>
   44590:	85 c0                	test   %eax,%eax
   44592:	0f 84 9f 00 00 00    	je     44637 <process_fork+0x1e7>
   44598:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4459b:	89 c7                	mov    %eax,%edi
   4459d:	e8 93 f7 ff ff       	call   43d35 <process_free>
   445a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   445a7:	e9 34 01 00 00       	jmp    446e0 <process_fork+0x290>
   445ac:	8b 45 e0             	mov    -0x20(%rbp),%eax
   445af:	48 98                	cltq   
   445b1:	83 e0 05             	and    $0x5,%eax
   445b4:	48 83 f8 05          	cmp    $0x5,%rax
   445b8:	75 7d                	jne    44637 <process_fork+0x1e7>
   445ba:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   445be:	8b 45 f4             	mov    -0xc(%rbp),%eax
   445c1:	48 63 d0             	movslq %eax,%rdx
   445c4:	48 89 d0             	mov    %rdx,%rax
   445c7:	48 c1 e0 04          	shl    $0x4,%rax
   445cb:	48 29 d0             	sub    %rdx,%rax
   445ce:	48 c1 e0 04          	shl    $0x4,%rax
   445d2:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   445d8:	48 8b 00             	mov    (%rax),%rax
   445db:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   445df:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   445e5:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   445eb:	b9 00 10 00 00       	mov    $0x1000,%ecx
   445f0:	48 89 fa             	mov    %rdi,%rdx
   445f3:	48 89 c7             	mov    %rax,%rdi
   445f6:	e8 91 e3 ff ff       	call   4298c <virtual_memory_map>
   445fb:	85 c0                	test   %eax,%eax
   445fd:	74 14                	je     44613 <process_fork+0x1c3>
   445ff:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44602:	89 c7                	mov    %eax,%edi
   44604:	e8 2c f7 ff ff       	call   43d35 <process_free>
   44609:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4460e:	e9 cd 00 00 00       	jmp    446e0 <process_fork+0x290>
   44613:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44617:	48 c1 e8 0c          	shr    $0xc,%rax
   4461b:	89 c2                	mov    %eax,%edx
   4461d:	48 63 c2             	movslq %edx,%rax
   44620:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   44627:	00 
   44628:	83 c0 01             	add    $0x1,%eax
   4462b:	89 c1                	mov    %eax,%ecx
   4462d:	48 63 c2             	movslq %edx,%rax
   44630:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
   44637:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4463e:	00 
   4463f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   44646:	00 
   44647:	0f 86 79 fe ff ff    	jbe    444c6 <process_fork+0x76>
   4464d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44651:	8b 08                	mov    (%rax),%ecx
   44653:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44656:	48 63 d0             	movslq %eax,%rdx
   44659:	48 89 d0             	mov    %rdx,%rax
   4465c:	48 c1 e0 04          	shl    $0x4,%rax
   44660:	48 29 d0             	sub    %rdx,%rax
   44663:	48 c1 e0 04          	shl    $0x4,%rax
   44667:	48 8d b0 10 10 05 00 	lea    0x51010(%rax),%rsi
   4466e:	48 63 d1             	movslq %ecx,%rdx
   44671:	48 89 d0             	mov    %rdx,%rax
   44674:	48 c1 e0 04          	shl    $0x4,%rax
   44678:	48 29 d0             	sub    %rdx,%rax
   4467b:	48 c1 e0 04          	shl    $0x4,%rax
   4467f:	48 8d 90 10 10 05 00 	lea    0x51010(%rax),%rdx
   44686:	48 8d 46 08          	lea    0x8(%rsi),%rax
   4468a:	48 83 c2 08          	add    $0x8,%rdx
   4468e:	b9 18 00 00 00       	mov    $0x18,%ecx
   44693:	48 89 c7             	mov    %rax,%rdi
   44696:	48 89 d6             	mov    %rdx,%rsi
   44699:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   4469c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4469f:	48 63 d0             	movslq %eax,%rdx
   446a2:	48 89 d0             	mov    %rdx,%rax
   446a5:	48 c1 e0 04          	shl    $0x4,%rax
   446a9:	48 29 d0             	sub    %rdx,%rax
   446ac:	48 c1 e0 04          	shl    $0x4,%rax
   446b0:	48 05 18 10 05 00    	add    $0x51018,%rax
   446b6:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   446bd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   446c0:	48 63 d0             	movslq %eax,%rdx
   446c3:	48 89 d0             	mov    %rdx,%rax
   446c6:	48 c1 e0 04          	shl    $0x4,%rax
   446ca:	48 29 d0             	sub    %rdx,%rax
   446cd:	48 c1 e0 04          	shl    $0x4,%rax
   446d1:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   446d7:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   446dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   446e0:	c9                   	leave  
   446e1:	c3                   	ret    

00000000000446e2 <process_page_alloc>:
   446e2:	55                   	push   %rbp
   446e3:	48 89 e5             	mov    %rsp,%rbp
   446e6:	48 83 ec 20          	sub    $0x20,%rsp
   446ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   446ee:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   446f2:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   446f9:	00 
   446fa:	77 07                	ja     44703 <process_page_alloc+0x21>
   446fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44701:	eb 4b                	jmp    4474e <process_page_alloc+0x6c>
   44703:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44707:	8b 00                	mov    (%rax),%eax
   44709:	89 c7                	mov    %eax,%edi
   4470b:	e8 0c f5 ff ff       	call   43c1c <palloc>
   44710:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44714:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   44719:	74 2e                	je     44749 <process_page_alloc+0x67>
   4471b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4471f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44723:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4472a:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   4472e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44734:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4473a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4473f:	48 89 c7             	mov    %rax,%rdi
   44742:	e8 45 e2 ff ff       	call   4298c <virtual_memory_map>
   44747:	eb 05                	jmp    4474e <process_page_alloc+0x6c>
   44749:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4474e:	c9                   	leave  
   4474f:	c3                   	ret    
