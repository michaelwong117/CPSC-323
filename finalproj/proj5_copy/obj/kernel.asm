
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
   400be:	e8 55 0c 00 00       	call   40d18 <exception>

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
   4016b:	48 83 ec 30          	sub    $0x30,%rsp
   4016f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
    hardware_init();
   40173:	e8 c8 1a 00 00       	call   41c40 <hardware_init>
    pageinfo_init();
   40178:	e8 70 11 00 00       	call   412ed <pageinfo_init>
    console_clear();
   4017d:	e8 18 3f 00 00       	call   4409a <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 a4 1f 00 00       	call   42130 <timer_init>

    // gonna add some stuff there for step 1
    // this is where ya put it
    // helping set up the kernel w correct perm

    for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE)
   4018c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40193:	00 
   40194:	eb 2a                	jmp    401c0 <kernel+0x59>
    {
        virtual_memory_map(kernel_pagetable, addr, addr,  
   40196:	48 8b 05 63 0e 01 00 	mov    0x10e63(%rip),%rax        # 51000 <kernel_pagetable>
   4019d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   401a1:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   401a5:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   401ab:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401b0:	48 89 c7             	mov    %rax,%rdi
   401b3:	e8 c6 2c 00 00       	call   42e7e <virtual_memory_map>
    for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE)
   401b8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   401bf:	00 
   401c0:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   401c7:	00 
   401c8:	76 cc                	jbe    40196 <kernel+0x2f>
        PAGESIZE, PTE_P | PTE_W);
    } 
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,  
   401ca:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401cf:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401d4:	48 8b 05 25 0e 01 00 	mov    0x10e25(%rip),%rax        # 51000 <kernel_pagetable>
   401db:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401e1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401e6:	48 89 c7             	mov    %rax,%rdi
   401e9:	e8 90 2c 00 00       	call   42e7e <virtual_memory_map>
    PAGESIZE, PTE_P | PTE_W | PTE_U);   

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401ee:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401f3:	be 00 00 00 00       	mov    $0x0,%esi
   401f8:	bf 20 e0 04 00       	mov    $0x4e020,%edi
   401fd:	e8 af 35 00 00       	call   437b1 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   40202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40209:	eb 44                	jmp    4024f <kernel+0xe8>
        processes[i].p_pid = i;
   4020b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4020e:	48 63 d0             	movslq %eax,%rdx
   40211:	48 89 d0             	mov    %rdx,%rax
   40214:	48 c1 e0 03          	shl    $0x3,%rax
   40218:	48 29 d0             	sub    %rdx,%rax
   4021b:	48 c1 e0 05          	shl    $0x5,%rax
   4021f:	48 8d 90 20 e0 04 00 	lea    0x4e020(%rax),%rdx
   40226:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40229:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   4022b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4022e:	48 63 d0             	movslq %eax,%rdx
   40231:	48 89 d0             	mov    %rdx,%rax
   40234:	48 c1 e0 03          	shl    $0x3,%rax
   40238:	48 29 d0             	sub    %rdx,%rax
   4023b:	48 c1 e0 05          	shl    $0x5,%rax
   4023f:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   40245:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   4024b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4024f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40253:	7e b6                	jle    4020b <kernel+0xa4>
    }

    if (command && strcmp(command, "fork") == 0) {
   40255:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4025a:	74 29                	je     40285 <kernel+0x11e>
   4025c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40260:	be c0 40 04 00       	mov    $0x440c0,%esi
   40265:	48 89 c7             	mov    %rax,%rdi
   40268:	e8 b5 35 00 00       	call   43822 <strcmp>
   4026d:	85 c0                	test   %eax,%eax
   4026f:	75 14                	jne    40285 <kernel+0x11e>
        process_setup(1, 4);
   40271:	be 04 00 00 00       	mov    $0x4,%esi
   40276:	bf 01 00 00 00       	mov    $0x1,%edi
   4027b:	e8 d1 00 00 00       	call   40351 <process_setup>
   40280:	e9 c2 00 00 00       	jmp    40347 <kernel+0x1e0>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40285:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4028a:	74 29                	je     402b5 <kernel+0x14e>
   4028c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40290:	be c5 40 04 00       	mov    $0x440c5,%esi
   40295:	48 89 c7             	mov    %rax,%rdi
   40298:	e8 85 35 00 00       	call   43822 <strcmp>
   4029d:	85 c0                	test   %eax,%eax
   4029f:	75 14                	jne    402b5 <kernel+0x14e>
        process_setup(1, 5);
   402a1:	be 05 00 00 00       	mov    $0x5,%esi
   402a6:	bf 01 00 00 00       	mov    $0x1,%edi
   402ab:	e8 a1 00 00 00       	call   40351 <process_setup>
   402b0:	e9 92 00 00 00       	jmp    40347 <kernel+0x1e0>
    } else if (command && strcmp(command, "test") == 0) {
   402b5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   402ba:	74 26                	je     402e2 <kernel+0x17b>
   402bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   402c0:	be ce 40 04 00       	mov    $0x440ce,%esi
   402c5:	48 89 c7             	mov    %rax,%rdi
   402c8:	e8 55 35 00 00       	call   43822 <strcmp>
   402cd:	85 c0                	test   %eax,%eax
   402cf:	75 11                	jne    402e2 <kernel+0x17b>
        process_setup(1, 6);
   402d1:	be 06 00 00 00       	mov    $0x6,%esi
   402d6:	bf 01 00 00 00       	mov    $0x1,%edi
   402db:	e8 71 00 00 00       	call   40351 <process_setup>
   402e0:	eb 65                	jmp    40347 <kernel+0x1e0>
    } else if (command && strcmp(command, "test2") == 0) {
   402e2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   402e7:	74 39                	je     40322 <kernel+0x1bb>
   402e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   402ed:	be d3 40 04 00       	mov    $0x440d3,%esi
   402f2:	48 89 c7             	mov    %rax,%rdi
   402f5:	e8 28 35 00 00       	call   43822 <strcmp>
   402fa:	85 c0                	test   %eax,%eax
   402fc:	75 24                	jne    40322 <kernel+0x1bb>
        for (pid_t i = 1; i <= 2; ++i) {
   402fe:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%rbp)
   40305:	eb 13                	jmp    4031a <kernel+0x1b3>
            process_setup(i, 6);
   40307:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4030a:	be 06 00 00 00       	mov    $0x6,%esi
   4030f:	89 c7                	mov    %eax,%edi
   40311:	e8 3b 00 00 00       	call   40351 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   40316:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
   4031a:	83 7d f0 02          	cmpl   $0x2,-0x10(%rbp)
   4031e:	7e e7                	jle    40307 <kernel+0x1a0>
   40320:	eb 25                	jmp    40347 <kernel+0x1e0>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   40322:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
   40329:	eb 16                	jmp    40341 <kernel+0x1da>
            process_setup(i, i - 1);
   4032b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4032e:	8d 50 ff             	lea    -0x1(%rax),%edx
   40331:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40334:	89 d6                	mov    %edx,%esi
   40336:	89 c7                	mov    %eax,%edi
   40338:	e8 14 00 00 00       	call   40351 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   4033d:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   40341:	83 7d ec 04          	cmpl   $0x4,-0x14(%rbp)
   40345:	7e e4                	jle    4032b <kernel+0x1c4>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   40347:	bf 00 e1 04 00       	mov    $0x4e100,%edi
   4034c:	e8 3f 0f 00 00       	call   41290 <run>

0000000000040351 <process_setup>:
// you have to allocate five physical pages for your pagetable
// your pagetable is going to be l1 l2 l3 l4 l5

// have to find free pages and place them.

void process_setup(pid_t pid, int program_number) {
   40351:	55                   	push   %rbp
   40352:	48 89 e5             	mov    %rsp,%rbp
   40355:	48 83 ec 50          	sub    $0x50,%rsp
   40359:	89 7d bc             	mov    %edi,-0x44(%rbp)
   4035c:	89 75 b8             	mov    %esi,-0x48(%rbp)
    process_init(&processes[pid], 0);
   4035f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40362:	48 63 d0             	movslq %eax,%rdx
   40365:	48 89 d0             	mov    %rdx,%rax
   40368:	48 c1 e0 03          	shl    $0x3,%rax
   4036c:	48 29 d0             	sub    %rdx,%rax
   4036f:	48 c1 e0 05          	shl    $0x5,%rax
   40373:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   40379:	be 00 00 00 00       	mov    $0x0,%esi
   4037e:	48 89 c7             	mov    %rax,%rdi
   40381:	e8 3c 20 00 00       	call   423c2 <process_init>

    x86_64_pagetable* res_pagetables[5];
    int res_pt = init_pagetable(pid, res_pagetables);
   40386:	48 8d 55 c8          	lea    -0x38(%rbp),%rdx
   4038a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4038d:	48 89 d6             	mov    %rdx,%rsi
   40390:	89 c7                	mov    %eax,%edi
   40392:	e8 50 01 00 00       	call   404e7 <init_pagetable>
   40397:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(res_pt != -1);
   4039a:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   4039e:	75 14                	jne    403b4 <process_setup+0x63>
   403a0:	ba d9 40 04 00       	mov    $0x440d9,%edx
   403a5:	be aa 00 00 00       	mov    $0xaa,%esi
   403aa:	bf e6 40 04 00       	mov    $0x440e6,%edi
   403af:	e8 cb 27 00 00       	call   42b7f <assert_fail>
    processes[pid].p_pagetable = res_pagetables[0];
   403b4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   403b8:	8b 45 bc             	mov    -0x44(%rbp),%eax
   403bb:	48 63 c8             	movslq %eax,%rcx
   403be:	48 89 c8             	mov    %rcx,%rax
   403c1:	48 c1 e0 03          	shl    $0x3,%rax
   403c5:	48 29 c8             	sub    %rcx,%rax
   403c8:	48 c1 e0 05          	shl    $0x5,%rax
   403cc:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   403d2:	48 89 10             	mov    %rdx,(%rax)

    // starter code
    // processes[pid].p_pagetable = kernel_pagetable;
    // ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount;
    int r = program_load(&processes[pid], program_number, NULL);
   403d5:	8b 45 bc             	mov    -0x44(%rbp),%eax
   403d8:	48 63 d0             	movslq %eax,%rdx
   403db:	48 89 d0             	mov    %rdx,%rax
   403de:	48 c1 e0 03          	shl    $0x3,%rax
   403e2:	48 29 d0             	sub    %rdx,%rax
   403e5:	48 c1 e0 05          	shl    $0x5,%rax
   403e9:	48 8d 88 20 e0 04 00 	lea    0x4e020(%rax),%rcx
   403f0:	8b 45 b8             	mov    -0x48(%rbp),%eax
   403f3:	ba 00 00 00 00       	mov    $0x0,%edx
   403f8:	89 c6                	mov    %eax,%esi
   403fa:	48 89 cf             	mov    %rcx,%rdi
   403fd:	e8 2e 2f 00 00       	call   43330 <program_load>
   40402:	89 45 f8             	mov    %eax,-0x8(%rbp)
    assert(r >= 0);
   40405:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
   40409:	79 14                	jns    4041f <process_setup+0xce>
   4040b:	ba ef 40 04 00       	mov    $0x440ef,%edx
   40410:	be b1 00 00 00       	mov    $0xb1,%esi
   40415:	bf e6 40 04 00       	mov    $0x440e6,%edi
   4041a:	e8 60 27 00 00       	call   42b7f <assert_fail>
    // this is setting up the stack
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   4041f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40422:	48 63 d0             	movslq %eax,%rdx
   40425:	48 89 d0             	mov    %rdx,%rax
   40428:	48 c1 e0 03          	shl    $0x3,%rax
   4042c:	48 29 d0             	sub    %rdx,%rax
   4042f:	48 c1 e0 05          	shl    $0x5,%rax
   40433:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40439:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    // log_printf("rsp: %p\n", processes[pid].p_registers.reg_rsp);
    uintptr_t next_page_addr = get_physical_page_addr(pid);
   40440:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40443:	0f be c0             	movsbl %al,%eax
   40446:	89 c7                	mov    %eax,%edi
   40448:	e8 b3 06 00 00       	call   40b00 <get_physical_page_addr>
   4044d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(next_page_addr != 0xffffffffffffffff);
   40451:	48 83 7d f0 ff       	cmpq   $0xffffffffffffffff,-0x10(%rbp)
   40456:	75 14                	jne    4046c <process_setup+0x11b>
   40458:	ba f8 40 04 00       	mov    $0x440f8,%edx
   4045d:	be b6 00 00 00       	mov    $0xb6,%esi
   40462:	bf e6 40 04 00       	mov    $0x440e6,%edi
   40467:	e8 13 27 00 00       	call   42b7f <assert_fail>
    // uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
    // assign_physical_page(stack_page, pid);

    
    // have to find a page for step 4
    virtual_memory_map(processes[pid].p_pagetable, processes[pid].p_registers.reg_rsp - PAGESIZE, next_page_addr,
   4046c:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4046f:	48 63 d0             	movslq %eax,%rdx
   40472:	48 89 d0             	mov    %rdx,%rax
   40475:	48 c1 e0 03          	shl    $0x3,%rax
   40479:	48 29 d0             	sub    %rdx,%rax
   4047c:	48 c1 e0 05          	shl    $0x5,%rax
   40480:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40486:	48 8b 00             	mov    (%rax),%rax
   40489:	48 8d b0 00 f0 ff ff 	lea    -0x1000(%rax),%rsi
   40490:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40493:	48 63 d0             	movslq %eax,%rdx
   40496:	48 89 d0             	mov    %rdx,%rax
   40499:	48 c1 e0 03          	shl    $0x3,%rax
   4049d:	48 29 d0             	sub    %rdx,%rax
   404a0:	48 c1 e0 05          	shl    $0x5,%rax
   404a4:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   404aa:	48 8b 00             	mov    (%rax),%rax
   404ad:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   404b1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   404b7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   404bc:	48 89 c7             	mov    %rax,%rdi
   404bf:	e8 ba 29 00 00       	call   42e7e <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   404c4:	8b 45 bc             	mov    -0x44(%rbp),%eax
   404c7:	48 63 d0             	movslq %eax,%rdx
   404ca:	48 89 d0             	mov    %rdx,%rax
   404cd:	48 c1 e0 03          	shl    $0x3,%rax
   404d1:	48 29 d0             	sub    %rdx,%rax
   404d4:	48 c1 e0 05          	shl    $0x5,%rax
   404d8:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   404de:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   404e4:	90                   	nop
   404e5:	c9                   	leave  
   404e6:	c3                   	ret    

00000000000404e7 <init_pagetable>:
// takes in the process id and the pagetable array
int init_pagetable(pid_t pid, x86_64_pagetable** res_pagetables)
{ // in here you would need to manually get rid of all the pagetables you've gotten so far
   404e7:	55                   	push   %rbp
   404e8:	48 89 e5             	mov    %rsp,%rbp
   404eb:	48 83 ec 50          	sub    $0x50,%rsp
   404ef:	89 7d bc             	mov    %edi,-0x44(%rbp)
   404f2:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
    // allocate before you write (memset and link)
    for (int i = 0; i < 5; i++)
   404f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   404fd:	eb 3b                	jmp    4053a <init_pagetable+0x53>
    {
        // allocates a physical page for each level of the pagetable
        int res = pagetable_allocate_physical_page(pid, &res_pagetables[i]);
   404ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40502:	48 98                	cltq   
   40504:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4050b:	00 
   4050c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40510:	48 01 c2             	add    %rax,%rdx
   40513:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40516:	0f be c0             	movsbl %al,%eax
   40519:	48 89 d6             	mov    %rdx,%rsi
   4051c:	89 c7                	mov    %eax,%edi
   4051e:	e8 6f 05 00 00       	call   40a92 <pagetable_allocate_physical_page>
   40523:	89 45 e0             	mov    %eax,-0x20(%rbp)
        if (res == -1)
   40526:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%rbp)
   4052a:	75 0a                	jne    40536 <init_pagetable+0x4f>
        {
            return -1;
   4052c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40531:	e9 33 01 00 00       	jmp    40669 <init_pagetable+0x182>
    for (int i = 0; i < 5; i++)
   40536:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4053a:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   4053e:	7e bf                	jle    404ff <init_pagetable+0x18>
        }
    }

    x86_64_pagetable* res_pagetable = res_pagetables[0];
   40540:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40544:	48 8b 00             	mov    (%rax),%rax
   40547:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // pagetables just contain entries

    for (int i = 0; i < 5; i++)
   4054b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40552:	eb 2d                	jmp    40581 <init_pagetable+0x9a>
    {
        // log_printf("size of res_pt entry: %d\n", sizeof(res_pagetables[i]->entry));
        memset(res_pagetables[i]->entry, 0, sizeof(res_pagetables[i]->entry));
   40554:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40557:	48 98                	cltq   
   40559:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40560:	00 
   40561:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40565:	48 01 d0             	add    %rdx,%rax
   40568:	48 8b 00             	mov    (%rax),%rax
   4056b:	ba 00 10 00 00       	mov    $0x1000,%edx
   40570:	be 00 00 00 00       	mov    $0x0,%esi
   40575:	48 89 c7             	mov    %rax,%rdi
   40578:	e8 34 32 00 00       	call   437b1 <memset>
    for (int i = 0; i < 5; i++)
   4057d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40581:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
   40585:	7e cd                	jle    40554 <init_pagetable+0x6d>
    }
    // res_pagetables[0] or res_pagetable is the l4 page table
    res_pagetables[0]->entry[0] =
        (x86_64_pageentry_t) res_pagetables[1] | PTE_P | PTE_W | PTE_U;
   40587:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4058b:	48 83 c0 08          	add    $0x8,%rax
   4058f:	48 8b 00             	mov    (%rax),%rax
   40592:	48 89 c2             	mov    %rax,%rdx
    res_pagetables[0]->entry[0] =
   40595:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40599:	48 8b 00             	mov    (%rax),%rax
        (x86_64_pageentry_t) res_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4059c:	48 83 ca 07          	or     $0x7,%rdx
    res_pagetables[0]->entry[0] =
   405a0:	48 89 10             	mov    %rdx,(%rax)
    res_pagetables[1]->entry[0] =
        (x86_64_pageentry_t) res_pagetables[2] | PTE_P | PTE_W | PTE_U;
   405a3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   405a7:	48 83 c0 10          	add    $0x10,%rax
   405ab:	48 8b 00             	mov    (%rax),%rax
   405ae:	48 89 c2             	mov    %rax,%rdx
    res_pagetables[1]->entry[0] =
   405b1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   405b5:	48 83 c0 08          	add    $0x8,%rax
   405b9:	48 8b 00             	mov    (%rax),%rax
        (x86_64_pageentry_t) res_pagetables[2] | PTE_P | PTE_W | PTE_U;
   405bc:	48 83 ca 07          	or     $0x7,%rdx
    res_pagetables[1]->entry[0] =
   405c0:	48 89 10             	mov    %rdx,(%rax)
    res_pagetables[2]->entry[0] =
        (x86_64_pageentry_t) res_pagetables[3] | PTE_P | PTE_W | PTE_U;
   405c3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   405c7:	48 83 c0 18          	add    $0x18,%rax
   405cb:	48 8b 00             	mov    (%rax),%rax
   405ce:	48 89 c2             	mov    %rax,%rdx
    res_pagetables[2]->entry[0] =
   405d1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   405d5:	48 83 c0 10          	add    $0x10,%rax
   405d9:	48 8b 00             	mov    (%rax),%rax
        (x86_64_pageentry_t) res_pagetables[3] | PTE_P | PTE_W | PTE_U;
   405dc:	48 83 ca 07          	or     $0x7,%rdx
    res_pagetables[2]->entry[0] =
   405e0:	48 89 10             	mov    %rdx,(%rax)
    res_pagetables[2]->entry[1] =
        (x86_64_pageentry_t) res_pagetables[4] | PTE_P | PTE_W | PTE_U;
   405e3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   405e7:	48 83 c0 20          	add    $0x20,%rax
   405eb:	48 8b 00             	mov    (%rax),%rax
   405ee:	48 89 c2             	mov    %rax,%rdx
    res_pagetables[2]->entry[1] =
   405f1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   405f5:	48 83 c0 10          	add    $0x10,%rax
   405f9:	48 8b 00             	mov    (%rax),%rax
        (x86_64_pageentry_t) res_pagetables[4] | PTE_P | PTE_W | PTE_U;
   405fc:	48 83 ca 07          	or     $0x7,%rdx
    res_pagetables[2]->entry[1] =
   40600:	48 89 50 08          	mov    %rdx,0x8(%rax)

    // copy mappings from kernel page tables
    for(uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE){
   40604:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   4060b:	00 
   4060c:	eb 4c                	jmp    4065a <init_pagetable+0x173>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   4060e:	48 8b 0d eb 09 01 00 	mov    0x109eb(%rip),%rcx        # 51000 <kernel_pagetable>
   40615:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   40619:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4061d:	48 89 ce             	mov    %rcx,%rsi
   40620:	48 89 c7             	mov    %rax,%rdi
   40623:	e8 11 2c 00 00       	call   43239 <virtual_memory_lookup>
        // log_printf("virtual add: %p, physical address: %p, permissions: %d\n", 
        //             addr, vmap.pa, vmap.perm);
        // vmap.pa is the physical address that the virutal address "addr"
        // is mapped to inside the kernel's pagetable
        if (vmap.pn != -1)
   40628:	8b 45 c8             	mov    -0x38(%rbp),%eax
   4062b:	83 f8 ff             	cmp    $0xffffffff,%eax
   4062e:	74 22                	je     40652 <init_pagetable+0x16b>
        { // if vmap.pn == -1 means the page isn't mapped
            int res = virtual_memory_map(res_pagetable, addr, vmap.pa,  
   40630:	8b 4d d8             	mov    -0x28(%rbp),%ecx
   40633:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40637:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4063b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4063f:	41 89 c8             	mov    %ecx,%r8d
   40642:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40647:	48 89 c7             	mov    %rax,%rdi
   4064a:	e8 2f 28 00 00       	call   42e7e <virtual_memory_map>
   4064f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    for(uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE){
   40652:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40659:	00 
   4065a:	48 81 7d f0 ff ff 0f 	cmpq   $0xfffff,-0x10(%rbp)
   40661:	00 
   40662:	76 aa                	jbe    4060e <init_pagetable+0x127>
        }
        // vmap = virtual_memory_lookup(res_pagetable, addr);
        // log_printf("res virtual add: %p, physical address: %p, permissions: %d\n", 
        // addr, vmap.pa, vmap.perm);
    }
    return 0;
   40664:	b8 00 00 00 00       	mov    $0x0,%eax
    // this is updating the kernel's pagetable, don't need
    // set_pagetable(res_pagetable);
}
   40669:	c9                   	leave  
   4066a:	c3                   	ret    

000000000004066b <find_free_process>:

int find_free_process()
{
   4066b:	55                   	push   %rbp
   4066c:	48 89 e5             	mov    %rsp,%rbp
   4066f:	48 83 ec 10          	sub    $0x10,%rsp
    int free_proc_slot = -1;
   40673:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    // find a free proc slot that's not slot 0
    for (int i = 1; i < NPROC; i++)
   4067a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40681:	eb 2c                	jmp    406af <find_free_process+0x44>
    {
        if (processes[i].p_state == P_FREE)
   40683:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40686:	48 63 d0             	movslq %eax,%rdx
   40689:	48 89 d0             	mov    %rdx,%rax
   4068c:	48 c1 e0 03          	shl    $0x3,%rax
   40690:	48 29 d0             	sub    %rdx,%rax
   40693:	48 c1 e0 05          	shl    $0x5,%rax
   40697:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4069d:	8b 00                	mov    (%rax),%eax
   4069f:	85 c0                	test   %eax,%eax
   406a1:	75 08                	jne    406ab <find_free_process+0x40>
        {   
            free_proc_slot = i; // the free process slot is i
   406a3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   406a6:	89 45 fc             	mov    %eax,-0x4(%rbp)
            // memcpy((void *) &current->p_registers, (void *) &processes[i].p_registers, sizeof(processes[i].p_registers));
            // look at what each element of the processes array should be
            // and set each element accordingly
            // read fault -> probably something with permissions
            break;
   406a9:	eb 0a                	jmp    406b5 <find_free_process+0x4a>
    for (int i = 1; i < NPROC; i++)
   406ab:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   406af:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   406b3:	7e ce                	jle    40683 <find_free_process+0x18>
        }
    }
    return free_proc_slot;
   406b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   406b8:	c9                   	leave  
   406b9:	c3                   	ret    

00000000000406ba <unassign_page>:
// unassigns the page at physical address addr
void unassign_page(uintptr_t addr, pid_t pid)
{
   406ba:	55                   	push   %rbp
   406bb:	48 89 e5             	mov    %rsp,%rbp
   406be:	48 83 ec 10          	sub    $0x10,%rsp
   406c2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   406c6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    if (pageinfo[PAGENUMBER(addr)].owner == pid && pageinfo[PAGENUMBER(addr)].refcount == 1)
   406c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406cd:	48 c1 e8 0c          	shr    $0xc,%rax
   406d1:	48 98                	cltq   
   406d3:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   406da:	00 
   406db:	0f be c0             	movsbl %al,%eax
   406de:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   406e1:	75 4e                	jne    40731 <unassign_page+0x77>
   406e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406e7:	48 c1 e8 0c          	shr    $0xc,%rax
   406eb:	48 98                	cltq   
   406ed:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   406f4:	00 
   406f5:	3c 01                	cmp    $0x1,%al
   406f7:	75 38                	jne    40731 <unassign_page+0x77>
    {
        // log_printf("CHANGE OWNER: physical addr %p has owner %d with refcount %d\n",
        //             addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);
        pageinfo[PAGENUMBER(addr)].owner = PO_FREE;
   406f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406fd:	48 c1 e8 0c          	shr    $0xc,%rax
   40701:	48 98                	cltq   
   40703:	c6 84 00 40 ee 04 00 	movb   $0x0,0x4ee40(%rax,%rax,1)
   4070a:	00 
        pageinfo[PAGENUMBER(addr)].refcount--;
   4070b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4070f:	48 c1 e8 0c          	shr    $0xc,%rax
   40713:	89 c2                	mov    %eax,%edx
   40715:	48 63 c2             	movslq %edx,%rax
   40718:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   4071f:	00 
   40720:	83 e8 01             	sub    $0x1,%eax
   40723:	89 c1                	mov    %eax,%ecx
   40725:	48 63 c2             	movslq %edx,%rax
   40728:	88 8c 00 41 ee 04 00 	mov    %cl,0x4ee41(%rax,%rax,1)
    // log_printf("\nRESULT: physical addr %p has owner %d with refcount %d\n",
    // addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);

    // if the pid is the same and refcount is 1
    // else if the refcount is greater than 1 and the owner is >= 0 ( meaning not the kernel or reserved)
}
   4072f:	eb 50                	jmp    40781 <unassign_page+0xc7>
    else if (pageinfo[PAGENUMBER(addr)].refcount > 1 && pageinfo[PAGENUMBER(addr)].owner > 0)
   40731:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40735:	48 c1 e8 0c          	shr    $0xc,%rax
   40739:	48 98                	cltq   
   4073b:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40742:	00 
   40743:	3c 01                	cmp    $0x1,%al
   40745:	7e 3a                	jle    40781 <unassign_page+0xc7>
   40747:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4074b:	48 c1 e8 0c          	shr    $0xc,%rax
   4074f:	48 98                	cltq   
   40751:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40758:	00 
   40759:	84 c0                	test   %al,%al
   4075b:	7e 24                	jle    40781 <unassign_page+0xc7>
        pageinfo[PAGENUMBER(addr)].refcount--;
   4075d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40761:	48 c1 e8 0c          	shr    $0xc,%rax
   40765:	89 c2                	mov    %eax,%edx
   40767:	48 63 c2             	movslq %edx,%rax
   4076a:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40771:	00 
   40772:	83 e8 01             	sub    $0x1,%eax
   40775:	89 c1                	mov    %eax,%ecx
   40777:	48 63 c2             	movslq %edx,%rax
   4077a:	88 8c 00 41 ee 04 00 	mov    %cl,0x4ee41(%rax,%rax,1)
}
   40781:	90                   	nop
   40782:	c9                   	leave  
   40783:	c3                   	ret    

0000000000040784 <free_bad_pagetable>:
void free_bad_pagetable(pid_t pid)
{
   40784:	55                   	push   %rbp
   40785:	48 89 e5             	mov    %rsp,%rbp
   40788:	48 83 ec 18          	sub    $0x18,%rsp
   4078c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
   4078f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40796:	00 
   40797:	eb 33                	jmp    407cc <free_bad_pagetable+0x48>
    {
        if (pageinfo[PAGENUMBER(addr)].owner == pid)
   40799:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4079d:	48 c1 e8 0c          	shr    $0xc,%rax
   407a1:	48 98                	cltq   
   407a3:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   407aa:	00 
   407ab:	0f be c0             	movsbl %al,%eax
   407ae:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   407b1:	75 11                	jne    407c4 <free_bad_pagetable+0x40>
        {
            unassign_page(addr, pid);
   407b3:	8b 55 ec             	mov    -0x14(%rbp),%edx
   407b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407ba:	89 d6                	mov    %edx,%esi
   407bc:	48 89 c7             	mov    %rax,%rdi
   407bf:	e8 f6 fe ff ff       	call   406ba <unassign_page>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
   407c4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   407cb:	00 
   407cc:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   407d3:	00 
   407d4:	76 c3                	jbe    40799 <free_bad_pagetable+0x15>
        }
    }  
    
}
   407d6:	90                   	nop
   407d7:	90                   	nop
   407d8:	c9                   	leave  
   407d9:	c3                   	ret    

00000000000407da <garbage_collect>:
void garbage_collect(int process, x86_64_pagetable * pt)
{
   407da:	55                   	push   %rbp
   407db:	48 89 e5             	mov    %rsp,%rbp
   407de:	48 83 ec 30          	sub    $0x30,%rsp
   407e2:	89 7d dc             	mov    %edi,-0x24(%rbp)
   407e5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    for(uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE)
   407e9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   407f0:	00 
   407f1:	eb 44                	jmp    40837 <garbage_collect+0x5d>
    {
        // looking up the virtual address addr in the original pagetable
        vamapping vmap = virtual_memory_lookup(pt, addr);
   407f3:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   407f7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407fb:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   407ff:	48 89 ce             	mov    %rcx,%rsi
   40802:	48 89 c7             	mov    %rax,%rdi
   40805:	e8 2f 2a 00 00       	call   43239 <virtual_memory_lookup>
        // log_printf("virtual add: %p, physical address: %p, permissions: %d\n", 
        //             addr, vmap.pa, vmap.perm);
        if (vmap.perm & PTE_P && vmap.pn >= 0)
   4080a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4080d:	48 98                	cltq   
   4080f:	83 e0 01             	and    $0x1,%eax
   40812:	48 85 c0             	test   %rax,%rax
   40815:	74 18                	je     4082f <garbage_collect+0x55>
   40817:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4081a:	85 c0                	test   %eax,%eax
   4081c:	78 11                	js     4082f <garbage_collect+0x55>
        {
            unassign_page(vmap.pa, process);
   4081e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40822:	8b 55 dc             	mov    -0x24(%rbp),%edx
   40825:	89 d6                	mov    %edx,%esi
   40827:	48 89 c7             	mov    %rax,%rdi
   4082a:	e8 8b fe ff ff       	call   406ba <unassign_page>
    for(uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE)
   4082f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40836:	00 
   40837:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4083e:	00 
   4083f:	76 b2                	jbe    407f3 <garbage_collect+0x19>
        }
    }
    
    processes[process].p_state = P_FREE;
   40841:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40844:	48 63 d0             	movslq %eax,%rdx
   40847:	48 89 d0             	mov    %rdx,%rax
   4084a:	48 c1 e0 03          	shl    $0x3,%rax
   4084e:	48 29 d0             	sub    %rdx,%rax
   40851:	48 c1 e0 05          	shl    $0x5,%rax
   40855:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4085b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    // if the refcount becomes zero, set the owner to PO_FREE
    // after you do this you then need to free the pagetable, free the five pages
    // then set the forked process back to PO_FREE (or PO_Broken)
    // set the parent's.rax value to -1 because the fork failed
    // garbage_collection_fork();
}
   40861:	90                   	nop
   40862:	c9                   	leave  
   40863:	c3                   	ret    

0000000000040864 <fork_copy>:


int fork_copy(pid_t child_pid, x86_64_pagetable * child, x86_64_pagetable * parent)
{  // STEP 1: copy pagetable
   40864:	55                   	push   %rbp
   40865:	48 89 e5             	mov    %rsp,%rbp
   40868:	48 83 ec 60          	sub    $0x60,%rsp
   4086c:	89 7d bc             	mov    %edi,-0x44(%rbp)
   4086f:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
   40873:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
   // in the parent, and copying that mapping from va to pa in the child

    // initalizing the page table WILL create a tree structure
    // but the contents of the entries has to be the same 

    for(uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE)
   40877:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4087e:	00 
   4087f:	e9 c6 01 00 00       	jmp    40a4a <fork_copy+0x1e6>
    {
        // looking up the virtual address addr in the original pagetable
        vamapping vmap = virtual_memory_lookup(parent, addr);
   40884:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   40888:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4088c:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
   40890:	48 89 ce             	mov    %rcx,%rsi
   40893:	48 89 c7             	mov    %rax,%rdi
   40896:	e8 9e 29 00 00       	call   43239 <virtual_memory_lookup>
        // {
        //     log_printf("virtual address %p is mapped to the console address %p\n", 
        //                     addr, CONSOLE_ADDR);
        // }

        int res = virtual_memory_map(child, addr, vmap.pa,
   4089b:	8b 4d d8             	mov    -0x28(%rbp),%ecx
   4089e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   408a2:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   408a6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   408aa:	41 89 c8             	mov    %ecx,%r8d
   408ad:	b9 00 10 00 00       	mov    $0x1000,%ecx
   408b2:	48 89 c7             	mov    %rax,%rdi
   408b5:	e8 c4 25 00 00       	call   42e7e <virtual_memory_map>
   408ba:	89 45 f4             	mov    %eax,-0xc(%rbp)
                    PAGESIZE, vmap.perm);
        if (res < 0) return -1;
   408bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   408c1:	79 0a                	jns    408cd <fork_copy+0x69>
   408c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   408c8:	e9 90 01 00 00       	jmp    40a5d <fork_copy+0x1f9>
        // mapping should be okay for freeing
        // map will only fail if you give it a bad address
        if ((vmap.perm & (PTE_P | PTE_W)) == (PTE_P | PTE_W))
   408cd:	8b 45 d8             	mov    -0x28(%rbp),%eax
   408d0:	48 98                	cltq   
   408d2:	83 e0 03             	and    $0x3,%eax
   408d5:	48 83 f8 03          	cmp    $0x3,%rax
   408d9:	75 6f                	jne    4094a <fork_copy+0xe6>
        { // if there is a page present in the original pagetable and it's not read-only
        // the page is indeed present and we have a find a new physical page for the copy
        // for which to put that virtual address at

            // log_printf("writable vmap.perm: %d\n", vmap.perm);
            uintptr_t next_page_addr = get_physical_page_addr(child_pid);
   408db:	8b 45 bc             	mov    -0x44(%rbp),%eax
   408de:	0f be c0             	movsbl %al,%eax
   408e1:	89 c7                	mov    %eax,%edi
   408e3:	e8 18 02 00 00       	call   40b00 <get_physical_page_addr>
   408e8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
            if (next_page_addr == 0xffffffffffffffff) return -1;
   408ec:	48 83 7d e8 ff       	cmpq   $0xffffffffffffffff,-0x18(%rbp)
   408f1:	75 0a                	jne    408fd <fork_copy+0x99>
   408f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   408f8:	e9 60 01 00 00       	jmp    40a5d <fork_copy+0x1f9>
            

            // use virtual memory lookup
            // copying from one pa to another all the bytes of the next pagesize
            memcpy((void *) next_page_addr, (void *) vmap.pa, PAGESIZE);
   408fd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40901:	48 89 c1             	mov    %rax,%rcx
   40904:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40908:	ba 00 10 00 00       	mov    $0x1000,%edx
   4090d:	48 89 ce             	mov    %rcx,%rsi
   40910:	48 89 c7             	mov    %rax,%rdi
   40913:	e8 30 2e 00 00       	call   43748 <memcpy>

            // log_printf("MAPPING virtual address %p to physical addreses %p, instead of original physical address %p\n", 
            //             addr, next_page_addr, vmap.pa);

            res = virtual_memory_map(child, addr, next_page_addr,
   40918:	8b 4d d8             	mov    -0x28(%rbp),%ecx
   4091b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4091f:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40923:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40927:	41 89 c8             	mov    %ecx,%r8d
   4092a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4092f:	48 89 c7             	mov    %rax,%rdi
   40932:	e8 47 25 00 00       	call   42e7e <virtual_memory_map>
   40937:	89 45 f4             	mov    %eax,-0xc(%rbp)
                            PAGESIZE, vmap.perm);
            if (res < 0) return -1;
   4093a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4093e:	79 31                	jns    40971 <fork_copy+0x10d>
   40940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40945:	e9 13 01 00 00       	jmp    40a5d <fork_copy+0x1f9>
            
        }
        else if ((vmap.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U) && !(vmap.perm & PTE_W))
   4094a:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4094d:	48 98                	cltq   
   4094f:	83 e0 05             	and    $0x5,%eax
   40952:	48 83 f8 05          	cmp    $0x5,%rax
   40956:	75 19                	jne    40971 <fork_copy+0x10d>
   40958:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4095b:	48 98                	cltq   
   4095d:	83 e0 02             	and    $0x2,%eax
   40960:	48 85 c0             	test   %rax,%rax
   40963:	75 0c                	jne    40971 <fork_copy+0x10d>
            //             pageinfo[PAGENUMBER(addr)].refcount);
            // only want to increase the refcount of the physical page
            // these two processes each have their own pagetable, and the entries
            // in these pagetables point to the same physical memory address
            
            update_refcount(vmap.pa); // update the refcounts so the OS marks page as shared
   40965:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40969:	48 89 c7             	mov    %rax,%rdi
   4096c:	e8 ee 00 00 00       	call   40a5f <update_refcount>
            // the addr is already mapped to the same pa (which is fine in the case of no write access)            

        }
        int free_process = (int) child_pid;
   40971:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40974:	89 45 e4             	mov    %eax,-0x1c(%rbp)
        // copy process info to new process
        processes[free_process].p_state = P_RUNNABLE;
   40977:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4097a:	48 63 d0             	movslq %eax,%rdx
   4097d:	48 89 d0             	mov    %rdx,%rax
   40980:	48 c1 e0 03          	shl    $0x3,%rax
   40984:	48 29 d0             	sub    %rdx,%rax
   40987:	48 c1 e0 05          	shl    $0x5,%rax
   4098b:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   40991:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
        processes[free_process].p_pid = free_process;
   40997:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4099a:	48 63 d0             	movslq %eax,%rdx
   4099d:	48 89 d0             	mov    %rdx,%rax
   409a0:	48 c1 e0 03          	shl    $0x3,%rax
   409a4:	48 29 d0             	sub    %rdx,%rax
   409a7:	48 c1 e0 05          	shl    $0x5,%rax
   409ab:	48 8d 90 20 e0 04 00 	lea    0x4e020(%rax),%rdx
   409b2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   409b5:	89 02                	mov    %eax,(%rdx)
        processes[free_process].p_registers = current->p_registers;
   409b7:	48 8b 0d 42 d6 00 00 	mov    0xd642(%rip),%rcx        # 4e000 <current>
   409be:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   409c1:	48 63 d0             	movslq %eax,%rdx
   409c4:	48 89 d0             	mov    %rdx,%rax
   409c7:	48 c1 e0 03          	shl    $0x3,%rax
   409cb:	48 29 d0             	sub    %rdx,%rax
   409ce:	48 c1 e0 05          	shl    $0x5,%rax
   409d2:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   409d8:	48 83 c0 08          	add    $0x8,%rax
   409dc:	48 8d 51 08          	lea    0x8(%rcx),%rdx
   409e0:	b9 18 00 00 00       	mov    $0x18,%ecx
   409e5:	48 89 c7             	mov    %rax,%rdi
   409e8:	48 89 d6             	mov    %rdx,%rsi
   409eb:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
        processes[free_process].p_registers.reg_rax = 0;
   409ee:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   409f1:	48 63 d0             	movslq %eax,%rdx
   409f4:	48 89 d0             	mov    %rdx,%rax
   409f7:	48 c1 e0 03          	shl    $0x3,%rax
   409fb:	48 29 d0             	sub    %rdx,%rax
   409fe:	48 c1 e0 05          	shl    $0x5,%rax
   40a02:	48 05 28 e0 04 00    	add    $0x4e028,%rax
   40a08:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
        current->p_registers.reg_rax = free_process;
   40a0f:	48 8b 05 ea d5 00 00 	mov    0xd5ea(%rip),%rax        # 4e000 <current>
   40a16:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   40a19:	48 63 d2             	movslq %edx,%rdx
   40a1c:	48 89 50 08          	mov    %rdx,0x8(%rax)
        processes[free_process].p_pagetable = child;
   40a20:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40a23:	48 63 d0             	movslq %eax,%rdx
   40a26:	48 89 d0             	mov    %rdx,%rax
   40a29:	48 c1 e0 03          	shl    $0x3,%rax
   40a2d:	48 29 d0             	sub    %rdx,%rax
   40a30:	48 c1 e0 05          	shl    $0x5,%rax
   40a34:	48 8d 90 f0 e0 04 00 	lea    0x4e0f0(%rax),%rdx
   40a3b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40a3f:	48 89 02             	mov    %rax,(%rdx)
    for(uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE)
   40a42:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40a49:	00 
   40a4a:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40a51:	00 
   40a52:	0f 86 2c fe ff ff    	jbe    40884 <fork_copy+0x20>
 
        // vmap = virtual_memory_lookup(res_pagetable, addr);
        // log_printf("res virtual add: %p, physical address: %p, permissions: %d\n", 
        // addr, vmap.pa, vmap.perm);
    }
    return 0;
   40a58:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40a5d:	c9                   	leave  
   40a5e:	c3                   	ret    

0000000000040a5f <update_refcount>:

void update_refcount(uintptr_t addr)
{
   40a5f:	55                   	push   %rbp
   40a60:	48 89 e5             	mov    %rsp,%rbp
   40a63:	48 83 ec 08          	sub    $0x8,%rsp
   40a67:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    pageinfo[PAGENUMBER(addr)].refcount++;
   40a6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a6f:	48 c1 e8 0c          	shr    $0xc,%rax
   40a73:	89 c2                	mov    %eax,%edx
   40a75:	48 63 c2             	movslq %edx,%rax
   40a78:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40a7f:	00 
   40a80:	83 c0 01             	add    $0x1,%eax
   40a83:	89 c1                	mov    %eax,%ecx
   40a85:	48 63 c2             	movslq %edx,%rax
   40a88:	88 8c 00 41 ee 04 00 	mov    %cl,0x4ee41(%rax,%rax,1)
}
   40a8f:	90                   	nop
   40a90:	c9                   	leave  
   40a91:	c3                   	ret    

0000000000040a92 <pagetable_allocate_physical_page>:
// takes in the owner's process id and a pointer to a pagetable
int pagetable_allocate_physical_page(int8_t owner, x86_64_pagetable ** curr_pt)
{
   40a92:	55                   	push   %rbp
   40a93:	48 89 e5             	mov    %rsp,%rbp
   40a96:	48 83 ec 20          	sub    $0x20,%rsp
   40a9a:	89 f8                	mov    %edi,%eax
   40a9c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   40aa0:	88 45 ec             	mov    %al,-0x14(%rbp)
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
   40aa3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40aaa:	00 
   40aab:	eb 42                	jmp    40aef <pagetable_allocate_physical_page+0x5d>
    {
        if (pageinfo[PAGENUMBER(addr)].owner == PO_FREE)
   40aad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ab1:	48 c1 e8 0c          	shr    $0xc,%rax
   40ab5:	48 98                	cltq   
   40ab7:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40abe:	00 
   40abf:	84 c0                	test   %al,%al
   40ac1:	75 24                	jne    40ae7 <pagetable_allocate_physical_page+0x55>
        {
            assign_physical_page(addr, owner);
   40ac3:	0f be 55 ec          	movsbl -0x14(%rbp),%edx
   40ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40acb:	89 d6                	mov    %edx,%esi
   40acd:	48 89 c7             	mov    %rax,%rdi
   40ad0:	e8 9d 00 00 00       	call   40b72 <assign_physical_page>
            // log_printf("FOUND physical address: %p\n", addr);
            *(curr_pt) = (x86_64_pagetable *) addr;
   40ad5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ad9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40add:	48 89 10             	mov    %rdx,(%rax)
            return 0;
   40ae0:	b8 00 00 00 00       	mov    $0x0,%eax
   40ae5:	eb 17                	jmp    40afe <pagetable_allocate_physical_page+0x6c>
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
   40ae7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40aee:	00 
   40aef:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40af6:	00 
   40af7:	76 b4                	jbe    40aad <pagetable_allocate_physical_page+0x1b>
        }
    }  
    return -1;
   40af9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   40afe:	c9                   	leave  
   40aff:	c3                   	ret    

0000000000040b00 <get_physical_page_addr>:

uintptr_t get_physical_page_addr(int8_t owner)
{
   40b00:	55                   	push   %rbp
   40b01:	48 89 e5             	mov    %rsp,%rbp
   40b04:	48 83 ec 20          	sub    $0x20,%rsp
   40b08:	89 f8                	mov    %edi,%eax
   40b0a:	88 45 ec             	mov    %al,-0x14(%rbp)
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
   40b0d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40b14:	00 
   40b15:	eb 48                	jmp    40b5f <get_physical_page_addr+0x5f>
    {
        if (pageinfo[PAGENUMBER(addr)].owner == PO_FREE)
   40b17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b1b:	48 c1 e8 0c          	shr    $0xc,%rax
   40b1f:	48 98                	cltq   
   40b21:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   40b28:	00 
   40b29:	84 c0                	test   %al,%al
   40b2b:	75 2a                	jne    40b57 <get_physical_page_addr+0x57>
        {
            int res = assign_physical_page(addr, owner);
   40b2d:	0f be 55 ec          	movsbl -0x14(%rbp),%edx
   40b31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b35:	89 d6                	mov    %edx,%esi
   40b37:	48 89 c7             	mov    %rax,%rdi
   40b3a:	e8 33 00 00 00       	call   40b72 <assign_physical_page>
   40b3f:	89 45 f4             	mov    %eax,-0xc(%rbp)
            if (res == -1) return -1;
   40b42:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   40b46:	75 09                	jne    40b51 <get_physical_page_addr+0x51>
   40b48:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   40b4f:	eb 1f                	jmp    40b70 <get_physical_page_addr+0x70>
            // log_printf("FOUND physical address: %p\n", addr);
            return addr;
   40b51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b55:	eb 19                	jmp    40b70 <get_physical_page_addr+0x70>
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
   40b57:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40b5e:	00 
   40b5f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40b66:	00 
   40b67:	76 ae                	jbe    40b17 <get_physical_page_addr+0x17>
        }
    }  
    return -1;
   40b69:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
}
   40b70:	c9                   	leave  
   40b71:	c3                   	ret    

0000000000040b72 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40b72:	55                   	push   %rbp
   40b73:	48 89 e5             	mov    %rsp,%rbp
   40b76:	48 83 ec 10          	sub    $0x10,%rsp
   40b7a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40b7e:	89 f0                	mov    %esi,%eax
   40b80:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40b83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b87:	25 ff 0f 00 00       	and    $0xfff,%eax
   40b8c:	48 85 c0             	test   %rax,%rax
   40b8f:	75 20                	jne    40bb1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   40b91:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40b98:	00 
   40b99:	77 16                	ja     40bb1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40b9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b9f:	48 c1 e8 0c          	shr    $0xc,%rax
   40ba3:	48 98                	cltq   
   40ba5:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   40bac:	00 
   40bad:	84 c0                	test   %al,%al
   40baf:	74 07                	je     40bb8 <assign_physical_page+0x46>
        return -1;
   40bb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40bb6:	eb 2c                	jmp    40be4 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40bb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bbc:	48 c1 e8 0c          	shr    $0xc,%rax
   40bc0:	48 98                	cltq   
   40bc2:	c6 84 00 41 ee 04 00 	movb   $0x1,0x4ee41(%rax,%rax,1)
   40bc9:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bce:	48 c1 e8 0c          	shr    $0xc,%rax
   40bd2:	48 98                	cltq   
   40bd4:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40bd8:	88 94 00 40 ee 04 00 	mov    %dl,0x4ee40(%rax,%rax,1)
        return 0;
   40bdf:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40be4:	c9                   	leave  
   40be5:	c3                   	ret    

0000000000040be6 <syscall_mapping>:

void syscall_mapping(proc* p){
   40be6:	55                   	push   %rbp
   40be7:	48 89 e5             	mov    %rsp,%rbp
   40bea:	48 83 ec 70          	sub    $0x70,%rsp
   40bee:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40bf2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40bf6:	48 8b 40 38          	mov    0x38(%rax),%rax
   40bfa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40bfe:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40c02:	48 8b 40 30          	mov    0x30(%rax),%rax
   40c06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40c0a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40c0e:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c15:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40c19:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40c1d:	48 89 ce             	mov    %rcx,%rsi
   40c20:	48 89 c7             	mov    %rax,%rdi
   40c23:	e8 11 26 00 00       	call   43239 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40c28:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40c2b:	48 98                	cltq   
   40c2d:	83 e0 06             	and    $0x6,%eax
   40c30:	48 83 f8 06          	cmp    $0x6,%rax
   40c34:	75 73                	jne    40ca9 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   40c36:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c3a:	48 83 c0 17          	add    $0x17,%rax
   40c3e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40c42:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40c46:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c4d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40c51:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40c55:	48 89 ce             	mov    %rcx,%rsi
   40c58:	48 89 c7             	mov    %rax,%rdi
   40c5b:	e8 d9 25 00 00       	call   43239 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40c60:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40c63:	48 98                	cltq   
   40c65:	83 e0 03             	and    $0x3,%eax
   40c68:	48 83 f8 03          	cmp    $0x3,%rax
   40c6c:	75 3e                	jne    40cac <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40c6e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40c72:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c79:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40c7d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c81:	48 89 ce             	mov    %rcx,%rsi
   40c84:	48 89 c7             	mov    %rax,%rdi
   40c87:	e8 ad 25 00 00       	call   43239 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40c8c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c90:	48 89 c1             	mov    %rax,%rcx
   40c93:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40c97:	ba 18 00 00 00       	mov    $0x18,%edx
   40c9c:	48 89 c6             	mov    %rax,%rsi
   40c9f:	48 89 cf             	mov    %rcx,%rdi
   40ca2:	e8 a1 2a 00 00       	call   43748 <memcpy>
   40ca7:	eb 04                	jmp    40cad <syscall_mapping+0xc7>
	return;
   40ca9:	90                   	nop
   40caa:	eb 01                	jmp    40cad <syscall_mapping+0xc7>
	return;
   40cac:	90                   	nop
}
   40cad:	c9                   	leave  
   40cae:	c3                   	ret    

0000000000040caf <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40caf:	55                   	push   %rbp
   40cb0:	48 89 e5             	mov    %rsp,%rbp
   40cb3:	48 83 ec 18          	sub    $0x18,%rsp
   40cb7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40cbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cbf:	48 8b 40 38          	mov    0x38(%rax),%rax
   40cc3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40cc6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40cca:	75 14                	jne    40ce0 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40ccc:	0f b6 05 2d 43 00 00 	movzbl 0x432d(%rip),%eax        # 45000 <disp_global>
   40cd3:	84 c0                	test   %al,%al
   40cd5:	0f 94 c0             	sete   %al
   40cd8:	88 05 22 43 00 00    	mov    %al,0x4322(%rip)        # 45000 <disp_global>
   40cde:	eb 36                	jmp    40d16 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40ce0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40ce4:	78 2f                	js     40d15 <syscall_mem_tog+0x66>
   40ce6:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40cea:	7f 29                	jg     40d15 <syscall_mem_tog+0x66>
   40cec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cf0:	8b 00                	mov    (%rax),%eax
   40cf2:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40cf5:	75 1e                	jne    40d15 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40cf7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cfb:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40d02:	84 c0                	test   %al,%al
   40d04:	0f 94 c0             	sete   %al
   40d07:	89 c2                	mov    %eax,%edx
   40d09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d0d:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   40d13:	eb 01                	jmp    40d16 <syscall_mem_tog+0x67>
            return;
   40d15:	90                   	nop
    }
}
   40d16:	c9                   	leave  
   40d17:	c3                   	ret    

0000000000040d18 <exception>:

// step 3 and onward
// a bunch of case statememt
// also might have to do something for step 1 or step 2 in here

void exception(x86_64_registers* reg) {
   40d18:	55                   	push   %rbp
   40d19:	48 89 e5             	mov    %rsp,%rbp
   40d1c:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   40d23:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40d2a:	48 8b 05 cf d2 00 00 	mov    0xd2cf(%rip),%rax        # 4e000 <current>
   40d31:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   40d38:	48 83 c0 08          	add    $0x8,%rax
   40d3c:	48 89 d6             	mov    %rdx,%rsi
   40d3f:	ba 18 00 00 00       	mov    $0x18,%edx
   40d44:	48 89 c7             	mov    %rax,%rdi
   40d47:	48 89 d1             	mov    %rdx,%rcx
   40d4a:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40d4d:	48 8b 05 ac 02 01 00 	mov    0x102ac(%rip),%rax        # 51000 <kernel_pagetable>
   40d54:	48 89 c7             	mov    %rax,%rdi
   40d57:	e8 f1 1f 00 00       	call   42d4d <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40d5c:	8b 05 9a 82 07 00    	mov    0x7829a(%rip),%eax        # b8ffc <cursorpos>
   40d62:	89 c7                	mov    %eax,%edi
   40d64:	e8 18 17 00 00       	call   42481 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40d69:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40d70:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40d77:	48 83 f8 0e          	cmp    $0xe,%rax
   40d7b:	74 14                	je     40d91 <exception+0x79>
   40d7d:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40d84:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40d8b:	48 83 f8 0d          	cmp    $0xd,%rax
   40d8f:	75 16                	jne    40da7 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40d91:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40d98:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d9f:	83 e0 04             	and    $0x4,%eax
   40da2:	48 85 c0             	test   %rax,%rax
   40da5:	74 1a                	je     40dc1 <exception+0xa9>
    {
        check_virtual_memory();
   40da7:	e8 d8 08 00 00       	call   41684 <check_virtual_memory>
        if(disp_global){
   40dac:	0f b6 05 4d 42 00 00 	movzbl 0x424d(%rip),%eax        # 45000 <disp_global>
   40db3:	84 c0                	test   %al,%al
   40db5:	74 0a                	je     40dc1 <exception+0xa9>
            memshow_physical();
   40db7:	e8 40 0a 00 00       	call   417fc <memshow_physical>
            memshow_virtual_animate();
   40dbc:	e8 66 0d 00 00       	call   41b27 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40dc1:	e8 98 1b 00 00       	call   4295e <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40dc6:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40dcd:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40dd4:	48 83 e8 0e          	sub    $0xe,%rax
   40dd8:	48 83 f8 2a          	cmp    $0x2a,%rax
   40ddc:	0f 87 01 04 00 00    	ja     411e3 <exception+0x4cb>
   40de2:	48 8b 04 c5 a8 41 04 	mov    0x441a8(,%rax,8),%rax
   40de9:	00 
   40dea:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40dec:	48 8b 05 0d d2 00 00 	mov    0xd20d(%rip),%rax        # 4e000 <current>
   40df3:	48 8b 40 38          	mov    0x38(%rax),%rax
   40df7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
		if((void *)addr == NULL)
   40dfb:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40e00:	75 0f                	jne    40e11 <exception+0xf9>
		    panic(NULL);
   40e02:	bf 00 00 00 00       	mov    $0x0,%edi
   40e07:	b8 00 00 00 00       	mov    $0x0,%eax
   40e0c:	e8 8e 1c 00 00       	call   42a9f <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40e11:	48 8b 05 e8 d1 00 00 	mov    0xd1e8(%rip),%rax        # 4e000 <current>
   40e18:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40e1f:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40e23:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40e27:	48 89 ce             	mov    %rcx,%rsi
   40e2a:	48 89 c7             	mov    %rax,%rdi
   40e2d:	e8 07 24 00 00       	call   43239 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40e32:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40e36:	48 89 c1             	mov    %rax,%rcx
   40e39:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40e40:	ba a0 00 00 00       	mov    $0xa0,%edx
   40e45:	48 89 ce             	mov    %rcx,%rsi
   40e48:	48 89 c7             	mov    %rax,%rdi
   40e4b:	e8 f8 28 00 00       	call   43748 <memcpy>
		panic(msg);
   40e50:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40e57:	48 89 c7             	mov    %rax,%rdi
   40e5a:	b8 00 00 00 00       	mov    $0x0,%eax
   40e5f:	e8 3b 1c 00 00       	call   42a9f <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40e64:	48 8b 05 95 d1 00 00 	mov    0xd195(%rip),%rax        # 4e000 <current>
   40e6b:	8b 10                	mov    (%rax),%edx
   40e6d:	48 8b 05 8c d1 00 00 	mov    0xd18c(%rip),%rax        # 4e000 <current>
   40e74:	48 63 d2             	movslq %edx,%rdx
   40e77:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40e7b:	e9 75 03 00 00       	jmp    411f5 <exception+0x4dd>

    case INT_SYS_YIELD:
        schedule();
   40e80:	e8 99 03 00 00       	call   4121e <schedule>
        break;                  /* will not be reached */
   40e85:	e9 6b 03 00 00       	jmp    411f5 <exception+0x4dd>
        // is you need to alloc a page now

        // sys_page_alloc addr IS a virtual address
        // the page with physical address X is used to 
        // satisfy the sys_page_alloc(X) allocation request for virtual address X.
        uintptr_t addr = current->p_registers.reg_rdi; // look at virtual address
   40e8a:	48 8b 05 6f d1 00 00 	mov    0xd16f(%rip),%rax        # 4e000 <current>
   40e91:	48 8b 40 38          	mov    0x38(%rax),%rax
   40e95:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

        if (addr < PROC_START_ADDR && addr != CONSOLE_ADDR)
   40e99:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   40ea0:	00 
   40ea1:	77 1f                	ja     40ec2 <exception+0x1aa>
   40ea3:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   40ea8:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
   40eac:	74 14                	je     40ec2 <exception+0x1aa>
        {
            current->p_registers.reg_rax = -1;
   40eae:	48 8b 05 4b d1 00 00 	mov    0xd14b(%rip),%rax        # 4e000 <current>
   40eb5:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40ebc:	ff 
            break;
   40ebd:	e9 33 03 00 00       	jmp    411f5 <exception+0x4dd>
        }
        if (addr > MEMSIZE_VIRTUAL || addr % PAGESIZE != 0)
   40ec2:	48 81 7d e0 00 00 30 	cmpq   $0x300000,-0x20(%rbp)
   40ec9:	00 
   40eca:	77 0e                	ja     40eda <exception+0x1c2>
   40ecc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40ed0:	25 ff 0f 00 00       	and    $0xfff,%eax
   40ed5:	48 85 c0             	test   %rax,%rax
   40ed8:	74 14                	je     40eee <exception+0x1d6>
        {
            current->p_registers.reg_rax = -1;
   40eda:	48 8b 05 1f d1 00 00 	mov    0xd11f(%rip),%rax        # 4e000 <current>
   40ee1:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40ee8:	ff 
            break;
   40ee9:	e9 07 03 00 00       	jmp    411f5 <exception+0x4dd>
        }

        // log_printf("virtual address: %p\n", addr);

        uintptr_t next_page_addr = get_physical_page_addr(current->p_pid);
   40eee:	48 8b 05 0b d1 00 00 	mov    0xd10b(%rip),%rax        # 4e000 <current>
   40ef5:	8b 00                	mov    (%rax),%eax
   40ef7:	0f be c0             	movsbl %al,%eax
   40efa:	89 c7                	mov    %eax,%edi
   40efc:	e8 ff fb ff ff       	call   40b00 <get_physical_page_addr>
   40f01:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        
        if (next_page_addr == 0xffffffffffffffff)
   40f05:	48 83 7d d8 ff       	cmpq   $0xffffffffffffffff,-0x28(%rbp)
   40f0a:	75 14                	jne    40f20 <exception+0x208>
        {
            current->p_registers.reg_rax = -1;
   40f0c:	48 8b 05 ed d0 00 00 	mov    0xd0ed(%rip),%rax        # 4e000 <current>
   40f13:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f1a:	ff 
            break;  
   40f1b:	e9 d5 02 00 00       	jmp    411f5 <exception+0x4dd>
        }

        int r = 0;
   40f20:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)

        // log_printf("MAPPING virtual address %p to physical addreses %p\n", 
        //             addr, next_page_addr);

        if (r >= 0) {
   40f27:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   40f2b:	78 46                	js     40f73 <exception+0x25b>
            int res = virtual_memory_map(current->p_pagetable, addr, next_page_addr,
   40f2d:	48 8b 05 cc d0 00 00 	mov    0xd0cc(%rip),%rax        # 4e000 <current>
   40f34:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40f3b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40f3f:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   40f43:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40f49:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40f4e:	48 89 c7             	mov    %rax,%rdi
   40f51:	e8 28 1f 00 00       	call   42e7e <virtual_memory_map>
   40f56:	89 45 d0             	mov    %eax,-0x30(%rbp)
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
            if (res < 0)
   40f59:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
   40f5d:	79 14                	jns    40f73 <exception+0x25b>
            {
                current->p_registers.reg_rax = -1;
   40f5f:	48 8b 05 9a d0 00 00 	mov    0xd09a(%rip),%rax        # 4e000 <current>
   40f66:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f6d:	ff 
                break;  
   40f6e:	e9 82 02 00 00       	jmp    411f5 <exception+0x4dd>
            }
        }
        current->p_registers.reg_rax = r;
   40f73:	48 8b 05 86 d0 00 00 	mov    0xd086(%rip),%rax        # 4e000 <current>
   40f7a:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   40f7d:	48 63 d2             	movslq %edx,%rdx
   40f80:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40f84:	e9 6c 02 00 00       	jmp    411f5 <exception+0x4dd>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40f89:	48 8b 05 70 d0 00 00 	mov    0xd070(%rip),%rax        # 4e000 <current>
   40f90:	48 89 c7             	mov    %rax,%rdi
   40f93:	e8 4e fc ff ff       	call   40be6 <syscall_mapping>
            break;
   40f98:	e9 58 02 00 00       	jmp    411f5 <exception+0x4dd>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40f9d:	48 8b 05 5c d0 00 00 	mov    0xd05c(%rip),%rax        # 4e000 <current>
   40fa4:	48 89 c7             	mov    %rax,%rdi
   40fa7:	e8 03 fd ff ff       	call   40caf <syscall_mem_tog>
	    break;
   40fac:	e9 44 02 00 00       	jmp    411f5 <exception+0x4dd>
	}

    case INT_TIMER:
        ++ticks;
   40fb1:	8b 05 69 de 00 00    	mov    0xde69(%rip),%eax        # 4ee20 <ticks>
   40fb7:	83 c0 01             	add    $0x1,%eax
   40fba:	89 05 60 de 00 00    	mov    %eax,0xde60(%rip)        # 4ee20 <ticks>
        schedule();
   40fc0:	e8 59 02 00 00       	call   4121e <schedule>
        break;                  /* will not be reached */
   40fc5:	e9 2b 02 00 00       	jmp    411f5 <exception+0x4dd>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40fca:	0f 20 d0             	mov    %cr2,%rax
   40fcd:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    return val;
   40fd1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40fd5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40fd9:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40fe0:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40fe7:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40fea:	48 85 c0             	test   %rax,%rax
   40fed:	74 07                	je     40ff6 <exception+0x2de>
   40fef:	b8 1d 41 04 00       	mov    $0x4411d,%eax
   40ff4:	eb 05                	jmp    40ffb <exception+0x2e3>
   40ff6:	b8 23 41 04 00       	mov    $0x44123,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40ffb:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40fff:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   41006:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4100d:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   41010:	48 85 c0             	test   %rax,%rax
   41013:	74 07                	je     4101c <exception+0x304>
   41015:	b8 28 41 04 00       	mov    $0x44128,%eax
   4101a:	eb 05                	jmp    41021 <exception+0x309>
   4101c:	b8 3b 41 04 00       	mov    $0x4413b,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   41021:	48 89 45 b0          	mov    %rax,-0x50(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   41025:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4102c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41033:	83 e0 04             	and    $0x4,%eax
   41036:	48 85 c0             	test   %rax,%rax
   41039:	75 2f                	jne    4106a <exception+0x352>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   4103b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   41042:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   41049:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
   4104d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41051:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41055:	49 89 f0             	mov    %rsi,%r8
   41058:	48 89 c6             	mov    %rax,%rsi
   4105b:	bf 48 41 04 00       	mov    $0x44148,%edi
   41060:	b8 00 00 00 00       	mov    $0x0,%eax
   41065:	e8 35 1a 00 00       	call   42a9f <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   4106a:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   41071:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   41078:	48 8b 05 81 cf 00 00 	mov    0xcf81(%rip),%rax        # 4e000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   4107f:	8b 00                	mov    (%rax),%eax
   41081:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   41085:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   41089:	52                   	push   %rdx
   4108a:	ff 75 b0             	push   -0x50(%rbp)
   4108d:	49 89 f1             	mov    %rsi,%r9
   41090:	49 89 c8             	mov    %rcx,%r8
   41093:	89 c1                	mov    %eax,%ecx
   41095:	ba 78 41 04 00       	mov    $0x44178,%edx
   4109a:	be 00 0c 00 00       	mov    $0xc00,%esi
   4109f:	bf 80 07 00 00       	mov    $0x780,%edi
   410a4:	b8 00 00 00 00       	mov    $0x0,%eax
   410a9:	e8 38 2f 00 00       	call   43fe6 <console_printf>
   410ae:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   410b2:	48 8b 05 47 cf 00 00 	mov    0xcf47(%rip),%rax        # 4e000 <current>
   410b9:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   410c0:	00 00 00 
        break;
   410c3:	e9 2d 01 00 00       	jmp    411f5 <exception+0x4dd>
    // states, etc.
        // you need to handle the fork case for step 5
        // you'll end up creating a new page table again
        // back to the process_setup

        int free_process = find_free_process();
   410c8:	b8 00 00 00 00       	mov    $0x0,%eax
   410cd:	e8 99 f5 ff ff       	call   4066b <find_free_process>
   410d2:	89 45 fc             	mov    %eax,-0x4(%rbp)

        if (free_process == -1) // if not found
   410d5:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   410d9:	75 14                	jne    410ef <exception+0x3d7>
        {
            current->p_registers.reg_rax = -1; break;  
   410db:	48 8b 05 1e cf 00 00 	mov    0xcf1e(%rip),%rax        # 4e000 <current>
   410e2:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   410e9:	ff 
   410ea:	e9 06 01 00 00       	jmp    411f5 <exception+0x4dd>
        }

        // initiate and copy over process pagetable

        process_init(&processes[free_process], 0);
   410ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410f2:	48 63 d0             	movslq %eax,%rdx
   410f5:	48 89 d0             	mov    %rdx,%rax
   410f8:	48 c1 e0 03          	shl    $0x3,%rax
   410fc:	48 29 d0             	sub    %rdx,%rax
   410ff:	48 c1 e0 05          	shl    $0x5,%rax
   41103:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   41109:	be 00 00 00 00       	mov    $0x0,%esi
   4110e:	48 89 c7             	mov    %rax,%rdi
   41111:	e8 ac 12 00 00       	call   423c2 <process_init>

        x86_64_pagetable* res_pagetables[5];
        int res_pt = init_pagetable(free_process, res_pagetables);
   41116:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
   4111d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41120:	48 89 d6             	mov    %rdx,%rsi
   41123:	89 c7                	mov    %eax,%edi
   41125:	e8 bd f3 ff ff       	call   404e7 <init_pagetable>
   4112a:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (res_pt == -1)
   4112d:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   41131:	75 1e                	jne    41151 <exception+0x439>
        {
            free_bad_pagetable(free_process);
   41133:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41136:	89 c7                	mov    %eax,%edi
   41138:	e8 47 f6 ff ff       	call   40784 <free_bad_pagetable>
            current->p_registers.reg_rax = -1; break;  
   4113d:	48 8b 05 bc ce 00 00 	mov    0xcebc(%rip),%rax        # 4e000 <current>
   41144:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4114b:	ff 
   4114c:	e9 a4 00 00 00       	jmp    411f5 <exception+0x4dd>
        }
        x86_64_pagetable* res_pagetable = res_pagetables[0];
   41151:	48 8b 85 f0 fe ff ff 	mov    -0x110(%rbp),%rax
   41158:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        int res_fork = fork_copy(free_process, res_pagetable, current->p_pagetable);
   4115c:	48 8b 05 9d ce 00 00 	mov    0xce9d(%rip),%rax        # 4e000 <current>
   41163:	48 8b 90 d0 00 00 00 	mov    0xd0(%rax),%rdx
   4116a:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   4116e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41171:	48 89 ce             	mov    %rcx,%rsi
   41174:	89 c7                	mov    %eax,%edi
   41176:	e8 e9 f6 ff ff       	call   40864 <fork_copy>
   4117b:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (res_fork == -1)
   4117e:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41182:	75 70                	jne    411f4 <exception+0x4dc>
        {
            garbage_collect(free_process, res_pagetable);
   41184:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41188:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4118b:	48 89 d6             	mov    %rdx,%rsi
   4118e:	89 c7                	mov    %eax,%edi
   41190:	e8 45 f6 ff ff       	call   407da <garbage_collect>
            free_bad_pagetable(free_process);
   41195:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41198:	89 c7                	mov    %eax,%edi
   4119a:	e8 e5 f5 ff ff       	call   40784 <free_bad_pagetable>
            current->p_registers.reg_rax = -1; break;  
   4119f:	48 8b 05 5a ce 00 00 	mov    0xce5a(%rip),%rax        # 4e000 <current>
   411a6:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   411ad:	ff 
   411ae:	eb 45                	jmp    411f5 <exception+0x4dd>
        }

        break;
    case INT_SYS_EXIT:
        garbage_collect(current->p_pid, current->p_pagetable);
   411b0:	48 8b 05 49 ce 00 00 	mov    0xce49(%rip),%rax        # 4e000 <current>
   411b7:	48 8b 90 d0 00 00 00 	mov    0xd0(%rax),%rdx
   411be:	48 8b 05 3b ce 00 00 	mov    0xce3b(%rip),%rax        # 4e000 <current>
   411c5:	8b 00                	mov    (%rax),%eax
   411c7:	48 89 d6             	mov    %rdx,%rsi
   411ca:	89 c7                	mov    %eax,%edi
   411cc:	e8 09 f6 ff ff       	call   407da <garbage_collect>
        free_bad_pagetable(current->p_pid);
   411d1:	48 8b 05 28 ce 00 00 	mov    0xce28(%rip),%rax        # 4e000 <current>
   411d8:	8b 00                	mov    (%rax),%eax
   411da:	89 c7                	mov    %eax,%edi
   411dc:	e8 a3 f5 ff ff       	call   40784 <free_bad_pagetable>
        break;
   411e1:	eb 12                	jmp    411f5 <exception+0x4dd>

    default:
        default_exception(current);
   411e3:	48 8b 05 16 ce 00 00 	mov    0xce16(%rip),%rax        # 4e000 <current>
   411ea:	48 89 c7             	mov    %rax,%rdi
   411ed:	e8 bd 19 00 00       	call   42baf <default_exception>
        break;                  /* will not be reached */
   411f2:	eb 01                	jmp    411f5 <exception+0x4dd>
        break;
   411f4:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   411f5:	48 8b 05 04 ce 00 00 	mov    0xce04(%rip),%rax        # 4e000 <current>
   411fc:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41202:	83 f8 01             	cmp    $0x1,%eax
   41205:	75 0f                	jne    41216 <exception+0x4fe>
        run(current);
   41207:	48 8b 05 f2 cd 00 00 	mov    0xcdf2(%rip),%rax        # 4e000 <current>
   4120e:	48 89 c7             	mov    %rax,%rdi
   41211:	e8 7a 00 00 00       	call   41290 <run>
    } else {
        schedule();
   41216:	e8 03 00 00 00       	call   4121e <schedule>
    }
}
   4121b:	90                   	nop
   4121c:	c9                   	leave  
   4121d:	c3                   	ret    

000000000004121e <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   4121e:	55                   	push   %rbp
   4121f:	48 89 e5             	mov    %rsp,%rbp
   41222:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   41226:	48 8b 05 d3 cd 00 00 	mov    0xcdd3(%rip),%rax        # 4e000 <current>
   4122d:	8b 00                	mov    (%rax),%eax
   4122f:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41232:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41235:	83 c0 01             	add    $0x1,%eax
   41238:	99                   	cltd   
   41239:	c1 ea 1c             	shr    $0x1c,%edx
   4123c:	01 d0                	add    %edx,%eax
   4123e:	83 e0 0f             	and    $0xf,%eax
   41241:	29 d0                	sub    %edx,%eax
   41243:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   41246:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41249:	48 63 d0             	movslq %eax,%rdx
   4124c:	48 89 d0             	mov    %rdx,%rax
   4124f:	48 c1 e0 03          	shl    $0x3,%rax
   41253:	48 29 d0             	sub    %rdx,%rax
   41256:	48 c1 e0 05          	shl    $0x5,%rax
   4125a:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41260:	8b 00                	mov    (%rax),%eax
   41262:	83 f8 01             	cmp    $0x1,%eax
   41265:	75 22                	jne    41289 <schedule+0x6b>
            run(&processes[pid]);
   41267:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4126a:	48 63 d0             	movslq %eax,%rdx
   4126d:	48 89 d0             	mov    %rdx,%rax
   41270:	48 c1 e0 03          	shl    $0x3,%rax
   41274:	48 29 d0             	sub    %rdx,%rax
   41277:	48 c1 e0 05          	shl    $0x5,%rax
   4127b:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   41281:	48 89 c7             	mov    %rax,%rdi
   41284:	e8 07 00 00 00       	call   41290 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   41289:	e8 d0 16 00 00       	call   4295e <check_keyboard>
        pid = (pid + 1) % NPROC;
   4128e:	eb a2                	jmp    41232 <schedule+0x14>

0000000000041290 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41290:	55                   	push   %rbp
   41291:	48 89 e5             	mov    %rsp,%rbp
   41294:	48 83 ec 10          	sub    $0x10,%rsp
   41298:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   4129c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412a0:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   412a6:	83 f8 01             	cmp    $0x1,%eax
   412a9:	74 14                	je     412bf <run+0x2f>
   412ab:	ba 00 43 04 00       	mov    $0x44300,%edx
   412b0:	be 08 03 00 00       	mov    $0x308,%esi
   412b5:	bf e6 40 04 00       	mov    $0x440e6,%edi
   412ba:	e8 c0 18 00 00       	call   42b7f <assert_fail>
    current = p;
   412bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412c3:	48 89 05 36 cd 00 00 	mov    %rax,0xcd36(%rip)        # 4e000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   412ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412ce:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   412d5:	48 89 c7             	mov    %rax,%rdi
   412d8:	e8 70 1a 00 00       	call   42d4d <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   412dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412e1:	48 83 c0 08          	add    $0x8,%rax
   412e5:	48 89 c7             	mov    %rax,%rdi
   412e8:	e8 d6 ed ff ff       	call   400c3 <exception_return>

00000000000412ed <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   412ed:	55                   	push   %rbp
   412ee:	48 89 e5             	mov    %rsp,%rbp
   412f1:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   412f5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   412fc:	00 
   412fd:	e9 81 00 00 00       	jmp    41383 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41302:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41306:	48 89 c7             	mov    %rax,%rdi
   41309:	e8 ef 0e 00 00       	call   421fd <physical_memory_isreserved>
   4130e:	85 c0                	test   %eax,%eax
   41310:	74 09                	je     4131b <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   41312:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   41319:	eb 2f                	jmp    4134a <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4131b:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41322:	00 
   41323:	76 0b                	jbe    41330 <pageinfo_init+0x43>
   41325:	b8 08 70 05 00       	mov    $0x57008,%eax
   4132a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4132e:	72 0a                	jb     4133a <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41330:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   41337:	00 
   41338:	75 09                	jne    41343 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   4133a:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41341:	eb 07                	jmp    4134a <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   41343:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4134a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4134e:	48 c1 e8 0c          	shr    $0xc,%rax
   41352:	89 c1                	mov    %eax,%ecx
   41354:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41357:	89 c2                	mov    %eax,%edx
   41359:	48 63 c1             	movslq %ecx,%rax
   4135c:	88 94 00 40 ee 04 00 	mov    %dl,0x4ee40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41363:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41367:	0f 95 c2             	setne  %dl
   4136a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4136e:	48 c1 e8 0c          	shr    $0xc,%rax
   41372:	48 98                	cltq   
   41374:	88 94 00 41 ee 04 00 	mov    %dl,0x4ee41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4137b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41382:	00 
   41383:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4138a:	00 
   4138b:	0f 86 71 ff ff ff    	jbe    41302 <pageinfo_init+0x15>
    }
}
   41391:	90                   	nop
   41392:	90                   	nop
   41393:	c9                   	leave  
   41394:	c3                   	ret    

0000000000041395 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   41395:	55                   	push   %rbp
   41396:	48 89 e5             	mov    %rsp,%rbp
   41399:	48 83 ec 50          	sub    $0x50,%rsp
   4139d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   413a1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   413a5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   413ab:	48 89 c2             	mov    %rax,%rdx
   413ae:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   413b2:	48 39 c2             	cmp    %rax,%rdx
   413b5:	74 14                	je     413cb <check_page_table_mappings+0x36>
   413b7:	ba 20 43 04 00       	mov    $0x44320,%edx
   413bc:	be 32 03 00 00       	mov    $0x332,%esi
   413c1:	bf e6 40 04 00       	mov    $0x440e6,%edi
   413c6:	e8 b4 17 00 00       	call   42b7f <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   413cb:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   413d2:	00 
   413d3:	e9 9a 00 00 00       	jmp    41472 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   413d8:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   413dc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   413e0:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   413e4:	48 89 ce             	mov    %rcx,%rsi
   413e7:	48 89 c7             	mov    %rax,%rdi
   413ea:	e8 4a 1e 00 00       	call   43239 <virtual_memory_lookup>
        if (vam.pa != va) {
   413ef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   413f3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413f7:	74 27                	je     41420 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   413f9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   413fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41401:	49 89 d0             	mov    %rdx,%r8
   41404:	48 89 c1             	mov    %rax,%rcx
   41407:	ba 3f 43 04 00       	mov    $0x4433f,%edx
   4140c:	be 00 c0 00 00       	mov    $0xc000,%esi
   41411:	bf e0 06 00 00       	mov    $0x6e0,%edi
   41416:	b8 00 00 00 00       	mov    $0x0,%eax
   4141b:	e8 c6 2b 00 00       	call   43fe6 <console_printf>
        }
        // log_printf("physical address of kernel mapping: %p, virtual address: %p\n",
        //                 vam.pa, va);
        assert(vam.pa == va);
   41420:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41424:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41428:	74 14                	je     4143e <check_page_table_mappings+0xa9>
   4142a:	ba 49 43 04 00       	mov    $0x44349,%edx
   4142f:	be 3d 03 00 00       	mov    $0x33d,%esi
   41434:	bf e6 40 04 00       	mov    $0x440e6,%edi
   41439:	e8 41 17 00 00       	call   42b7f <assert_fail>
        if (va >= (uintptr_t) start_data) {
   4143e:	b8 00 50 04 00       	mov    $0x45000,%eax
   41443:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41447:	72 21                	jb     4146a <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   41449:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4144c:	48 98                	cltq   
   4144e:	83 e0 02             	and    $0x2,%eax
   41451:	48 85 c0             	test   %rax,%rax
   41454:	75 14                	jne    4146a <check_page_table_mappings+0xd5>
   41456:	ba 56 43 04 00       	mov    $0x44356,%edx
   4145b:	be 3f 03 00 00       	mov    $0x33f,%esi
   41460:	bf e6 40 04 00       	mov    $0x440e6,%edi
   41465:	e8 15 17 00 00       	call   42b7f <assert_fail>
         va += PAGESIZE) {
   4146a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41471:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41472:	b8 08 70 05 00       	mov    $0x57008,%eax
   41477:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4147b:	0f 82 57 ff ff ff    	jb     413d8 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41481:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   41488:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   41489:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4148d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41491:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41495:	48 89 ce             	mov    %rcx,%rsi
   41498:	48 89 c7             	mov    %rax,%rdi
   4149b:	e8 99 1d 00 00       	call   43239 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   414a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414a4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   414a8:	74 14                	je     414be <check_page_table_mappings+0x129>
   414aa:	ba 67 43 04 00       	mov    $0x44367,%edx
   414af:	be 46 03 00 00       	mov    $0x346,%esi
   414b4:	bf e6 40 04 00       	mov    $0x440e6,%edi
   414b9:	e8 c1 16 00 00       	call   42b7f <assert_fail>
    assert(vam.perm & PTE_W);
   414be:	8b 45 e8             	mov    -0x18(%rbp),%eax
   414c1:	48 98                	cltq   
   414c3:	83 e0 02             	and    $0x2,%eax
   414c6:	48 85 c0             	test   %rax,%rax
   414c9:	75 14                	jne    414df <check_page_table_mappings+0x14a>
   414cb:	ba 56 43 04 00       	mov    $0x44356,%edx
   414d0:	be 47 03 00 00       	mov    $0x347,%esi
   414d5:	bf e6 40 04 00       	mov    $0x440e6,%edi
   414da:	e8 a0 16 00 00       	call   42b7f <assert_fail>
}
   414df:	90                   	nop
   414e0:	c9                   	leave  
   414e1:	c3                   	ret    

00000000000414e2 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   414e2:	55                   	push   %rbp
   414e3:	48 89 e5             	mov    %rsp,%rbp
   414e6:	48 83 ec 20          	sub    $0x20,%rsp
   414ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   414ee:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   414f1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   414f4:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   414f7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   414fe:	48 8b 05 fb fa 00 00 	mov    0xfafb(%rip),%rax        # 51000 <kernel_pagetable>
   41505:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41509:	75 67                	jne    41572 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   4150b:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41512:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41519:	eb 51                	jmp    4156c <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   4151b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4151e:	48 63 d0             	movslq %eax,%rdx
   41521:	48 89 d0             	mov    %rdx,%rax
   41524:	48 c1 e0 03          	shl    $0x3,%rax
   41528:	48 29 d0             	sub    %rdx,%rax
   4152b:	48 c1 e0 05          	shl    $0x5,%rax
   4152f:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41535:	8b 00                	mov    (%rax),%eax
   41537:	85 c0                	test   %eax,%eax
   41539:	74 2d                	je     41568 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4153b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4153e:	48 63 d0             	movslq %eax,%rdx
   41541:	48 89 d0             	mov    %rdx,%rax
   41544:	48 c1 e0 03          	shl    $0x3,%rax
   41548:	48 29 d0             	sub    %rdx,%rax
   4154b:	48 c1 e0 05          	shl    $0x5,%rax
   4154f:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41555:	48 8b 10             	mov    (%rax),%rdx
   41558:	48 8b 05 a1 fa 00 00 	mov    0xfaa1(%rip),%rax        # 51000 <kernel_pagetable>
   4155f:	48 39 c2             	cmp    %rax,%rdx
   41562:	75 04                	jne    41568 <check_page_table_ownership+0x86>
                ++expected_refcount;
   41564:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41568:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4156c:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41570:	7e a9                	jle    4151b <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41572:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41575:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41578:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4157c:	be 00 00 00 00       	mov    $0x0,%esi
   41581:	48 89 c7             	mov    %rax,%rdi
   41584:	e8 03 00 00 00       	call   4158c <check_page_table_ownership_level>
}
   41589:	90                   	nop
   4158a:	c9                   	leave  
   4158b:	c3                   	ret    

000000000004158c <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4158c:	55                   	push   %rbp
   4158d:	48 89 e5             	mov    %rsp,%rbp
   41590:	48 83 ec 30          	sub    $0x30,%rsp
   41594:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41598:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4159b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4159e:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   415a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415a5:	48 c1 e8 0c          	shr    $0xc,%rax
   415a9:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   415ae:	7e 14                	jle    415c4 <check_page_table_ownership_level+0x38>
   415b0:	ba 78 43 04 00       	mov    $0x44378,%edx
   415b5:	be 64 03 00 00       	mov    $0x364,%esi
   415ba:	bf e6 40 04 00       	mov    $0x440e6,%edi
   415bf:	e8 bb 15 00 00       	call   42b7f <assert_fail>
    // uncommment at some point
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   415c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415c8:	48 c1 e8 0c          	shr    $0xc,%rax
   415cc:	48 98                	cltq   
   415ce:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   415d5:	00 
   415d6:	0f be c0             	movsbl %al,%eax
   415d9:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   415dc:	74 14                	je     415f2 <check_page_table_ownership_level+0x66>
   415de:	ba 90 43 04 00       	mov    $0x44390,%edx
   415e3:	be 66 03 00 00       	mov    $0x366,%esi
   415e8:	bf e6 40 04 00       	mov    $0x440e6,%edi
   415ed:	e8 8d 15 00 00       	call   42b7f <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   415f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415f6:	48 c1 e8 0c          	shr    $0xc,%rax
   415fa:	48 98                	cltq   
   415fc:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41603:	00 
   41604:	0f be c0             	movsbl %al,%eax
   41607:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4160a:	74 14                	je     41620 <check_page_table_ownership_level+0x94>
   4160c:	ba b8 43 04 00       	mov    $0x443b8,%edx
   41611:	be 67 03 00 00       	mov    $0x367,%esi
   41616:	bf e6 40 04 00       	mov    $0x440e6,%edi
   4161b:	e8 5f 15 00 00       	call   42b7f <assert_fail>
    if (level < 3) {
   41620:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41624:	7f 5b                	jg     41681 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41626:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4162d:	eb 49                	jmp    41678 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   4162f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41633:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41636:	48 63 d2             	movslq %edx,%rdx
   41639:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4163d:	48 85 c0             	test   %rax,%rax
   41640:	74 32                	je     41674 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41642:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41646:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41649:	48 63 d2             	movslq %edx,%rdx
   4164c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41650:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41656:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4165a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4165d:	8d 70 01             	lea    0x1(%rax),%esi
   41660:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41667:	b9 01 00 00 00       	mov    $0x1,%ecx
   4166c:	48 89 c7             	mov    %rax,%rdi
   4166f:	e8 18 ff ff ff       	call   4158c <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41674:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41678:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4167f:	7e ae                	jle    4162f <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41681:	90                   	nop
   41682:	c9                   	leave  
   41683:	c3                   	ret    

0000000000041684 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41684:	55                   	push   %rbp
   41685:	48 89 e5             	mov    %rsp,%rbp
   41688:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4168c:	8b 05 56 ca 00 00    	mov    0xca56(%rip),%eax        # 4e0e8 <processes+0xc8>
   41692:	85 c0                	test   %eax,%eax
   41694:	74 14                	je     416aa <check_virtual_memory+0x26>
   41696:	ba e8 43 04 00       	mov    $0x443e8,%edx
   4169b:	be 7a 03 00 00       	mov    $0x37a,%esi
   416a0:	bf e6 40 04 00       	mov    $0x440e6,%edi
   416a5:	e8 d5 14 00 00       	call   42b7f <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   416aa:	48 8b 05 4f f9 00 00 	mov    0xf94f(%rip),%rax        # 51000 <kernel_pagetable>
   416b1:	48 89 c7             	mov    %rax,%rdi
   416b4:	e8 dc fc ff ff       	call   41395 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   416b9:	48 8b 05 40 f9 00 00 	mov    0xf940(%rip),%rax        # 51000 <kernel_pagetable>
   416c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
   416c5:	48 89 c7             	mov    %rax,%rdi
   416c8:	e8 15 fe ff ff       	call   414e2 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   416cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   416d4:	e9 9c 00 00 00       	jmp    41775 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   416d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416dc:	48 63 d0             	movslq %eax,%rdx
   416df:	48 89 d0             	mov    %rdx,%rax
   416e2:	48 c1 e0 03          	shl    $0x3,%rax
   416e6:	48 29 d0             	sub    %rdx,%rax
   416e9:	48 c1 e0 05          	shl    $0x5,%rax
   416ed:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   416f3:	8b 00                	mov    (%rax),%eax
   416f5:	85 c0                	test   %eax,%eax
   416f7:	74 78                	je     41771 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   416f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416fc:	48 63 d0             	movslq %eax,%rdx
   416ff:	48 89 d0             	mov    %rdx,%rax
   41702:	48 c1 e0 03          	shl    $0x3,%rax
   41706:	48 29 d0             	sub    %rdx,%rax
   41709:	48 c1 e0 05          	shl    $0x5,%rax
   4170d:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41713:	48 8b 10             	mov    (%rax),%rdx
   41716:	48 8b 05 e3 f8 00 00 	mov    0xf8e3(%rip),%rax        # 51000 <kernel_pagetable>
   4171d:	48 39 c2             	cmp    %rax,%rdx
   41720:	74 4f                	je     41771 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41722:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41725:	48 63 d0             	movslq %eax,%rdx
   41728:	48 89 d0             	mov    %rdx,%rax
   4172b:	48 c1 e0 03          	shl    $0x3,%rax
   4172f:	48 29 d0             	sub    %rdx,%rax
   41732:	48 c1 e0 05          	shl    $0x5,%rax
   41736:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   4173c:	48 8b 00             	mov    (%rax),%rax
   4173f:	48 89 c7             	mov    %rax,%rdi
   41742:	e8 4e fc ff ff       	call   41395 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41747:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4174a:	48 63 d0             	movslq %eax,%rdx
   4174d:	48 89 d0             	mov    %rdx,%rax
   41750:	48 c1 e0 03          	shl    $0x3,%rax
   41754:	48 29 d0             	sub    %rdx,%rax
   41757:	48 c1 e0 05          	shl    $0x5,%rax
   4175b:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41761:	48 8b 00             	mov    (%rax),%rax
   41764:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41767:	89 d6                	mov    %edx,%esi
   41769:	48 89 c7             	mov    %rax,%rdi
   4176c:	e8 71 fd ff ff       	call   414e2 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41771:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41775:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41779:	0f 8e 5a ff ff ff    	jle    416d9 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4177f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41786:	eb 67                	jmp    417ef <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41788:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4178b:	48 98                	cltq   
   4178d:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41794:	00 
   41795:	84 c0                	test   %al,%al
   41797:	7e 52                	jle    417eb <check_virtual_memory+0x167>
   41799:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4179c:	48 98                	cltq   
   4179e:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   417a5:	00 
   417a6:	84 c0                	test   %al,%al
   417a8:	78 41                	js     417eb <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   417aa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417ad:	48 98                	cltq   
   417af:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   417b6:	00 
   417b7:	0f be c0             	movsbl %al,%eax
   417ba:	48 63 d0             	movslq %eax,%rdx
   417bd:	48 89 d0             	mov    %rdx,%rax
   417c0:	48 c1 e0 03          	shl    $0x3,%rax
   417c4:	48 29 d0             	sub    %rdx,%rax
   417c7:	48 c1 e0 05          	shl    $0x5,%rax
   417cb:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   417d1:	8b 00                	mov    (%rax),%eax
   417d3:	85 c0                	test   %eax,%eax
   417d5:	75 14                	jne    417eb <check_virtual_memory+0x167>
   417d7:	ba 08 44 04 00       	mov    $0x44408,%edx
   417dc:	be 91 03 00 00       	mov    $0x391,%esi
   417e1:	bf e6 40 04 00       	mov    $0x440e6,%edi
   417e6:	e8 94 13 00 00       	call   42b7f <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   417eb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   417ef:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   417f6:	7e 90                	jle    41788 <check_virtual_memory+0x104>
        }
    }
}
   417f8:	90                   	nop
   417f9:	90                   	nop
   417fa:	c9                   	leave  
   417fb:	c3                   	ret    

