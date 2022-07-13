
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 2f 30 10 00       	mov    $0x10302f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 f1 1f 00 00 	mov    %rax,0x1ff1(%rip)        # 102010 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 d5 1f 00 00 	mov    %rax,0x1fd5(%rip)        # 102008 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 00 02 00 00       	call   10023c <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 6a 0b 00 00       	call   100bce <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100071:	48 89 f9             	mov    %rdi,%rcx
  100074:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100076:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10007d:	00 
  10007e:	72 08                	jb     100088 <console_putc+0x17>
        cp->cursor = console;
  100080:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100087:	00 
    }
    if (c == '\n') {
  100088:	40 80 fe 0a          	cmp    $0xa,%sil
  10008c:	74 16                	je     1000a4 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10008e:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100092:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100096:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10009a:	40 0f b6 f6          	movzbl %sil,%esi
  10009e:	09 fe                	or     %edi,%esi
  1000a0:	66 89 30             	mov    %si,(%rax)
    }
}
  1000a3:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  1000a4:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1000a8:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1000af:	4c 89 c6             	mov    %r8,%rsi
  1000b2:	48 d1 fe             	sar    %rsi
  1000b5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1000bc:	66 66 66 
  1000bf:	48 89 f0             	mov    %rsi,%rax
  1000c2:	48 f7 ea             	imul   %rdx
  1000c5:	48 c1 fa 05          	sar    $0x5,%rdx
  1000c9:	49 c1 f8 3f          	sar    $0x3f,%r8
  1000cd:	4c 29 c2             	sub    %r8,%rdx
  1000d0:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1000d4:	48 c1 e2 04          	shl    $0x4,%rdx
  1000d8:	89 f0                	mov    %esi,%eax
  1000da:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1000dc:	83 cf 20             	or     $0x20,%edi
  1000df:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1000e3:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1000e7:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1000eb:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1000ee:	83 c0 01             	add    $0x1,%eax
  1000f1:	83 f8 50             	cmp    $0x50,%eax
  1000f4:	75 e9                	jne    1000df <console_putc+0x6e>
  1000f6:	c3                   	ret    

00000000001000f7 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1000f7:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000fb:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1000ff:	73 0b                	jae    10010c <string_putc+0x15>
        *sp->s++ = c;
  100101:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100105:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  100109:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  10010c:	c3                   	ret    

000000000010010d <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  10010d:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100110:	48 85 d2             	test   %rdx,%rdx
  100113:	74 17                	je     10012c <memcpy+0x1f>
  100115:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10011a:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  10011f:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100123:	48 83 c1 01          	add    $0x1,%rcx
  100127:	48 39 d1             	cmp    %rdx,%rcx
  10012a:	75 ee                	jne    10011a <memcpy+0xd>
}
  10012c:	c3                   	ret    