00000000000417fc <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   417fc:	55                   	push   %rbp
   417fd:	48 89 e5             	mov    %rsp,%rbp
   41800:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41804:	ba 66 44 04 00       	mov    $0x44466,%edx
   41809:	be 00 0f 00 00       	mov    $0xf00,%esi
   4180e:	bf 20 00 00 00       	mov    $0x20,%edi
   41813:	b8 00 00 00 00       	mov    $0x0,%eax
   41818:	e8 c9 27 00 00       	call   43fe6 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4181d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41824:	e9 f4 00 00 00       	jmp    4191d <memshow_physical+0x121>
        if (pn % 64 == 0) {
   41829:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4182c:	83 e0 3f             	and    $0x3f,%eax
   4182f:	85 c0                	test   %eax,%eax
   41831:	75 3e                	jne    41871 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41833:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41836:	c1 e0 0c             	shl    $0xc,%eax
   41839:	89 c2                	mov    %eax,%edx
   4183b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4183e:	8d 48 3f             	lea    0x3f(%rax),%ecx
   41841:	85 c0                	test   %eax,%eax
   41843:	0f 48 c1             	cmovs  %ecx,%eax
   41846:	c1 f8 06             	sar    $0x6,%eax
   41849:	8d 48 01             	lea    0x1(%rax),%ecx
   4184c:	89 c8                	mov    %ecx,%eax
   4184e:	c1 e0 02             	shl    $0x2,%eax
   41851:	01 c8                	add    %ecx,%eax
   41853:	c1 e0 04             	shl    $0x4,%eax
   41856:	83 c0 03             	add    $0x3,%eax
   41859:	89 d1                	mov    %edx,%ecx
   4185b:	ba 76 44 04 00       	mov    $0x44476,%edx
   41860:	be 00 0f 00 00       	mov    $0xf00,%esi
   41865:	89 c7                	mov    %eax,%edi
   41867:	b8 00 00 00 00       	mov    $0x0,%eax
   4186c:	e8 75 27 00 00       	call   43fe6 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41871:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41874:	48 98                	cltq   
   41876:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   4187d:	00 
   4187e:	0f be c0             	movsbl %al,%eax
   41881:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41884:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41887:	48 98                	cltq   
   41889:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41890:	00 
   41891:	84 c0                	test   %al,%al
   41893:	75 07                	jne    4189c <memshow_physical+0xa0>
            owner = PO_FREE;
   41895:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4189c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4189f:	83 c0 02             	add    $0x2,%eax
   418a2:	48 98                	cltq   
   418a4:	0f b7 84 00 40 44 04 	movzwl 0x44440(%rax,%rax,1),%eax
   418ab:	00 
   418ac:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   418b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418b3:	48 98                	cltq   
   418b5:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   418bc:	00 
   418bd:	3c 01                	cmp    $0x1,%al
   418bf:	7e 1a                	jle    418db <memshow_physical+0xdf>
   418c1:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   418c6:	48 c1 e8 0c          	shr    $0xc,%rax
   418ca:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   418cd:	74 0c                	je     418db <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   418cf:	b8 53 00 00 00       	mov    $0x53,%eax
   418d4:	80 cc 0f             	or     $0xf,%ah
   418d7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   418db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418de:	8d 50 3f             	lea    0x3f(%rax),%edx
   418e1:	85 c0                	test   %eax,%eax
   418e3:	0f 48 c2             	cmovs  %edx,%eax
   418e6:	c1 f8 06             	sar    $0x6,%eax
   418e9:	8d 50 01             	lea    0x1(%rax),%edx
   418ec:	89 d0                	mov    %edx,%eax
   418ee:	c1 e0 02             	shl    $0x2,%eax
   418f1:	01 d0                	add    %edx,%eax
   418f3:	c1 e0 04             	shl    $0x4,%eax
   418f6:	89 c1                	mov    %eax,%ecx
   418f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418fb:	99                   	cltd   
   418fc:	c1 ea 1a             	shr    $0x1a,%edx
   418ff:	01 d0                	add    %edx,%eax
   41901:	83 e0 3f             	and    $0x3f,%eax
   41904:	29 d0                	sub    %edx,%eax
   41906:	83 c0 0c             	add    $0xc,%eax
   41909:	01 c8                	add    %ecx,%eax
   4190b:	48 98                	cltq   
   4190d:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41911:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41918:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41919:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4191d:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41924:	0f 8e ff fe ff ff    	jle    41829 <memshow_physical+0x2d>
    }
}
   4192a:	90                   	nop
   4192b:	90                   	nop
   4192c:	c9                   	leave  
   4192d:	c3                   	ret    

000000000004192e <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   4192e:	55                   	push   %rbp
   4192f:	48 89 e5             	mov    %rsp,%rbp
   41932:	48 83 ec 40          	sub    $0x40,%rsp
   41936:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4193a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4193e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41942:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41948:	48 89 c2             	mov    %rax,%rdx
   4194b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4194f:	48 39 c2             	cmp    %rax,%rdx
   41952:	74 14                	je     41968 <memshow_virtual+0x3a>
   41954:	ba 80 44 04 00       	mov    $0x44480,%edx
   41959:	be c2 03 00 00       	mov    $0x3c2,%esi
   4195e:	bf e6 40 04 00       	mov    $0x440e6,%edi
   41963:	e8 17 12 00 00       	call   42b7f <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41968:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4196c:	48 89 c1             	mov    %rax,%rcx
   4196f:	ba ad 44 04 00       	mov    $0x444ad,%edx
   41974:	be 00 0f 00 00       	mov    $0xf00,%esi
   41979:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4197e:	b8 00 00 00 00       	mov    $0x0,%eax
   41983:	e8 5e 26 00 00       	call   43fe6 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41988:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4198f:	00 
   41990:	e9 80 01 00 00       	jmp    41b15 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41995:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41999:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4199d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   419a1:	48 89 ce             	mov    %rcx,%rsi
   419a4:	48 89 c7             	mov    %rax,%rdi
   419a7:	e8 8d 18 00 00       	call   43239 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   419ac:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419af:	85 c0                	test   %eax,%eax
   419b1:	79 0b                	jns    419be <memshow_virtual+0x90>
            color = ' ';
   419b3:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   419b9:	e9 d7 00 00 00       	jmp    41a95 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   419be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   419c2:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   419c8:	76 14                	jbe    419de <memshow_virtual+0xb0>
   419ca:	ba ca 44 04 00       	mov    $0x444ca,%edx
   419cf:	be cb 03 00 00       	mov    $0x3cb,%esi
   419d4:	bf e6 40 04 00       	mov    $0x440e6,%edi
   419d9:	e8 a1 11 00 00       	call   42b7f <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   419de:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419e1:	48 98                	cltq   
   419e3:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   419ea:	00 
   419eb:	0f be c0             	movsbl %al,%eax
   419ee:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   419f1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419f4:	48 98                	cltq   
   419f6:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   419fd:	00 
   419fe:	84 c0                	test   %al,%al
   41a00:	75 07                	jne    41a09 <memshow_virtual+0xdb>
                owner = PO_FREE;
   41a02:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41a09:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a0c:	83 c0 02             	add    $0x2,%eax
   41a0f:	48 98                	cltq   
   41a11:	0f b7 84 00 40 44 04 	movzwl 0x44440(%rax,%rax,1),%eax
   41a18:	00 
   41a19:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41a1d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41a20:	48 98                	cltq   
   41a22:	83 e0 04             	and    $0x4,%eax
   41a25:	48 85 c0             	test   %rax,%rax
   41a28:	74 27                	je     41a51 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41a2a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a2e:	c1 e0 04             	shl    $0x4,%eax
   41a31:	66 25 00 f0          	and    $0xf000,%ax
   41a35:	89 c2                	mov    %eax,%edx
   41a37:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a3b:	c1 f8 04             	sar    $0x4,%eax
   41a3e:	66 25 00 0f          	and    $0xf00,%ax
   41a42:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41a44:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a48:	0f b6 c0             	movzbl %al,%eax
   41a4b:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41a4d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41a51:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a54:	48 98                	cltq   
   41a56:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41a5d:	00 
   41a5e:	3c 01                	cmp    $0x1,%al
   41a60:	7e 33                	jle    41a95 <memshow_virtual+0x167>
   41a62:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41a67:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41a6b:	74 28                	je     41a95 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41a6d:	b8 53 00 00 00       	mov    $0x53,%eax
   41a72:	89 c2                	mov    %eax,%edx
   41a74:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a78:	66 25 00 f0          	and    $0xf000,%ax
   41a7c:	09 d0                	or     %edx,%eax
   41a7e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41a82:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41a85:	48 98                	cltq   
   41a87:	83 e0 04             	and    $0x4,%eax
   41a8a:	48 85 c0             	test   %rax,%rax
   41a8d:	75 06                	jne    41a95 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41a8f:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41a95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a99:	48 c1 e8 0c          	shr    $0xc,%rax
   41a9d:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41aa0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41aa3:	83 e0 3f             	and    $0x3f,%eax
   41aa6:	85 c0                	test   %eax,%eax
   41aa8:	75 34                	jne    41ade <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41aaa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41aad:	c1 e8 06             	shr    $0x6,%eax
   41ab0:	89 c2                	mov    %eax,%edx
   41ab2:	89 d0                	mov    %edx,%eax
   41ab4:	c1 e0 02             	shl    $0x2,%eax
   41ab7:	01 d0                	add    %edx,%eax
   41ab9:	c1 e0 04             	shl    $0x4,%eax
   41abc:	05 73 03 00 00       	add    $0x373,%eax
   41ac1:	89 c7                	mov    %eax,%edi
   41ac3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ac7:	48 89 c1             	mov    %rax,%rcx
   41aca:	ba 76 44 04 00       	mov    $0x44476,%edx
   41acf:	be 00 0f 00 00       	mov    $0xf00,%esi
   41ad4:	b8 00 00 00 00       	mov    $0x0,%eax
   41ad9:	e8 08 25 00 00       	call   43fe6 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41ade:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ae1:	c1 e8 06             	shr    $0x6,%eax
   41ae4:	89 c2                	mov    %eax,%edx
   41ae6:	89 d0                	mov    %edx,%eax
   41ae8:	c1 e0 02             	shl    $0x2,%eax
   41aeb:	01 d0                	add    %edx,%eax
   41aed:	c1 e0 04             	shl    $0x4,%eax
   41af0:	89 c2                	mov    %eax,%edx
   41af2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41af5:	83 e0 3f             	and    $0x3f,%eax
   41af8:	01 d0                	add    %edx,%eax
   41afa:	05 7c 03 00 00       	add    $0x37c,%eax
   41aff:	89 c2                	mov    %eax,%edx
   41b01:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b05:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41b0c:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41b0d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41b14:	00 
   41b15:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41b1c:	00 
   41b1d:	0f 86 72 fe ff ff    	jbe    41995 <memshow_virtual+0x67>
    }
}
   41b23:	90                   	nop
   41b24:	90                   	nop
   41b25:	c9                   	leave  
   41b26:	c3                   	ret    