000000000010012d <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10012d:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100130:	48 39 fe             	cmp    %rdi,%rsi
  100133:	72 1d                	jb     100152 <memmove+0x25>
        while (n-- > 0) {
  100135:	b9 00 00 00 00       	mov    $0x0,%ecx
  10013a:	48 85 d2             	test   %rdx,%rdx
  10013d:	74 12                	je     100151 <memmove+0x24>
            *d++ = *s++;
  10013f:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100143:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100147:	48 83 c1 01          	add    $0x1,%rcx
  10014b:	48 39 ca             	cmp    %rcx,%rdx
  10014e:	75 ef                	jne    10013f <memmove+0x12>
}
  100150:	c3                   	ret    
  100151:	c3                   	ret    
    if (s < d && s + n > d) {
  100152:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100156:	48 39 cf             	cmp    %rcx,%rdi
  100159:	73 da                	jae    100135 <memmove+0x8>
        while (n-- > 0) {
  10015b:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  10015f:	48 85 d2             	test   %rdx,%rdx
  100162:	74 ec                	je     100150 <memmove+0x23>
            *--d = *--s;
  100164:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100168:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10016b:	48 83 e9 01          	sub    $0x1,%rcx
  10016f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100173:	75 ef                	jne    100164 <memmove+0x37>
  100175:	c3                   	ret    

0000000000100176 <memset>:
void* memset(void* v, int c, size_t n) {
  100176:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100179:	48 85 d2             	test   %rdx,%rdx
  10017c:	74 12                	je     100190 <memset+0x1a>
  10017e:	48 01 fa             	add    %rdi,%rdx
  100181:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100184:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100187:	48 83 c1 01          	add    $0x1,%rcx
  10018b:	48 39 ca             	cmp    %rcx,%rdx
  10018e:	75 f4                	jne    100184 <memset+0xe>
}
  100190:	c3                   	ret    

0000000000100191 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100191:	80 3f 00             	cmpb   $0x0,(%rdi)
  100194:	74 10                	je     1001a6 <strlen+0x15>
  100196:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10019b:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  10019f:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001a3:	75 f6                	jne    10019b <strlen+0xa>
  1001a5:	c3                   	ret    
  1001a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001ab:	c3                   	ret    

00000000001001ac <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1001ac:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001af:	ba 00 00 00 00       	mov    $0x0,%edx
  1001b4:	48 85 f6             	test   %rsi,%rsi
  1001b7:	74 11                	je     1001ca <strnlen+0x1e>
  1001b9:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1001bd:	74 0c                	je     1001cb <strnlen+0x1f>
        ++n;
  1001bf:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001c3:	48 39 d0             	cmp    %rdx,%rax
  1001c6:	75 f1                	jne    1001b9 <strnlen+0xd>
  1001c8:	eb 04                	jmp    1001ce <strnlen+0x22>
  1001ca:	c3                   	ret    
  1001cb:	48 89 d0             	mov    %rdx,%rax
}
  1001ce:	c3                   	ret    

00000000001001cf <strcpy>:
char* strcpy(char* dst, const char* src) {
  1001cf:	48 89 f8             	mov    %rdi,%rax
  1001d2:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1001d7:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1001db:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1001de:	48 83 c2 01          	add    $0x1,%rdx
  1001e2:	84 c9                	test   %cl,%cl
  1001e4:	75 f1                	jne    1001d7 <strcpy+0x8>
}
  1001e6:	c3                   	ret    

00000000001001e7 <strcmp>:
    while (*a && *b && *a == *b) {
  1001e7:	0f b6 07             	movzbl (%rdi),%eax
  1001ea:	84 c0                	test   %al,%al
  1001ec:	74 1a                	je     100208 <strcmp+0x21>
  1001ee:	0f b6 16             	movzbl (%rsi),%edx
  1001f1:	38 c2                	cmp    %al,%dl
  1001f3:	75 13                	jne    100208 <strcmp+0x21>
  1001f5:	84 d2                	test   %dl,%dl
  1001f7:	74 0f                	je     100208 <strcmp+0x21>
        ++a, ++b;
  1001f9:	48 83 c7 01          	add    $0x1,%rdi
  1001fd:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100201:	0f b6 07             	movzbl (%rdi),%eax
  100204:	84 c0                	test   %al,%al
  100206:	75 e6                	jne    1001ee <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100208:	3a 06                	cmp    (%rsi),%al
  10020a:	0f 97 c0             	seta   %al
  10020d:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100210:	83 d8 00             	sbb    $0x0,%eax
}
  100213:	c3                   	ret    

0000000000100214 <strchr>:
    while (*s && *s != (char) c) {
  100214:	0f b6 07             	movzbl (%rdi),%eax
  100217:	84 c0                	test   %al,%al
  100219:	74 10                	je     10022b <strchr+0x17>
  10021b:	40 38 f0             	cmp    %sil,%al
  10021e:	74 18                	je     100238 <strchr+0x24>
        ++s;
  100220:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100224:	0f b6 07             	movzbl (%rdi),%eax
  100227:	84 c0                	test   %al,%al
  100229:	75 f0                	jne    10021b <strchr+0x7>
        return NULL;
  10022b:	40 84 f6             	test   %sil,%sil
  10022e:	b8 00 00 00 00       	mov    $0x0,%eax
  100233:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100237:	c3                   	ret    
  100238:	48 89 f8             	mov    %rdi,%rax
  10023b:	c3                   	ret    

000000000010023c <rand>:
    if (!rand_seed_set) {
  10023c:	83 3d d9 1d 00 00 00 	cmpl   $0x0,0x1dd9(%rip)        # 10201c <rand_seed_set>
  100243:	74 1b                	je     100260 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100245:	69 05 c9 1d 00 00 0d 	imul   $0x19660d,0x1dc9(%rip),%eax        # 102018 <rand_seed>
  10024c:	66 19 00 
  10024f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100254:	89 05 be 1d 00 00    	mov    %eax,0x1dbe(%rip)        # 102018 <rand_seed>
    return rand_seed & RAND_MAX;
  10025a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10025f:	c3                   	ret    
    rand_seed = seed;
  100260:	c7 05 ae 1d 00 00 9e 	movl   $0x30d4879e,0x1dae(%rip)        # 102018 <rand_seed>
  100267:	87 d4 30 
    rand_seed_set = 1;
  10026a:	c7 05 a8 1d 00 00 01 	movl   $0x1,0x1da8(%rip)        # 10201c <rand_seed_set>
  100271:	00 00 00 
}
  100274:	eb cf                	jmp    100245 <rand+0x9>

0000000000100276 <srand>:
    rand_seed = seed;
  100276:	89 3d 9c 1d 00 00    	mov    %edi,0x1d9c(%rip)        # 102018 <rand_seed>
    rand_seed_set = 1;
  10027c:	c7 05 96 1d 00 00 01 	movl   $0x1,0x1d96(%rip)        # 10201c <rand_seed_set>
  100283:	00 00 00 
}
  100286:	c3                   	ret    

0000000000100287 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100287:	55                   	push   %rbp
  100288:	48 89 e5             	mov    %rsp,%rbp
  10028b:	41 57                	push   %r15
  10028d:	41 56                	push   %r14
  10028f:	41 55                	push   %r13
  100291:	41 54                	push   %r12
  100293:	53                   	push   %rbx
  100294:	48 83 ec 58          	sub    $0x58,%rsp
  100298:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10029c:	0f b6 02             	movzbl (%rdx),%eax
  10029f:	84 c0                	test   %al,%al
  1002a1:	0f 84 b0 06 00 00    	je     100957 <printer_vprintf+0x6d0>
  1002a7:	49 89 fe             	mov    %rdi,%r14
  1002aa:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1002ad:	41 89 f7             	mov    %esi,%r15d
  1002b0:	e9 a4 04 00 00       	jmp    100759 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1002b5:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1002ba:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1002c0:	45 84 e4             	test   %r12b,%r12b
  1002c3:	0f 84 82 06 00 00    	je     10094b <printer_vprintf+0x6c4>
        int flags = 0;
  1002c9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1002cf:	41 0f be f4          	movsbl %r12b,%esi
  1002d3:	bf a1 12 10 00       	mov    $0x1012a1,%edi
  1002d8:	e8 37 ff ff ff       	call   100214 <strchr>
  1002dd:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1002e0:	48 85 c0             	test   %rax,%rax
  1002e3:	74 55                	je     10033a <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1002e5:	48 81 e9 a1 12 10 00 	sub    $0x1012a1,%rcx
  1002ec:	b8 01 00 00 00       	mov    $0x1,%eax
  1002f1:	d3 e0                	shl    %cl,%eax
  1002f3:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1002f6:	48 83 c3 01          	add    $0x1,%rbx
  1002fa:	44 0f b6 23          	movzbl (%rbx),%r12d
  1002fe:	45 84 e4             	test   %r12b,%r12b
  100301:	75 cc                	jne    1002cf <printer_vprintf+0x48>
  100303:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100307:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  10030d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100314:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100317:	0f 84 a9 00 00 00    	je     1003c6 <printer_vprintf+0x13f>
        int length = 0;
  10031d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100322:	0f b6 13             	movzbl (%rbx),%edx
  100325:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100328:	3c 37                	cmp    $0x37,%al
  10032a:	0f 87 c4 04 00 00    	ja     1007f4 <printer_vprintf+0x56d>
  100330:	0f b6 c0             	movzbl %al,%eax
  100333:	ff 24 c5 b0 10 10 00 	jmp    *0x1010b0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10033a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10033e:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100343:	3c 08                	cmp    $0x8,%al
  100345:	77 2f                	ja     100376 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100347:	0f b6 03             	movzbl (%rbx),%eax
  10034a:	8d 50 d0             	lea    -0x30(%rax),%edx
  10034d:	80 fa 09             	cmp    $0x9,%dl
  100350:	77 5e                	ja     1003b0 <printer_vprintf+0x129>
  100352:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100358:	48 83 c3 01          	add    $0x1,%rbx
  10035c:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100361:	0f be c0             	movsbl %al,%eax
  100364:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100369:	0f b6 03             	movzbl (%rbx),%eax
  10036c:	8d 50 d0             	lea    -0x30(%rax),%edx
  10036f:	80 fa 09             	cmp    $0x9,%dl
  100372:	76 e4                	jbe    100358 <printer_vprintf+0xd1>
  100374:	eb 97                	jmp    10030d <printer_vprintf+0x86>
        } else if (*format == '*') {
  100376:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10037a:	75 3f                	jne    1003bb <printer_vprintf+0x134>
            width = va_arg(val, int);
  10037c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100380:	8b 07                	mov    (%rdi),%eax
  100382:	83 f8 2f             	cmp    $0x2f,%eax
  100385:	77 17                	ja     10039e <printer_vprintf+0x117>
  100387:	89 c2                	mov    %eax,%edx
  100389:	48 03 57 10          	add    0x10(%rdi),%rdx
  10038d:	83 c0 08             	add    $0x8,%eax
  100390:	89 07                	mov    %eax,(%rdi)
  100392:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100395:	48 83 c3 01          	add    $0x1,%rbx
  100399:	e9 6f ff ff ff       	jmp    10030d <printer_vprintf+0x86>
            width = va_arg(val, int);
  10039e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1003a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1003a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1003aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1003ae:	eb e2                	jmp    100392 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003b0:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003b6:	e9 52 ff ff ff       	jmp    10030d <printer_vprintf+0x86>
        int width = -1;
  1003bb:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1003c1:	e9 47 ff ff ff       	jmp    10030d <printer_vprintf+0x86>
            ++format;
  1003c6:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1003ca:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1003ce:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1003d1:	80 f9 09             	cmp    $0x9,%cl
  1003d4:	76 13                	jbe    1003e9 <printer_vprintf+0x162>
            } else if (*format == '*') {
  1003d6:	3c 2a                	cmp    $0x2a,%al
  1003d8:	74 33                	je     10040d <printer_vprintf+0x186>
            ++format;
  1003da:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1003dd:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1003e4:	e9 34 ff ff ff       	jmp    10031d <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003e9:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1003ee:	48 83 c2 01          	add    $0x1,%rdx
  1003f2:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1003f5:	0f be c0             	movsbl %al,%eax
  1003f8:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003fc:	0f b6 02             	movzbl (%rdx),%eax
  1003ff:	8d 70 d0             	lea    -0x30(%rax),%esi
  100402:	40 80 fe 09          	cmp    $0x9,%sil
  100406:	76 e6                	jbe    1003ee <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  100408:	48 89 d3             	mov    %rdx,%rbx
  10040b:	eb 1c                	jmp    100429 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  10040d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100411:	8b 07                	mov    (%rdi),%eax
  100413:	83 f8 2f             	cmp    $0x2f,%eax
  100416:	77 23                	ja     10043b <printer_vprintf+0x1b4>
  100418:	89 c2                	mov    %eax,%edx
  10041a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10041e:	83 c0 08             	add    $0x8,%eax
  100421:	89 07                	mov    %eax,(%rdi)
  100423:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100425:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  100429:	85 c9                	test   %ecx,%ecx
  10042b:	b8 00 00 00 00       	mov    $0x0,%eax
  100430:	0f 49 c1             	cmovns %ecx,%eax
  100433:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100436:	e9 e2 fe ff ff       	jmp    10031d <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10043b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10043f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100443:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100447:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10044b:	eb d6                	jmp    100423 <printer_vprintf+0x19c>
        switch (*format) {
  10044d:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100452:	e9 f3 00 00 00       	jmp    10054a <printer_vprintf+0x2c3>
            ++format;
  100457:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10045b:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100460:	e9 bd fe ff ff       	jmp    100322 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100465:	85 c9                	test   %ecx,%ecx
  100467:	74 55                	je     1004be <printer_vprintf+0x237>
  100469:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10046d:	8b 07                	mov    (%rdi),%eax
  10046f:	83 f8 2f             	cmp    $0x2f,%eax
  100472:	77 38                	ja     1004ac <printer_vprintf+0x225>
  100474:	89 c2                	mov    %eax,%edx
  100476:	48 03 57 10          	add    0x10(%rdi),%rdx
  10047a:	83 c0 08             	add    $0x8,%eax
  10047d:	89 07                	mov    %eax,(%rdi)
  10047f:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100482:	48 89 d0             	mov    %rdx,%rax
  100485:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100489:	49 89 d0             	mov    %rdx,%r8
  10048c:	49 f7 d8             	neg    %r8
  10048f:	25 80 00 00 00       	and    $0x80,%eax
  100494:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100498:	0b 45 a8             	or     -0x58(%rbp),%eax
  10049b:	83 c8 60             	or     $0x60,%eax
  10049e:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1004a1:	41 bc a8 10 10 00    	mov    $0x1010a8,%r12d
            break;
  1004a7:	e9 35 01 00 00       	jmp    1005e1 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004bc:	eb c1                	jmp    10047f <printer_vprintf+0x1f8>
  1004be:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004c2:	8b 07                	mov    (%rdi),%eax
  1004c4:	83 f8 2f             	cmp    $0x2f,%eax
  1004c7:	77 10                	ja     1004d9 <printer_vprintf+0x252>
  1004c9:	89 c2                	mov    %eax,%edx
  1004cb:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004cf:	83 c0 08             	add    $0x8,%eax
  1004d2:	89 07                	mov    %eax,(%rdi)
  1004d4:	48 63 12             	movslq (%rdx),%rdx
  1004d7:	eb a9                	jmp    100482 <printer_vprintf+0x1fb>
  1004d9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004dd:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004e1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004e5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1004e9:	eb e9                	jmp    1004d4 <printer_vprintf+0x24d>
        int base = 10;
  1004eb:	be 0a 00 00 00       	mov    $0xa,%esi
  1004f0:	eb 58                	jmp    10054a <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1004f2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004f6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004fa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004fe:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100502:	eb 60                	jmp    100564 <printer_vprintf+0x2dd>
  100504:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100508:	8b 07                	mov    (%rdi),%eax
  10050a:	83 f8 2f             	cmp    $0x2f,%eax
  10050d:	77 10                	ja     10051f <printer_vprintf+0x298>
  10050f:	89 c2                	mov    %eax,%edx
  100511:	48 03 57 10          	add    0x10(%rdi),%rdx
  100515:	83 c0 08             	add    $0x8,%eax
  100518:	89 07                	mov    %eax,(%rdi)
  10051a:	44 8b 02             	mov    (%rdx),%r8d
  10051d:	eb 48                	jmp    100567 <printer_vprintf+0x2e0>
  10051f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100523:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100527:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10052b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10052f:	eb e9                	jmp    10051a <printer_vprintf+0x293>
  100531:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100534:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10053b:	bf 90 12 10 00       	mov    $0x101290,%edi
  100540:	e9 e2 02 00 00       	jmp    100827 <printer_vprintf+0x5a0>
            base = 16;
  100545:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10054a:	85 c9                	test   %ecx,%ecx
  10054c:	74 b6                	je     100504 <printer_vprintf+0x27d>
  10054e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100552:	8b 01                	mov    (%rcx),%eax
  100554:	83 f8 2f             	cmp    $0x2f,%eax
  100557:	77 99                	ja     1004f2 <printer_vprintf+0x26b>
  100559:	89 c2                	mov    %eax,%edx
  10055b:	48 03 51 10          	add    0x10(%rcx),%rdx
  10055f:	83 c0 08             	add    $0x8,%eax
  100562:	89 01                	mov    %eax,(%rcx)
  100564:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100567:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10056b:	85 f6                	test   %esi,%esi
  10056d:	79 c2                	jns    100531 <printer_vprintf+0x2aa>
        base = -base;
  10056f:	41 89 f1             	mov    %esi,%r9d
  100572:	f7 de                	neg    %esi
  100574:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10057b:	bf 70 12 10 00       	mov    $0x101270,%edi
  100580:	e9 a2 02 00 00       	jmp    100827 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100585:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100589:	8b 07                	mov    (%rdi),%eax
  10058b:	83 f8 2f             	cmp    $0x2f,%eax
  10058e:	77 1c                	ja     1005ac <printer_vprintf+0x325>
  100590:	89 c2                	mov    %eax,%edx
  100592:	48 03 57 10          	add    0x10(%rdi),%rdx
  100596:	83 c0 08             	add    $0x8,%eax
  100599:	89 07                	mov    %eax,(%rdi)
  10059b:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10059e:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1005a5:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005aa:	eb c3                	jmp    10056f <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1005ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005bc:	eb dd                	jmp    10059b <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1005be:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c2:	8b 01                	mov    (%rcx),%eax
  1005c4:	83 f8 2f             	cmp    $0x2f,%eax
  1005c7:	0f 87 a5 01 00 00    	ja     100772 <printer_vprintf+0x4eb>
  1005cd:	89 c2                	mov    %eax,%edx
  1005cf:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005d3:	83 c0 08             	add    $0x8,%eax
  1005d6:	89 01                	mov    %eax,(%rcx)
  1005d8:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1005db:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1005e1:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005e4:	83 e0 20             	and    $0x20,%eax
  1005e7:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1005ea:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1005f0:	0f 85 21 02 00 00    	jne    100817 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1005f6:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005f9:	89 45 88             	mov    %eax,-0x78(%rbp)
  1005fc:	83 e0 60             	and    $0x60,%eax
  1005ff:	83 f8 60             	cmp    $0x60,%eax
  100602:	0f 84 54 02 00 00    	je     10085c <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100608:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10060b:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  10060e:	48 c7 45 a0 a8 10 10 	movq   $0x1010a8,-0x60(%rbp)
  100615:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100616:	83 f8 21             	cmp    $0x21,%eax
  100619:	0f 84 79 02 00 00    	je     100898 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10061f:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100622:	89 f8                	mov    %edi,%eax
  100624:	f7 d0                	not    %eax
  100626:	c1 e8 1f             	shr    $0x1f,%eax
  100629:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10062c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100630:	0f 85 9e 02 00 00    	jne    1008d4 <printer_vprintf+0x64d>
  100636:	84 c0                	test   %al,%al
  100638:	0f 84 96 02 00 00    	je     1008d4 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10063e:	48 63 f7             	movslq %edi,%rsi
  100641:	4c 89 e7             	mov    %r12,%rdi
  100644:	e8 63 fb ff ff       	call   1001ac <strnlen>
  100649:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10064c:	8b 45 88             	mov    -0x78(%rbp),%eax
  10064f:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100652:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100659:	83 f8 22             	cmp    $0x22,%eax
  10065c:	0f 84 aa 02 00 00    	je     10090c <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100662:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100666:	e8 26 fb ff ff       	call   100191 <strlen>
  10066b:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10066e:	03 55 98             	add    -0x68(%rbp),%edx
  100671:	44 89 e9             	mov    %r13d,%ecx
  100674:	29 d1                	sub    %edx,%ecx
  100676:	29 c1                	sub    %eax,%ecx
  100678:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10067b:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10067e:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100682:	75 2d                	jne    1006b1 <printer_vprintf+0x42a>
  100684:	85 c9                	test   %ecx,%ecx
  100686:	7e 29                	jle    1006b1 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  100688:	44 89 fa             	mov    %r15d,%edx
  10068b:	be 20 00 00 00       	mov    $0x20,%esi
  100690:	4c 89 f7             	mov    %r14,%rdi
  100693:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100696:	41 83 ed 01          	sub    $0x1,%r13d
  10069a:	45 85 ed             	test   %r13d,%r13d
  10069d:	7f e9                	jg     100688 <printer_vprintf+0x401>
  10069f:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1006a2:	85 ff                	test   %edi,%edi
  1006a4:	b8 01 00 00 00       	mov    $0x1,%eax
  1006a9:	0f 4f c7             	cmovg  %edi,%eax
  1006ac:	29 c7                	sub    %eax,%edi
  1006ae:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1006b1:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006b5:	0f b6 07             	movzbl (%rdi),%eax
  1006b8:	84 c0                	test   %al,%al
  1006ba:	74 22                	je     1006de <printer_vprintf+0x457>
  1006bc:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006c0:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1006c3:	0f b6 f0             	movzbl %al,%esi
  1006c6:	44 89 fa             	mov    %r15d,%edx
  1006c9:	4c 89 f7             	mov    %r14,%rdi
  1006cc:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  1006cf:	48 83 c3 01          	add    $0x1,%rbx
  1006d3:	0f b6 03             	movzbl (%rbx),%eax
  1006d6:	84 c0                	test   %al,%al
  1006d8:	75 e9                	jne    1006c3 <printer_vprintf+0x43c>
  1006da:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1006de:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1006e1:	85 c0                	test   %eax,%eax
  1006e3:	7e 1d                	jle    100702 <printer_vprintf+0x47b>
  1006e5:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006e9:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1006eb:	44 89 fa             	mov    %r15d,%edx
  1006ee:	be 30 00 00 00       	mov    $0x30,%esi
  1006f3:	4c 89 f7             	mov    %r14,%rdi
  1006f6:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  1006f9:	83 eb 01             	sub    $0x1,%ebx
  1006fc:	75 ed                	jne    1006eb <printer_vprintf+0x464>
  1006fe:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100702:	8b 45 98             	mov    -0x68(%rbp),%eax
  100705:	85 c0                	test   %eax,%eax
  100707:	7e 27                	jle    100730 <printer_vprintf+0x4a9>
  100709:	89 c0                	mov    %eax,%eax
  10070b:	4c 01 e0             	add    %r12,%rax
  10070e:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100712:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100715:	41 0f b6 34 24       	movzbl (%r12),%esi
  10071a:	44 89 fa             	mov    %r15d,%edx
  10071d:	4c 89 f7             	mov    %r14,%rdi
  100720:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  100723:	49 83 c4 01          	add    $0x1,%r12
  100727:	49 39 dc             	cmp    %rbx,%r12
  10072a:	75 e9                	jne    100715 <printer_vprintf+0x48e>
  10072c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100730:	45 85 ed             	test   %r13d,%r13d
  100733:	7e 14                	jle    100749 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100735:	44 89 fa             	mov    %r15d,%edx
  100738:	be 20 00 00 00       	mov    $0x20,%esi
  10073d:	4c 89 f7             	mov    %r14,%rdi
  100740:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  100743:	41 83 ed 01          	sub    $0x1,%r13d
  100747:	75 ec                	jne    100735 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  100749:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10074d:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100751:	84 c0                	test   %al,%al
  100753:	0f 84 fe 01 00 00    	je     100957 <printer_vprintf+0x6d0>
        if (*format != '%') {
  100759:	3c 25                	cmp    $0x25,%al
  10075b:	0f 84 54 fb ff ff    	je     1002b5 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100761:	0f b6 f0             	movzbl %al,%esi
  100764:	44 89 fa             	mov    %r15d,%edx
  100767:	4c 89 f7             	mov    %r14,%rdi
  10076a:	41 ff 16             	call   *(%r14)
            continue;
  10076d:	4c 89 e3             	mov    %r12,%rbx
  100770:	eb d7                	jmp    100749 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100772:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100776:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10077a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10077e:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100782:	e9 51 fe ff ff       	jmp    1005d8 <printer_vprintf+0x351>
            color = va_arg(val, int);
  100787:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10078b:	8b 07                	mov    (%rdi),%eax
  10078d:	83 f8 2f             	cmp    $0x2f,%eax
  100790:	77 10                	ja     1007a2 <printer_vprintf+0x51b>
  100792:	89 c2                	mov    %eax,%edx
  100794:	48 03 57 10          	add    0x10(%rdi),%rdx
  100798:	83 c0 08             	add    $0x8,%eax
  10079b:	89 07                	mov    %eax,(%rdi)
  10079d:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1007a0:	eb a7                	jmp    100749 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1007a2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007a6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1007aa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ae:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1007b2:	eb e9                	jmp    10079d <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1007b4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007b8:	8b 01                	mov    (%rcx),%eax
  1007ba:	83 f8 2f             	cmp    $0x2f,%eax
  1007bd:	77 23                	ja     1007e2 <printer_vprintf+0x55b>
  1007bf:	89 c2                	mov    %eax,%edx
  1007c1:	48 03 51 10          	add    0x10(%rcx),%rdx
  1007c5:	83 c0 08             	add    $0x8,%eax
  1007c8:	89 01                	mov    %eax,(%rcx)
  1007ca:	8b 02                	mov    (%rdx),%eax
  1007cc:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1007cf:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1007d3:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1007d7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1007dd:	e9 ff fd ff ff       	jmp    1005e1 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1007e2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007e6:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007ea:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ee:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1007f2:	eb d6                	jmp    1007ca <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1007f4:	84 d2                	test   %dl,%dl
  1007f6:	0f 85 39 01 00 00    	jne    100935 <printer_vprintf+0x6ae>
  1007fc:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100804:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100808:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10080c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100812:	e9 ca fd ff ff       	jmp    1005e1 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  100817:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10081d:	bf 90 12 10 00       	mov    $0x101290,%edi
        if (flags & FLAG_NUMERIC) {
  100822:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100827:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10082b:	4c 89 c1             	mov    %r8,%rcx
  10082e:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100832:	48 63 f6             	movslq %esi,%rsi
  100835:	49 83 ec 01          	sub    $0x1,%r12
  100839:	48 89 c8             	mov    %rcx,%rax
  10083c:	ba 00 00 00 00       	mov    $0x0,%edx
  100841:	48 f7 f6             	div    %rsi
  100844:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100848:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10084c:	48 89 ca             	mov    %rcx,%rdx
  10084f:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100852:	48 39 d6             	cmp    %rdx,%rsi
  100855:	76 de                	jbe    100835 <printer_vprintf+0x5ae>
  100857:	e9 9a fd ff ff       	jmp    1005f6 <printer_vprintf+0x36f>
                prefix = "-";
  10085c:	48 c7 45 a0 a5 10 10 	movq   $0x1010a5,-0x60(%rbp)
  100863:	00 
            if (flags & FLAG_NEGATIVE) {
  100864:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100867:	a8 80                	test   $0x80,%al
  100869:	0f 85 b0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = "+";
  10086f:	48 c7 45 a0 a0 10 10 	movq   $0x1010a0,-0x60(%rbp)
  100876:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100877:	a8 10                	test   $0x10,%al
  100879:	0f 85 a0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = " ";
  10087f:	a8 08                	test   $0x8,%al
  100881:	ba a8 10 10 00       	mov    $0x1010a8,%edx
  100886:	b8 a7 10 10 00       	mov    $0x1010a7,%eax
  10088b:	48 0f 44 c2          	cmove  %rdx,%rax
  10088f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100893:	e9 87 fd ff ff       	jmp    10061f <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100898:	41 8d 41 10          	lea    0x10(%r9),%eax
  10089c:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1008a1:	0f 85 78 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1008a7:	4d 85 c0             	test   %r8,%r8
  1008aa:	75 0d                	jne    1008b9 <printer_vprintf+0x632>
  1008ac:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1008b3:	0f 84 66 fd ff ff    	je     10061f <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1008b9:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1008bd:	ba a9 10 10 00       	mov    $0x1010a9,%edx
  1008c2:	b8 a2 10 10 00       	mov    $0x1010a2,%eax
  1008c7:	48 0f 44 c2          	cmove  %rdx,%rax
  1008cb:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1008cf:	e9 4b fd ff ff       	jmp    10061f <printer_vprintf+0x398>
            len = strlen(data);
  1008d4:	4c 89 e7             	mov    %r12,%rdi
  1008d7:	e8 b5 f8 ff ff       	call   100191 <strlen>
  1008dc:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1008df:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1008e3:	0f 84 63 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
  1008e9:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1008ed:	0f 84 59 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1008f3:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1008f6:	89 ca                	mov    %ecx,%edx
  1008f8:	29 c2                	sub    %eax,%edx
  1008fa:	39 c1                	cmp    %eax,%ecx
  1008fc:	b8 00 00 00 00       	mov    $0x0,%eax
  100901:	0f 4e d0             	cmovle %eax,%edx
  100904:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100907:	e9 56 fd ff ff       	jmp    100662 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  10090c:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100910:	e8 7c f8 ff ff       	call   100191 <strlen>
  100915:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100918:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  10091b:	44 89 e9             	mov    %r13d,%ecx
  10091e:	29 f9                	sub    %edi,%ecx
  100920:	29 c1                	sub    %eax,%ecx
  100922:	44 39 ea             	cmp    %r13d,%edx
  100925:	b8 00 00 00 00       	mov    $0x0,%eax
  10092a:	0f 4d c8             	cmovge %eax,%ecx
  10092d:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100930:	e9 2d fd ff ff       	jmp    100662 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100935:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100938:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10093c:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100940:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100946:	e9 96 fc ff ff       	jmp    1005e1 <printer_vprintf+0x35a>
        int flags = 0;
  10094b:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100952:	e9 b0 f9 ff ff       	jmp    100307 <printer_vprintf+0x80>
}
  100957:	48 83 c4 58          	add    $0x58,%rsp
  10095b:	5b                   	pop    %rbx
  10095c:	41 5c                	pop    %r12
  10095e:	41 5d                	pop    %r13
  100960:	41 5e                	pop    %r14
  100962:	41 5f                	pop    %r15
  100964:	5d                   	pop    %rbp
  100965:	c3                   	ret    

0000000000100966 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100966:	55                   	push   %rbp
  100967:	48 89 e5             	mov    %rsp,%rbp
  10096a:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  10096e:	48 c7 45 f0 71 00 10 	movq   $0x100071,-0x10(%rbp)
  100975:	00 
        cpos = 0;
  100976:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  10097c:	b8 00 00 00 00       	mov    $0x0,%eax
  100981:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100984:	48 63 ff             	movslq %edi,%rdi
  100987:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  10098e:	00 
  10098f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100993:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100997:	e8 eb f8 ff ff       	call   100287 <printer_vprintf>
    return cp.cursor - console;
  10099c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009a0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1009a6:	48 d1 f8             	sar    %rax
}
  1009a9:	c9                   	leave  
  1009aa:	c3                   	ret    

00000000001009ab <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1009ab:	55                   	push   %rbp
  1009ac:	48 89 e5             	mov    %rsp,%rbp
  1009af:	48 83 ec 50          	sub    $0x50,%rsp
  1009b3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1009b7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1009bb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1009bf:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1009c6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1009ca:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1009ce:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1009d2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1009d6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1009da:	e8 87 ff ff ff       	call   100966 <console_vprintf>
}
  1009df:	c9                   	leave  
  1009e0:	c3                   	ret    

00000000001009e1 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1009e1:	55                   	push   %rbp
  1009e2:	48 89 e5             	mov    %rsp,%rbp
  1009e5:	53                   	push   %rbx
  1009e6:	48 83 ec 28          	sub    $0x28,%rsp
  1009ea:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1009ed:	48 c7 45 d8 f7 00 10 	movq   $0x1000f7,-0x28(%rbp)
  1009f4:	00 
    sp.s = s;
  1009f5:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  1009f9:	48 85 f6             	test   %rsi,%rsi
  1009fc:	75 0b                	jne    100a09 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  1009fe:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100a01:	29 d8                	sub    %ebx,%eax
}
  100a03:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100a07:	c9                   	leave  
  100a08:	c3                   	ret    
        sp.end = s + size - 1;
  100a09:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a0e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a12:	be 00 00 00 00       	mov    $0x0,%esi
  100a17:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100a1b:	e8 67 f8 ff ff       	call   100287 <printer_vprintf>
        *sp.s = 0;
  100a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a24:	c6 00 00             	movb   $0x0,(%rax)
  100a27:	eb d5                	jmp    1009fe <vsnprintf+0x1d>

0000000000100a29 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100a29:	55                   	push   %rbp
  100a2a:	48 89 e5             	mov    %rsp,%rbp
  100a2d:	48 83 ec 50          	sub    $0x50,%rsp
  100a31:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a35:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a39:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100a3d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a44:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a4c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100a54:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a58:	e8 84 ff ff ff       	call   1009e1 <vsnprintf>
    va_end(val);
    return n;
}
  100a5d:	c9                   	leave  
  100a5e:	c3                   	ret    