0000000000041b27 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41b27:	55                   	push   %rbp
   41b28:	48 89 e5             	mov    %rsp,%rbp
   41b2b:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41b2f:	8b 05 0b d7 00 00    	mov    0xd70b(%rip),%eax        # 4f240 <last_ticks.1>
   41b35:	85 c0                	test   %eax,%eax
   41b37:	74 13                	je     41b4c <memshow_virtual_animate+0x25>
   41b39:	8b 05 e1 d2 00 00    	mov    0xd2e1(%rip),%eax        # 4ee20 <ticks>
   41b3f:	8b 15 fb d6 00 00    	mov    0xd6fb(%rip),%edx        # 4f240 <last_ticks.1>
   41b45:	29 d0                	sub    %edx,%eax
   41b47:	83 f8 31             	cmp    $0x31,%eax
   41b4a:	76 2c                	jbe    41b78 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41b4c:	8b 05 ce d2 00 00    	mov    0xd2ce(%rip),%eax        # 4ee20 <ticks>
   41b52:	89 05 e8 d6 00 00    	mov    %eax,0xd6e8(%rip)        # 4f240 <last_ticks.1>
        ++showing;
   41b58:	8b 05 a6 34 00 00    	mov    0x34a6(%rip),%eax        # 45004 <showing.0>
   41b5e:	83 c0 01             	add    $0x1,%eax
   41b61:	89 05 9d 34 00 00    	mov    %eax,0x349d(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41b67:	eb 0f                	jmp    41b78 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41b69:	8b 05 95 34 00 00    	mov    0x3495(%rip),%eax        # 45004 <showing.0>
   41b6f:	83 c0 01             	add    $0x1,%eax
   41b72:	89 05 8c 34 00 00    	mov    %eax,0x348c(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   41b78:	8b 05 86 34 00 00    	mov    0x3486(%rip),%eax        # 45004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41b7e:	83 f8 20             	cmp    $0x20,%eax
   41b81:	7f 2e                	jg     41bb1 <memshow_virtual_animate+0x8a>
   41b83:	8b 05 7b 34 00 00    	mov    0x347b(%rip),%eax        # 45004 <showing.0>
   41b89:	99                   	cltd   
   41b8a:	c1 ea 1c             	shr    $0x1c,%edx
   41b8d:	01 d0                	add    %edx,%eax
   41b8f:	83 e0 0f             	and    $0xf,%eax
   41b92:	29 d0                	sub    %edx,%eax
   41b94:	48 63 d0             	movslq %eax,%rdx
   41b97:	48 89 d0             	mov    %rdx,%rax
   41b9a:	48 c1 e0 03          	shl    $0x3,%rax
   41b9e:	48 29 d0             	sub    %rdx,%rax
   41ba1:	48 c1 e0 05          	shl    $0x5,%rax
   41ba5:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41bab:	8b 00                	mov    (%rax),%eax
   41bad:	85 c0                	test   %eax,%eax
   41baf:	74 b8                	je     41b69 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41bb1:	8b 05 4d 34 00 00    	mov    0x344d(%rip),%eax        # 45004 <showing.0>
   41bb7:	99                   	cltd   
   41bb8:	c1 ea 1c             	shr    $0x1c,%edx
   41bbb:	01 d0                	add    %edx,%eax
   41bbd:	83 e0 0f             	and    $0xf,%eax
   41bc0:	29 d0                	sub    %edx,%eax
   41bc2:	89 05 3c 34 00 00    	mov    %eax,0x343c(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41bc8:	8b 05 36 34 00 00    	mov    0x3436(%rip),%eax        # 45004 <showing.0>
   41bce:	48 63 d0             	movslq %eax,%rdx
   41bd1:	48 89 d0             	mov    %rdx,%rax
   41bd4:	48 c1 e0 03          	shl    $0x3,%rax
   41bd8:	48 29 d0             	sub    %rdx,%rax
   41bdb:	48 c1 e0 05          	shl    $0x5,%rax
   41bdf:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41be5:	8b 00                	mov    (%rax),%eax
   41be7:	85 c0                	test   %eax,%eax
   41be9:	74 52                	je     41c3d <memshow_virtual_animate+0x116>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41beb:	8b 15 13 34 00 00    	mov    0x3413(%rip),%edx        # 45004 <showing.0>
   41bf1:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41bf5:	89 d1                	mov    %edx,%ecx
   41bf7:	ba e4 44 04 00       	mov    $0x444e4,%edx
   41bfc:	be 04 00 00 00       	mov    $0x4,%esi
   41c01:	48 89 c7             	mov    %rax,%rdi
   41c04:	b8 00 00 00 00       	mov    $0x0,%eax
   41c09:	e8 56 24 00 00       	call   44064 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41c0e:	8b 05 f0 33 00 00    	mov    0x33f0(%rip),%eax        # 45004 <showing.0>
   41c14:	48 63 d0             	movslq %eax,%rdx
   41c17:	48 89 d0             	mov    %rdx,%rax
   41c1a:	48 c1 e0 03          	shl    $0x3,%rax
   41c1e:	48 29 d0             	sub    %rdx,%rax
   41c21:	48 c1 e0 05          	shl    $0x5,%rax
   41c25:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41c2b:	48 8b 00             	mov    (%rax),%rax
   41c2e:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41c32:	48 89 d6             	mov    %rdx,%rsi
   41c35:	48 89 c7             	mov    %rax,%rdi
   41c38:	e8 f1 fc ff ff       	call   4192e <memshow_virtual>
    }
}
   41c3d:	90                   	nop
   41c3e:	c9                   	leave  
   41c3f:	c3                   	ret    

0000000000041c40 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41c40:	55                   	push   %rbp
   41c41:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41c44:	e8 53 01 00 00       	call   41d9c <segments_init>
    interrupt_init();
   41c49:	e8 d4 03 00 00       	call   42022 <interrupt_init>
    virtual_memory_init();
   41c4e:	e8 e7 0f 00 00       	call   42c3a <virtual_memory_init>
}
   41c53:	90                   	nop
   41c54:	5d                   	pop    %rbp
   41c55:	c3                   	ret    

0000000000041c56 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41c56:	55                   	push   %rbp
   41c57:	48 89 e5             	mov    %rsp,%rbp
   41c5a:	48 83 ec 18          	sub    $0x18,%rsp
   41c5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c62:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c66:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41c69:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c6c:	48 98                	cltq   
   41c6e:	48 c1 e0 2d          	shl    $0x2d,%rax
   41c72:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41c76:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41c7d:	90 00 00 
   41c80:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41c83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c87:	48 89 10             	mov    %rdx,(%rax)
}
   41c8a:	90                   	nop
   41c8b:	c9                   	leave  
   41c8c:	c3                   	ret    

0000000000041c8d <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41c8d:	55                   	push   %rbp
   41c8e:	48 89 e5             	mov    %rsp,%rbp
   41c91:	48 83 ec 28          	sub    $0x28,%rsp
   41c95:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c99:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c9d:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41ca0:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41ca4:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41ca8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41cac:	48 c1 e0 10          	shl    $0x10,%rax
   41cb0:	48 89 c2             	mov    %rax,%rdx
   41cb3:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41cba:	00 00 00 
   41cbd:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41cc0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41cc4:	48 c1 e0 20          	shl    $0x20,%rax
   41cc8:	48 89 c1             	mov    %rax,%rcx
   41ccb:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41cd2:	00 00 ff 
   41cd5:	48 21 c8             	and    %rcx,%rax
   41cd8:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41cdb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41cdf:	48 83 e8 01          	sub    $0x1,%rax
   41ce3:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41ce6:	48 09 d0             	or     %rdx,%rax
        | type
   41ce9:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41ced:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41cf0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cf3:	48 98                	cltq   
   41cf5:	48 c1 e0 2d          	shl    $0x2d,%rax
   41cf9:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41cfc:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41d03:	80 00 00 
   41d06:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d0d:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41d10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d14:	48 83 c0 08          	add    $0x8,%rax
   41d18:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41d1c:	48 c1 ea 20          	shr    $0x20,%rdx
   41d20:	48 89 10             	mov    %rdx,(%rax)
}
   41d23:	90                   	nop
   41d24:	c9                   	leave  
   41d25:	c3                   	ret    

0000000000041d26 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41d26:	55                   	push   %rbp
   41d27:	48 89 e5             	mov    %rsp,%rbp
   41d2a:	48 83 ec 20          	sub    $0x20,%rsp
   41d2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d32:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d36:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41d39:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d3d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d41:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41d44:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41d48:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41d4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41d4e:	48 98                	cltq   
   41d50:	48 c1 e0 2d          	shl    $0x2d,%rax
   41d54:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41d57:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d5b:	48 c1 e0 20          	shl    $0x20,%rax
   41d5f:	48 89 c1             	mov    %rax,%rcx
   41d62:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41d69:	00 ff ff 
   41d6c:	48 21 c8             	and    %rcx,%rax
   41d6f:	48 09 c2             	or     %rax,%rdx
   41d72:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41d79:	80 00 00 
   41d7c:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d83:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41d86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d8a:	48 c1 e8 20          	shr    $0x20,%rax
   41d8e:	48 89 c2             	mov    %rax,%rdx
   41d91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d95:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41d99:	90                   	nop
   41d9a:	c9                   	leave  
   41d9b:	c3                   	ret    