0000000000100a5f <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a5f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100a64:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100a69:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a6e:	48 83 c0 02          	add    $0x2,%rax
  100a72:	48 39 d0             	cmp    %rdx,%rax
  100a75:	75 f2                	jne    100a69 <console_clear+0xa>
    }
    cursorpos = 0;
  100a77:	c7 05 7b 85 fb ff 00 	movl   $0x0,-0x47a85(%rip)        # b8ffc <cursorpos>
  100a7e:	00 00 00 
}
  100a81:	c3                   	ret    

0000000000100a82 <grab_payload>:

#define HEADER_SZ sizeof(header_list)

void * grab_payload(header_list * header_pt)
{
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  100a82:	48 8d 47 10          	lea    0x10(%rdi),%rax
    return payload;
}
  100a86:	c3                   	ret    

0000000000100a87 <grab_header>:

header_list * grab_header(void * mem_payload)
{
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100a87:	48 8d 47 f0          	lea    -0x10(%rdi),%rax
    return header;
}
  100a8b:	c3                   	ret    

0000000000100a8c <next_block>:

header_list* next_block(header_list *header)
{ 
    return (header_list*) ((uintptr_t) header + header->size); 
  100a8c:	48 89 f8             	mov    %rdi,%rax
  100a8f:	48 03 07             	add    (%rdi),%rax
}
  100a92:	c3                   	ret    