0000000000041d9c <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41d9c:	55                   	push   %rbp
   41d9d:	48 89 e5             	mov    %rsp,%rbp
   41da0:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41da4:	48 c7 05 b1 d4 00 00 	movq   $0x0,0xd4b1(%rip)        # 4f260 <segments>
   41dab:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41daf:	ba 00 00 00 00       	mov    $0x0,%edx
   41db4:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41dbb:	08 20 00 
   41dbe:	48 89 c6             	mov    %rax,%rsi
   41dc1:	bf 68 f2 04 00       	mov    $0x4f268,%edi
   41dc6:	e8 8b fe ff ff       	call   41c56 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41dcb:	ba 03 00 00 00       	mov    $0x3,%edx
   41dd0:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41dd7:	08 20 00 
   41dda:	48 89 c6             	mov    %rax,%rsi
   41ddd:	bf 70 f2 04 00       	mov    $0x4f270,%edi
   41de2:	e8 6f fe ff ff       	call   41c56 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41de7:	ba 00 00 00 00       	mov    $0x0,%edx
   41dec:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41df3:	02 00 00 
   41df6:	48 89 c6             	mov    %rax,%rsi
   41df9:	bf 78 f2 04 00       	mov    $0x4f278,%edi
   41dfe:	e8 53 fe ff ff       	call   41c56 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41e03:	ba 03 00 00 00       	mov    $0x3,%edx
   41e08:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41e0f:	02 00 00 
   41e12:	48 89 c6             	mov    %rax,%rsi
   41e15:	bf 80 f2 04 00       	mov    $0x4f280,%edi
   41e1a:	e8 37 fe ff ff       	call   41c56 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41e1f:	b8 a0 02 05 00       	mov    $0x502a0,%eax
   41e24:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41e2a:	48 89 c1             	mov    %rax,%rcx
   41e2d:	ba 00 00 00 00       	mov    $0x0,%edx
   41e32:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41e39:	09 00 00 
   41e3c:	48 89 c6             	mov    %rax,%rsi
   41e3f:	bf 88 f2 04 00       	mov    $0x4f288,%edi
   41e44:	e8 44 fe ff ff       	call   41c8d <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41e49:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41e4f:	b8 60 f2 04 00       	mov    $0x4f260,%eax
   41e54:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41e58:	ba 60 00 00 00       	mov    $0x60,%edx
   41e5d:	be 00 00 00 00       	mov    $0x0,%esi
   41e62:	bf a0 02 05 00       	mov    $0x502a0,%edi
   41e67:	e8 45 19 00 00       	call   437b1 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41e6c:	48 c7 05 2d e4 00 00 	movq   $0x80000,0xe42d(%rip)        # 502a4 <kernel_task_descriptor+0x4>
   41e73:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41e77:	ba 00 10 00 00       	mov    $0x1000,%edx
   41e7c:	be 00 00 00 00       	mov    $0x0,%esi
   41e81:	bf a0 f2 04 00       	mov    $0x4f2a0,%edi
   41e86:	e8 26 19 00 00       	call   437b1 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41e8b:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41e92:	eb 30                	jmp    41ec4 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41e94:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41e99:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e9c:	48 c1 e0 04          	shl    $0x4,%rax
   41ea0:	48 05 a0 f2 04 00    	add    $0x4f2a0,%rax
   41ea6:	48 89 d1             	mov    %rdx,%rcx
   41ea9:	ba 00 00 00 00       	mov    $0x0,%edx
   41eae:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41eb5:	0e 00 00 
   41eb8:	48 89 c7             	mov    %rax,%rdi
   41ebb:	e8 66 fe ff ff       	call   41d26 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41ec0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ec4:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41ecb:	76 c7                	jbe    41e94 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41ecd:	b8 36 00 04 00       	mov    $0x40036,%eax
   41ed2:	48 89 c1             	mov    %rax,%rcx
   41ed5:	ba 00 00 00 00       	mov    $0x0,%edx
   41eda:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ee1:	0e 00 00 
   41ee4:	48 89 c6             	mov    %rax,%rsi
   41ee7:	bf a0 f4 04 00       	mov    $0x4f4a0,%edi
   41eec:	e8 35 fe ff ff       	call   41d26 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41ef1:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41ef6:	48 89 c1             	mov    %rax,%rcx
   41ef9:	ba 00 00 00 00       	mov    $0x0,%edx
   41efe:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f05:	0e 00 00 
   41f08:	48 89 c6             	mov    %rax,%rsi
   41f0b:	bf 70 f3 04 00       	mov    $0x4f370,%edi
   41f10:	e8 11 fe ff ff       	call   41d26 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41f15:	b8 32 00 04 00       	mov    $0x40032,%eax
   41f1a:	48 89 c1             	mov    %rax,%rcx
   41f1d:	ba 00 00 00 00       	mov    $0x0,%edx
   41f22:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f29:	0e 00 00 
   41f2c:	48 89 c6             	mov    %rax,%rsi
   41f2f:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   41f34:	e8 ed fd ff ff       	call   41d26 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f39:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41f40:	eb 3e                	jmp    41f80 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41f42:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f45:	83 e8 30             	sub    $0x30,%eax
   41f48:	89 c0                	mov    %eax,%eax
   41f4a:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41f51:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41f52:	48 89 c2             	mov    %rax,%rdx
   41f55:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f58:	48 c1 e0 04          	shl    $0x4,%rax
   41f5c:	48 05 a0 f2 04 00    	add    $0x4f2a0,%rax
   41f62:	48 89 d1             	mov    %rdx,%rcx
   41f65:	ba 03 00 00 00       	mov    $0x3,%edx
   41f6a:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41f71:	0e 00 00 
   41f74:	48 89 c7             	mov    %rax,%rdi
   41f77:	e8 aa fd ff ff       	call   41d26 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f7c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41f80:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41f84:	76 bc                	jbe    41f42 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41f86:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41f8c:	b8 a0 f2 04 00       	mov    $0x4f2a0,%eax
   41f91:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41f95:	b8 28 00 00 00       	mov    $0x28,%eax
   41f9a:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41f9e:	0f 00 d8             	ltr    %ax
   41fa1:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41fa5:	0f 20 c0             	mov    %cr0,%rax
   41fa8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41fac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41fb0:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41fb3:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41fba:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fbd:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41fc0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fc3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41fc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41fcb:	0f 22 c0             	mov    %rax,%cr0
}
   41fce:	90                   	nop
    lcr0(cr0);
}
   41fcf:	90                   	nop
   41fd0:	c9                   	leave  
   41fd1:	c3                   	ret    

0000000000041fd2 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41fd2:	55                   	push   %rbp
   41fd3:	48 89 e5             	mov    %rsp,%rbp
   41fd6:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41fda:	0f b7 05 1f e3 00 00 	movzwl 0xe31f(%rip),%eax        # 50300 <interrupts_enabled>
   41fe1:	f7 d0                	not    %eax
   41fe3:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41fe7:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41feb:	0f b6 c0             	movzbl %al,%eax
   41fee:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41ff5:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41ffc:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41fff:	ee                   	out    %al,(%dx)
}
   42000:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   42001:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42005:	66 c1 e8 08          	shr    $0x8,%ax
   42009:	0f b6 c0             	movzbl %al,%eax
   4200c:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   42013:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42016:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4201a:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4201d:	ee                   	out    %al,(%dx)
}
   4201e:	90                   	nop
}
   4201f:	90                   	nop
   42020:	c9                   	leave  
   42021:	c3                   	ret    

0000000000042022 <interrupt_init>:

void interrupt_init(void) {
   42022:	55                   	push   %rbp
   42023:	48 89 e5             	mov    %rsp,%rbp
   42026:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   4202a:	66 c7 05 cd e2 00 00 	movw   $0x0,0xe2cd(%rip)        # 50300 <interrupts_enabled>
   42031:	00 00 
    interrupt_mask();
   42033:	e8 9a ff ff ff       	call   41fd2 <interrupt_mask>
   42038:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4203f:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42043:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   42047:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4204a:	ee                   	out    %al,(%dx)
}
   4204b:	90                   	nop
   4204c:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42053:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42057:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4205b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4205e:	ee                   	out    %al,(%dx)
}
   4205f:	90                   	nop
   42060:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   42067:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4206b:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   4206f:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42072:	ee                   	out    %al,(%dx)
}
   42073:	90                   	nop
   42074:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4207b:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4207f:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42083:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42086:	ee                   	out    %al,(%dx)
}
   42087:	90                   	nop
   42088:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   4208f:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42093:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42097:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4209a:	ee                   	out    %al,(%dx)
}
   4209b:	90                   	nop
   4209c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   420a3:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420a7:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   420ab:	8b 55 cc             	mov    -0x34(%rbp),%edx
   420ae:	ee                   	out    %al,(%dx)
}
   420af:	90                   	nop
   420b0:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   420b7:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420bb:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   420bf:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   420c2:	ee                   	out    %al,(%dx)
}
   420c3:	90                   	nop
   420c4:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   420cb:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420cf:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   420d3:	8b 55 dc             	mov    -0x24(%rbp),%edx
   420d6:	ee                   	out    %al,(%dx)
}
   420d7:	90                   	nop
   420d8:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   420df:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420e3:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   420e7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   420ea:	ee                   	out    %al,(%dx)
}
   420eb:	90                   	nop
   420ec:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   420f3:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420f7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   420fb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   420fe:	ee                   	out    %al,(%dx)
}
   420ff:	90                   	nop
   42100:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   42107:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4210b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4210f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42112:	ee                   	out    %al,(%dx)
}
   42113:	90                   	nop
   42114:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   4211b:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4211f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42123:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42126:	ee                   	out    %al,(%dx)
}
   42127:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   42128:	e8 a5 fe ff ff       	call   41fd2 <interrupt_mask>
}
   4212d:	90                   	nop
   4212e:	c9                   	leave  
   4212f:	c3                   	ret    

0000000000042130 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   42130:	55                   	push   %rbp
   42131:	48 89 e5             	mov    %rsp,%rbp
   42134:	48 83 ec 28          	sub    $0x28,%rsp
   42138:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4213b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4213f:	0f 8e 9f 00 00 00    	jle    421e4 <timer_init+0xb4>
   42145:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   4214c:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42150:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42154:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42157:	ee                   	out    %al,(%dx)
}
   42158:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   42159:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4215c:	89 c2                	mov    %eax,%edx
   4215e:	c1 ea 1f             	shr    $0x1f,%edx
   42161:	01 d0                	add    %edx,%eax
   42163:	d1 f8                	sar    %eax
   42165:	05 de 34 12 00       	add    $0x1234de,%eax
   4216a:	99                   	cltd   
   4216b:	f7 7d dc             	idivl  -0x24(%rbp)
   4216e:	89 c2                	mov    %eax,%edx
   42170:	89 d0                	mov    %edx,%eax
   42172:	c1 f8 1f             	sar    $0x1f,%eax
   42175:	c1 e8 18             	shr    $0x18,%eax
   42178:	89 c1                	mov    %eax,%ecx
   4217a:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   4217d:	0f b6 c0             	movzbl %al,%eax
   42180:	29 c8                	sub    %ecx,%eax
   42182:	0f b6 c0             	movzbl %al,%eax
   42185:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   4218c:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4218f:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42193:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42196:	ee                   	out    %al,(%dx)
}
   42197:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   42198:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4219b:	89 c2                	mov    %eax,%edx
   4219d:	c1 ea 1f             	shr    $0x1f,%edx
   421a0:	01 d0                	add    %edx,%eax
   421a2:	d1 f8                	sar    %eax
   421a4:	05 de 34 12 00       	add    $0x1234de,%eax
   421a9:	99                   	cltd   
   421aa:	f7 7d dc             	idivl  -0x24(%rbp)
   421ad:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   421b3:	85 c0                	test   %eax,%eax
   421b5:	0f 48 c2             	cmovs  %edx,%eax
   421b8:	c1 f8 08             	sar    $0x8,%eax
   421bb:	0f b6 c0             	movzbl %al,%eax
   421be:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   421c5:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421c8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421cc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   421cf:	ee                   	out    %al,(%dx)
}
   421d0:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   421d1:	0f b7 05 28 e1 00 00 	movzwl 0xe128(%rip),%eax        # 50300 <interrupts_enabled>
   421d8:	83 c8 01             	or     $0x1,%eax
   421db:	66 89 05 1e e1 00 00 	mov    %ax,0xe11e(%rip)        # 50300 <interrupts_enabled>
   421e2:	eb 11                	jmp    421f5 <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   421e4:	0f b7 05 15 e1 00 00 	movzwl 0xe115(%rip),%eax        # 50300 <interrupts_enabled>
   421eb:	83 e0 fe             	and    $0xfffffffe,%eax
   421ee:	66 89 05 0b e1 00 00 	mov    %ax,0xe10b(%rip)        # 50300 <interrupts_enabled>
    }
    interrupt_mask();
   421f5:	e8 d8 fd ff ff       	call   41fd2 <interrupt_mask>
}
   421fa:	90                   	nop
   421fb:	c9                   	leave  
   421fc:	c3                   	ret    

00000000000421fd <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   421fd:	55                   	push   %rbp
   421fe:	48 89 e5             	mov    %rsp,%rbp
   42201:	48 83 ec 08          	sub    $0x8,%rsp
   42205:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   42209:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4220e:	74 14                	je     42224 <physical_memory_isreserved+0x27>
   42210:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   42217:	00 
   42218:	76 11                	jbe    4222b <physical_memory_isreserved+0x2e>
   4221a:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   42221:	00 
   42222:	77 07                	ja     4222b <physical_memory_isreserved+0x2e>
   42224:	b8 01 00 00 00       	mov    $0x1,%eax
   42229:	eb 05                	jmp    42230 <physical_memory_isreserved+0x33>
   4222b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42230:	c9                   	leave  
   42231:	c3                   	ret    

0000000000042232 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42232:	55                   	push   %rbp
   42233:	48 89 e5             	mov    %rsp,%rbp
   42236:	48 83 ec 10          	sub    $0x10,%rsp
   4223a:	89 7d fc             	mov    %edi,-0x4(%rbp)
   4223d:	89 75 f8             	mov    %esi,-0x8(%rbp)
   42240:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   42243:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42246:	c1 e0 10             	shl    $0x10,%eax
   42249:	89 c2                	mov    %eax,%edx
   4224b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4224e:	c1 e0 0b             	shl    $0xb,%eax
   42251:	09 c2                	or     %eax,%edx
   42253:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42256:	c1 e0 08             	shl    $0x8,%eax
   42259:	09 d0                	or     %edx,%eax
}
   4225b:	c9                   	leave  
   4225c:	c3                   	ret    

000000000004225d <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   4225d:	55                   	push   %rbp
   4225e:	48 89 e5             	mov    %rsp,%rbp
   42261:	48 83 ec 18          	sub    $0x18,%rsp
   42265:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42268:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   4226b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4226e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42271:	09 d0                	or     %edx,%eax
   42273:	0d 00 00 00 80       	or     $0x80000000,%eax
   42278:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   4227f:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42282:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42285:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42288:	ef                   	out    %eax,(%dx)
}
   42289:	90                   	nop
   4228a:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42291:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42294:	89 c2                	mov    %eax,%edx
   42296:	ed                   	in     (%dx),%eax
   42297:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4229a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4229d:	c9                   	leave  
   4229e:	c3                   	ret    

000000000004229f <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   4229f:	55                   	push   %rbp
   422a0:	48 89 e5             	mov    %rsp,%rbp
   422a3:	48 83 ec 28          	sub    $0x28,%rsp
   422a7:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422aa:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   422ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422b4:	eb 73                	jmp    42329 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   422b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   422bd:	eb 60                	jmp    4231f <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   422bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   422c6:	eb 4a                	jmp    42312 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   422c8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   422cb:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   422ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422d1:	89 ce                	mov    %ecx,%esi
   422d3:	89 c7                	mov    %eax,%edi
   422d5:	e8 58 ff ff ff       	call   42232 <pci_make_configaddr>
   422da:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   422dd:	8b 45 f0             	mov    -0x10(%rbp),%eax
   422e0:	be 00 00 00 00       	mov    $0x0,%esi
   422e5:	89 c7                	mov    %eax,%edi
   422e7:	e8 71 ff ff ff       	call   4225d <pci_config_readl>
   422ec:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   422ef:	8b 45 d8             	mov    -0x28(%rbp),%eax
   422f2:	c1 e0 10             	shl    $0x10,%eax
   422f5:	0b 45 dc             	or     -0x24(%rbp),%eax
   422f8:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   422fb:	75 05                	jne    42302 <pci_find_device+0x63>
                    return configaddr;
   422fd:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42300:	eb 35                	jmp    42337 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42302:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   42306:	75 06                	jne    4230e <pci_find_device+0x6f>
   42308:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4230c:	74 0c                	je     4231a <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   4230e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42312:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   42316:	75 b0                	jne    422c8 <pci_find_device+0x29>
   42318:	eb 01                	jmp    4231b <pci_find_device+0x7c>
                    break;
   4231a:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4231b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4231f:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42323:	75 9a                	jne    422bf <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   42325:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42329:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42330:	75 84                	jne    422b6 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   42332:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42337:	c9                   	leave  
   42338:	c3                   	ret    

0000000000042339 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   42339:	55                   	push   %rbp
   4233a:	48 89 e5             	mov    %rsp,%rbp
   4233d:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42341:	be 13 71 00 00       	mov    $0x7113,%esi
   42346:	bf 86 80 00 00       	mov    $0x8086,%edi
   4234b:	e8 4f ff ff ff       	call   4229f <pci_find_device>
   42350:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42353:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   42357:	78 30                	js     42389 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42359:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4235c:	be 40 00 00 00       	mov    $0x40,%esi
   42361:	89 c7                	mov    %eax,%edi
   42363:	e8 f5 fe ff ff       	call   4225d <pci_config_readl>
   42368:	25 c0 ff 00 00       	and    $0xffc0,%eax
   4236d:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42370:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42373:	83 c0 04             	add    $0x4,%eax
   42376:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42379:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   4237f:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42383:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42386:	66 ef                	out    %ax,(%dx)
}
   42388:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42389:	ba 00 45 04 00       	mov    $0x44500,%edx
   4238e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42393:	bf 80 07 00 00       	mov    $0x780,%edi
   42398:	b8 00 00 00 00       	mov    $0x0,%eax
   4239d:	e8 44 1c 00 00       	call   43fe6 <console_printf>
 spinloop: goto spinloop;
   423a2:	eb fe                	jmp    423a2 <poweroff+0x69>

00000000000423a4 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   423a4:	55                   	push   %rbp
   423a5:	48 89 e5             	mov    %rsp,%rbp
   423a8:	48 83 ec 10          	sub    $0x10,%rsp
   423ac:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   423b3:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423bb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423be:	ee                   	out    %al,(%dx)
}
   423bf:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   423c0:	eb fe                	jmp    423c0 <reboot+0x1c>

00000000000423c2 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   423c2:	55                   	push   %rbp
   423c3:	48 89 e5             	mov    %rsp,%rbp
   423c6:	48 83 ec 10          	sub    $0x10,%rsp
   423ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   423ce:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   423d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423d5:	48 83 c0 08          	add    $0x8,%rax
   423d9:	ba c0 00 00 00       	mov    $0xc0,%edx
   423de:	be 00 00 00 00       	mov    $0x0,%esi
   423e3:	48 89 c7             	mov    %rax,%rdi
   423e6:	e8 c6 13 00 00       	call   437b1 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   423eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423ef:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   423f6:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   423f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423fc:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42403:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   42407:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4240b:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   42412:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42416:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4241a:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42421:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42423:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42427:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   4242e:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42432:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42435:	83 e0 01             	and    $0x1,%eax
   42438:	85 c0                	test   %eax,%eax
   4243a:	74 1c                	je     42458 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4243c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42440:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42447:	80 cc 30             	or     $0x30,%ah
   4244a:	48 89 c2             	mov    %rax,%rdx
   4244d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42451:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42458:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4245b:	83 e0 02             	and    $0x2,%eax
   4245e:	85 c0                	test   %eax,%eax
   42460:	74 1c                	je     4247e <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42462:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42466:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4246d:	80 e4 fd             	and    $0xfd,%ah
   42470:	48 89 c2             	mov    %rax,%rdx
   42473:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42477:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4247e:	90                   	nop
   4247f:	c9                   	leave  
   42480:	c3                   	ret    

0000000000042481 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42481:	55                   	push   %rbp
   42482:	48 89 e5             	mov    %rsp,%rbp
   42485:	48 83 ec 28          	sub    $0x28,%rsp
   42489:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4248c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42490:	78 09                	js     4249b <console_show_cursor+0x1a>
   42492:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   42499:	7e 07                	jle    424a2 <console_show_cursor+0x21>
        cpos = 0;
   4249b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   424a2:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   424a9:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424ad:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   424b1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   424b4:	ee                   	out    %al,(%dx)
}
   424b5:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   424b6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   424b9:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   424bf:	85 c0                	test   %eax,%eax
   424c1:	0f 48 c2             	cmovs  %edx,%eax
   424c4:	c1 f8 08             	sar    $0x8,%eax
   424c7:	0f b6 c0             	movzbl %al,%eax
   424ca:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   424d1:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424d4:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   424d8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   424db:	ee                   	out    %al,(%dx)
}
   424dc:	90                   	nop
   424dd:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   424e4:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424e8:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   424ec:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424ef:	ee                   	out    %al,(%dx)
}
   424f0:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   424f1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   424f4:	99                   	cltd   
   424f5:	c1 ea 18             	shr    $0x18,%edx
   424f8:	01 d0                	add    %edx,%eax
   424fa:	0f b6 c0             	movzbl %al,%eax
   424fd:	29 d0                	sub    %edx,%eax
   424ff:	0f b6 c0             	movzbl %al,%eax
   42502:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42509:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4250c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42510:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42513:	ee                   	out    %al,(%dx)
}
   42514:	90                   	nop
}
   42515:	90                   	nop
   42516:	c9                   	leave  
   42517:	c3                   	ret    

0000000000042518 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42518:	55                   	push   %rbp
   42519:	48 89 e5             	mov    %rsp,%rbp
   4251c:	48 83 ec 20          	sub    $0x20,%rsp
   42520:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42527:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4252a:	89 c2                	mov    %eax,%edx
   4252c:	ec                   	in     (%dx),%al
   4252d:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42530:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42534:	0f b6 c0             	movzbl %al,%eax
   42537:	83 e0 01             	and    $0x1,%eax
   4253a:	85 c0                	test   %eax,%eax
   4253c:	75 0a                	jne    42548 <keyboard_readc+0x30>
        return -1;
   4253e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42543:	e9 e7 01 00 00       	jmp    4272f <keyboard_readc+0x217>
   42548:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4254f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42552:	89 c2                	mov    %eax,%edx
   42554:	ec                   	in     (%dx),%al
   42555:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42558:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4255c:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   4255f:	0f b6 05 9c dd 00 00 	movzbl 0xdd9c(%rip),%eax        # 50302 <last_escape.2>
   42566:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42569:	c6 05 92 dd 00 00 00 	movb   $0x0,0xdd92(%rip)        # 50302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42570:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42574:	75 11                	jne    42587 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42576:	c6 05 85 dd 00 00 80 	movb   $0x80,0xdd85(%rip)        # 50302 <last_escape.2>
        return 0;
   4257d:	b8 00 00 00 00       	mov    $0x0,%eax
   42582:	e9 a8 01 00 00       	jmp    4272f <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42587:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4258b:	84 c0                	test   %al,%al
   4258d:	79 60                	jns    425ef <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   4258f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42593:	83 e0 7f             	and    $0x7f,%eax
   42596:	89 c2                	mov    %eax,%edx
   42598:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4259c:	09 d0                	or     %edx,%eax
   4259e:	48 98                	cltq   
   425a0:	0f b6 80 20 45 04 00 	movzbl 0x44520(%rax),%eax
   425a7:	0f b6 c0             	movzbl %al,%eax
   425aa:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   425ad:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   425b4:	7e 2f                	jle    425e5 <keyboard_readc+0xcd>
   425b6:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   425bd:	7f 26                	jg     425e5 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   425bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   425c2:	2d fa 00 00 00       	sub    $0xfa,%eax
   425c7:	ba 01 00 00 00       	mov    $0x1,%edx
   425cc:	89 c1                	mov    %eax,%ecx
   425ce:	d3 e2                	shl    %cl,%edx
   425d0:	89 d0                	mov    %edx,%eax
   425d2:	f7 d0                	not    %eax
   425d4:	89 c2                	mov    %eax,%edx
   425d6:	0f b6 05 26 dd 00 00 	movzbl 0xdd26(%rip),%eax        # 50303 <modifiers.1>
   425dd:	21 d0                	and    %edx,%eax
   425df:	88 05 1e dd 00 00    	mov    %al,0xdd1e(%rip)        # 50303 <modifiers.1>
        }
        return 0;
   425e5:	b8 00 00 00 00       	mov    $0x0,%eax
   425ea:	e9 40 01 00 00       	jmp    4272f <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   425ef:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425f3:	0a 45 fa             	or     -0x6(%rbp),%al
   425f6:	0f b6 c0             	movzbl %al,%eax
   425f9:	48 98                	cltq   
   425fb:	0f b6 80 20 45 04 00 	movzbl 0x44520(%rax),%eax
   42602:	0f b6 c0             	movzbl %al,%eax
   42605:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42608:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4260c:	7e 57                	jle    42665 <keyboard_readc+0x14d>
   4260e:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42612:	7f 51                	jg     42665 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42614:	0f b6 05 e8 dc 00 00 	movzbl 0xdce8(%rip),%eax        # 50303 <modifiers.1>
   4261b:	0f b6 c0             	movzbl %al,%eax
   4261e:	83 e0 02             	and    $0x2,%eax
   42621:	85 c0                	test   %eax,%eax
   42623:	74 09                	je     4262e <keyboard_readc+0x116>
            ch -= 0x60;
   42625:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42629:	e9 fd 00 00 00       	jmp    4272b <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4262e:	0f b6 05 ce dc 00 00 	movzbl 0xdcce(%rip),%eax        # 50303 <modifiers.1>
   42635:	0f b6 c0             	movzbl %al,%eax
   42638:	83 e0 01             	and    $0x1,%eax
   4263b:	85 c0                	test   %eax,%eax
   4263d:	0f 94 c2             	sete   %dl
   42640:	0f b6 05 bc dc 00 00 	movzbl 0xdcbc(%rip),%eax        # 50303 <modifiers.1>
   42647:	0f b6 c0             	movzbl %al,%eax
   4264a:	83 e0 08             	and    $0x8,%eax
   4264d:	85 c0                	test   %eax,%eax
   4264f:	0f 94 c0             	sete   %al
   42652:	31 d0                	xor    %edx,%eax
   42654:	84 c0                	test   %al,%al
   42656:	0f 84 cf 00 00 00    	je     4272b <keyboard_readc+0x213>
            ch -= 0x20;
   4265c:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42660:	e9 c6 00 00 00       	jmp    4272b <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42665:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4266c:	7e 30                	jle    4269e <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4266e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42671:	2d fa 00 00 00       	sub    $0xfa,%eax
   42676:	ba 01 00 00 00       	mov    $0x1,%edx
   4267b:	89 c1                	mov    %eax,%ecx
   4267d:	d3 e2                	shl    %cl,%edx
   4267f:	89 d0                	mov    %edx,%eax
   42681:	89 c2                	mov    %eax,%edx
   42683:	0f b6 05 79 dc 00 00 	movzbl 0xdc79(%rip),%eax        # 50303 <modifiers.1>
   4268a:	31 d0                	xor    %edx,%eax
   4268c:	88 05 71 dc 00 00    	mov    %al,0xdc71(%rip)        # 50303 <modifiers.1>
        ch = 0;
   42692:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42699:	e9 8e 00 00 00       	jmp    4272c <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   4269e:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   426a5:	7e 2d                	jle    426d4 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   426a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   426aa:	2d fa 00 00 00       	sub    $0xfa,%eax
   426af:	ba 01 00 00 00       	mov    $0x1,%edx
   426b4:	89 c1                	mov    %eax,%ecx
   426b6:	d3 e2                	shl    %cl,%edx
   426b8:	89 d0                	mov    %edx,%eax
   426ba:	89 c2                	mov    %eax,%edx
   426bc:	0f b6 05 40 dc 00 00 	movzbl 0xdc40(%rip),%eax        # 50303 <modifiers.1>
   426c3:	09 d0                	or     %edx,%eax
   426c5:	88 05 38 dc 00 00    	mov    %al,0xdc38(%rip)        # 50303 <modifiers.1>
        ch = 0;
   426cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   426d2:	eb 58                	jmp    4272c <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   426d4:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   426d8:	7e 31                	jle    4270b <keyboard_readc+0x1f3>
   426da:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   426e1:	7f 28                	jg     4270b <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   426e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   426e6:	8d 50 80             	lea    -0x80(%rax),%edx
   426e9:	0f b6 05 13 dc 00 00 	movzbl 0xdc13(%rip),%eax        # 50303 <modifiers.1>
   426f0:	0f b6 c0             	movzbl %al,%eax
   426f3:	83 e0 03             	and    $0x3,%eax
   426f6:	48 98                	cltq   
   426f8:	48 63 d2             	movslq %edx,%rdx
   426fb:	0f b6 84 90 20 46 04 	movzbl 0x44620(%rax,%rdx,4),%eax
   42702:	00 
   42703:	0f b6 c0             	movzbl %al,%eax
   42706:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42709:	eb 21                	jmp    4272c <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4270b:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4270f:	7f 1b                	jg     4272c <keyboard_readc+0x214>
   42711:	0f b6 05 eb db 00 00 	movzbl 0xdbeb(%rip),%eax        # 50303 <modifiers.1>
   42718:	0f b6 c0             	movzbl %al,%eax
   4271b:	83 e0 02             	and    $0x2,%eax
   4271e:	85 c0                	test   %eax,%eax
   42720:	74 0a                	je     4272c <keyboard_readc+0x214>
        ch = 0;
   42722:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42729:	eb 01                	jmp    4272c <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   4272b:	90                   	nop
    }

    return ch;
   4272c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4272f:	c9                   	leave  
   42730:	c3                   	ret    

0000000000042731 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42731:	55                   	push   %rbp
   42732:	48 89 e5             	mov    %rsp,%rbp
   42735:	48 83 ec 20          	sub    $0x20,%rsp
   42739:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42740:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42743:	89 c2                	mov    %eax,%edx
   42745:	ec                   	in     (%dx),%al
   42746:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42749:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42750:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42753:	89 c2                	mov    %eax,%edx
   42755:	ec                   	in     (%dx),%al
   42756:	88 45 eb             	mov    %al,-0x15(%rbp)
   42759:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42760:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42763:	89 c2                	mov    %eax,%edx
   42765:	ec                   	in     (%dx),%al
   42766:	88 45 f3             	mov    %al,-0xd(%rbp)
   42769:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42770:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42773:	89 c2                	mov    %eax,%edx
   42775:	ec                   	in     (%dx),%al
   42776:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42779:	90                   	nop
   4277a:	c9                   	leave  
   4277b:	c3                   	ret    

000000000004277c <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4277c:	55                   	push   %rbp
   4277d:	48 89 e5             	mov    %rsp,%rbp
   42780:	48 83 ec 40          	sub    $0x40,%rsp
   42784:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42788:	89 f0                	mov    %esi,%eax
   4278a:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4278d:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42790:	8b 05 6e db 00 00    	mov    0xdb6e(%rip),%eax        # 50304 <initialized.0>
   42796:	85 c0                	test   %eax,%eax
   42798:	75 1e                	jne    427b8 <parallel_port_putc+0x3c>
   4279a:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   427a1:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427a5:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   427a9:	8b 55 f8             	mov    -0x8(%rbp),%edx
   427ac:	ee                   	out    %al,(%dx)
}
   427ad:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   427ae:	c7 05 4c db 00 00 01 	movl   $0x1,0xdb4c(%rip)        # 50304 <initialized.0>
   427b5:	00 00 00 
    }

    for (int i = 0;
   427b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   427bf:	eb 09                	jmp    427ca <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   427c1:	e8 6b ff ff ff       	call   42731 <delay>
         ++i) {
   427c6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   427ca:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   427d1:	7f 18                	jg     427eb <parallel_port_putc+0x6f>
   427d3:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   427da:	8b 45 f0             	mov    -0x10(%rbp),%eax
   427dd:	89 c2                	mov    %eax,%edx
   427df:	ec                   	in     (%dx),%al
   427e0:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   427e3:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   427e7:	84 c0                	test   %al,%al
   427e9:	79 d6                	jns    427c1 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   427eb:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   427ef:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   427f6:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427f9:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   427fd:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42800:	ee                   	out    %al,(%dx)
}
   42801:	90                   	nop
   42802:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42809:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4280d:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42811:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42814:	ee                   	out    %al,(%dx)
}
   42815:	90                   	nop
   42816:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   4281d:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42821:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42825:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42828:	ee                   	out    %al,(%dx)
}
   42829:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4282a:	90                   	nop
   4282b:	c9                   	leave  
   4282c:	c3                   	ret    

000000000004282d <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   4282d:	55                   	push   %rbp
   4282e:	48 89 e5             	mov    %rsp,%rbp
   42831:	48 83 ec 20          	sub    $0x20,%rsp
   42835:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42839:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   4283d:	48 c7 45 f8 7c 27 04 	movq   $0x4277c,-0x8(%rbp)
   42844:	00 
    printer_vprintf(&p, 0, format, val);
   42845:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42849:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4284d:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42851:	be 00 00 00 00       	mov    $0x0,%esi
   42856:	48 89 c7             	mov    %rax,%rdi
   42859:	e8 64 10 00 00       	call   438c2 <printer_vprintf>
}
   4285e:	90                   	nop
   4285f:	c9                   	leave  
   42860:	c3                   	ret    

0000000000042861 <log_printf>:

void log_printf(const char* format, ...) {
   42861:	55                   	push   %rbp
   42862:	48 89 e5             	mov    %rsp,%rbp
   42865:	48 83 ec 60          	sub    $0x60,%rsp
   42869:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4286d:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42871:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42875:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42879:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4287d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42881:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42888:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4288c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42890:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42894:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42898:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4289c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   428a0:	48 89 d6             	mov    %rdx,%rsi
   428a3:	48 89 c7             	mov    %rax,%rdi
   428a6:	e8 82 ff ff ff       	call   4282d <log_vprintf>
    va_end(val);
}
   428ab:	90                   	nop
   428ac:	c9                   	leave  
   428ad:	c3                   	ret    

00000000000428ae <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   428ae:	55                   	push   %rbp
   428af:	48 89 e5             	mov    %rsp,%rbp
   428b2:	48 83 ec 40          	sub    $0x40,%rsp
   428b6:	89 7d dc             	mov    %edi,-0x24(%rbp)
   428b9:	89 75 d8             	mov    %esi,-0x28(%rbp)
   428bc:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   428c0:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   428c4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   428c8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   428cc:	48 8b 0a             	mov    (%rdx),%rcx
   428cf:	48 89 08             	mov    %rcx,(%rax)
   428d2:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   428d6:	48 89 48 08          	mov    %rcx,0x8(%rax)
   428da:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   428de:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   428e2:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   428e6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428ea:	48 89 d6             	mov    %rdx,%rsi
   428ed:	48 89 c7             	mov    %rax,%rdi
   428f0:	e8 38 ff ff ff       	call   4282d <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   428f5:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   428f9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   428fd:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42900:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42903:	89 c7                	mov    %eax,%edi
   42905:	e8 97 16 00 00       	call   43fa1 <console_vprintf>
}
   4290a:	c9                   	leave  
   4290b:	c3                   	ret    

000000000004290c <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4290c:	55                   	push   %rbp
   4290d:	48 89 e5             	mov    %rsp,%rbp
   42910:	48 83 ec 60          	sub    $0x60,%rsp
   42914:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42917:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4291a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4291e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42922:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42926:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4292a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42931:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42935:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42939:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4293d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42941:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42945:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42949:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4294c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4294f:	89 c7                	mov    %eax,%edi
   42951:	e8 58 ff ff ff       	call   428ae <error_vprintf>
   42956:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42959:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4295c:	c9                   	leave  
   4295d:	c3                   	ret    

000000000004295e <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4295e:	55                   	push   %rbp
   4295f:	48 89 e5             	mov    %rsp,%rbp
   42962:	53                   	push   %rbx
   42963:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42967:	e8 ac fb ff ff       	call   42518 <keyboard_readc>
   4296c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4296f:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42973:	74 1c                	je     42991 <check_keyboard+0x33>
   42975:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42979:	74 16                	je     42991 <check_keyboard+0x33>
   4297b:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   4297f:	74 10                	je     42991 <check_keyboard+0x33>
   42981:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42985:	74 0a                	je     42991 <check_keyboard+0x33>
   42987:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4298b:	0f 85 e9 00 00 00    	jne    42a7a <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42991:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42998:	00 
        memset(pt, 0, PAGESIZE * 3);
   42999:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4299d:	ba 00 30 00 00       	mov    $0x3000,%edx
   429a2:	be 00 00 00 00       	mov    $0x0,%esi
   429a7:	48 89 c7             	mov    %rax,%rdi
   429aa:	e8 02 0e 00 00       	call   437b1 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   429af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429b3:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   429ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429be:	48 05 00 10 00 00    	add    $0x1000,%rax
   429c4:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   429cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429cf:	48 05 00 20 00 00    	add    $0x2000,%rax
   429d5:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   429dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429e0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429e4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429e8:	0f 22 d8             	mov    %rax,%cr3
}
   429eb:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   429ec:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   429f3:	48 c7 45 e8 78 46 04 	movq   $0x44678,-0x18(%rbp)
   429fa:	00 
        if (c == 'a') {
   429fb:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   429ff:	75 0a                	jne    42a0b <check_keyboard+0xad>
            argument = "allocator";
   42a01:	48 c7 45 e8 7d 46 04 	movq   $0x4467d,-0x18(%rbp)
   42a08:	00 
   42a09:	eb 2e                	jmp    42a39 <check_keyboard+0xdb>
        } else if (c == 'e') {
   42a0b:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42a0f:	75 0a                	jne    42a1b <check_keyboard+0xbd>
            argument = "forkexit";
   42a11:	48 c7 45 e8 87 46 04 	movq   $0x44687,-0x18(%rbp)
   42a18:	00 
   42a19:	eb 1e                	jmp    42a39 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42a1b:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42a1f:	75 0a                	jne    42a2b <check_keyboard+0xcd>
            argument = "test";
   42a21:	48 c7 45 e8 90 46 04 	movq   $0x44690,-0x18(%rbp)
   42a28:	00 
   42a29:	eb 0e                	jmp    42a39 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42a2b:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42a2f:	75 08                	jne    42a39 <check_keyboard+0xdb>
            argument = "test2";
   42a31:	48 c7 45 e8 95 46 04 	movq   $0x44695,-0x18(%rbp)
   42a38:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42a39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a3d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42a41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a46:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42a4a:	76 14                	jbe    42a60 <check_keyboard+0x102>
   42a4c:	ba 9b 46 04 00       	mov    $0x4469b,%edx
   42a51:	be 5c 02 00 00       	mov    $0x25c,%esi
   42a56:	bf b7 46 04 00       	mov    $0x446b7,%edi
   42a5b:	e8 1f 01 00 00       	call   42b7f <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42a60:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a64:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42a67:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42a6b:	48 89 c3             	mov    %rax,%rbx
   42a6e:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42a73:	e9 88 d5 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42a78:	eb 11                	jmp    42a8b <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42a7a:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42a7e:	74 06                	je     42a86 <check_keyboard+0x128>
   42a80:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42a84:	75 05                	jne    42a8b <check_keyboard+0x12d>
        poweroff();
   42a86:	e8 ae f8 ff ff       	call   42339 <poweroff>
    }
    return c;
   42a8b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42a8e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42a92:	c9                   	leave  
   42a93:	c3                   	ret    

0000000000042a94 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42a94:	55                   	push   %rbp
   42a95:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42a98:	e8 c1 fe ff ff       	call   4295e <check_keyboard>
   42a9d:	eb f9                	jmp    42a98 <fail+0x4>

0000000000042a9f <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42a9f:	55                   	push   %rbp
   42aa0:	48 89 e5             	mov    %rsp,%rbp
   42aa3:	48 83 ec 60          	sub    $0x60,%rsp
   42aa7:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42aab:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42aaf:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42ab3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42ab7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42abb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42abf:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42ac6:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42aca:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42ace:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42ad2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42ad6:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42adb:	0f 84 80 00 00 00    	je     42b61 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42ae1:	ba c4 46 04 00       	mov    $0x446c4,%edx
   42ae6:	be 00 c0 00 00       	mov    $0xc000,%esi
   42aeb:	bf 30 07 00 00       	mov    $0x730,%edi
   42af0:	b8 00 00 00 00       	mov    $0x0,%eax
   42af5:	e8 12 fe ff ff       	call   4290c <error_printf>
   42afa:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42afd:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42b01:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42b05:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b08:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b0d:	89 c7                	mov    %eax,%edi
   42b0f:	e8 9a fd ff ff       	call   428ae <error_vprintf>
   42b14:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42b17:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42b1a:	48 63 c1             	movslq %ecx,%rax
   42b1d:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42b24:	48 c1 e8 20          	shr    $0x20,%rax
   42b28:	c1 f8 05             	sar    $0x5,%eax
   42b2b:	89 ce                	mov    %ecx,%esi
   42b2d:	c1 fe 1f             	sar    $0x1f,%esi
   42b30:	29 f0                	sub    %esi,%eax
   42b32:	89 c2                	mov    %eax,%edx
   42b34:	89 d0                	mov    %edx,%eax
   42b36:	c1 e0 02             	shl    $0x2,%eax
   42b39:	01 d0                	add    %edx,%eax
   42b3b:	c1 e0 04             	shl    $0x4,%eax
   42b3e:	29 c1                	sub    %eax,%ecx
   42b40:	89 ca                	mov    %ecx,%edx
   42b42:	85 d2                	test   %edx,%edx
   42b44:	74 34                	je     42b7a <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42b46:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b49:	ba cc 46 04 00       	mov    $0x446cc,%edx
   42b4e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b53:	89 c7                	mov    %eax,%edi
   42b55:	b8 00 00 00 00       	mov    $0x0,%eax
   42b5a:	e8 ad fd ff ff       	call   4290c <error_printf>
   42b5f:	eb 19                	jmp    42b7a <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42b61:	ba ce 46 04 00       	mov    $0x446ce,%edx
   42b66:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b6b:	bf 30 07 00 00       	mov    $0x730,%edi
   42b70:	b8 00 00 00 00       	mov    $0x0,%eax
   42b75:	e8 92 fd ff ff       	call   4290c <error_printf>
    }

    va_end(val);
    fail();
   42b7a:	e8 15 ff ff ff       	call   42a94 <fail>

0000000000042b7f <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42b7f:	55                   	push   %rbp
   42b80:	48 89 e5             	mov    %rsp,%rbp
   42b83:	48 83 ec 20          	sub    $0x20,%rsp
   42b87:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42b8b:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42b8e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42b92:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42b96:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b9d:	48 89 c6             	mov    %rax,%rsi
   42ba0:	bf d4 46 04 00       	mov    $0x446d4,%edi
   42ba5:	b8 00 00 00 00       	mov    $0x0,%eax
   42baa:	e8 f0 fe ff ff       	call   42a9f <panic>

0000000000042baf <default_exception>:
}

void default_exception(proc* p){
   42baf:	55                   	push   %rbp
   42bb0:	48 89 e5             	mov    %rsp,%rbp
   42bb3:	48 83 ec 20          	sub    $0x20,%rsp
   42bb7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42bbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bbf:	48 83 c0 08          	add    $0x8,%rax
   42bc3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42bc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bcb:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42bd2:	48 89 c6             	mov    %rax,%rsi
   42bd5:	bf f2 46 04 00       	mov    $0x446f2,%edi
   42bda:	b8 00 00 00 00       	mov    $0x0,%eax
   42bdf:	e8 bb fe ff ff       	call   42a9f <panic>

0000000000042be4 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42be4:	55                   	push   %rbp
   42be5:	48 89 e5             	mov    %rsp,%rbp
   42be8:	48 83 ec 10          	sub    $0x10,%rsp
   42bec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42bf0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42bf3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42bf7:	78 06                	js     42bff <pageindex+0x1b>
   42bf9:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42bfd:	7e 14                	jle    42c13 <pageindex+0x2f>
   42bff:	ba 10 47 04 00       	mov    $0x44710,%edx
   42c04:	be 1e 00 00 00       	mov    $0x1e,%esi
   42c09:	bf 29 47 04 00       	mov    $0x44729,%edi
   42c0e:	e8 6c ff ff ff       	call   42b7f <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42c13:	b8 03 00 00 00       	mov    $0x3,%eax
   42c18:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42c1b:	89 c2                	mov    %eax,%edx
   42c1d:	89 d0                	mov    %edx,%eax
   42c1f:	c1 e0 03             	shl    $0x3,%eax
   42c22:	01 d0                	add    %edx,%eax
   42c24:	83 c0 0c             	add    $0xc,%eax
   42c27:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42c2b:	89 c1                	mov    %eax,%ecx
   42c2d:	48 d3 ea             	shr    %cl,%rdx
   42c30:	48 89 d0             	mov    %rdx,%rax
   42c33:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42c38:	c9                   	leave  
   42c39:	c3                   	ret    

0000000000042c3a <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42c3a:	55                   	push   %rbp
   42c3b:	48 89 e5             	mov    %rsp,%rbp
   42c3e:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42c42:	48 c7 05 b3 e3 00 00 	movq   $0x52000,0xe3b3(%rip)        # 51000 <kernel_pagetable>
   42c49:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42c4d:	ba 00 50 00 00       	mov    $0x5000,%edx
   42c52:	be 00 00 00 00       	mov    $0x0,%esi
   42c57:	bf 00 20 05 00       	mov    $0x52000,%edi
   42c5c:	e8 50 0b 00 00       	call   437b1 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42c61:	b8 00 30 05 00       	mov    $0x53000,%eax
   42c66:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42c6a:	48 89 05 8f f3 00 00 	mov    %rax,0xf38f(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42c71:	b8 00 40 05 00       	mov    $0x54000,%eax
   42c76:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42c7a:	48 89 05 7f 03 01 00 	mov    %rax,0x1037f(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42c81:	b8 00 50 05 00       	mov    $0x55000,%eax
   42c86:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42c8a:	48 89 05 6f 13 01 00 	mov    %rax,0x1136f(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42c91:	b8 00 60 05 00       	mov    $0x56000,%eax
   42c96:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42c9a:	48 89 05 67 13 01 00 	mov    %rax,0x11367(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42ca1:	48 8b 05 58 e3 00 00 	mov    0xe358(%rip),%rax        # 51000 <kernel_pagetable>
   42ca8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42cae:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42cb3:	ba 00 00 00 00       	mov    $0x0,%edx
   42cb8:	be 00 00 00 00       	mov    $0x0,%esi
   42cbd:	48 89 c7             	mov    %rax,%rdi
   42cc0:	e8 b9 01 00 00       	call   42e7e <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42cc5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42ccc:	00 
   42ccd:	eb 62                	jmp    42d31 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42ccf:	48 8b 0d 2a e3 00 00 	mov    0xe32a(%rip),%rcx        # 51000 <kernel_pagetable>
   42cd6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42cda:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42cde:	48 89 ce             	mov    %rcx,%rsi
   42ce1:	48 89 c7             	mov    %rax,%rdi
   42ce4:	e8 50 05 00 00       	call   43239 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42ce9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ced:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42cf1:	74 14                	je     42d07 <virtual_memory_init+0xcd>
   42cf3:	ba 32 47 04 00       	mov    $0x44732,%edx
   42cf8:	be 2d 00 00 00       	mov    $0x2d,%esi
   42cfd:	bf 42 47 04 00       	mov    $0x44742,%edi
   42d02:	e8 78 fe ff ff       	call   42b7f <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42d07:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42d0a:	48 98                	cltq   
   42d0c:	83 e0 03             	and    $0x3,%eax
   42d0f:	48 83 f8 03          	cmp    $0x3,%rax
   42d13:	74 14                	je     42d29 <virtual_memory_init+0xef>
   42d15:	ba 48 47 04 00       	mov    $0x44748,%edx
   42d1a:	be 2e 00 00 00       	mov    $0x2e,%esi
   42d1f:	bf 42 47 04 00       	mov    $0x44742,%edi
   42d24:	e8 56 fe ff ff       	call   42b7f <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42d29:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42d30:	00 
   42d31:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42d38:	00 
   42d39:	76 94                	jbe    42ccf <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42d3b:	48 8b 05 be e2 00 00 	mov    0xe2be(%rip),%rax        # 51000 <kernel_pagetable>
   42d42:	48 89 c7             	mov    %rax,%rdi
   42d45:	e8 03 00 00 00       	call   42d4d <set_pagetable>
}
   42d4a:	90                   	nop
   42d4b:	c9                   	leave  
   42d4c:	c3                   	ret    

0000000000042d4d <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42d4d:	55                   	push   %rbp
   42d4e:	48 89 e5             	mov    %rsp,%rbp
   42d51:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42d55:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42d59:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d5d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d62:	48 85 c0             	test   %rax,%rax
   42d65:	74 14                	je     42d7b <set_pagetable+0x2e>
   42d67:	ba 75 47 04 00       	mov    $0x44775,%edx
   42d6c:	be 3d 00 00 00       	mov    $0x3d,%esi
   42d71:	bf 42 47 04 00       	mov    $0x44742,%edi
   42d76:	e8 04 fe ff ff       	call   42b7f <assert_fail>
    // check for kernel space being mapped in pagetable
    // log_printf("pagetable pa: %p\n", virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa);
    // log_printf("default pa: %p\n", (uintptr_t) default_int_handler);

    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42d7b:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42d80:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42d84:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42d88:	48 89 ce             	mov    %rcx,%rsi
   42d8b:	48 89 c7             	mov    %rax,%rdi
   42d8e:	e8 a6 04 00 00       	call   43239 <virtual_memory_lookup>
   42d93:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42d97:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42d9c:	48 39 d0             	cmp    %rdx,%rax
   42d9f:	74 14                	je     42db5 <set_pagetable+0x68>
   42da1:	ba 90 47 04 00       	mov    $0x44790,%edx
   42da6:	be 42 00 00 00       	mov    $0x42,%esi
   42dab:	bf 42 47 04 00       	mov    $0x44742,%edi
   42db0:	e8 ca fd ff ff       	call   42b7f <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42db5:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42db9:	48 8b 0d 40 e2 00 00 	mov    0xe240(%rip),%rcx        # 51000 <kernel_pagetable>
   42dc0:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42dc4:	48 89 ce             	mov    %rcx,%rsi
   42dc7:	48 89 c7             	mov    %rax,%rdi
   42dca:	e8 6a 04 00 00       	call   43239 <virtual_memory_lookup>
   42dcf:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42dd3:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42dd7:	48 39 c2             	cmp    %rax,%rdx
   42dda:	74 14                	je     42df0 <set_pagetable+0xa3>
   42ddc:	ba f8 47 04 00       	mov    $0x447f8,%edx
   42de1:	be 44 00 00 00       	mov    $0x44,%esi
   42de6:	bf 42 47 04 00       	mov    $0x44742,%edi
   42deb:	e8 8f fd ff ff       	call   42b7f <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42df0:	48 8b 05 09 e2 00 00 	mov    0xe209(%rip),%rax        # 51000 <kernel_pagetable>
   42df7:	48 89 c2             	mov    %rax,%rdx
   42dfa:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42dfe:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42e02:	48 89 ce             	mov    %rcx,%rsi
   42e05:	48 89 c7             	mov    %rax,%rdi
   42e08:	e8 2c 04 00 00       	call   43239 <virtual_memory_lookup>
   42e0d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e11:	48 8b 15 e8 e1 00 00 	mov    0xe1e8(%rip),%rdx        # 51000 <kernel_pagetable>
   42e18:	48 39 d0             	cmp    %rdx,%rax
   42e1b:	74 14                	je     42e31 <set_pagetable+0xe4>
   42e1d:	ba 58 48 04 00       	mov    $0x44858,%edx
   42e22:	be 46 00 00 00       	mov    $0x46,%esi
   42e27:	bf 42 47 04 00       	mov    $0x44742,%edi
   42e2c:	e8 4e fd ff ff       	call   42b7f <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42e31:	ba 7e 2e 04 00       	mov    $0x42e7e,%edx
   42e36:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42e3a:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42e3e:	48 89 ce             	mov    %rcx,%rsi
   42e41:	48 89 c7             	mov    %rax,%rdi
   42e44:	e8 f0 03 00 00       	call   43239 <virtual_memory_lookup>
   42e49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e4d:	ba 7e 2e 04 00       	mov    $0x42e7e,%edx
   42e52:	48 39 d0             	cmp    %rdx,%rax
   42e55:	74 14                	je     42e6b <set_pagetable+0x11e>
   42e57:	ba c0 48 04 00       	mov    $0x448c0,%edx
   42e5c:	be 48 00 00 00       	mov    $0x48,%esi
   42e61:	bf 42 47 04 00       	mov    $0x44742,%edi
   42e66:	e8 14 fd ff ff       	call   42b7f <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42e6b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42e6f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42e73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e77:	0f 22 d8             	mov    %rax,%cr3
}
   42e7a:	90                   	nop
}
   42e7b:	90                   	nop
   42e7c:	c9                   	leave  
   42e7d:	c3                   	ret    

0000000000042e7e <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42e7e:	55                   	push   %rbp
   42e7f:	48 89 e5             	mov    %rsp,%rbp
   42e82:	53                   	push   %rbx
   42e83:	48 83 ec 58          	sub    $0x58,%rsp
   42e87:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e8b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e8f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42e93:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42e97:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42e9b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e9f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ea4:	48 85 c0             	test   %rax,%rax
   42ea7:	74 14                	je     42ebd <virtual_memory_map+0x3f>
   42ea9:	ba 26 49 04 00       	mov    $0x44926,%edx
   42eae:	be 69 00 00 00       	mov    $0x69,%esi
   42eb3:	bf 42 47 04 00       	mov    $0x44742,%edi
   42eb8:	e8 c2 fc ff ff       	call   42b7f <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42ebd:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ec1:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ec6:	48 85 c0             	test   %rax,%rax
   42ec9:	74 14                	je     42edf <virtual_memory_map+0x61>
   42ecb:	ba 39 49 04 00       	mov    $0x44939,%edx
   42ed0:	be 6a 00 00 00       	mov    $0x6a,%esi
   42ed5:	bf 42 47 04 00       	mov    $0x44742,%edi
   42eda:	e8 a0 fc ff ff       	call   42b7f <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42edf:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ee3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ee7:	48 01 d0             	add    %rdx,%rax
   42eea:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42eee:	76 24                	jbe    42f14 <virtual_memory_map+0x96>
   42ef0:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ef4:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ef8:	48 01 d0             	add    %rdx,%rax
   42efb:	48 85 c0             	test   %rax,%rax
   42efe:	74 14                	je     42f14 <virtual_memory_map+0x96>
   42f00:	ba 4c 49 04 00       	mov    $0x4494c,%edx
   42f05:	be 6b 00 00 00       	mov    $0x6b,%esi
   42f0a:	bf 42 47 04 00       	mov    $0x44742,%edi
   42f0f:	e8 6b fc ff ff       	call   42b7f <assert_fail>
    if (perm & PTE_P) {
   42f14:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f17:	48 98                	cltq   
   42f19:	83 e0 01             	and    $0x1,%eax
   42f1c:	48 85 c0             	test   %rax,%rax
   42f1f:	74 6e                	je     42f8f <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42f21:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42f25:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f2a:	48 85 c0             	test   %rax,%rax
   42f2d:	74 14                	je     42f43 <virtual_memory_map+0xc5>
   42f2f:	ba 6a 49 04 00       	mov    $0x4496a,%edx
   42f34:	be 6d 00 00 00       	mov    $0x6d,%esi
   42f39:	bf 42 47 04 00       	mov    $0x44742,%edi
   42f3e:	e8 3c fc ff ff       	call   42b7f <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42f43:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f47:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f4b:	48 01 d0             	add    %rdx,%rax
   42f4e:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42f52:	76 14                	jbe    42f68 <virtual_memory_map+0xea>
   42f54:	ba 7d 49 04 00       	mov    $0x4497d,%edx
   42f59:	be 6e 00 00 00       	mov    $0x6e,%esi
   42f5e:	bf 42 47 04 00       	mov    $0x44742,%edi
   42f63:	e8 17 fc ff ff       	call   42b7f <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42f68:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f6c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f70:	48 01 d0             	add    %rdx,%rax
   42f73:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42f79:	76 14                	jbe    42f8f <virtual_memory_map+0x111>
   42f7b:	ba 8b 49 04 00       	mov    $0x4498b,%edx
   42f80:	be 6f 00 00 00       	mov    $0x6f,%esi
   42f85:	bf 42 47 04 00       	mov    $0x44742,%edi
   42f8a:	e8 f0 fb ff ff       	call   42b7f <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42f8f:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42f93:	78 09                	js     42f9e <virtual_memory_map+0x120>
   42f95:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42f9c:	7e 14                	jle    42fb2 <virtual_memory_map+0x134>
   42f9e:	ba a7 49 04 00       	mov    $0x449a7,%edx
   42fa3:	be 71 00 00 00       	mov    $0x71,%esi
   42fa8:	bf 42 47 04 00       	mov    $0x44742,%edi
   42fad:	e8 cd fb ff ff       	call   42b7f <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42fb2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42fb6:	25 ff 0f 00 00       	and    $0xfff,%eax
   42fbb:	48 85 c0             	test   %rax,%rax
   42fbe:	74 14                	je     42fd4 <virtual_memory_map+0x156>
   42fc0:	ba c8 49 04 00       	mov    $0x449c8,%edx
   42fc5:	be 72 00 00 00       	mov    $0x72,%esi
   42fca:	bf 42 47 04 00       	mov    $0x44742,%edi
   42fcf:	e8 ab fb ff ff       	call   42b7f <assert_fail>

    int last_index123 = -1;
   42fd4:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42fdb:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42fe2:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42fe3:	e9 e1 00 00 00       	jmp    430c9 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42fe8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42fec:	48 c1 e8 15          	shr    $0x15,%rax
   42ff0:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42ff3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ff6:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42ff9:	74 20                	je     4301b <virtual_memory_map+0x19d>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   42ffb:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42ffe:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43002:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43006:	48 89 ce             	mov    %rcx,%rsi
   43009:	48 89 c7             	mov    %rax,%rdi
   4300c:	e8 ce 00 00 00       	call   430df <lookup_l1pagetable>
   43011:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   43015:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43018:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   4301b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4301e:	48 98                	cltq   
   43020:	83 e0 01             	and    $0x1,%eax
   43023:	48 85 c0             	test   %rax,%rax
   43026:	74 34                	je     4305c <virtual_memory_map+0x1de>
   43028:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4302d:	74 2d                	je     4305c <virtual_memory_map+0x1de>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
            l1pagetable->entry[L1PAGEINDEX(va)] = pa | perm;
   4302f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43032:	48 63 d8             	movslq %eax,%rbx
   43035:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43039:	be 03 00 00 00       	mov    $0x3,%esi
   4303e:	48 89 c7             	mov    %rax,%rdi
   43041:	e8 9e fb ff ff       	call   42be4 <pageindex>
   43046:	89 c2                	mov    %eax,%edx
   43048:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   4304c:	48 89 d9             	mov    %rbx,%rcx
   4304f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43053:	48 63 d2             	movslq %edx,%rdx
   43056:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4305a:	eb 55                	jmp    430b1 <virtual_memory_map+0x233>

        } else if (l1pagetable) { // if page is NOT marked present
   4305c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43061:	74 26                	je     43089 <virtual_memory_map+0x20b>
            // TODO
            // map to address 0 with `perm`
            l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   43063:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43067:	be 03 00 00 00       	mov    $0x3,%esi
   4306c:	48 89 c7             	mov    %rax,%rdi
   4306f:	e8 70 fb ff ff       	call   42be4 <pageindex>
   43074:	89 c2                	mov    %eax,%edx
   43076:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43079:	48 63 c8             	movslq %eax,%rcx
   4307c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43080:	48 63 d2             	movslq %edx,%rdx
   43083:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43087:	eb 28                	jmp    430b1 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   43089:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4308c:	48 98                	cltq   
   4308e:	83 e0 01             	and    $0x1,%eax
   43091:	48 85 c0             	test   %rax,%rax
   43094:	74 1b                	je     430b1 <virtual_memory_map+0x233>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43096:	be 8b 00 00 00       	mov    $0x8b,%esi
   4309b:	bf f0 49 04 00       	mov    $0x449f0,%edi
   430a0:	b8 00 00 00 00       	mov    $0x0,%eax
   430a5:	e8 b7 f7 ff ff       	call   42861 <log_printf>
            return -1;
   430aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   430af:	eb 28                	jmp    430d9 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   430b1:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   430b8:	00 
   430b9:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   430c0:	00 
   430c1:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   430c8:	00 
   430c9:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   430ce:	0f 85 14 ff ff ff    	jne    42fe8 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   430d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
   430d9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   430dd:	c9                   	leave  
   430de:	c3                   	ret    

00000000000430df <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   430df:	55                   	push   %rbp
   430e0:	48 89 e5             	mov    %rsp,%rbp
   430e3:	48 83 ec 40          	sub    $0x40,%rsp
   430e7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   430eb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   430ef:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   430f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   430f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   430fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   43101:	e9 23 01 00 00       	jmp    43229 <lookup_l1pagetable+0x14a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   43106:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43109:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4310d:	89 d6                	mov    %edx,%esi
   4310f:	48 89 c7             	mov    %rax,%rdi
   43112:	e8 cd fa ff ff       	call   42be4 <pageindex>
   43117:	89 c2                	mov    %eax,%edx
   43119:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4311d:	48 63 d2             	movslq %edx,%rdx
   43120:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   43124:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   43128:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4312c:	83 e0 01             	and    $0x1,%eax
   4312f:	48 85 c0             	test   %rax,%rax
   43132:	75 63                	jne    43197 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   43134:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43137:	8d 48 02             	lea    0x2(%rax),%ecx
   4313a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4313e:	25 ff 0f 00 00       	and    $0xfff,%eax
   43143:	48 89 c2             	mov    %rax,%rdx
   43146:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4314a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43150:	48 89 c6             	mov    %rax,%rsi
   43153:	bf 30 4a 04 00       	mov    $0x44a30,%edi
   43158:	b8 00 00 00 00       	mov    $0x0,%eax
   4315d:	e8 ff f6 ff ff       	call   42861 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43162:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43165:	48 98                	cltq   
   43167:	83 e0 01             	and    $0x1,%eax
   4316a:	48 85 c0             	test   %rax,%rax
   4316d:	75 0a                	jne    43179 <lookup_l1pagetable+0x9a>
                return NULL;
   4316f:	b8 00 00 00 00       	mov    $0x0,%eax
   43174:	e9 be 00 00 00       	jmp    43237 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43179:	be af 00 00 00       	mov    $0xaf,%esi
   4317e:	bf 98 4a 04 00       	mov    $0x44a98,%edi
   43183:	b8 00 00 00 00       	mov    $0x0,%eax
   43188:	e8 d4 f6 ff ff       	call   42861 <log_printf>
            return NULL;
   4318d:	b8 00 00 00 00       	mov    $0x0,%eax
   43192:	e9 a0 00 00 00       	jmp    43237 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4319b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   431a1:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   431a7:	76 14                	jbe    431bd <lookup_l1pagetable+0xde>
   431a9:	ba d8 4a 04 00       	mov    $0x44ad8,%edx
   431ae:	be b4 00 00 00       	mov    $0xb4,%esi
   431b3:	bf 42 47 04 00       	mov    $0x44742,%edi
   431b8:	e8 c2 f9 ff ff       	call   42b7f <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   431bd:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431c0:	48 98                	cltq   
   431c2:	83 e0 02             	and    $0x2,%eax
   431c5:	48 85 c0             	test   %rax,%rax
   431c8:	74 20                	je     431ea <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   431ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431ce:	83 e0 02             	and    $0x2,%eax
   431d1:	48 85 c0             	test   %rax,%rax
   431d4:	75 14                	jne    431ea <lookup_l1pagetable+0x10b>
   431d6:	ba f8 4a 04 00       	mov    $0x44af8,%edx
   431db:	be b6 00 00 00       	mov    $0xb6,%esi
   431e0:	bf 42 47 04 00       	mov    $0x44742,%edi
   431e5:	e8 95 f9 ff ff       	call   42b7f <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   431ea:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431ed:	48 98                	cltq   
   431ef:	83 e0 04             	and    $0x4,%eax
   431f2:	48 85 c0             	test   %rax,%rax
   431f5:	74 20                	je     43217 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   431f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431fb:	83 e0 04             	and    $0x4,%eax
   431fe:	48 85 c0             	test   %rax,%rax
   43201:	75 14                	jne    43217 <lookup_l1pagetable+0x138>
   43203:	ba 03 4b 04 00       	mov    $0x44b03,%edx
   43208:	be b9 00 00 00       	mov    $0xb9,%esi
   4320d:	bf 42 47 04 00       	mov    $0x44742,%edi
   43212:	e8 68 f9 ff ff       	call   42b7f <assert_fail>
        }

        // TODO
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable*) PTE_ADDR(pe); // replace this
   43217:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4321b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43221:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43225:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43229:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4322d:	0f 8e d3 fe ff ff    	jle    43106 <lookup_l1pagetable+0x27>
    }
    return pt;
   43233:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43237:	c9                   	leave  
   43238:	c3                   	ret    