0000000000100a93 <initialize_malloc>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100a93:	bf 10 00 00 00       	mov    $0x10,%edi
  100a98:	cd 3a                	int    $0x3a
  100a9a:	48 89 05 87 15 00 00 	mov    %rax,0x1587(%rip)        # 102028 <result.0>
  100aa1:	bf 00 00 00 00       	mov    $0x0,%edi
  100aa6:	cd 3a                	int    $0x3a
  100aa8:	48 89 05 79 15 00 00 	mov    %rax,0x1579(%rip)        # 102028 <result.0>
int first_run = 1;

int initialize_malloc()
{
    sbrk(sizeof(header_list));
    first_bp = sbrk(0);
  100aaf:	48 89 05 6a 15 00 00 	mov    %rax,0x156a(%rip)        # 102020 <first_bp>
    
    grab_header(first_bp)->size = 0;
  100ab6:	48 c7 40 f0 00 00 00 	movq   $0x0,-0x10(%rax)
  100abd:	00 
    grab_header(first_bp)->allocated = 1;
  100abe:	48 8b 05 5b 15 00 00 	mov    0x155b(%rip),%rax        # 102020 <first_bp>
  100ac5:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)

    first_run = 0;
  100acc:	c7 05 2a 15 00 00 00 	movl   $0x0,0x152a(%rip)        # 102000 <first_run>
  100ad3:	00 00 00 
    return 0;
}
  100ad6:	b8 00 00 00 00       	mov    $0x0,%eax
  100adb:	c3                   	ret    