0000000000043239 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43239:	55                   	push   %rbp
   4323a:	48 89 e5             	mov    %rsp,%rbp
   4323d:	48 83 ec 50          	sub    $0x50,%rsp
   43241:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43245:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   43249:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4324d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43251:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43255:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4325c:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4325d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43264:	eb 41                	jmp    432a7 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43266:	8b 55 ec             	mov    -0x14(%rbp),%edx
   43269:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4326d:	89 d6                	mov    %edx,%esi
   4326f:	48 89 c7             	mov    %rax,%rdi
   43272:	e8 6d f9 ff ff       	call   42be4 <pageindex>
   43277:	89 c2                	mov    %eax,%edx
   43279:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4327d:	48 63 d2             	movslq %edx,%rdx
   43280:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43284:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43288:	83 e0 06             	and    $0x6,%eax
   4328b:	48 f7 d0             	not    %rax
   4328e:	48 21 d0             	and    %rdx,%rax
   43291:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43295:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43299:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4329f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   432a3:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   432a7:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   432ab:	7f 0c                	jg     432b9 <virtual_memory_lookup+0x80>
   432ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432b1:	83 e0 01             	and    $0x1,%eax
   432b4:	48 85 c0             	test   %rax,%rax
   432b7:	75 ad                	jne    43266 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   432b9:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   432c0:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   432c7:	ff 
   432c8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   432cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d3:	83 e0 01             	and    $0x1,%eax
   432d6:	48 85 c0             	test   %rax,%rax
   432d9:	74 34                	je     4330f <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   432db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432df:	48 c1 e8 0c          	shr    $0xc,%rax
   432e3:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   432e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432f0:	48 89 c2             	mov    %rax,%rdx
   432f3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   432f7:	25 ff 0f 00 00       	and    $0xfff,%eax
   432fc:	48 09 d0             	or     %rdx,%rax
   432ff:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43303:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43307:	25 ff 0f 00 00       	and    $0xfff,%eax
   4330c:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   4330f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43313:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43317:	48 89 10             	mov    %rdx,(%rax)
   4331a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4331e:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43322:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43326:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   4332a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4332e:	c9                   	leave  
   4332f:	c3                   	ret    

0000000000043330 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43330:	55                   	push   %rbp
   43331:	48 89 e5             	mov    %rsp,%rbp
   43334:	48 83 ec 40          	sub    $0x40,%rsp
   43338:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4333c:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   4333f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43343:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   4334a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4334e:	78 08                	js     43358 <program_load+0x28>
   43350:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43353:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   43356:	7c 14                	jl     4336c <program_load+0x3c>
   43358:	ba 10 4b 04 00       	mov    $0x44b10,%edx
   4335d:	be 37 00 00 00       	mov    $0x37,%esi
   43362:	bf 40 4b 04 00       	mov    $0x44b40,%edi
   43367:	e8 13 f8 ff ff       	call   42b7f <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4336c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4336f:	48 98                	cltq   
   43371:	48 c1 e0 04          	shl    $0x4,%rax
   43375:	48 05 20 50 04 00    	add    $0x45020,%rax
   4337b:	48 8b 00             	mov    (%rax),%rax
   4337e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43382:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43386:	8b 00                	mov    (%rax),%eax
   43388:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   4338d:	74 14                	je     433a3 <program_load+0x73>
   4338f:	ba 4b 4b 04 00       	mov    $0x44b4b,%edx
   43394:	be 39 00 00 00       	mov    $0x39,%esi
   43399:	bf 40 4b 04 00       	mov    $0x44b40,%edi
   4339e:	e8 dc f7 ff ff       	call   42b7f <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   433a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433a7:	48 8b 50 20          	mov    0x20(%rax),%rdx
   433ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433af:	48 01 d0             	add    %rdx,%rax
   433b2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   433b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   433bd:	e9 94 00 00 00       	jmp    43456 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   433c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433c5:	48 63 d0             	movslq %eax,%rdx
   433c8:	48 89 d0             	mov    %rdx,%rax
   433cb:	48 c1 e0 03          	shl    $0x3,%rax
   433cf:	48 29 d0             	sub    %rdx,%rax
   433d2:	48 c1 e0 03          	shl    $0x3,%rax
   433d6:	48 89 c2             	mov    %rax,%rdx
   433d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433dd:	48 01 d0             	add    %rdx,%rax
   433e0:	8b 00                	mov    (%rax),%eax
   433e2:	83 f8 01             	cmp    $0x1,%eax
   433e5:	75 6b                	jne    43452 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   433e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433ea:	48 63 d0             	movslq %eax,%rdx
   433ed:	48 89 d0             	mov    %rdx,%rax
   433f0:	48 c1 e0 03          	shl    $0x3,%rax
   433f4:	48 29 d0             	sub    %rdx,%rax
   433f7:	48 c1 e0 03          	shl    $0x3,%rax
   433fb:	48 89 c2             	mov    %rax,%rdx
   433fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43402:	48 01 d0             	add    %rdx,%rax
   43405:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43409:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4340d:	48 01 d0             	add    %rdx,%rax
   43410:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43414:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43417:	48 63 d0             	movslq %eax,%rdx
   4341a:	48 89 d0             	mov    %rdx,%rax
   4341d:	48 c1 e0 03          	shl    $0x3,%rax
   43421:	48 29 d0             	sub    %rdx,%rax
   43424:	48 c1 e0 03          	shl    $0x3,%rax
   43428:	48 89 c2             	mov    %rax,%rdx
   4342b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4342f:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43433:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43437:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4343b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4343f:	48 89 c7             	mov    %rax,%rdi
   43442:	e8 3d 00 00 00       	call   43484 <program_load_segment>
   43447:	85 c0                	test   %eax,%eax
   43449:	79 07                	jns    43452 <program_load+0x122>
                return -1;
   4344b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43450:	eb 30                	jmp    43482 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43452:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4345a:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4345e:	0f b7 c0             	movzwl %ax,%eax
   43461:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43464:	0f 8c 58 ff ff ff    	jl     433c2 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4346a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4346e:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43472:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43476:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4347d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43482:	c9                   	leave  
   43483:	c3                   	ret    

0000000000043484 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43484:	55                   	push   %rbp
   43485:	48 89 e5             	mov    %rsp,%rbp
   43488:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4348c:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43490:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43494:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   43498:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4349c:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   434a0:	48 8b 40 10          	mov    0x10(%rax),%rax
   434a4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   434a8:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   434ac:	48 8b 50 20          	mov    0x20(%rax),%rdx
   434b0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434b4:	48 01 d0             	add    %rdx,%rax
   434b7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   434bb:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   434bf:	48 8b 50 28          	mov    0x28(%rax),%rdx
   434c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434c7:	48 01 d0             	add    %rdx,%rax
   434ca:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   434ce:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   434d5:	ff 

    
    // allocate memory

    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) 
   434d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   434de:	e9 84 00 00 00       	jmp    43567 <program_load_segment+0xe3>
    {
        uintptr_t next_page_addr = get_physical_page_addr(p->p_pid);
   434e3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   434e7:	8b 00                	mov    (%rax),%eax
   434e9:	0f be c0             	movsbl %al,%eax
   434ec:	89 c7                	mov    %eax,%edi
   434ee:	e8 0d d6 ff ff       	call   40b00 <get_physical_page_addr>
   434f3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

        int res = virtual_memory_map(p->p_pagetable, addr, next_page_addr,
   434f7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   434fb:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43502:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   43506:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4350a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43510:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43515:	48 89 c7             	mov    %rax,%rdi
   43518:	e8 61 f9 ff ff       	call   42e7e <virtual_memory_map>
   4351d:	89 45 bc             	mov    %eax,-0x44(%rbp)
                PAGESIZE, PTE_P | PTE_W | PTE_U);

        if (next_page_addr == 0xffffffffffffffff || res < 0) 
   43520:	48 83 7d c0 ff       	cmpq   $0xffffffffffffffff,-0x40(%rbp)
   43525:	74 06                	je     4352d <program_load_segment+0xa9>
   43527:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4352b:	79 32                	jns    4355f <program_load_segment+0xdb>
        { 
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4352d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43531:	8b 00                	mov    (%rax),%eax
   43533:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43537:	49 89 d0             	mov    %rdx,%r8
   4353a:	89 c1                	mov    %eax,%ecx
   4353c:	ba 68 4b 04 00       	mov    $0x44b68,%edx
   43541:	be 00 c0 00 00       	mov    $0xc000,%esi
   43546:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4354b:	b8 00 00 00 00       	mov    $0x0,%eax
   43550:	e8 91 0a 00 00       	call   43fe6 <console_printf>
            return -1;
   43555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4355a:	e9 4b 01 00 00       	jmp    436aa <program_load_segment+0x226>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) 
   4355f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43566:	00 
   43567:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4356b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4356f:	0f 82 6e ff ff ff    	jb     434e3 <program_load_segment+0x5f>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43575:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43579:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43580:	48 89 c7             	mov    %rax,%rdi
   43583:	e8 c5 f7 ff ff       	call   42d4d <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43588:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4358c:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43590:	48 89 c2             	mov    %rax,%rdx
   43593:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43597:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4359b:	48 89 ce             	mov    %rcx,%rsi
   4359e:	48 89 c7             	mov    %rax,%rdi
   435a1:	e8 a2 01 00 00       	call   43748 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   435a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   435aa:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   435ae:	48 89 c2             	mov    %rax,%rdx
   435b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435b5:	be 00 00 00 00       	mov    $0x0,%esi
   435ba:	48 89 c7             	mov    %rax,%rdi
   435bd:	e8 ef 01 00 00       	call   437b1 <memset>

    set_pagetable(kernel_pagetable);
   435c2:	48 8b 05 37 da 00 00 	mov    0xda37(%rip),%rax        # 51000 <kernel_pagetable>
   435c9:	48 89 c7             	mov    %rax,%rdi
   435cc:	e8 7c f7 ff ff       	call   42d4d <set_pagetable>

    int map_read_only = 0;
   435d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) map_read_only = 1;
   435d8:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   435dc:	8b 40 04             	mov    0x4(%rax),%eax
   435df:	83 e0 02             	and    $0x2,%eax
   435e2:	85 c0                	test   %eax,%eax
   435e4:	75 07                	jne    435ed <program_load_segment+0x169>
   435e6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)

    // now that we've memsetted, according to aidan's advice, no change permissions
    if (map_read_only) // if this is a read_only process segment, permissions
   435ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   435f1:	0f 84 9f 00 00 00    	je     43696 <program_load_segment+0x212>
    {
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) 
   435f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435fb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   435ff:	e9 84 00 00 00       	jmp    43688 <program_load_segment+0x204>
        {
            vamapping vmap = virtual_memory_lookup(p->p_pagetable, addr);
   43604:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43608:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4360f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   43613:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43617:	48 89 ce             	mov    %rcx,%rsi
   4361a:	48 89 c7             	mov    %rax,%rdi
   4361d:	e8 17 fc ff ff       	call   43239 <virtual_memory_lookup>
            int map_res = virtual_memory_map(p->p_pagetable, addr, vmap.pa, PAGESIZE,
   43622:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   43626:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4362a:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43631:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   43635:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4363b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43640:	48 89 c7             	mov    %rax,%rdi
   43643:	e8 36 f8 ff ff       	call   42e7e <virtual_memory_map>
   43648:	89 45 cc             	mov    %eax,-0x34(%rbp)
                                      PTE_P | PTE_U);
            if (map_res < 0)
   4364b:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   4364f:	79 2f                	jns    43680 <program_load_segment+0x1fc>
            {
                console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43651:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43655:	8b 00                	mov    (%rax),%eax
   43657:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4365b:	49 89 d0             	mov    %rdx,%r8
   4365e:	89 c1                	mov    %eax,%ecx
   43660:	ba 68 4b 04 00       	mov    $0x44b68,%edx
   43665:	be 00 c0 00 00       	mov    $0xc000,%esi
   4366a:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4366f:	b8 00 00 00 00       	mov    $0x0,%eax
   43674:	e8 6d 09 00 00       	call   43fe6 <console_printf>
                return -1;
   43679:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4367e:	eb 2a                	jmp    436aa <program_load_segment+0x226>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) 
   43680:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   43687:	00 
   43688:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4368c:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43690:	0f 82 6e ff ff ff    	jb     43604 <program_load_segment+0x180>
    // permissions, you need to change them after those two lines
    // after the memcpy and memset


    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43696:	48 8b 05 63 d9 00 00 	mov    0xd963(%rip),%rax        # 51000 <kernel_pagetable>
   4369d:	48 89 c7             	mov    %rax,%rdi
   436a0:	e8 a8 f6 ff ff       	call   42d4d <set_pagetable>
    return 0;
   436a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
   436aa:	c9                   	leave  
   436ab:	c3                   	ret    

00000000000436ac <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   436ac:	48 89 f9             	mov    %rdi,%rcx
   436af:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   436b1:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   436b8:	00 
   436b9:	72 08                	jb     436c3 <console_putc+0x17>
        cp->cursor = console;
   436bb:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   436c2:	00 
    }
    if (c == '\n') {
   436c3:	40 80 fe 0a          	cmp    $0xa,%sil
   436c7:	74 16                	je     436df <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   436c9:	48 8b 41 08          	mov    0x8(%rcx),%rax
   436cd:	48 8d 50 02          	lea    0x2(%rax),%rdx
   436d1:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   436d5:	40 0f b6 f6          	movzbl %sil,%esi
   436d9:	09 fe                	or     %edi,%esi
   436db:	66 89 30             	mov    %si,(%rax)
    }
}
   436de:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
   436df:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   436e3:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   436ea:	4c 89 c6             	mov    %r8,%rsi
   436ed:	48 d1 fe             	sar    %rsi
   436f0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   436f7:	66 66 66 
   436fa:	48 89 f0             	mov    %rsi,%rax
   436fd:	48 f7 ea             	imul   %rdx
   43700:	48 c1 fa 05          	sar    $0x5,%rdx
   43704:	49 c1 f8 3f          	sar    $0x3f,%r8
   43708:	4c 29 c2             	sub    %r8,%rdx
   4370b:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   4370f:	48 c1 e2 04          	shl    $0x4,%rdx
   43713:	89 f0                	mov    %esi,%eax
   43715:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   43717:	83 cf 20             	or     $0x20,%edi
   4371a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4371e:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   43722:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   43726:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   43729:	83 c0 01             	add    $0x1,%eax
   4372c:	83 f8 50             	cmp    $0x50,%eax
   4372f:	75 e9                	jne    4371a <console_putc+0x6e>
   43731:	c3                   	ret    

0000000000043732 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   43732:	48 8b 47 08          	mov    0x8(%rdi),%rax
   43736:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   4373a:	73 0b                	jae    43747 <string_putc+0x15>
        *sp->s++ = c;
   4373c:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43740:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   43744:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   43747:	c3                   	ret    

0000000000043748 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   43748:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4374b:	48 85 d2             	test   %rdx,%rdx
   4374e:	74 17                	je     43767 <memcpy+0x1f>
   43750:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   43755:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   4375a:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4375e:	48 83 c1 01          	add    $0x1,%rcx
   43762:	48 39 d1             	cmp    %rdx,%rcx
   43765:	75 ee                	jne    43755 <memcpy+0xd>
}
   43767:	c3                   	ret    

0000000000043768 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   43768:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   4376b:	48 39 fe             	cmp    %rdi,%rsi
   4376e:	72 1d                	jb     4378d <memmove+0x25>
        while (n-- > 0) {
   43770:	b9 00 00 00 00       	mov    $0x0,%ecx
   43775:	48 85 d2             	test   %rdx,%rdx
   43778:	74 12                	je     4378c <memmove+0x24>
            *d++ = *s++;
   4377a:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   4377e:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   43782:	48 83 c1 01          	add    $0x1,%rcx
   43786:	48 39 ca             	cmp    %rcx,%rdx
   43789:	75 ef                	jne    4377a <memmove+0x12>
}
   4378b:	c3                   	ret    
   4378c:	c3                   	ret    
    if (s < d && s + n > d) {
   4378d:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   43791:	48 39 cf             	cmp    %rcx,%rdi
   43794:	73 da                	jae    43770 <memmove+0x8>
        while (n-- > 0) {
   43796:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   4379a:	48 85 d2             	test   %rdx,%rdx
   4379d:	74 ec                	je     4378b <memmove+0x23>
            *--d = *--s;
   4379f:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   437a3:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   437a6:	48 83 e9 01          	sub    $0x1,%rcx
   437aa:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   437ae:	75 ef                	jne    4379f <memmove+0x37>
   437b0:	c3                   	ret    

00000000000437b1 <memset>:
void* memset(void* v, int c, size_t n) {
   437b1:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   437b4:	48 85 d2             	test   %rdx,%rdx
   437b7:	74 12                	je     437cb <memset+0x1a>
   437b9:	48 01 fa             	add    %rdi,%rdx
   437bc:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   437bf:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   437c2:	48 83 c1 01          	add    $0x1,%rcx
   437c6:	48 39 ca             	cmp    %rcx,%rdx
   437c9:	75 f4                	jne    437bf <memset+0xe>
}
   437cb:	c3                   	ret    

00000000000437cc <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   437cc:	80 3f 00             	cmpb   $0x0,(%rdi)
   437cf:	74 10                	je     437e1 <strlen+0x15>
   437d1:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   437d6:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   437da:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   437de:	75 f6                	jne    437d6 <strlen+0xa>
   437e0:	c3                   	ret    
   437e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
   437e6:	c3                   	ret    

00000000000437e7 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   437e7:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   437ea:	ba 00 00 00 00       	mov    $0x0,%edx
   437ef:	48 85 f6             	test   %rsi,%rsi
   437f2:	74 11                	je     43805 <strnlen+0x1e>
   437f4:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   437f8:	74 0c                	je     43806 <strnlen+0x1f>
        ++n;
   437fa:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   437fe:	48 39 d0             	cmp    %rdx,%rax
   43801:	75 f1                	jne    437f4 <strnlen+0xd>
   43803:	eb 04                	jmp    43809 <strnlen+0x22>
   43805:	c3                   	ret    
   43806:	48 89 d0             	mov    %rdx,%rax
}
   43809:	c3                   	ret    

000000000004380a <strcpy>:
char* strcpy(char* dst, const char* src) {
   4380a:	48 89 f8             	mov    %rdi,%rax
   4380d:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   43812:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   43816:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   43819:	48 83 c2 01          	add    $0x1,%rdx
   4381d:	84 c9                	test   %cl,%cl
   4381f:	75 f1                	jne    43812 <strcpy+0x8>
}
   43821:	c3                   	ret    

0000000000043822 <strcmp>:
    while (*a && *b && *a == *b) {
   43822:	0f b6 07             	movzbl (%rdi),%eax
   43825:	84 c0                	test   %al,%al
   43827:	74 1a                	je     43843 <strcmp+0x21>
   43829:	0f b6 16             	movzbl (%rsi),%edx
   4382c:	38 c2                	cmp    %al,%dl
   4382e:	75 13                	jne    43843 <strcmp+0x21>
   43830:	84 d2                	test   %dl,%dl
   43832:	74 0f                	je     43843 <strcmp+0x21>
        ++a, ++b;
   43834:	48 83 c7 01          	add    $0x1,%rdi
   43838:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   4383c:	0f b6 07             	movzbl (%rdi),%eax
   4383f:	84 c0                	test   %al,%al
   43841:	75 e6                	jne    43829 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   43843:	3a 06                	cmp    (%rsi),%al
   43845:	0f 97 c0             	seta   %al
   43848:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   4384b:	83 d8 00             	sbb    $0x0,%eax
}
   4384e:	c3                   	ret    

000000000004384f <strchr>:
    while (*s && *s != (char) c) {
   4384f:	0f b6 07             	movzbl (%rdi),%eax
   43852:	84 c0                	test   %al,%al
   43854:	74 10                	je     43866 <strchr+0x17>
   43856:	40 38 f0             	cmp    %sil,%al
   43859:	74 18                	je     43873 <strchr+0x24>
        ++s;
   4385b:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   4385f:	0f b6 07             	movzbl (%rdi),%eax
   43862:	84 c0                	test   %al,%al
   43864:	75 f0                	jne    43856 <strchr+0x7>
        return NULL;
   43866:	40 84 f6             	test   %sil,%sil
   43869:	b8 00 00 00 00       	mov    $0x0,%eax
   4386e:	48 0f 44 c7          	cmove  %rdi,%rax
}
   43872:	c3                   	ret    
   43873:	48 89 f8             	mov    %rdi,%rax
   43876:	c3                   	ret    

0000000000043877 <rand>:
    if (!rand_seed_set) {
   43877:	83 3d 86 37 01 00 00 	cmpl   $0x0,0x13786(%rip)        # 57004 <rand_seed_set>
   4387e:	74 1b                	je     4389b <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43880:	69 05 76 37 01 00 0d 	imul   $0x19660d,0x13776(%rip),%eax        # 57000 <rand_seed>
   43887:	66 19 00 
   4388a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4388f:	89 05 6b 37 01 00    	mov    %eax,0x1376b(%rip)        # 57000 <rand_seed>
    return rand_seed & RAND_MAX;
   43895:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4389a:	c3                   	ret    
    rand_seed = seed;
   4389b:	c7 05 5b 37 01 00 9e 	movl   $0x30d4879e,0x1375b(%rip)        # 57000 <rand_seed>
   438a2:	87 d4 30 
    rand_seed_set = 1;
   438a5:	c7 05 55 37 01 00 01 	movl   $0x1,0x13755(%rip)        # 57004 <rand_seed_set>
   438ac:	00 00 00 
}
   438af:	eb cf                	jmp    43880 <rand+0x9>

00000000000438b1 <srand>:
    rand_seed = seed;
   438b1:	89 3d 49 37 01 00    	mov    %edi,0x13749(%rip)        # 57000 <rand_seed>
    rand_seed_set = 1;
   438b7:	c7 05 43 37 01 00 01 	movl   $0x1,0x13743(%rip)        # 57004 <rand_seed_set>
   438be:	00 00 00 
}
   438c1:	c3                   	ret    