0000000000100adc <expand_heap>:
  100adc:	cd 3a                	int    $0x3a
  100ade:	48 89 05 43 15 00 00 	mov    %rax,0x1543(%rip)        # 102028 <result.0>

int expand_heap(uint64_t block_size)
{
    void *bp = sbrk(block_size);

    if ((uintptr_t) bp == (uintptr_t) -1) return -1;
  100ae5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100ae9:	74 2a                	je     100b15 <expand_heap+0x39>
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100aeb:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
    grab_header(bp)->size = block_size;
  100aef:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
    grab_header(bp)->allocated = 0;
  100af3:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)

    next_block(grab_header(bp))->size = 0;
  100afa:	48 c7 44 07 f0 00 00 	movq   $0x0,-0x10(%rdi,%rax,1)
  100b01:	00 00 
    next_block(grab_header(bp))->allocated = 1;
  100b03:	48 8b 40 f0          	mov    -0x10(%rax),%rax
  100b07:	c7 44 10 08 01 00 00 	movl   $0x1,0x8(%rax,%rdx,1)
  100b0e:	00 
    return 0; // succesfully increased brk and expanded heap
  100b0f:	b8 00 00 00 00       	mov    $0x0,%eax
  100b14:	c3                   	ret    
    if ((uintptr_t) bp == (uintptr_t) -1) return -1;
  100b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100b1a:	c3                   	ret    

0000000000100b1b <extend>:

int extend(uint64_t new_size)
{
  100b1b:	55                   	push   %rbp
  100b1c:	48 89 e5             	mov    %rsp,%rbp
    uint64_t block_size = BLOCK_ALIGN(new_size);
  100b1f:	48 81 c7 ff 7f 00 00 	add    $0x7fff,%rdi
  100b26:	48 81 e7 00 80 ff ff 	and    $0xffffffffffff8000,%rdi
    if (expand_heap(block_size) == -1) return -1;
  100b2d:	e8 aa ff ff ff       	call   100adc <expand_heap>
  100b32:	83 f8 ff             	cmp    $0xffffffff,%eax
  100b35:	0f 94 c0             	sete   %al
  100b38:	0f b6 c0             	movzbl %al,%eax
  100b3b:	f7 d8                	neg    %eax
    return 0; 
}
  100b3d:	5d                   	pop    %rbp
  100b3e:	c3                   	ret    

0000000000100b3f <split>:

void split(header_list *header, uint64_t size)
{
    uint64_t extra_size = header->size - size;
  100b3f:	48 8b 07             	mov    (%rdi),%rax
  100b42:	48 29 f0             	sub    %rsi,%rax
 
    if (header->size - size > ALIGN(1 + HEADER_SZ))
  100b45:	48 83 f8 18          	cmp    $0x18,%rax
  100b49:	76 12                	jbe    100b5d <split+0x1e>
    {
        header->size = size;        
  100b4b:	48 89 37             	mov    %rsi,(%rdi)
        next_block(header)->size = extra_size;
  100b4e:	48 89 04 3e          	mov    %rax,(%rsi,%rdi,1)
        next_block(header)->allocated = 0;
  100b52:	48 8b 07             	mov    (%rdi),%rax
  100b55:	c7 44 38 08 00 00 00 	movl   $0x0,0x8(%rax,%rdi,1)
  100b5c:	00 
    }
    header->allocated = 1;
  100b5d:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%rdi)
}
  100b64:	c3                   	ret    

0000000000100b65 <free>:

void free(void *firstbyte) {
    if (firstbyte == NULL) return;
  100b65:	48 85 ff             	test   %rdi,%rdi
  100b68:	74 14                	je     100b7e <free+0x19>
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100b6a:	48 8b 15 af 14 00 00 	mov    0x14af(%rip),%rdx        # 102020 <first_bp>
  100b71:	48 8d 42 f0          	lea    -0x10(%rdx),%rax

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100b75:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  100b79:	48 85 d2             	test   %rdx,%rdx
  100b7c:	75 0c                	jne    100b8a <free+0x25>
                curr->allocated = 0;
                return;
            }
        }
    }
}
  100b7e:	c3                   	ret    
    return (header_list*) ((uintptr_t) header + header->size); 
  100b7f:	48 01 d0             	add    %rdx,%rax
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100b82:	48 8b 10             	mov    (%rax),%rdx
  100b85:	48 85 d2             	test   %rdx,%rdx
  100b88:	74 f4                	je     100b7e <free+0x19>
        if (curr->allocated == 1)
  100b8a:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100b8e:	75 ef                	jne    100b7f <free+0x1a>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  100b90:	48 8d 48 10          	lea    0x10(%rax),%rcx
            if (grab_payload(curr) == firstbyte)
  100b94:	48 39 cf             	cmp    %rcx,%rdi
  100b97:	75 e6                	jne    100b7f <free+0x1a>
                curr->allocated = 0;
  100b99:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
                return;
  100ba0:	c3                   	ret    

0000000000100ba1 <find_free_block>:
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100ba1:	48 8b 15 78 14 00 00 	mov    0x1478(%rip),%rdx        # 102020 <first_bp>
  100ba8:	48 8d 42 f0          	lea    -0x10(%rdx),%rax

header_list * find_free_block(uint64_t new_sz)
{
    header_list * curr = grab_header(first_bp);
    for ( curr ; curr->size != 0; curr = next_block(curr))
  100bac:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  100bb0:	48 85 d2             	test   %rdx,%rdx
  100bb3:	75 0d                	jne    100bc2 <find_free_block+0x21>
  100bb5:	eb 16                	jmp    100bcd <find_free_block+0x2c>
    return (header_list*) ((uintptr_t) header + header->size); 
  100bb7:	48 01 d0             	add    %rdx,%rax
    for ( curr ; curr->size != 0; curr = next_block(curr))
  100bba:	48 8b 10             	mov    (%rax),%rdx
  100bbd:	48 85 d2             	test   %rdx,%rdx
  100bc0:	74 0b                	je     100bcd <find_free_block+0x2c>
    {
        if (curr->allocated == 0)
        {
            if (curr->size >= new_sz)
  100bc2:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  100bc6:	75 ef                	jne    100bb7 <find_free_block+0x16>
  100bc8:	48 39 d7             	cmp    %rdx,%rdi
  100bcb:	77 ea                	ja     100bb7 <find_free_block+0x16>
            }
        }
    }
    // otherwise return a header with size zero
    return curr;
}
  100bcd:	c3                   	ret    

0000000000100bce <malloc>:

void *malloc(uint64_t numbytes)
{
    if (numbytes == 0 || numbytes >= SIZE_MAX)
  100bce:	48 8d 47 ff          	lea    -0x1(%rdi),%rax
  100bd2:	48 83 f8 fd          	cmp    $0xfffffffffffffffd,%rax
  100bd6:	77 73                	ja     100c4b <malloc+0x7d>
{
  100bd8:	55                   	push   %rbp
  100bd9:	48 89 e5             	mov    %rsp,%rbp
  100bdc:	41 54                	push   %r12
  100bde:	53                   	push   %rbx
  100bdf:	48 89 fb             	mov    %rdi,%rbx
    { 
        return NULL; 
    }

    if (first_run) initialize_malloc(); 
  100be2:	83 3d 17 14 00 00 00 	cmpl   $0x0,0x1417(%rip)        # 102000 <first_run>
  100be9:	75 42                	jne    100c2d <malloc+0x5f>

    uint64_t new_size = ALIGN(numbytes + HEADER_SZ);
  100beb:	48 83 c3 17          	add    $0x17,%rbx
  100bef:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx

    header_list *header = find_free_block(new_size);
  100bf3:	48 89 df             	mov    %rbx,%rdi
  100bf6:	e8 a6 ff ff ff       	call   100ba1 <find_free_block>
  100bfb:	49 89 c4             	mov    %rax,%r12

    if (header->size != 0)
  100bfe:	48 83 38 00          	cmpq   $0x0,(%rax)
  100c02:	75 35                	jne    100c39 <malloc+0x6b>
        split(header, new_size);
        return grab_payload(header);
    }
    else
    {   // otherwise, extend the heap, split the header of zero, and return that payload
        if (extend(new_size) == -1) return NULL;
  100c04:	48 89 df             	mov    %rbx,%rdi
  100c07:	e8 0f ff ff ff       	call   100b1b <extend>
  100c0c:	89 c2                	mov    %eax,%edx
  100c0e:	b8 00 00 00 00       	mov    $0x0,%eax
  100c13:	83 fa ff             	cmp    $0xffffffff,%edx
  100c16:	74 10                	je     100c28 <malloc+0x5a>
        split(header, new_size);
  100c18:	48 89 de             	mov    %rbx,%rsi
  100c1b:	4c 89 e7             	mov    %r12,%rdi
  100c1e:	e8 1c ff ff ff       	call   100b3f <split>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  100c23:	49 8d 44 24 10       	lea    0x10(%r12),%rax
        return grab_payload(header);
    }
}
  100c28:	5b                   	pop    %rbx
  100c29:	41 5c                	pop    %r12
  100c2b:	5d                   	pop    %rbp
  100c2c:	c3                   	ret    
    if (first_run) initialize_malloc(); 
  100c2d:	b8 00 00 00 00       	mov    $0x0,%eax
  100c32:	e8 5c fe ff ff       	call   100a93 <initialize_malloc>
  100c37:	eb b2                	jmp    100beb <malloc+0x1d>
        split(header, new_size);
  100c39:	48 89 de             	mov    %rbx,%rsi
  100c3c:	48 89 c7             	mov    %rax,%rdi
  100c3f:	e8 fb fe ff ff       	call   100b3f <split>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  100c44:	49 8d 44 24 10       	lea    0x10(%r12),%rax
        return grab_payload(header);
  100c49:	eb dd                	jmp    100c28 <malloc+0x5a>
        return NULL; 
  100c4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c50:	c3                   	ret    

0000000000100c51 <calloc>:

void * calloc(uint64_t num, uint64_t sz) 
{
  100c51:	55                   	push   %rbp
  100c52:	48 89 e5             	mov    %rsp,%rbp
  100c55:	41 54                	push   %r12
  100c57:	53                   	push   %rbx
    if (num <= 0 || sz <= 0) return NULL;
  100c58:	48 85 ff             	test   %rdi,%rdi
  100c5b:	74 4e                	je     100cab <calloc+0x5a>
  100c5d:	48 85 f6             	test   %rsi,%rsi
  100c60:	74 49                	je     100cab <calloc+0x5a>
    if (num >= SIZE_MAX / sz) return NULL;
  100c62:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  100c69:	ba 00 00 00 00       	mov    $0x0,%edx
  100c6e:	48 f7 f6             	div    %rsi
  100c71:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100c77:	48 39 f8             	cmp    %rdi,%rax
  100c7a:	76 27                	jbe    100ca3 <calloc+0x52>

    void * ptr = malloc(num * sz);
  100c7c:	48 89 fb             	mov    %rdi,%rbx
  100c7f:	48 0f af de          	imul   %rsi,%rbx
  100c83:	48 89 df             	mov    %rbx,%rdi
  100c86:	e8 43 ff ff ff       	call   100bce <malloc>
  100c8b:	49 89 c4             	mov    %rax,%r12

    if (ptr != NULL)
  100c8e:	48 85 c0             	test   %rax,%rax
  100c91:	74 10                	je     100ca3 <calloc+0x52>
    {
        memset(ptr, 0, num * sz);
  100c93:	48 89 da             	mov    %rbx,%rdx
  100c96:	be 00 00 00 00       	mov    $0x0,%esi
  100c9b:	48 89 c7             	mov    %rax,%rdi
  100c9e:	e8 d3 f4 ff ff       	call   100176 <memset>
    }

    return ptr;
}
  100ca3:	4c 89 e0             	mov    %r12,%rax
  100ca6:	5b                   	pop    %rbx
  100ca7:	41 5c                	pop    %r12
  100ca9:	5d                   	pop    %rbp
  100caa:	c3                   	ret    
    if (num <= 0 || sz <= 0) return NULL;
  100cab:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100cb1:	eb f0                	jmp    100ca3 <calloc+0x52>

0000000000100cb3 <realloc>:


void * realloc(void * ptr, uint64_t sz) 
{
  100cb3:	55                   	push   %rbp
  100cb4:	48 89 e5             	mov    %rsp,%rbp
  100cb7:	41 55                	push   %r13
  100cb9:	41 54                	push   %r12
  100cbb:	53                   	push   %rbx
  100cbc:	48 83 ec 08          	sub    $0x8,%rsp
    // if pointer is null, same as malloc for all sizes
    if (ptr == NULL) return malloc(sz);
  100cc0:	48 85 ff             	test   %rdi,%rdi
  100cc3:	74 28                	je     100ced <realloc+0x3a>
  100cc5:	48 89 fb             	mov    %rdi,%rbx
    // if size is zero and the ptr isn't NULL, simply free ptr
    if (sz == 0)
  100cc8:	48 85 f6             	test   %rsi,%rsi
  100ccb:	74 2d                	je     100cfa <realloc+0x47>
    {
        free(ptr); return NULL;
    }
    if (sz >= SIZE_MAX)
  100ccd:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
  100cd1:	74 5c                	je     100d2f <realloc+0x7c>
    // the contents will be unchanged in the range from the start of the region up to the
    // minimum of the old and new sizes

    // the start of the region is at ptr
    // if the new size is less than the old size, leave it unchanged
    uint64_t block_sz = grab_header(ptr)->size;  // original size of block at ptr
  100cd3:	4c 8b 6f f0          	mov    -0x10(%rdi),%r13
    
    if (block_sz > sz) return ptr;
  100cd7:	49 89 fc             	mov    %rdi,%r12
  100cda:	4c 39 ee             	cmp    %r13,%rsi
  100cdd:	73 28                	jae    100d07 <realloc+0x54>

        free(ptr); // free the old pointer

        return new_block;
    }
}
  100cdf:	4c 89 e0             	mov    %r12,%rax
  100ce2:	48 83 c4 08          	add    $0x8,%rsp
  100ce6:	5b                   	pop    %rbx
  100ce7:	41 5c                	pop    %r12
  100ce9:	41 5d                	pop    %r13
  100ceb:	5d                   	pop    %rbp
  100cec:	c3                   	ret    
    if (ptr == NULL) return malloc(sz);
  100ced:	48 89 f7             	mov    %rsi,%rdi
  100cf0:	e8 d9 fe ff ff       	call   100bce <malloc>
  100cf5:	49 89 c4             	mov    %rax,%r12
  100cf8:	eb e5                	jmp    100cdf <realloc+0x2c>
        free(ptr); return NULL;
  100cfa:	e8 66 fe ff ff       	call   100b65 <free>
  100cff:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100d05:	eb d8                	jmp    100cdf <realloc+0x2c>
    header_list * new_block = malloc(sz);
  100d07:	48 89 f7             	mov    %rsi,%rdi
  100d0a:	e8 bf fe ff ff       	call   100bce <malloc>
  100d0f:	49 89 c4             	mov    %rax,%r12
    if (new_block == NULL)
  100d12:	48 85 c0             	test   %rax,%rax
  100d15:	74 c8                	je     100cdf <realloc+0x2c>
        memcpy(new_block, ptr, block_sz);
  100d17:	4c 89 ea             	mov    %r13,%rdx
  100d1a:	48 89 de             	mov    %rbx,%rsi
  100d1d:	48 89 c7             	mov    %rax,%rdi
  100d20:	e8 e8 f3 ff ff       	call   10010d <memcpy>
        free(ptr); // free the old pointer
  100d25:	48 89 df             	mov    %rbx,%rdi
  100d28:	e8 38 fe ff ff       	call   100b65 <free>
        return new_block;
  100d2d:	eb b0                	jmp    100cdf <realloc+0x2c>
        return NULL;
  100d2f:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100d35:	eb a8                	jmp    100cdf <realloc+0x2c>

0000000000100d37 <defrag>:
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100d37:	48 8b 05 e2 12 00 00 	mov    0x12e2(%rip),%rax        # 102020 <first_bp>
  100d3e:	48 8d 50 f0          	lea    -0x10(%rax),%rdx

void defrag() 
{
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100d42:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  100d46:	48 85 c9             	test   %rcx,%rcx
  100d49:	75 0f                	jne    100d5a <defrag+0x23>
        if (curr->allocated == 0 && adj->allocated == 0)
        {
            curr->size += adj->size;
        }
    }
}
  100d4b:	c3                   	ret    
    return (header_list*) ((uintptr_t) header + header->size); 
  100d4c:	48 03 02             	add    (%rdx),%rax
  100d4f:	48 89 c2             	mov    %rax,%rdx
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100d52:	48 8b 08             	mov    (%rax),%rcx
  100d55:	48 85 c9             	test   %rcx,%rcx
  100d58:	74 f1                	je     100d4b <defrag+0x14>
    return (header_list*) ((uintptr_t) header + header->size); 
  100d5a:	48 89 d0             	mov    %rdx,%rax
        if (curr->allocated == 0 && adj->allocated == 0)
  100d5d:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  100d61:	75 e9                	jne    100d4c <defrag+0x15>
    return (header_list*) ((uintptr_t) header + header->size); 
  100d63:	48 8d 34 0a          	lea    (%rdx,%rcx,1),%rsi
        if (curr->allocated == 0 && adj->allocated == 0)
  100d67:	83 7e 08 00          	cmpl   $0x0,0x8(%rsi)
  100d6b:	75 df                	jne    100d4c <defrag+0x15>
            curr->size += adj->size;
  100d6d:	48 03 0e             	add    (%rsi),%rcx
  100d70:	48 89 0a             	mov    %rcx,(%rdx)
  100d73:	eb d7                	jmp    100d4c <defrag+0x15>

0000000000100d75 <merge_array>:

void merge_array(long *array, int start, int mid, int end, uintptr_t * ptr_array)  
{
  100d75:	55                   	push   %rbp
  100d76:	48 89 e5             	mov    %rsp,%rbp
  100d79:	41 57                	push   %r15
  100d7b:	41 56                	push   %r14
  100d7d:	41 55                	push   %r13
  100d7f:	41 54                	push   %r12
  100d81:	53                   	push   %rbx
  100d82:	48 83 ec 08          	sub    $0x8,%rsp
  100d86:	41 89 f3             	mov    %esi,%r11d
  100d89:	89 d3                	mov    %edx,%ebx
  100d8b:	41 89 cc             	mov    %ecx,%r12d
     long sorted[end - start + 1];
  100d8e:	89 c8                	mov    %ecx,%eax
  100d90:	29 f0                	sub    %esi,%eax
  100d92:	83 c0 01             	add    $0x1,%eax
  100d95:	48 98                	cltq   
  100d97:	48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
  100d9e:	00 
  100d9f:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  100da3:	48 29 c4             	sub    %rax,%rsp
  100da6:	49 89 e1             	mov    %rsp,%r9
     uintptr_t sorted_ptr[end - start + 1];
  100da9:	48 29 c4             	sub    %rax,%rsp
  100dac:	49 89 e2             	mov    %rsp,%r10
     int a = 0;
     int b = start;
     int c = mid + 1;
  100daf:	8d 52 01             	lea    0x1(%rdx),%edx
     while(b <= mid && c <= end)
  100db2:	39 de                	cmp    %ebx,%esi
  100db4:	7f 4f                	jg     100e05 <merge_array+0x90>
  100db6:	39 d1                	cmp    %edx,%ecx
  100db8:	7c 4b                	jl     100e05 <merge_array+0x90>
     int b = start;
  100dba:	89 f1                	mov    %esi,%ecx
     while(b <= mid && c <= end)
  100dbc:	b8 00 00 00 00       	mov    $0x0,%eax
  100dc1:	eb 1f                	jmp    100de2 <merge_array+0x6d>
                sorted_ptr[a] = ptr_array[b];
                a++; b++;
            }
            else
            {
                sorted[a] = array[c];
  100dc3:	4d 89 2c c1          	mov    %r13,(%r9,%rax,8)
                sorted_ptr[a] = ptr_array[c];
  100dc7:	4d 8b 2c f0          	mov    (%r8,%rsi,8),%r13
                a++; c++;
  100dcb:	8d 70 01             	lea    0x1(%rax),%esi
  100dce:	83 c2 01             	add    $0x1,%edx
                sorted_ptr[a] = ptr_array[c];
  100dd1:	4d 89 2c c2          	mov    %r13,(%r10,%rax,8)
     while(b <= mid && c <= end)
  100dd5:	48 83 c0 01          	add    $0x1,%rax
  100dd9:	39 d9                	cmp    %ebx,%ecx
  100ddb:	7f 30                	jg     100e0d <merge_array+0x98>
  100ddd:	44 39 e2             	cmp    %r12d,%edx
  100de0:	7f 2b                	jg     100e0d <merge_array+0x98>
            if(array[b] > array[c])
  100de2:	4c 63 f1             	movslq %ecx,%r14
  100de5:	4e 8b 3c f7          	mov    (%rdi,%r14,8),%r15
  100de9:	48 63 f2             	movslq %edx,%rsi
  100dec:	4c 8b 2c f7          	mov    (%rdi,%rsi,8),%r13
  100df0:	4d 39 ef             	cmp    %r13,%r15
  100df3:	7e ce                	jle    100dc3 <merge_array+0x4e>
                sorted[a] = array[b];
  100df5:	4d 89 3c c1          	mov    %r15,(%r9,%rax,8)
                sorted_ptr[a] = ptr_array[b];
  100df9:	4f 8b 2c f0          	mov    (%r8,%r14,8),%r13
                a++; b++;
  100dfd:	8d 70 01             	lea    0x1(%rax),%esi
  100e00:	83 c1 01             	add    $0x1,%ecx
  100e03:	eb cc                	jmp    100dd1 <merge_array+0x5c>
     int b = start;
  100e05:	44 89 d9             	mov    %r11d,%ecx
     int a = 0;
  100e08:	be 00 00 00 00       	mov    $0x0,%esi
            }
     }

     while(b <= mid) 
  100e0d:	39 cb                	cmp    %ecx,%ebx
  100e0f:	7c 32                	jl     100e43 <merge_array+0xce>
  100e11:	48 63 c1             	movslq %ecx,%rax
  100e14:	4c 63 f6             	movslq %esi,%r14
  100e17:	49 29 c6             	sub    %rax,%r14
  100e1a:	49 c1 e6 03          	shl    $0x3,%r14
  100e1e:	4f 8d 3c 31          	lea    (%r9,%r14,1),%r15
  100e22:	4d 01 d6             	add    %r10,%r14
     {
         sorted[a] = array[b];
  100e25:	4c 8b 2c c7          	mov    (%rdi,%rax,8),%r13
  100e29:	4d 89 2c c7          	mov    %r13,(%r15,%rax,8)
         sorted_ptr[a] = ptr_array[b];
  100e2d:	4d 8b 2c c0          	mov    (%r8,%rax,8),%r13
  100e31:	4d 89 2c c6          	mov    %r13,(%r14,%rax,8)
     while(b <= mid) 
  100e35:	48 83 c0 01          	add    $0x1,%rax
  100e39:	39 c3                	cmp    %eax,%ebx
  100e3b:	7d e8                	jge    100e25 <merge_array+0xb0>
  100e3d:	8d 74 1e 01          	lea    0x1(%rsi,%rbx,1),%esi
         a++; b++;
  100e41:	29 ce                	sub    %ecx,%esi
     }
     while(c <= end)
  100e43:	41 39 d4             	cmp    %edx,%r12d
  100e46:	7c 35                	jl     100e7d <merge_array+0x108>
  100e48:	48 63 c2             	movslq %edx,%rax
  100e4b:	48 63 de             	movslq %esi,%rbx
  100e4e:	48 29 c3             	sub    %rax,%rbx
  100e51:	48 c1 e3 03          	shl    $0x3,%rbx
  100e55:	4d 8d 2c 19          	lea    (%r9,%rbx,1),%r13
  100e59:	4c 01 d3             	add    %r10,%rbx
     {
        sorted[a] = array[c];
  100e5c:	48 8b 0c c7          	mov    (%rdi,%rax,8),%rcx
  100e60:	49 89 4c c5 00       	mov    %rcx,0x0(%r13,%rax,8)
        sorted_ptr[a] = ptr_array[c];
  100e65:	49 8b 0c c0          	mov    (%r8,%rax,8),%rcx
  100e69:	48 89 0c c3          	mov    %rcx,(%rbx,%rax,8)
     while(c <= end)
  100e6d:	48 83 c0 01          	add    $0x1,%rax
  100e71:	41 39 c4             	cmp    %eax,%r12d
  100e74:	7d e6                	jge    100e5c <merge_array+0xe7>
  100e76:	29 d6                	sub    %edx,%esi
        a++; c++;
  100e78:	42 8d 74 26 01       	lea    0x1(%rsi,%r12,1),%esi
     }
     int i;
     for(i = 0; i < a; i++) 
  100e7d:	85 f6                	test   %esi,%esi
  100e7f:	7e 2d                	jle    100eae <merge_array+0x139>
  100e81:	89 f6                	mov    %esi,%esi
  100e83:	4d 63 db             	movslq %r11d,%r11
  100e86:	49 c1 e3 03          	shl    $0x3,%r11
  100e8a:	4c 01 df             	add    %r11,%rdi
  100e8d:	4d 01 d8             	add    %r11,%r8
  100e90:	b8 00 00 00 00       	mov    $0x0,%eax
     {
        array[i + start] = sorted[i];
  100e95:	49 8b 14 c1          	mov    (%r9,%rax,8),%rdx
  100e99:	48 89 14 c7          	mov    %rdx,(%rdi,%rax,8)
        ptr_array[i + start] = sorted_ptr[i];
  100e9d:	49 8b 14 c2          	mov    (%r10,%rax,8),%rdx
  100ea1:	49 89 14 c0          	mov    %rdx,(%r8,%rax,8)
     for(i = 0; i < a; i++) 
  100ea5:	48 83 c0 01          	add    $0x1,%rax
  100ea9:	48 39 f0             	cmp    %rsi,%rax
  100eac:	75 e7                	jne    100e95 <merge_array+0x120>
     }
}
  100eae:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  100eb2:	5b                   	pop    %rbx
  100eb3:	41 5c                	pop    %r12
  100eb5:	41 5d                	pop    %r13
  100eb7:	41 5e                	pop    %r14
  100eb9:	41 5f                	pop    %r15
  100ebb:	5d                   	pop    %rbp
  100ebc:	c3                   	ret    

0000000000100ebd <merge_sort>:

void merge_sort(long * array, int start, int end, uintptr_t * ptr_array) {
    int mid = (start + end) / 2;
    if(start < end) {
  100ebd:	39 d6                	cmp    %edx,%esi
  100ebf:	7c 01                	jl     100ec2 <merge_sort+0x5>
  100ec1:	c3                   	ret    
void merge_sort(long * array, int start, int end, uintptr_t * ptr_array) {
  100ec2:	55                   	push   %rbp
  100ec3:	48 89 e5             	mov    %rsp,%rbp
  100ec6:	41 57                	push   %r15
  100ec8:	41 56                	push   %r14
  100eca:	41 55                	push   %r13
  100ecc:	41 54                	push   %r12
  100ece:	53                   	push   %rbx
  100ecf:	48 83 ec 08          	sub    $0x8,%rsp
  100ed3:	49 89 fd             	mov    %rdi,%r13
  100ed6:	89 f3                	mov    %esi,%ebx
  100ed8:	41 89 d4             	mov    %edx,%r12d
  100edb:	49 89 cf             	mov    %rcx,%r15
    int mid = (start + end) / 2;
  100ede:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
  100ee1:	41 89 c6             	mov    %eax,%r14d
  100ee4:	41 c1 ee 1f          	shr    $0x1f,%r14d
  100ee8:	41 01 c6             	add    %eax,%r14d
  100eeb:	41 d1 fe             	sar    %r14d
        merge_sort(array, start, mid, ptr_array);
  100eee:	44 89 f2             	mov    %r14d,%edx
  100ef1:	e8 c7 ff ff ff       	call   100ebd <merge_sort>
        merge_sort(array, mid + 1, end, ptr_array);
  100ef6:	41 8d 76 01          	lea    0x1(%r14),%esi
  100efa:	4c 89 f9             	mov    %r15,%rcx
  100efd:	44 89 e2             	mov    %r12d,%edx
  100f00:	4c 89 ef             	mov    %r13,%rdi
  100f03:	e8 b5 ff ff ff       	call   100ebd <merge_sort>
        merge_array(array, start, mid, end, ptr_array);
  100f08:	4d 89 f8             	mov    %r15,%r8
  100f0b:	44 89 e1             	mov    %r12d,%ecx
  100f0e:	44 89 f2             	mov    %r14d,%edx
  100f11:	89 de                	mov    %ebx,%esi
  100f13:	4c 89 ef             	mov    %r13,%rdi
  100f16:	e8 5a fe ff ff       	call   100d75 <merge_array>
    }

}
  100f1b:	48 83 c4 08          	add    $0x8,%rsp
  100f1f:	5b                   	pop    %rbx
  100f20:	41 5c                	pop    %r12
  100f22:	41 5d                	pop    %r13
  100f24:	41 5e                	pop    %r14
  100f26:	41 5f                	pop    %r15
  100f28:	5d                   	pop    %rbp
  100f29:	c3                   	ret    

0000000000100f2a <heap_info>:
//     int free_space;
//     int largest_free_chunk;
// } heap_info_struct;

int heap_info(heap_info_struct * info) 
{
  100f2a:	55                   	push   %rbp
  100f2b:	48 89 e5             	mov    %rsp,%rbp
  100f2e:	41 56                	push   %r14
  100f30:	41 55                	push   %r13
  100f32:	41 54                	push   %r12
  100f34:	53                   	push   %rbx
  100f35:	49 89 fc             	mov    %rdi,%r12
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100f38:	48 8b 15 e1 10 00 00 	mov    0x10e1(%rip),%rdx        # 102020 <first_bp>
  100f3f:	48 8d 42 f0          	lea    -0x10(%rdx),%rax
    long * size_array = NULL;
    void ** ptr_array = NULL;
    int free_space = 0;
    int largest_free_chunk = 0;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100f43:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  100f47:	48 85 d2             	test   %rdx,%rdx
  100f4a:	74 40                	je     100f8c <heap_info+0x62>
    int num_allocs = 0;
  100f4c:	bb 00 00 00 00       	mov    $0x0,%ebx
    {
        if (curr->allocated == 1) num_allocs++; 
  100f51:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  100f55:	0f 94 c1             	sete   %cl
  100f58:	0f b6 c9             	movzbl %cl,%ecx
  100f5b:	01 cb                	add    %ecx,%ebx
    return (header_list*) ((uintptr_t) header + header->size); 
  100f5d:	48 01 d0             	add    %rdx,%rax
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100f60:	48 8b 10             	mov    (%rax),%rdx
  100f63:	48 85 d2             	test   %rdx,%rdx
  100f66:	75 e9                	jne    100f51 <heap_info+0x27>
    }

    info->num_allocs = num_allocs;
  100f68:	41 89 1c 24          	mov    %ebx,(%r12)
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100f6c:	48 8b 05 ad 10 00 00 	mov    0x10ad(%rip),%rax        # 102020 <first_bp>
  100f73:	48 8d 50 f0          	lea    -0x10(%rax),%rdx

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100f77:	48 8b 40 f0          	mov    -0x10(%rax),%rax
  100f7b:	48 85 c0             	test   %rax,%rax
  100f7e:	74 2d                	je     100fad <heap_info+0x83>
    int largest_free_chunk = 0;
  100f80:	b9 00 00 00 00       	mov    $0x0,%ecx
    int free_space = 0;
  100f85:	bf 00 00 00 00       	mov    $0x0,%edi
  100f8a:	eb 12                	jmp    100f9e <heap_info+0x74>
    int num_allocs = 0;
  100f8c:	bb 00 00 00 00       	mov    $0x0,%ebx
  100f91:	eb d5                	jmp    100f68 <heap_info+0x3e>
    return (header_list*) ((uintptr_t) header + header->size); 
  100f93:	48 01 c2             	add    %rax,%rdx
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100f96:	48 8b 02             	mov    (%rdx),%rax
  100f99:	48 85 c0             	test   %rax,%rax
  100f9c:	74 19                	je     100fb7 <heap_info+0x8d>
    {   // free space that was not made by heap_info
        if (curr->allocated == 0) 
  100f9e:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  100fa2:	75 ef                	jne    100f93 <heap_info+0x69>
        {
            free_space += curr->size;
  100fa4:	01 c7                	add    %eax,%edi
            if (largest_free_chunk < (int) curr->size)
  100fa6:	39 c1                	cmp    %eax,%ecx
  100fa8:	0f 4c c8             	cmovl  %eax,%ecx
  100fab:	eb e6                	jmp    100f93 <heap_info+0x69>
    int largest_free_chunk = 0;
  100fad:	b9 00 00 00 00       	mov    $0x0,%ecx
    int free_space = 0;
  100fb2:	bf 00 00 00 00       	mov    $0x0,%edi
            {
                largest_free_chunk = (int) curr->size;
            }
        }
    }
    info->free_space = free_space;
  100fb7:	41 89 7c 24 18       	mov    %edi,0x18(%r12)
    info->largest_free_chunk = largest_free_chunk;
  100fbc:	41 89 4c 24 1c       	mov    %ecx,0x1c(%r12)

    // app_printf(0, "Finished calculating free chunks\n");

    size_array = malloc(sizeof(long) * num_allocs);
  100fc1:	4c 63 f3             	movslq %ebx,%r14
  100fc4:	49 c1 e6 03          	shl    $0x3,%r14
  100fc8:	4c 89 f7             	mov    %r14,%rdi
  100fcb:	e8 fe fb ff ff       	call   100bce <malloc>
  100fd0:	49 89 c5             	mov    %rax,%r13
    ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
  100fd3:	4c 89 f7             	mov    %r14,%rdi
  100fd6:	e8 f3 fb ff ff       	call   100bce <malloc>
  100fdb:	49 89 c6             	mov    %rax,%r14
    // ret_ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
    
    if (num_allocs == 0)
  100fde:	85 db                	test   %ebx,%ebx
  100fe0:	74 2b                	je     10100d <heap_info+0xe3>
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;        
    }
    // otherwise must be an error in malloc
    else if (size_array == NULL || ptr_array == NULL) return -1;
  100fe2:	4d 85 ed             	test   %r13,%r13
  100fe5:	0f 84 a6 00 00 00    	je     101091 <heap_info+0x167>
  100feb:	48 85 c0             	test   %rax,%rax
  100fee:	0f 84 9d 00 00 00    	je     101091 <heap_info+0x167>
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  100ff4:	48 8b 15 25 10 00 00 	mov    0x1025(%rip),%rdx        # 102020 <first_bp>
  100ffb:	48 8d 42 f0          	lea    -0x10(%rdx),%rax
    // app_printf(0, "Finished mallocing arrays\n");
    // app_printf(0, "size_array add: %p, start of ptr_array add: %p\n", (uintptr_t) ptr_array, (uintptr_t) size_array);

    uint64_t i = 0;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  100fff:	48 83 7a f0 00       	cmpq   $0x0,-0x10(%rdx)
  101004:	74 4e                	je     101054 <heap_info+0x12a>
    uint64_t i = 0;
  101006:	b9 00 00 00 00       	mov    $0x0,%ecx
  10100b:	eb 31                	jmp    10103e <heap_info+0x114>
        info->size_array = NULL;
  10100d:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  101014:	00 00 
        info->ptr_array = NULL;
  101016:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  10101d:	00 00 
        return 0;        
  10101f:	eb 65                	jmp    101086 <heap_info+0x15c>
        if (curr->allocated == 1)
        {
            // don't count the size_array and ptr_array malloc
            void * mem_payload = grab_payload(curr);
            if (size_array == mem_payload || ptr_array == mem_payload) continue;
            ptr_array[i] = mem_payload;
  101021:	49 89 14 ce          	mov    %rdx,(%r14,%rcx,8)
            size_array[i] = curr->size - HEADER_SZ;
  101025:	48 8b 30             	mov    (%rax),%rsi
  101028:	48 8d 56 f0          	lea    -0x10(%rsi),%rdx
  10102c:	49 89 54 cd 00       	mov    %rdx,0x0(%r13,%rcx,8)
            i++;
  101031:	48 83 c1 01          	add    $0x1,%rcx
    return (header_list*) ((uintptr_t) header + header->size); 
  101035:	48 03 00             	add    (%rax),%rax
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  101038:	48 83 38 00          	cmpq   $0x0,(%rax)
  10103c:	74 16                	je     101054 <heap_info+0x12a>
        if (curr->allocated == 1)
  10103e:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  101042:	75 f1                	jne    101035 <heap_info+0x10b>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  101044:	48 8d 50 10          	lea    0x10(%rax),%rdx
            if (size_array == mem_payload || ptr_array == mem_payload) continue;
  101048:	49 39 d5             	cmp    %rdx,%r13
  10104b:	74 e8                	je     101035 <heap_info+0x10b>
  10104d:	49 39 d6             	cmp    %rdx,%r14
  101050:	75 cf                	jne    101021 <heap_info+0xf7>
  101052:	eb e1                	jmp    101035 <heap_info+0x10b>
    //     app_printf(0, "at idx %d is %p\n", j, ptr_array[j]);
    // }

    // app_printf(0, "Finished filling arrays\n");

    merge_sort(size_array, 0, num_allocs-1, (uintptr_t *) ptr_array);
  101054:	8d 53 ff             	lea    -0x1(%rbx),%edx
  101057:	4c 89 f1             	mov    %r14,%rcx
  10105a:	be 00 00 00 00       	mov    $0x0,%esi
  10105f:	4c 89 ef             	mov    %r13,%rdi
  101062:	e8 56 fe ff ff       	call   100ebd <merge_sort>

    info->size_array = size_array;
  101067:	4d 89 6c 24 08       	mov    %r13,0x8(%r12)
    info->ptr_array = ptr_array; // need to make sure this is sorted in accordance to size
  10106c:	4d 89 74 24 10       	mov    %r14,0x10(%r12)
    // }


    // app_printf(0, "successful, exiting!\n");

    free(size_array);
  101071:	4c 89 ef             	mov    %r13,%rdi
  101074:	e8 ec fa ff ff       	call   100b65 <free>
    free(ptr_array);
  101079:	4c 89 f7             	mov    %r14,%rdi
  10107c:	e8 e4 fa ff ff       	call   100b65 <free>

    return 0;
  101081:	bb 00 00 00 00       	mov    $0x0,%ebx
}
  101086:	89 d8                	mov    %ebx,%eax
  101088:	5b                   	pop    %rbx
  101089:	41 5c                	pop    %r12
  10108b:	41 5d                	pop    %r13
  10108d:	41 5e                	pop    %r14
  10108f:	5d                   	pop    %rbp
  101090:	c3                   	ret    
    else if (size_array == NULL || ptr_array == NULL) return -1;
  101091:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  101096:	eb ee                	jmp    101086 <heap_info+0x15c>