00000000000438c2 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   438c2:	55                   	push   %rbp
   438c3:	48 89 e5             	mov    %rsp,%rbp
   438c6:	41 57                	push   %r15
   438c8:	41 56                	push   %r14
   438ca:	41 55                	push   %r13
   438cc:	41 54                	push   %r12
   438ce:	53                   	push   %rbx
   438cf:	48 83 ec 58          	sub    $0x58,%rsp
   438d3:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   438d7:	0f b6 02             	movzbl (%rdx),%eax
   438da:	84 c0                	test   %al,%al
   438dc:	0f 84 b0 06 00 00    	je     43f92 <printer_vprintf+0x6d0>
   438e2:	49 89 fe             	mov    %rdi,%r14
   438e5:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   438e8:	41 89 f7             	mov    %esi,%r15d
   438eb:	e9 a4 04 00 00       	jmp    43d94 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   438f0:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   438f5:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   438fb:	45 84 e4             	test   %r12b,%r12b
   438fe:	0f 84 82 06 00 00    	je     43f86 <printer_vprintf+0x6c4>
        int flags = 0;
   43904:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   4390a:	41 0f be f4          	movsbl %r12b,%esi
   4390e:	bf a1 4d 04 00       	mov    $0x44da1,%edi
   43913:	e8 37 ff ff ff       	call   4384f <strchr>
   43918:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   4391b:	48 85 c0             	test   %rax,%rax
   4391e:	74 55                	je     43975 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   43920:	48 81 e9 a1 4d 04 00 	sub    $0x44da1,%rcx
   43927:	b8 01 00 00 00       	mov    $0x1,%eax
   4392c:	d3 e0                	shl    %cl,%eax
   4392e:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   43931:	48 83 c3 01          	add    $0x1,%rbx
   43935:	44 0f b6 23          	movzbl (%rbx),%r12d
   43939:	45 84 e4             	test   %r12b,%r12b
   4393c:	75 cc                	jne    4390a <printer_vprintf+0x48>
   4393e:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   43942:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   43948:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   4394f:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   43952:	0f 84 a9 00 00 00    	je     43a01 <printer_vprintf+0x13f>
        int length = 0;
   43958:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   4395d:	0f b6 13             	movzbl (%rbx),%edx
   43960:	8d 42 bd             	lea    -0x43(%rdx),%eax
   43963:	3c 37                	cmp    $0x37,%al
   43965:	0f 87 c4 04 00 00    	ja     43e2f <printer_vprintf+0x56d>
   4396b:	0f b6 c0             	movzbl %al,%eax
   4396e:	ff 24 c5 b0 4b 04 00 	jmp    *0x44bb0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   43975:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   43979:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   4397e:	3c 08                	cmp    $0x8,%al
   43980:	77 2f                	ja     439b1 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43982:	0f b6 03             	movzbl (%rbx),%eax
   43985:	8d 50 d0             	lea    -0x30(%rax),%edx
   43988:	80 fa 09             	cmp    $0x9,%dl
   4398b:	77 5e                	ja     439eb <printer_vprintf+0x129>
   4398d:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   43993:	48 83 c3 01          	add    $0x1,%rbx
   43997:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   4399c:	0f be c0             	movsbl %al,%eax
   4399f:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   439a4:	0f b6 03             	movzbl (%rbx),%eax
   439a7:	8d 50 d0             	lea    -0x30(%rax),%edx
   439aa:	80 fa 09             	cmp    $0x9,%dl
   439ad:	76 e4                	jbe    43993 <printer_vprintf+0xd1>
   439af:	eb 97                	jmp    43948 <printer_vprintf+0x86>
        } else if (*format == '*') {
   439b1:	41 80 fc 2a          	cmp    $0x2a,%r12b
   439b5:	75 3f                	jne    439f6 <printer_vprintf+0x134>
            width = va_arg(val, int);
   439b7:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   439bb:	8b 07                	mov    (%rdi),%eax
   439bd:	83 f8 2f             	cmp    $0x2f,%eax
   439c0:	77 17                	ja     439d9 <printer_vprintf+0x117>
   439c2:	89 c2                	mov    %eax,%edx
   439c4:	48 03 57 10          	add    0x10(%rdi),%rdx
   439c8:	83 c0 08             	add    $0x8,%eax
   439cb:	89 07                	mov    %eax,(%rdi)
   439cd:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   439d0:	48 83 c3 01          	add    $0x1,%rbx
   439d4:	e9 6f ff ff ff       	jmp    43948 <printer_vprintf+0x86>
            width = va_arg(val, int);
   439d9:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   439dd:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   439e1:	48 8d 42 08          	lea    0x8(%rdx),%rax
   439e5:	48 89 41 08          	mov    %rax,0x8(%rcx)
   439e9:	eb e2                	jmp    439cd <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   439eb:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   439f1:	e9 52 ff ff ff       	jmp    43948 <printer_vprintf+0x86>
        int width = -1;
   439f6:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   439fc:	e9 47 ff ff ff       	jmp    43948 <printer_vprintf+0x86>
            ++format;
   43a01:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   43a05:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43a09:	8d 48 d0             	lea    -0x30(%rax),%ecx
   43a0c:	80 f9 09             	cmp    $0x9,%cl
   43a0f:	76 13                	jbe    43a24 <printer_vprintf+0x162>
            } else if (*format == '*') {
   43a11:	3c 2a                	cmp    $0x2a,%al
   43a13:	74 33                	je     43a48 <printer_vprintf+0x186>
            ++format;
   43a15:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   43a18:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   43a1f:	e9 34 ff ff ff       	jmp    43958 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a24:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   43a29:	48 83 c2 01          	add    $0x1,%rdx
   43a2d:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   43a30:	0f be c0             	movsbl %al,%eax
   43a33:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a37:	0f b6 02             	movzbl (%rdx),%eax
   43a3a:	8d 70 d0             	lea    -0x30(%rax),%esi
   43a3d:	40 80 fe 09          	cmp    $0x9,%sil
   43a41:	76 e6                	jbe    43a29 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   43a43:	48 89 d3             	mov    %rdx,%rbx
   43a46:	eb 1c                	jmp    43a64 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   43a48:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43a4c:	8b 07                	mov    (%rdi),%eax
   43a4e:	83 f8 2f             	cmp    $0x2f,%eax
   43a51:	77 23                	ja     43a76 <printer_vprintf+0x1b4>
   43a53:	89 c2                	mov    %eax,%edx
   43a55:	48 03 57 10          	add    0x10(%rdi),%rdx
   43a59:	83 c0 08             	add    $0x8,%eax
   43a5c:	89 07                	mov    %eax,(%rdi)
   43a5e:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43a60:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   43a64:	85 c9                	test   %ecx,%ecx
   43a66:	b8 00 00 00 00       	mov    $0x0,%eax
   43a6b:	0f 49 c1             	cmovns %ecx,%eax
   43a6e:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43a71:	e9 e2 fe ff ff       	jmp    43958 <printer_vprintf+0x96>
                precision = va_arg(val, int);
   43a76:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43a7a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43a7e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43a82:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43a86:	eb d6                	jmp    43a5e <printer_vprintf+0x19c>
        switch (*format) {
   43a88:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43a8d:	e9 f3 00 00 00       	jmp    43b85 <printer_vprintf+0x2c3>
            ++format;
   43a92:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   43a96:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   43a9b:	e9 bd fe ff ff       	jmp    4395d <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43aa0:	85 c9                	test   %ecx,%ecx
   43aa2:	74 55                	je     43af9 <printer_vprintf+0x237>
   43aa4:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43aa8:	8b 07                	mov    (%rdi),%eax
   43aaa:	83 f8 2f             	cmp    $0x2f,%eax
   43aad:	77 38                	ja     43ae7 <printer_vprintf+0x225>
   43aaf:	89 c2                	mov    %eax,%edx
   43ab1:	48 03 57 10          	add    0x10(%rdi),%rdx
   43ab5:	83 c0 08             	add    $0x8,%eax
   43ab8:	89 07                	mov    %eax,(%rdi)
   43aba:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43abd:	48 89 d0             	mov    %rdx,%rax
   43ac0:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   43ac4:	49 89 d0             	mov    %rdx,%r8
   43ac7:	49 f7 d8             	neg    %r8
   43aca:	25 80 00 00 00       	and    $0x80,%eax
   43acf:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43ad3:	0b 45 a8             	or     -0x58(%rbp),%eax
   43ad6:	83 c8 60             	or     $0x60,%eax
   43ad9:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   43adc:	41 bc a7 4b 04 00    	mov    $0x44ba7,%r12d
            break;
   43ae2:	e9 35 01 00 00       	jmp    43c1c <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43ae7:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43aeb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43aef:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43af3:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43af7:	eb c1                	jmp    43aba <printer_vprintf+0x1f8>
   43af9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43afd:	8b 07                	mov    (%rdi),%eax
   43aff:	83 f8 2f             	cmp    $0x2f,%eax
   43b02:	77 10                	ja     43b14 <printer_vprintf+0x252>
   43b04:	89 c2                	mov    %eax,%edx
   43b06:	48 03 57 10          	add    0x10(%rdi),%rdx
   43b0a:	83 c0 08             	add    $0x8,%eax
   43b0d:	89 07                	mov    %eax,(%rdi)
   43b0f:	48 63 12             	movslq (%rdx),%rdx
   43b12:	eb a9                	jmp    43abd <printer_vprintf+0x1fb>
   43b14:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43b18:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43b1c:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43b20:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43b24:	eb e9                	jmp    43b0f <printer_vprintf+0x24d>
        int base = 10;
   43b26:	be 0a 00 00 00       	mov    $0xa,%esi
   43b2b:	eb 58                	jmp    43b85 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43b2d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43b31:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43b35:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43b39:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43b3d:	eb 60                	jmp    43b9f <printer_vprintf+0x2dd>
   43b3f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43b43:	8b 07                	mov    (%rdi),%eax
   43b45:	83 f8 2f             	cmp    $0x2f,%eax
   43b48:	77 10                	ja     43b5a <printer_vprintf+0x298>
   43b4a:	89 c2                	mov    %eax,%edx
   43b4c:	48 03 57 10          	add    0x10(%rdi),%rdx
   43b50:	83 c0 08             	add    $0x8,%eax
   43b53:	89 07                	mov    %eax,(%rdi)
   43b55:	44 8b 02             	mov    (%rdx),%r8d
   43b58:	eb 48                	jmp    43ba2 <printer_vprintf+0x2e0>
   43b5a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43b5e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43b62:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43b66:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43b6a:	eb e9                	jmp    43b55 <printer_vprintf+0x293>
   43b6c:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43b6f:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   43b76:	bf 90 4d 04 00       	mov    $0x44d90,%edi
   43b7b:	e9 e2 02 00 00       	jmp    43e62 <printer_vprintf+0x5a0>
            base = 16;
   43b80:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43b85:	85 c9                	test   %ecx,%ecx
   43b87:	74 b6                	je     43b3f <printer_vprintf+0x27d>
   43b89:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43b8d:	8b 01                	mov    (%rcx),%eax
   43b8f:	83 f8 2f             	cmp    $0x2f,%eax
   43b92:	77 99                	ja     43b2d <printer_vprintf+0x26b>
   43b94:	89 c2                	mov    %eax,%edx
   43b96:	48 03 51 10          	add    0x10(%rcx),%rdx
   43b9a:	83 c0 08             	add    $0x8,%eax
   43b9d:	89 01                	mov    %eax,(%rcx)
   43b9f:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43ba2:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43ba6:	85 f6                	test   %esi,%esi
   43ba8:	79 c2                	jns    43b6c <printer_vprintf+0x2aa>
        base = -base;
   43baa:	41 89 f1             	mov    %esi,%r9d
   43bad:	f7 de                	neg    %esi
   43baf:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43bb6:	bf 70 4d 04 00       	mov    $0x44d70,%edi
   43bbb:	e9 a2 02 00 00       	jmp    43e62 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   43bc0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43bc4:	8b 07                	mov    (%rdi),%eax
   43bc6:	83 f8 2f             	cmp    $0x2f,%eax
   43bc9:	77 1c                	ja     43be7 <printer_vprintf+0x325>
   43bcb:	89 c2                	mov    %eax,%edx
   43bcd:	48 03 57 10          	add    0x10(%rdi),%rdx
   43bd1:	83 c0 08             	add    $0x8,%eax
   43bd4:	89 07                	mov    %eax,(%rdi)
   43bd6:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43bd9:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   43be0:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43be5:	eb c3                	jmp    43baa <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   43be7:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43beb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43bef:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43bf3:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43bf7:	eb dd                	jmp    43bd6 <printer_vprintf+0x314>
            data = va_arg(val, char*);
   43bf9:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43bfd:	8b 01                	mov    (%rcx),%eax
   43bff:	83 f8 2f             	cmp    $0x2f,%eax
   43c02:	0f 87 a5 01 00 00    	ja     43dad <printer_vprintf+0x4eb>
   43c08:	89 c2                	mov    %eax,%edx
   43c0a:	48 03 51 10          	add    0x10(%rcx),%rdx
   43c0e:	83 c0 08             	add    $0x8,%eax
   43c11:	89 01                	mov    %eax,(%rcx)
   43c13:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   43c16:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   43c1c:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43c1f:	83 e0 20             	and    $0x20,%eax
   43c22:	89 45 8c             	mov    %eax,-0x74(%rbp)
   43c25:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   43c2b:	0f 85 21 02 00 00    	jne    43e52 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43c31:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43c34:	89 45 88             	mov    %eax,-0x78(%rbp)
   43c37:	83 e0 60             	and    $0x60,%eax
   43c3a:	83 f8 60             	cmp    $0x60,%eax
   43c3d:	0f 84 54 02 00 00    	je     43e97 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43c43:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43c46:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43c49:	48 c7 45 a0 a7 4b 04 	movq   $0x44ba7,-0x60(%rbp)
   43c50:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43c51:	83 f8 21             	cmp    $0x21,%eax
   43c54:	0f 84 79 02 00 00    	je     43ed3 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43c5a:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   43c5d:	89 f8                	mov    %edi,%eax
   43c5f:	f7 d0                	not    %eax
   43c61:	c1 e8 1f             	shr    $0x1f,%eax
   43c64:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43c67:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43c6b:	0f 85 9e 02 00 00    	jne    43f0f <printer_vprintf+0x64d>
   43c71:	84 c0                	test   %al,%al
   43c73:	0f 84 96 02 00 00    	je     43f0f <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   43c79:	48 63 f7             	movslq %edi,%rsi
   43c7c:	4c 89 e7             	mov    %r12,%rdi
   43c7f:	e8 63 fb ff ff       	call   437e7 <strnlen>
   43c84:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43c87:	8b 45 88             	mov    -0x78(%rbp),%eax
   43c8a:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   43c8d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43c94:	83 f8 22             	cmp    $0x22,%eax
   43c97:	0f 84 aa 02 00 00    	je     43f47 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   43c9d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43ca1:	e8 26 fb ff ff       	call   437cc <strlen>
   43ca6:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43ca9:	03 55 98             	add    -0x68(%rbp),%edx
   43cac:	44 89 e9             	mov    %r13d,%ecx
   43caf:	29 d1                	sub    %edx,%ecx
   43cb1:	29 c1                	sub    %eax,%ecx
   43cb3:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   43cb6:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43cb9:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   43cbd:	75 2d                	jne    43cec <printer_vprintf+0x42a>
   43cbf:	85 c9                	test   %ecx,%ecx
   43cc1:	7e 29                	jle    43cec <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   43cc3:	44 89 fa             	mov    %r15d,%edx
   43cc6:	be 20 00 00 00       	mov    $0x20,%esi
   43ccb:	4c 89 f7             	mov    %r14,%rdi
   43cce:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43cd1:	41 83 ed 01          	sub    $0x1,%r13d
   43cd5:	45 85 ed             	test   %r13d,%r13d
   43cd8:	7f e9                	jg     43cc3 <printer_vprintf+0x401>
   43cda:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   43cdd:	85 ff                	test   %edi,%edi
   43cdf:	b8 01 00 00 00       	mov    $0x1,%eax
   43ce4:	0f 4f c7             	cmovg  %edi,%eax
   43ce7:	29 c7                	sub    %eax,%edi
   43ce9:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   43cec:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43cf0:	0f b6 07             	movzbl (%rdi),%eax
   43cf3:	84 c0                	test   %al,%al
   43cf5:	74 22                	je     43d19 <printer_vprintf+0x457>
   43cf7:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43cfb:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   43cfe:	0f b6 f0             	movzbl %al,%esi
   43d01:	44 89 fa             	mov    %r15d,%edx
   43d04:	4c 89 f7             	mov    %r14,%rdi
   43d07:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
   43d0a:	48 83 c3 01          	add    $0x1,%rbx
   43d0e:	0f b6 03             	movzbl (%rbx),%eax
   43d11:	84 c0                	test   %al,%al
   43d13:	75 e9                	jne    43cfe <printer_vprintf+0x43c>
   43d15:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43d19:	8b 45 9c             	mov    -0x64(%rbp),%eax
   43d1c:	85 c0                	test   %eax,%eax
   43d1e:	7e 1d                	jle    43d3d <printer_vprintf+0x47b>
   43d20:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43d24:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   43d26:	44 89 fa             	mov    %r15d,%edx
   43d29:	be 30 00 00 00       	mov    $0x30,%esi
   43d2e:	4c 89 f7             	mov    %r14,%rdi
   43d31:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
   43d34:	83 eb 01             	sub    $0x1,%ebx
   43d37:	75 ed                	jne    43d26 <printer_vprintf+0x464>
   43d39:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   43d3d:	8b 45 98             	mov    -0x68(%rbp),%eax
   43d40:	85 c0                	test   %eax,%eax
   43d42:	7e 27                	jle    43d6b <printer_vprintf+0x4a9>
   43d44:	89 c0                	mov    %eax,%eax
   43d46:	4c 01 e0             	add    %r12,%rax
   43d49:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43d4d:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43d50:	41 0f b6 34 24       	movzbl (%r12),%esi
   43d55:	44 89 fa             	mov    %r15d,%edx
   43d58:	4c 89 f7             	mov    %r14,%rdi
   43d5b:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
   43d5e:	49 83 c4 01          	add    $0x1,%r12
   43d62:	49 39 dc             	cmp    %rbx,%r12
   43d65:	75 e9                	jne    43d50 <printer_vprintf+0x48e>
   43d67:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43d6b:	45 85 ed             	test   %r13d,%r13d
   43d6e:	7e 14                	jle    43d84 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43d70:	44 89 fa             	mov    %r15d,%edx
   43d73:	be 20 00 00 00       	mov    $0x20,%esi
   43d78:	4c 89 f7             	mov    %r14,%rdi
   43d7b:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
   43d7e:	41 83 ed 01          	sub    $0x1,%r13d
   43d82:	75 ec                	jne    43d70 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   43d84:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43d88:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43d8c:	84 c0                	test   %al,%al
   43d8e:	0f 84 fe 01 00 00    	je     43f92 <printer_vprintf+0x6d0>
        if (*format != '%') {
   43d94:	3c 25                	cmp    $0x25,%al
   43d96:	0f 84 54 fb ff ff    	je     438f0 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   43d9c:	0f b6 f0             	movzbl %al,%esi
   43d9f:	44 89 fa             	mov    %r15d,%edx
   43da2:	4c 89 f7             	mov    %r14,%rdi
   43da5:	41 ff 16             	call   *(%r14)
            continue;
   43da8:	4c 89 e3             	mov    %r12,%rbx
   43dab:	eb d7                	jmp    43d84 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   43dad:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43db1:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43db5:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43db9:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43dbd:	e9 51 fe ff ff       	jmp    43c13 <printer_vprintf+0x351>
            color = va_arg(val, int);
   43dc2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43dc6:	8b 07                	mov    (%rdi),%eax
   43dc8:	83 f8 2f             	cmp    $0x2f,%eax
   43dcb:	77 10                	ja     43ddd <printer_vprintf+0x51b>
   43dcd:	89 c2                	mov    %eax,%edx
   43dcf:	48 03 57 10          	add    0x10(%rdi),%rdx
   43dd3:	83 c0 08             	add    $0x8,%eax
   43dd6:	89 07                	mov    %eax,(%rdi)
   43dd8:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   43ddb:	eb a7                	jmp    43d84 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   43ddd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43de1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43de5:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43de9:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43ded:	eb e9                	jmp    43dd8 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   43def:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43df3:	8b 01                	mov    (%rcx),%eax
   43df5:	83 f8 2f             	cmp    $0x2f,%eax
   43df8:	77 23                	ja     43e1d <printer_vprintf+0x55b>
   43dfa:	89 c2                	mov    %eax,%edx
   43dfc:	48 03 51 10          	add    0x10(%rcx),%rdx
   43e00:	83 c0 08             	add    $0x8,%eax
   43e03:	89 01                	mov    %eax,(%rcx)
   43e05:	8b 02                	mov    (%rdx),%eax
   43e07:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43e0a:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43e0e:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43e12:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43e18:	e9 ff fd ff ff       	jmp    43c1c <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   43e1d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43e21:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43e25:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43e29:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43e2d:	eb d6                	jmp    43e05 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   43e2f:	84 d2                	test   %dl,%dl
   43e31:	0f 85 39 01 00 00    	jne    43f70 <printer_vprintf+0x6ae>
   43e37:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   43e3b:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   43e3f:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   43e43:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43e47:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43e4d:	e9 ca fd ff ff       	jmp    43c1c <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   43e52:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   43e58:	bf 90 4d 04 00       	mov    $0x44d90,%edi
        if (flags & FLAG_NUMERIC) {
   43e5d:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   43e62:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   43e66:	4c 89 c1             	mov    %r8,%rcx
   43e69:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   43e6d:	48 63 f6             	movslq %esi,%rsi
   43e70:	49 83 ec 01          	sub    $0x1,%r12
   43e74:	48 89 c8             	mov    %rcx,%rax
   43e77:	ba 00 00 00 00       	mov    $0x0,%edx
   43e7c:	48 f7 f6             	div    %rsi
   43e7f:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   43e83:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   43e87:	48 89 ca             	mov    %rcx,%rdx
   43e8a:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   43e8d:	48 39 d6             	cmp    %rdx,%rsi
   43e90:	76 de                	jbe    43e70 <printer_vprintf+0x5ae>
   43e92:	e9 9a fd ff ff       	jmp    43c31 <printer_vprintf+0x36f>
                prefix = "-";
   43e97:	48 c7 45 a0 a4 4b 04 	movq   $0x44ba4,-0x60(%rbp)
   43e9e:	00 
            if (flags & FLAG_NEGATIVE) {
   43e9f:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43ea2:	a8 80                	test   $0x80,%al
   43ea4:	0f 85 b0 fd ff ff    	jne    43c5a <printer_vprintf+0x398>
                prefix = "+";
   43eaa:	48 c7 45 a0 9f 4b 04 	movq   $0x44b9f,-0x60(%rbp)
   43eb1:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43eb2:	a8 10                	test   $0x10,%al
   43eb4:	0f 85 a0 fd ff ff    	jne    43c5a <printer_vprintf+0x398>
                prefix = " ";
   43eba:	a8 08                	test   $0x8,%al
   43ebc:	ba a7 4b 04 00       	mov    $0x44ba7,%edx
   43ec1:	b8 a6 4b 04 00       	mov    $0x44ba6,%eax
   43ec6:	48 0f 44 c2          	cmove  %rdx,%rax
   43eca:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43ece:	e9 87 fd ff ff       	jmp    43c5a <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   43ed3:	41 8d 41 10          	lea    0x10(%r9),%eax
   43ed7:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   43edc:	0f 85 78 fd ff ff    	jne    43c5a <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   43ee2:	4d 85 c0             	test   %r8,%r8
   43ee5:	75 0d                	jne    43ef4 <printer_vprintf+0x632>
   43ee7:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   43eee:	0f 84 66 fd ff ff    	je     43c5a <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   43ef4:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   43ef8:	ba a8 4b 04 00       	mov    $0x44ba8,%edx
   43efd:	b8 a1 4b 04 00       	mov    $0x44ba1,%eax
   43f02:	48 0f 44 c2          	cmove  %rdx,%rax
   43f06:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43f0a:	e9 4b fd ff ff       	jmp    43c5a <printer_vprintf+0x398>
            len = strlen(data);
   43f0f:	4c 89 e7             	mov    %r12,%rdi
   43f12:	e8 b5 f8 ff ff       	call   437cc <strlen>
   43f17:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43f1a:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43f1e:	0f 84 63 fd ff ff    	je     43c87 <printer_vprintf+0x3c5>
   43f24:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43f28:	0f 84 59 fd ff ff    	je     43c87 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   43f2e:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   43f31:	89 ca                	mov    %ecx,%edx
   43f33:	29 c2                	sub    %eax,%edx
   43f35:	39 c1                	cmp    %eax,%ecx
   43f37:	b8 00 00 00 00       	mov    $0x0,%eax
   43f3c:	0f 4e d0             	cmovle %eax,%edx
   43f3f:	89 55 9c             	mov    %edx,-0x64(%rbp)
   43f42:	e9 56 fd ff ff       	jmp    43c9d <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   43f47:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43f4b:	e8 7c f8 ff ff       	call   437cc <strlen>
   43f50:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43f53:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43f56:	44 89 e9             	mov    %r13d,%ecx
   43f59:	29 f9                	sub    %edi,%ecx
   43f5b:	29 c1                	sub    %eax,%ecx
   43f5d:	44 39 ea             	cmp    %r13d,%edx
   43f60:	b8 00 00 00 00       	mov    $0x0,%eax
   43f65:	0f 4d c8             	cmovge %eax,%ecx
   43f68:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   43f6b:	e9 2d fd ff ff       	jmp    43c9d <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43f70:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43f73:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43f77:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43f7b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43f81:	e9 96 fc ff ff       	jmp    43c1c <printer_vprintf+0x35a>
        int flags = 0;
   43f86:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   43f8d:	e9 b0 f9 ff ff       	jmp    43942 <printer_vprintf+0x80>
}
   43f92:	48 83 c4 58          	add    $0x58,%rsp
   43f96:	5b                   	pop    %rbx
   43f97:	41 5c                	pop    %r12
   43f99:	41 5d                	pop    %r13
   43f9b:	41 5e                	pop    %r14
   43f9d:	41 5f                	pop    %r15
   43f9f:	5d                   	pop    %rbp
   43fa0:	c3                   	ret    

0000000000043fa1 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43fa1:	55                   	push   %rbp
   43fa2:	48 89 e5             	mov    %rsp,%rbp
   43fa5:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   43fa9:	48 c7 45 f0 ac 36 04 	movq   $0x436ac,-0x10(%rbp)
   43fb0:	00 
        cpos = 0;
   43fb1:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   43fb7:	b8 00 00 00 00       	mov    $0x0,%eax
   43fbc:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   43fbf:	48 63 ff             	movslq %edi,%rdi
   43fc2:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   43fc9:	00 
   43fca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43fce:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   43fd2:	e8 eb f8 ff ff       	call   438c2 <printer_vprintf>
    return cp.cursor - console;
   43fd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fdb:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43fe1:	48 d1 f8             	sar    %rax
}
   43fe4:	c9                   	leave  
   43fe5:	c3                   	ret    

0000000000043fe6 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   43fe6:	55                   	push   %rbp
   43fe7:	48 89 e5             	mov    %rsp,%rbp
   43fea:	48 83 ec 50          	sub    $0x50,%rsp
   43fee:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43ff2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43ff6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   43ffa:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44001:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44005:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44009:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4400d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44011:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44015:	e8 87 ff ff ff       	call   43fa1 <console_vprintf>
}
   4401a:	c9                   	leave  
   4401b:	c3                   	ret    

000000000004401c <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4401c:	55                   	push   %rbp
   4401d:	48 89 e5             	mov    %rsp,%rbp
   44020:	53                   	push   %rbx
   44021:	48 83 ec 28          	sub    $0x28,%rsp
   44025:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   44028:	48 c7 45 d8 32 37 04 	movq   $0x43732,-0x28(%rbp)
   4402f:	00 
    sp.s = s;
   44030:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   44034:	48 85 f6             	test   %rsi,%rsi
   44037:	75 0b                	jne    44044 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   44039:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4403c:	29 d8                	sub    %ebx,%eax
}
   4403e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44042:	c9                   	leave  
   44043:	c3                   	ret    
        sp.end = s + size - 1;
   44044:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   44049:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4404d:	be 00 00 00 00       	mov    $0x0,%esi
   44052:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   44056:	e8 67 f8 ff ff       	call   438c2 <printer_vprintf>
        *sp.s = 0;
   4405b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4405f:	c6 00 00             	movb   $0x0,(%rax)
   44062:	eb d5                	jmp    44039 <vsnprintf+0x1d>

0000000000044064 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44064:	55                   	push   %rbp
   44065:	48 89 e5             	mov    %rsp,%rbp
   44068:	48 83 ec 50          	sub    $0x50,%rsp
   4406c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44070:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44074:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44078:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4407f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44083:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44087:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4408b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   4408f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44093:	e8 84 ff ff ff       	call   4401c <vsnprintf>
    va_end(val);
    return n;
}
   44098:	c9                   	leave  
   44099:	c3                   	ret    

000000000004409a <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4409a:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4409f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   440a4:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   440a9:	48 83 c0 02          	add    $0x2,%rax
   440ad:	48 39 d0             	cmp    %rdx,%rax
   440b0:	75 f2                	jne    440a4 <console_clear+0xa>
    }
    cursorpos = 0;
   440b2:	c7 05 40 4f 07 00 00 	movl   $0x0,0x74f40(%rip)        # b8ffc <cursorpos>
   440b9:	00 00 00 
}
   440bc:	c3                   	ret    
