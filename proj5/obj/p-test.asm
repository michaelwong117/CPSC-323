
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 54                	push   %r12
  100006:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100007:	cd 31                	int    $0x31
  100009:	41 89 c4             	mov    %eax,%r12d

    pid_t parent = sys_getpid();
    app_printf(parent, "Parent pid is %d\n", parent);
  10000c:	89 c2                	mov    %eax,%edx
  10000e:	be f0 0c 10 00       	mov    $0x100cf0,%esi
  100013:	89 c7                	mov    %eax,%edi
  100015:	b8 00 00 00 00       	mov    $0x0,%eax
  10001a:	e8 45 0b 00 00       	call   100b64 <app_printf>
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10001f:	cd 34                	int    $0x34
    pid_t fork = sys_fork();
    assert(fork >= 0);
  100021:	85 c0                	test   %eax,%eax
  100023:	78 44                	js     100069 <process_main+0x69>
  100025:	89 c3                	mov    %eax,%ebx

    srand(parent);
  100027:	44 89 e7             	mov    %r12d,%edi
  10002a:	e8 29 03 00 00       	call   100358 <srand>
    if(fork != 0){
  10002f:	85 db                	test   %ebx,%ebx
  100031:	75 4a                	jne    10007d <process_main+0x7d>
    asm volatile ("int %1" : "=a" (result)
  100033:	cd 31                	int    $0x31
  100035:	89 c3                	mov    %eax,%ebx
    }
    else
    {
child:;
        pid_t p = sys_getpid();
        srand(p);
  100037:	89 c7                	mov    %eax,%edi
  100039:	e8 1a 03 00 00       	call   100358 <srand>

        // The heap starts on the page right after the 'end' symbol,
        // whose address is the first address not allocated to process code
        // or data.
        heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10003e:	b8 17 20 10 00       	mov    $0x102017,%eax
  100043:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100049:	48 89 05 b8 0f 00 00 	mov    %rax,0xfb8(%rip)        # 101008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100050:	48 89 e0             	mov    %rsp,%rax

        // The bottom of the stack is the first address on the current
        // stack page (this process never needs more than one stack page).
        stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100053:	48 83 e8 01          	sub    $0x1,%rax
  100057:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10005d:	48 89 05 9c 0f 00 00 	mov    %rax,0xf9c(%rip)        # 101000 <stack_bottom>
  100064:	e9 94 00 00 00       	jmp    1000fd <process_main+0xfd>
    assert(fork >= 0);
  100069:	ba 02 0d 10 00       	mov    $0x100d02,%edx
  10006e:	be 10 00 00 00       	mov    $0x10,%esi
  100073:	bf 0c 0d 10 00       	mov    $0x100d0c,%edi
  100078:	e8 44 0c 00 00       	call   100cc1 <assert_fail>
        app_printf(parent, "%dp\n", parent);
  10007d:	44 89 e2             	mov    %r12d,%edx
  100080:	be 15 0d 10 00       	mov    $0x100d15,%esi
  100085:	44 89 e7             	mov    %r12d,%edi
  100088:	b8 00 00 00 00       	mov    $0x0,%eax
  10008d:	e8 d2 0a 00 00       	call   100b64 <app_printf>
  100092:	eb 08                	jmp    10009c <process_main+0x9c>
    asm volatile ("int %1" : "=a" (result)
  100094:	cd 34                	int    $0x34
                if(fork_new == 0){
  100096:	85 c0                	test   %eax,%eax
  100098:	74 99                	je     100033 <process_main+0x33>
    asm volatile ("int %0" : /* no result */
  10009a:	cd 32                	int    $0x32
            if(rand() % ALLOC_SLOWDOWN == parent){
  10009c:	e8 7d 02 00 00       	call   10031e <rand>
  1000a1:	48 63 d0             	movslq %eax,%rdx
  1000a4:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000ab:	48 c1 fa 25          	sar    $0x25,%rdx
  1000af:	89 c1                	mov    %eax,%ecx
  1000b1:	c1 f9 1f             	sar    $0x1f,%ecx
  1000b4:	29 ca                	sub    %ecx,%edx
  1000b6:	6b d2 64             	imul   $0x64,%edx,%edx
  1000b9:	29 d0                	sub    %edx,%eax
  1000bb:	44 39 e0             	cmp    %r12d,%eax
  1000be:	74 d4                	je     100094 <process_main+0x94>
  1000c0:	cd 32                	int    $0x32
}
  1000c2:	eb d8                	jmp    10009c <process_main+0x9c>

        // Allocate heap pages until (1) hit the stack (out of address space)
        // or (2) allocation fails (out of physical memory).
        while (1) {
            if ((rand() % ALLOC_SLOWDOWN) < p) {
                assert(sys_getpid() != parent);
  1000c4:	ba 1a 0d 10 00       	mov    $0x100d1a,%edx
  1000c9:	be 36 00 00 00       	mov    $0x36,%esi
  1000ce:	bf 0c 0d 10 00       	mov    $0x100d0c,%edi
  1000d3:	e8 e9 0b 00 00       	call   100cc1 <assert_fail>
void process_main(void) {
  1000d8:	b8 0a 00 00 00       	mov    $0xa,%eax
    asm volatile ("int %0" : /* no result */
  1000dd:	cd 32                	int    $0x32
            sys_yield();
        }

        // After running out of memory, make an exit after 10 yields
        int i = 10;
        while(i--){
  1000df:	83 e8 01             	sub    $0x1,%eax
  1000e2:	75 f9                	jne    1000dd <process_main+0xdd>
            sys_yield();
        }
        app_printf(p, "%d\n", p);
  1000e4:	89 da                	mov    %ebx,%edx
  1000e6:	be fe 0c 10 00       	mov    $0x100cfe,%esi
  1000eb:	89 df                	mov    %ebx,%edi
  1000ed:	b8 00 00 00 00       	mov    $0x0,%eax
  1000f2:	e8 6d 0a 00 00       	call   100b64 <app_printf>

// sys_exit()
//    Exit this process. Does not return.
static inline void sys_exit(void) __attribute__((noreturn));
static inline void sys_exit(void) {
    asm volatile ("int %0" : /* no result */
  1000f7:	cd 35                	int    $0x35
                  : "i" (INT_SYS_EXIT)
                  : "cc", "memory");
 spinloop: goto spinloop;       // should never get here
  1000f9:	eb fe                	jmp    1000f9 <process_main+0xf9>
    asm volatile ("int %0" : /* no result */
  1000fb:	cd 32                	int    $0x32
            if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000fd:	e8 1c 02 00 00       	call   10031e <rand>
  100102:	48 63 d0             	movslq %eax,%rdx
  100105:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10010c:	48 c1 fa 25          	sar    $0x25,%rdx
  100110:	89 c1                	mov    %eax,%ecx
  100112:	c1 f9 1f             	sar    $0x1f,%ecx
  100115:	29 ca                	sub    %ecx,%edx
  100117:	6b d2 64             	imul   $0x64,%edx,%edx
  10011a:	29 d0                	sub    %edx,%eax
  10011c:	39 d8                	cmp    %ebx,%eax
  10011e:	7d db                	jge    1000fb <process_main+0xfb>
    asm volatile ("int %1" : "=a" (result)
  100120:	cd 31                	int    $0x31
                assert(sys_getpid() != parent);
  100122:	41 39 c4             	cmp    %eax,%r12d
  100125:	74 9d                	je     1000c4 <process_main+0xc4>
                if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  100127:	48 8b 3d da 0e 00 00 	mov    0xeda(%rip),%rdi        # 101008 <heap_top>
  10012e:	48 3b 3d cb 0e 00 00 	cmp    0xecb(%rip),%rdi        # 101000 <stack_bottom>
  100135:	74 a1                	je     1000d8 <process_main+0xd8>
    asm volatile ("int %1" : "=a" (result)
  100137:	cd 33                	int    $0x33
  100139:	85 c0                	test   %eax,%eax
  10013b:	78 9b                	js     1000d8 <process_main+0xd8>
                *heap_top = p;      /* check we have write access to new page */
  10013d:	48 8b 05 c4 0e 00 00 	mov    0xec4(%rip),%rax        # 101008 <heap_top>
  100144:	88 18                	mov    %bl,(%rax)
                heap_top += PAGESIZE;
  100146:	48 81 05 b7 0e 00 00 	addq   $0x1000,0xeb7(%rip)        # 101008 <heap_top>
  10014d:	00 10 00 00 
  100151:	eb a8                	jmp    1000fb <process_main+0xfb>

0000000000100153 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100153:	48 89 f9             	mov    %rdi,%rcx
  100156:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100158:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10015f:	00 
  100160:	72 08                	jb     10016a <console_putc+0x17>
        cp->cursor = console;
  100162:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100169:	00 
    }
    if (c == '\n') {
  10016a:	40 80 fe 0a          	cmp    $0xa,%sil
  10016e:	74 16                	je     100186 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100170:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100174:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100178:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10017c:	40 0f b6 f6          	movzbl %sil,%esi
  100180:	09 fe                	or     %edi,%esi
  100182:	66 89 30             	mov    %si,(%rax)
    }
}
  100185:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  100186:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  10018a:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100191:	4c 89 c6             	mov    %r8,%rsi
  100194:	48 d1 fe             	sar    %rsi
  100197:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10019e:	66 66 66 
  1001a1:	48 89 f0             	mov    %rsi,%rax
  1001a4:	48 f7 ea             	imul   %rdx
  1001a7:	48 c1 fa 05          	sar    $0x5,%rdx
  1001ab:	49 c1 f8 3f          	sar    $0x3f,%r8
  1001af:	4c 29 c2             	sub    %r8,%rdx
  1001b2:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1001b6:	48 c1 e2 04          	shl    $0x4,%rdx
  1001ba:	89 f0                	mov    %esi,%eax
  1001bc:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1001be:	83 cf 20             	or     $0x20,%edi
  1001c1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1001c5:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1001c9:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1001cd:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1001d0:	83 c0 01             	add    $0x1,%eax
  1001d3:	83 f8 50             	cmp    $0x50,%eax
  1001d6:	75 e9                	jne    1001c1 <console_putc+0x6e>
  1001d8:	c3                   	ret    

00000000001001d9 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1001d9:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001dd:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1001e1:	73 0b                	jae    1001ee <string_putc+0x15>
        *sp->s++ = c;
  1001e3:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1001e7:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001eb:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1001ee:	c3                   	ret    

00000000001001ef <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1001ef:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001f2:	48 85 d2             	test   %rdx,%rdx
  1001f5:	74 17                	je     10020e <memcpy+0x1f>
  1001f7:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1001fc:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100201:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100205:	48 83 c1 01          	add    $0x1,%rcx
  100209:	48 39 d1             	cmp    %rdx,%rcx
  10020c:	75 ee                	jne    1001fc <memcpy+0xd>
}
  10020e:	c3                   	ret    

000000000010020f <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10020f:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100212:	48 39 fe             	cmp    %rdi,%rsi
  100215:	72 1d                	jb     100234 <memmove+0x25>
        while (n-- > 0) {
  100217:	b9 00 00 00 00       	mov    $0x0,%ecx
  10021c:	48 85 d2             	test   %rdx,%rdx
  10021f:	74 12                	je     100233 <memmove+0x24>
            *d++ = *s++;
  100221:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100225:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100229:	48 83 c1 01          	add    $0x1,%rcx
  10022d:	48 39 ca             	cmp    %rcx,%rdx
  100230:	75 ef                	jne    100221 <memmove+0x12>
}
  100232:	c3                   	ret    
  100233:	c3                   	ret    
    if (s < d && s + n > d) {
  100234:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100238:	48 39 cf             	cmp    %rcx,%rdi
  10023b:	73 da                	jae    100217 <memmove+0x8>
        while (n-- > 0) {
  10023d:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100241:	48 85 d2             	test   %rdx,%rdx
  100244:	74 ec                	je     100232 <memmove+0x23>
            *--d = *--s;
  100246:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  10024a:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10024d:	48 83 e9 01          	sub    $0x1,%rcx
  100251:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100255:	75 ef                	jne    100246 <memmove+0x37>
  100257:	c3                   	ret    

0000000000100258 <memset>:
void* memset(void* v, int c, size_t n) {
  100258:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10025b:	48 85 d2             	test   %rdx,%rdx
  10025e:	74 12                	je     100272 <memset+0x1a>
  100260:	48 01 fa             	add    %rdi,%rdx
  100263:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100266:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100269:	48 83 c1 01          	add    $0x1,%rcx
  10026d:	48 39 ca             	cmp    %rcx,%rdx
  100270:	75 f4                	jne    100266 <memset+0xe>
}
  100272:	c3                   	ret    

0000000000100273 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100273:	80 3f 00             	cmpb   $0x0,(%rdi)
  100276:	74 10                	je     100288 <strlen+0x15>
  100278:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10027d:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100281:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100285:	75 f6                	jne    10027d <strlen+0xa>
  100287:	c3                   	ret    
  100288:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10028d:	c3                   	ret    

000000000010028e <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  10028e:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100291:	ba 00 00 00 00       	mov    $0x0,%edx
  100296:	48 85 f6             	test   %rsi,%rsi
  100299:	74 11                	je     1002ac <strnlen+0x1e>
  10029b:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  10029f:	74 0c                	je     1002ad <strnlen+0x1f>
        ++n;
  1002a1:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002a5:	48 39 d0             	cmp    %rdx,%rax
  1002a8:	75 f1                	jne    10029b <strnlen+0xd>
  1002aa:	eb 04                	jmp    1002b0 <strnlen+0x22>
  1002ac:	c3                   	ret    
  1002ad:	48 89 d0             	mov    %rdx,%rax
}
  1002b0:	c3                   	ret    

00000000001002b1 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1002b1:	48 89 f8             	mov    %rdi,%rax
  1002b4:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1002b9:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1002bd:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1002c0:	48 83 c2 01          	add    $0x1,%rdx
  1002c4:	84 c9                	test   %cl,%cl
  1002c6:	75 f1                	jne    1002b9 <strcpy+0x8>
}
  1002c8:	c3                   	ret    

00000000001002c9 <strcmp>:
    while (*a && *b && *a == *b) {
  1002c9:	0f b6 07             	movzbl (%rdi),%eax
  1002cc:	84 c0                	test   %al,%al
  1002ce:	74 1a                	je     1002ea <strcmp+0x21>
  1002d0:	0f b6 16             	movzbl (%rsi),%edx
  1002d3:	38 c2                	cmp    %al,%dl
  1002d5:	75 13                	jne    1002ea <strcmp+0x21>
  1002d7:	84 d2                	test   %dl,%dl
  1002d9:	74 0f                	je     1002ea <strcmp+0x21>
        ++a, ++b;
  1002db:	48 83 c7 01          	add    $0x1,%rdi
  1002df:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1002e3:	0f b6 07             	movzbl (%rdi),%eax
  1002e6:	84 c0                	test   %al,%al
  1002e8:	75 e6                	jne    1002d0 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1002ea:	3a 06                	cmp    (%rsi),%al
  1002ec:	0f 97 c0             	seta   %al
  1002ef:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1002f2:	83 d8 00             	sbb    $0x0,%eax
}
  1002f5:	c3                   	ret    

00000000001002f6 <strchr>:
    while (*s && *s != (char) c) {
  1002f6:	0f b6 07             	movzbl (%rdi),%eax
  1002f9:	84 c0                	test   %al,%al
  1002fb:	74 10                	je     10030d <strchr+0x17>
  1002fd:	40 38 f0             	cmp    %sil,%al
  100300:	74 18                	je     10031a <strchr+0x24>
        ++s;
  100302:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100306:	0f b6 07             	movzbl (%rdi),%eax
  100309:	84 c0                	test   %al,%al
  10030b:	75 f0                	jne    1002fd <strchr+0x7>
        return NULL;
  10030d:	40 84 f6             	test   %sil,%sil
  100310:	b8 00 00 00 00       	mov    $0x0,%eax
  100315:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100319:	c3                   	ret    
  10031a:	48 89 f8             	mov    %rdi,%rax
  10031d:	c3                   	ret    

000000000010031e <rand>:
    if (!rand_seed_set) {
  10031e:	83 3d ef 0c 00 00 00 	cmpl   $0x0,0xcef(%rip)        # 101014 <rand_seed_set>
  100325:	74 1b                	je     100342 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100327:	69 05 df 0c 00 00 0d 	imul   $0x19660d,0xcdf(%rip),%eax        # 101010 <rand_seed>
  10032e:	66 19 00 
  100331:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100336:	89 05 d4 0c 00 00    	mov    %eax,0xcd4(%rip)        # 101010 <rand_seed>
    return rand_seed & RAND_MAX;
  10033c:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100341:	c3                   	ret    
    rand_seed = seed;
  100342:	c7 05 c4 0c 00 00 9e 	movl   $0x30d4879e,0xcc4(%rip)        # 101010 <rand_seed>
  100349:	87 d4 30 
    rand_seed_set = 1;
  10034c:	c7 05 be 0c 00 00 01 	movl   $0x1,0xcbe(%rip)        # 101014 <rand_seed_set>
  100353:	00 00 00 
}
  100356:	eb cf                	jmp    100327 <rand+0x9>

0000000000100358 <srand>:
    rand_seed = seed;
  100358:	89 3d b2 0c 00 00    	mov    %edi,0xcb2(%rip)        # 101010 <rand_seed>
    rand_seed_set = 1;
  10035e:	c7 05 ac 0c 00 00 01 	movl   $0x1,0xcac(%rip)        # 101014 <rand_seed_set>
  100365:	00 00 00 
}
  100368:	c3                   	ret    

0000000000100369 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100369:	55                   	push   %rbp
  10036a:	48 89 e5             	mov    %rsp,%rbp
  10036d:	41 57                	push   %r15
  10036f:	41 56                	push   %r14
  100371:	41 55                	push   %r13
  100373:	41 54                	push   %r12
  100375:	53                   	push   %rbx
  100376:	48 83 ec 58          	sub    $0x58,%rsp
  10037a:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10037e:	0f b6 02             	movzbl (%rdx),%eax
  100381:	84 c0                	test   %al,%al
  100383:	0f 84 b0 06 00 00    	je     100a39 <printer_vprintf+0x6d0>
  100389:	49 89 fe             	mov    %rdi,%r14
  10038c:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  10038f:	41 89 f7             	mov    %esi,%r15d
  100392:	e9 a4 04 00 00       	jmp    10083b <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  100397:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  10039c:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1003a2:	45 84 e4             	test   %r12b,%r12b
  1003a5:	0f 84 82 06 00 00    	je     100a2d <printer_vprintf+0x6c4>
        int flags = 0;
  1003ab:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1003b1:	41 0f be f4          	movsbl %r12b,%esi
  1003b5:	bf 31 0f 10 00       	mov    $0x100f31,%edi
  1003ba:	e8 37 ff ff ff       	call   1002f6 <strchr>
  1003bf:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1003c2:	48 85 c0             	test   %rax,%rax
  1003c5:	74 55                	je     10041c <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1003c7:	48 81 e9 31 0f 10 00 	sub    $0x100f31,%rcx
  1003ce:	b8 01 00 00 00       	mov    $0x1,%eax
  1003d3:	d3 e0                	shl    %cl,%eax
  1003d5:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1003d8:	48 83 c3 01          	add    $0x1,%rbx
  1003dc:	44 0f b6 23          	movzbl (%rbx),%r12d
  1003e0:	45 84 e4             	test   %r12b,%r12b
  1003e3:	75 cc                	jne    1003b1 <printer_vprintf+0x48>
  1003e5:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1003e9:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1003ef:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1003f6:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1003f9:	0f 84 a9 00 00 00    	je     1004a8 <printer_vprintf+0x13f>
        int length = 0;
  1003ff:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100404:	0f b6 13             	movzbl (%rbx),%edx
  100407:	8d 42 bd             	lea    -0x43(%rdx),%eax
  10040a:	3c 37                	cmp    $0x37,%al
  10040c:	0f 87 c4 04 00 00    	ja     1008d6 <printer_vprintf+0x56d>
  100412:	0f b6 c0             	movzbl %al,%eax
  100415:	ff 24 c5 40 0d 10 00 	jmp    *0x100d40(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10041c:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  100420:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100425:	3c 08                	cmp    $0x8,%al
  100427:	77 2f                	ja     100458 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100429:	0f b6 03             	movzbl (%rbx),%eax
  10042c:	8d 50 d0             	lea    -0x30(%rax),%edx
  10042f:	80 fa 09             	cmp    $0x9,%dl
  100432:	77 5e                	ja     100492 <printer_vprintf+0x129>
  100434:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  10043a:	48 83 c3 01          	add    $0x1,%rbx
  10043e:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100443:	0f be c0             	movsbl %al,%eax
  100446:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10044b:	0f b6 03             	movzbl (%rbx),%eax
  10044e:	8d 50 d0             	lea    -0x30(%rax),%edx
  100451:	80 fa 09             	cmp    $0x9,%dl
  100454:	76 e4                	jbe    10043a <printer_vprintf+0xd1>
  100456:	eb 97                	jmp    1003ef <printer_vprintf+0x86>
        } else if (*format == '*') {
  100458:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10045c:	75 3f                	jne    10049d <printer_vprintf+0x134>
            width = va_arg(val, int);
  10045e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100462:	8b 07                	mov    (%rdi),%eax
  100464:	83 f8 2f             	cmp    $0x2f,%eax
  100467:	77 17                	ja     100480 <printer_vprintf+0x117>
  100469:	89 c2                	mov    %eax,%edx
  10046b:	48 03 57 10          	add    0x10(%rdi),%rdx
  10046f:	83 c0 08             	add    $0x8,%eax
  100472:	89 07                	mov    %eax,(%rdi)
  100474:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100477:	48 83 c3 01          	add    $0x1,%rbx
  10047b:	e9 6f ff ff ff       	jmp    1003ef <printer_vprintf+0x86>
            width = va_arg(val, int);
  100480:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100484:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100488:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10048c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100490:	eb e2                	jmp    100474 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100492:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  100498:	e9 52 ff ff ff       	jmp    1003ef <printer_vprintf+0x86>
        int width = -1;
  10049d:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1004a3:	e9 47 ff ff ff       	jmp    1003ef <printer_vprintf+0x86>
            ++format;
  1004a8:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1004ac:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1004b0:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1004b3:	80 f9 09             	cmp    $0x9,%cl
  1004b6:	76 13                	jbe    1004cb <printer_vprintf+0x162>
            } else if (*format == '*') {
  1004b8:	3c 2a                	cmp    $0x2a,%al
  1004ba:	74 33                	je     1004ef <printer_vprintf+0x186>
            ++format;
  1004bc:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1004bf:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1004c6:	e9 34 ff ff ff       	jmp    1003ff <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004cb:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1004d0:	48 83 c2 01          	add    $0x1,%rdx
  1004d4:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1004d7:	0f be c0             	movsbl %al,%eax
  1004da:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1004de:	0f b6 02             	movzbl (%rdx),%eax
  1004e1:	8d 70 d0             	lea    -0x30(%rax),%esi
  1004e4:	40 80 fe 09          	cmp    $0x9,%sil
  1004e8:	76 e6                	jbe    1004d0 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1004ea:	48 89 d3             	mov    %rdx,%rbx
  1004ed:	eb 1c                	jmp    10050b <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1004ef:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004f3:	8b 07                	mov    (%rdi),%eax
  1004f5:	83 f8 2f             	cmp    $0x2f,%eax
  1004f8:	77 23                	ja     10051d <printer_vprintf+0x1b4>
  1004fa:	89 c2                	mov    %eax,%edx
  1004fc:	48 03 57 10          	add    0x10(%rdi),%rdx
  100500:	83 c0 08             	add    $0x8,%eax
  100503:	89 07                	mov    %eax,(%rdi)
  100505:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100507:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  10050b:	85 c9                	test   %ecx,%ecx
  10050d:	b8 00 00 00 00       	mov    $0x0,%eax
  100512:	0f 49 c1             	cmovns %ecx,%eax
  100515:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100518:	e9 e2 fe ff ff       	jmp    1003ff <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10051d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100521:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100525:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100529:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10052d:	eb d6                	jmp    100505 <printer_vprintf+0x19c>
        switch (*format) {
  10052f:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100534:	e9 f3 00 00 00       	jmp    10062c <printer_vprintf+0x2c3>
            ++format;
  100539:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10053d:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100542:	e9 bd fe ff ff       	jmp    100404 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100547:	85 c9                	test   %ecx,%ecx
  100549:	74 55                	je     1005a0 <printer_vprintf+0x237>
  10054b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10054f:	8b 07                	mov    (%rdi),%eax
  100551:	83 f8 2f             	cmp    $0x2f,%eax
  100554:	77 38                	ja     10058e <printer_vprintf+0x225>
  100556:	89 c2                	mov    %eax,%edx
  100558:	48 03 57 10          	add    0x10(%rdi),%rdx
  10055c:	83 c0 08             	add    $0x8,%eax
  10055f:	89 07                	mov    %eax,(%rdi)
  100561:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100564:	48 89 d0             	mov    %rdx,%rax
  100567:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10056b:	49 89 d0             	mov    %rdx,%r8
  10056e:	49 f7 d8             	neg    %r8
  100571:	25 80 00 00 00       	and    $0x80,%eax
  100576:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10057a:	0b 45 a8             	or     -0x58(%rbp),%eax
  10057d:	83 c8 60             	or     $0x60,%eax
  100580:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100583:	41 bc 01 0d 10 00    	mov    $0x100d01,%r12d
            break;
  100589:	e9 35 01 00 00       	jmp    1006c3 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10058e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100592:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100596:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10059a:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10059e:	eb c1                	jmp    100561 <printer_vprintf+0x1f8>
  1005a0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005a4:	8b 07                	mov    (%rdi),%eax
  1005a6:	83 f8 2f             	cmp    $0x2f,%eax
  1005a9:	77 10                	ja     1005bb <printer_vprintf+0x252>
  1005ab:	89 c2                	mov    %eax,%edx
  1005ad:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005b1:	83 c0 08             	add    $0x8,%eax
  1005b4:	89 07                	mov    %eax,(%rdi)
  1005b6:	48 63 12             	movslq (%rdx),%rdx
  1005b9:	eb a9                	jmp    100564 <printer_vprintf+0x1fb>
  1005bb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005bf:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1005c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005c7:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1005cb:	eb e9                	jmp    1005b6 <printer_vprintf+0x24d>
        int base = 10;
  1005cd:	be 0a 00 00 00       	mov    $0xa,%esi
  1005d2:	eb 58                	jmp    10062c <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005d4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005d8:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005dc:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005e0:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005e4:	eb 60                	jmp    100646 <printer_vprintf+0x2dd>
  1005e6:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005ea:	8b 07                	mov    (%rdi),%eax
  1005ec:	83 f8 2f             	cmp    $0x2f,%eax
  1005ef:	77 10                	ja     100601 <printer_vprintf+0x298>
  1005f1:	89 c2                	mov    %eax,%edx
  1005f3:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005f7:	83 c0 08             	add    $0x8,%eax
  1005fa:	89 07                	mov    %eax,(%rdi)
  1005fc:	44 8b 02             	mov    (%rdx),%r8d
  1005ff:	eb 48                	jmp    100649 <printer_vprintf+0x2e0>
  100601:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100605:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100609:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10060d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100611:	eb e9                	jmp    1005fc <printer_vprintf+0x293>
  100613:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100616:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10061d:	bf 20 0f 10 00       	mov    $0x100f20,%edi
  100622:	e9 e2 02 00 00       	jmp    100909 <printer_vprintf+0x5a0>
            base = 16;
  100627:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10062c:	85 c9                	test   %ecx,%ecx
  10062e:	74 b6                	je     1005e6 <printer_vprintf+0x27d>
  100630:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100634:	8b 01                	mov    (%rcx),%eax
  100636:	83 f8 2f             	cmp    $0x2f,%eax
  100639:	77 99                	ja     1005d4 <printer_vprintf+0x26b>
  10063b:	89 c2                	mov    %eax,%edx
  10063d:	48 03 51 10          	add    0x10(%rcx),%rdx
  100641:	83 c0 08             	add    $0x8,%eax
  100644:	89 01                	mov    %eax,(%rcx)
  100646:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100649:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10064d:	85 f6                	test   %esi,%esi
  10064f:	79 c2                	jns    100613 <printer_vprintf+0x2aa>
        base = -base;
  100651:	41 89 f1             	mov    %esi,%r9d
  100654:	f7 de                	neg    %esi
  100656:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10065d:	bf 00 0f 10 00       	mov    $0x100f00,%edi
  100662:	e9 a2 02 00 00       	jmp    100909 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100667:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10066b:	8b 07                	mov    (%rdi),%eax
  10066d:	83 f8 2f             	cmp    $0x2f,%eax
  100670:	77 1c                	ja     10068e <printer_vprintf+0x325>
  100672:	89 c2                	mov    %eax,%edx
  100674:	48 03 57 10          	add    0x10(%rdi),%rdx
  100678:	83 c0 08             	add    $0x8,%eax
  10067b:	89 07                	mov    %eax,(%rdi)
  10067d:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100680:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  100687:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10068c:	eb c3                	jmp    100651 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  10068e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100692:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100696:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10069a:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10069e:	eb dd                	jmp    10067d <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1006a0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1006a4:	8b 01                	mov    (%rcx),%eax
  1006a6:	83 f8 2f             	cmp    $0x2f,%eax
  1006a9:	0f 87 a5 01 00 00    	ja     100854 <printer_vprintf+0x4eb>
  1006af:	89 c2                	mov    %eax,%edx
  1006b1:	48 03 51 10          	add    0x10(%rcx),%rdx
  1006b5:	83 c0 08             	add    $0x8,%eax
  1006b8:	89 01                	mov    %eax,(%rcx)
  1006ba:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1006bd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1006c3:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006c6:	83 e0 20             	and    $0x20,%eax
  1006c9:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1006cc:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1006d2:	0f 85 21 02 00 00    	jne    1008f9 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1006d8:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006db:	89 45 88             	mov    %eax,-0x78(%rbp)
  1006de:	83 e0 60             	and    $0x60,%eax
  1006e1:	83 f8 60             	cmp    $0x60,%eax
  1006e4:	0f 84 54 02 00 00    	je     10093e <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006ea:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1006ed:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1006f0:	48 c7 45 a0 01 0d 10 	movq   $0x100d01,-0x60(%rbp)
  1006f7:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1006f8:	83 f8 21             	cmp    $0x21,%eax
  1006fb:	0f 84 79 02 00 00    	je     10097a <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100701:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100704:	89 f8                	mov    %edi,%eax
  100706:	f7 d0                	not    %eax
  100708:	c1 e8 1f             	shr    $0x1f,%eax
  10070b:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10070e:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100712:	0f 85 9e 02 00 00    	jne    1009b6 <printer_vprintf+0x64d>
  100718:	84 c0                	test   %al,%al
  10071a:	0f 84 96 02 00 00    	je     1009b6 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  100720:	48 63 f7             	movslq %edi,%rsi
  100723:	4c 89 e7             	mov    %r12,%rdi
  100726:	e8 63 fb ff ff       	call   10028e <strnlen>
  10072b:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10072e:	8b 45 88             	mov    -0x78(%rbp),%eax
  100731:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100734:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  10073b:	83 f8 22             	cmp    $0x22,%eax
  10073e:	0f 84 aa 02 00 00    	je     1009ee <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100744:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100748:	e8 26 fb ff ff       	call   100273 <strlen>
  10074d:	8b 55 9c             	mov    -0x64(%rbp),%edx
  100750:	03 55 98             	add    -0x68(%rbp),%edx
  100753:	44 89 e9             	mov    %r13d,%ecx
  100756:	29 d1                	sub    %edx,%ecx
  100758:	29 c1                	sub    %eax,%ecx
  10075a:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10075d:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100760:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100764:	75 2d                	jne    100793 <printer_vprintf+0x42a>
  100766:	85 c9                	test   %ecx,%ecx
  100768:	7e 29                	jle    100793 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  10076a:	44 89 fa             	mov    %r15d,%edx
  10076d:	be 20 00 00 00       	mov    $0x20,%esi
  100772:	4c 89 f7             	mov    %r14,%rdi
  100775:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100778:	41 83 ed 01          	sub    $0x1,%r13d
  10077c:	45 85 ed             	test   %r13d,%r13d
  10077f:	7f e9                	jg     10076a <printer_vprintf+0x401>
  100781:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100784:	85 ff                	test   %edi,%edi
  100786:	b8 01 00 00 00       	mov    $0x1,%eax
  10078b:	0f 4f c7             	cmovg  %edi,%eax
  10078e:	29 c7                	sub    %eax,%edi
  100790:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100793:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100797:	0f b6 07             	movzbl (%rdi),%eax
  10079a:	84 c0                	test   %al,%al
  10079c:	74 22                	je     1007c0 <printer_vprintf+0x457>
  10079e:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007a2:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1007a5:	0f b6 f0             	movzbl %al,%esi
  1007a8:	44 89 fa             	mov    %r15d,%edx
  1007ab:	4c 89 f7             	mov    %r14,%rdi
  1007ae:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  1007b1:	48 83 c3 01          	add    $0x1,%rbx
  1007b5:	0f b6 03             	movzbl (%rbx),%eax
  1007b8:	84 c0                	test   %al,%al
  1007ba:	75 e9                	jne    1007a5 <printer_vprintf+0x43c>
  1007bc:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1007c0:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1007c3:	85 c0                	test   %eax,%eax
  1007c5:	7e 1d                	jle    1007e4 <printer_vprintf+0x47b>
  1007c7:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007cb:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1007cd:	44 89 fa             	mov    %r15d,%edx
  1007d0:	be 30 00 00 00       	mov    $0x30,%esi
  1007d5:	4c 89 f7             	mov    %r14,%rdi
  1007d8:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  1007db:	83 eb 01             	sub    $0x1,%ebx
  1007de:	75 ed                	jne    1007cd <printer_vprintf+0x464>
  1007e0:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1007e4:	8b 45 98             	mov    -0x68(%rbp),%eax
  1007e7:	85 c0                	test   %eax,%eax
  1007e9:	7e 27                	jle    100812 <printer_vprintf+0x4a9>
  1007eb:	89 c0                	mov    %eax,%eax
  1007ed:	4c 01 e0             	add    %r12,%rax
  1007f0:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1007f4:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1007f7:	41 0f b6 34 24       	movzbl (%r12),%esi
  1007fc:	44 89 fa             	mov    %r15d,%edx
  1007ff:	4c 89 f7             	mov    %r14,%rdi
  100802:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  100805:	49 83 c4 01          	add    $0x1,%r12
  100809:	49 39 dc             	cmp    %rbx,%r12
  10080c:	75 e9                	jne    1007f7 <printer_vprintf+0x48e>
  10080e:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100812:	45 85 ed             	test   %r13d,%r13d
  100815:	7e 14                	jle    10082b <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100817:	44 89 fa             	mov    %r15d,%edx
  10081a:	be 20 00 00 00       	mov    $0x20,%esi
  10081f:	4c 89 f7             	mov    %r14,%rdi
  100822:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  100825:	41 83 ed 01          	sub    $0x1,%r13d
  100829:	75 ec                	jne    100817 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  10082b:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10082f:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100833:	84 c0                	test   %al,%al
  100835:	0f 84 fe 01 00 00    	je     100a39 <printer_vprintf+0x6d0>
        if (*format != '%') {
  10083b:	3c 25                	cmp    $0x25,%al
  10083d:	0f 84 54 fb ff ff    	je     100397 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100843:	0f b6 f0             	movzbl %al,%esi
  100846:	44 89 fa             	mov    %r15d,%edx
  100849:	4c 89 f7             	mov    %r14,%rdi
  10084c:	41 ff 16             	call   *(%r14)
            continue;
  10084f:	4c 89 e3             	mov    %r12,%rbx
  100852:	eb d7                	jmp    10082b <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100854:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100858:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10085c:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100860:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100864:	e9 51 fe ff ff       	jmp    1006ba <printer_vprintf+0x351>
            color = va_arg(val, int);
  100869:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10086d:	8b 07                	mov    (%rdi),%eax
  10086f:	83 f8 2f             	cmp    $0x2f,%eax
  100872:	77 10                	ja     100884 <printer_vprintf+0x51b>
  100874:	89 c2                	mov    %eax,%edx
  100876:	48 03 57 10          	add    0x10(%rdi),%rdx
  10087a:	83 c0 08             	add    $0x8,%eax
  10087d:	89 07                	mov    %eax,(%rdi)
  10087f:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100882:	eb a7                	jmp    10082b <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100884:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100888:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10088c:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100890:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100894:	eb e9                	jmp    10087f <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  100896:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10089a:	8b 01                	mov    (%rcx),%eax
  10089c:	83 f8 2f             	cmp    $0x2f,%eax
  10089f:	77 23                	ja     1008c4 <printer_vprintf+0x55b>
  1008a1:	89 c2                	mov    %eax,%edx
  1008a3:	48 03 51 10          	add    0x10(%rcx),%rdx
  1008a7:	83 c0 08             	add    $0x8,%eax
  1008aa:	89 01                	mov    %eax,(%rcx)
  1008ac:	8b 02                	mov    (%rdx),%eax
  1008ae:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1008b1:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1008b5:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008b9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1008bf:	e9 ff fd ff ff       	jmp    1006c3 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1008c4:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1008c8:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1008cc:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1008d0:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1008d4:	eb d6                	jmp    1008ac <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1008d6:	84 d2                	test   %dl,%dl
  1008d8:	0f 85 39 01 00 00    	jne    100a17 <printer_vprintf+0x6ae>
  1008de:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1008e2:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1008e6:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1008ea:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1008ee:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1008f4:	e9 ca fd ff ff       	jmp    1006c3 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1008f9:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1008ff:	bf 20 0f 10 00       	mov    $0x100f20,%edi
        if (flags & FLAG_NUMERIC) {
  100904:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100909:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10090d:	4c 89 c1             	mov    %r8,%rcx
  100910:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100914:	48 63 f6             	movslq %esi,%rsi
  100917:	49 83 ec 01          	sub    $0x1,%r12
  10091b:	48 89 c8             	mov    %rcx,%rax
  10091e:	ba 00 00 00 00       	mov    $0x0,%edx
  100923:	48 f7 f6             	div    %rsi
  100926:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  10092a:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10092e:	48 89 ca             	mov    %rcx,%rdx
  100931:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100934:	48 39 d6             	cmp    %rdx,%rsi
  100937:	76 de                	jbe    100917 <printer_vprintf+0x5ae>
  100939:	e9 9a fd ff ff       	jmp    1006d8 <printer_vprintf+0x36f>
                prefix = "-";
  10093e:	48 c7 45 a0 36 0d 10 	movq   $0x100d36,-0x60(%rbp)
  100945:	00 
            if (flags & FLAG_NEGATIVE) {
  100946:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100949:	a8 80                	test   $0x80,%al
  10094b:	0f 85 b0 fd ff ff    	jne    100701 <printer_vprintf+0x398>
                prefix = "+";
  100951:	48 c7 45 a0 31 0d 10 	movq   $0x100d31,-0x60(%rbp)
  100958:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100959:	a8 10                	test   $0x10,%al
  10095b:	0f 85 a0 fd ff ff    	jne    100701 <printer_vprintf+0x398>
                prefix = " ";
  100961:	a8 08                	test   $0x8,%al
  100963:	ba 01 0d 10 00       	mov    $0x100d01,%edx
  100968:	b8 3d 0f 10 00       	mov    $0x100f3d,%eax
  10096d:	48 0f 44 c2          	cmove  %rdx,%rax
  100971:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100975:	e9 87 fd ff ff       	jmp    100701 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  10097a:	41 8d 41 10          	lea    0x10(%r9),%eax
  10097e:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100983:	0f 85 78 fd ff ff    	jne    100701 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  100989:	4d 85 c0             	test   %r8,%r8
  10098c:	75 0d                	jne    10099b <printer_vprintf+0x632>
  10098e:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100995:	0f 84 66 fd ff ff    	je     100701 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  10099b:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  10099f:	ba 38 0d 10 00       	mov    $0x100d38,%edx
  1009a4:	b8 33 0d 10 00       	mov    $0x100d33,%eax
  1009a9:	48 0f 44 c2          	cmove  %rdx,%rax
  1009ad:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1009b1:	e9 4b fd ff ff       	jmp    100701 <printer_vprintf+0x398>
            len = strlen(data);
  1009b6:	4c 89 e7             	mov    %r12,%rdi
  1009b9:	e8 b5 f8 ff ff       	call   100273 <strlen>
  1009be:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1009c1:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1009c5:	0f 84 63 fd ff ff    	je     10072e <printer_vprintf+0x3c5>
  1009cb:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1009cf:	0f 84 59 fd ff ff    	je     10072e <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1009d5:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1009d8:	89 ca                	mov    %ecx,%edx
  1009da:	29 c2                	sub    %eax,%edx
  1009dc:	39 c1                	cmp    %eax,%ecx
  1009de:	b8 00 00 00 00       	mov    $0x0,%eax
  1009e3:	0f 4e d0             	cmovle %eax,%edx
  1009e6:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1009e9:	e9 56 fd ff ff       	jmp    100744 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  1009ee:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1009f2:	e8 7c f8 ff ff       	call   100273 <strlen>
  1009f7:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1009fa:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1009fd:	44 89 e9             	mov    %r13d,%ecx
  100a00:	29 f9                	sub    %edi,%ecx
  100a02:	29 c1                	sub    %eax,%ecx
  100a04:	44 39 ea             	cmp    %r13d,%edx
  100a07:	b8 00 00 00 00       	mov    $0x0,%eax
  100a0c:	0f 4d c8             	cmovge %eax,%ecx
  100a0f:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100a12:	e9 2d fd ff ff       	jmp    100744 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100a17:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100a1a:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100a1e:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100a22:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100a28:	e9 96 fc ff ff       	jmp    1006c3 <printer_vprintf+0x35a>
        int flags = 0;
  100a2d:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100a34:	e9 b0 f9 ff ff       	jmp    1003e9 <printer_vprintf+0x80>
}
  100a39:	48 83 c4 58          	add    $0x58,%rsp
  100a3d:	5b                   	pop    %rbx
  100a3e:	41 5c                	pop    %r12
  100a40:	41 5d                	pop    %r13
  100a42:	41 5e                	pop    %r14
  100a44:	41 5f                	pop    %r15
  100a46:	5d                   	pop    %rbp
  100a47:	c3                   	ret    

0000000000100a48 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100a48:	55                   	push   %rbp
  100a49:	48 89 e5             	mov    %rsp,%rbp
  100a4c:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100a50:	48 c7 45 f0 53 01 10 	movq   $0x100153,-0x10(%rbp)
  100a57:	00 
        cpos = 0;
  100a58:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a5e:	b8 00 00 00 00       	mov    $0x0,%eax
  100a63:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a66:	48 63 ff             	movslq %edi,%rdi
  100a69:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a70:	00 
  100a71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a75:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a79:	e8 eb f8 ff ff       	call   100369 <printer_vprintf>
    return cp.cursor - console;
  100a7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a82:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a88:	48 d1 f8             	sar    %rax
}
  100a8b:	c9                   	leave  
  100a8c:	c3                   	ret    

0000000000100a8d <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a8d:	55                   	push   %rbp
  100a8e:	48 89 e5             	mov    %rsp,%rbp
  100a91:	48 83 ec 50          	sub    $0x50,%rsp
  100a95:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a99:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a9d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100aa1:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100aa8:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100aac:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ab0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100ab4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100ab8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100abc:	e8 87 ff ff ff       	call   100a48 <console_vprintf>
}
  100ac1:	c9                   	leave  
  100ac2:	c3                   	ret    

0000000000100ac3 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100ac3:	55                   	push   %rbp
  100ac4:	48 89 e5             	mov    %rsp,%rbp
  100ac7:	53                   	push   %rbx
  100ac8:	48 83 ec 28          	sub    $0x28,%rsp
  100acc:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100acf:	48 c7 45 d8 d9 01 10 	movq   $0x1001d9,-0x28(%rbp)
  100ad6:	00 
    sp.s = s;
  100ad7:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100adb:	48 85 f6             	test   %rsi,%rsi
  100ade:	75 0b                	jne    100aeb <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100ae0:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100ae3:	29 d8                	sub    %ebx,%eax
}
  100ae5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100ae9:	c9                   	leave  
  100aea:	c3                   	ret    
        sp.end = s + size - 1;
  100aeb:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100af0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100af4:	be 00 00 00 00       	mov    $0x0,%esi
  100af9:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100afd:	e8 67 f8 ff ff       	call   100369 <printer_vprintf>
        *sp.s = 0;
  100b02:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100b06:	c6 00 00             	movb   $0x0,(%rax)
  100b09:	eb d5                	jmp    100ae0 <vsnprintf+0x1d>

0000000000100b0b <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100b0b:	55                   	push   %rbp
  100b0c:	48 89 e5             	mov    %rsp,%rbp
  100b0f:	48 83 ec 50          	sub    $0x50,%rsp
  100b13:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b17:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b1b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100b1f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100b26:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b2a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b2e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b32:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100b36:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b3a:	e8 84 ff ff ff       	call   100ac3 <vsnprintf>
    va_end(val);
    return n;
}
  100b3f:	c9                   	leave  
  100b40:	c3                   	ret    

0000000000100b41 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b41:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100b46:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100b4b:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100b50:	48 83 c0 02          	add    $0x2,%rax
  100b54:	48 39 d0             	cmp    %rdx,%rax
  100b57:	75 f2                	jne    100b4b <console_clear+0xa>
    }
    cursorpos = 0;
  100b59:	c7 05 99 84 fb ff 00 	movl   $0x0,-0x47b67(%rip)        # b8ffc <cursorpos>
  100b60:	00 00 00 
}
  100b63:	c3                   	ret    

0000000000100b64 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100b64:	55                   	push   %rbp
  100b65:	48 89 e5             	mov    %rsp,%rbp
  100b68:	48 83 ec 50          	sub    $0x50,%rsp
  100b6c:	49 89 f2             	mov    %rsi,%r10
  100b6f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100b73:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b77:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b7b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100b7f:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100b84:	85 ff                	test   %edi,%edi
  100b86:	78 2e                	js     100bb6 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100b88:	48 63 ff             	movslq %edi,%rdi
  100b8b:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100b92:	cc cc cc 
  100b95:	48 89 f8             	mov    %rdi,%rax
  100b98:	48 f7 e2             	mul    %rdx
  100b9b:	48 89 d0             	mov    %rdx,%rax
  100b9e:	48 c1 e8 02          	shr    $0x2,%rax
  100ba2:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100ba6:	48 01 c2             	add    %rax,%rdx
  100ba9:	48 29 d7             	sub    %rdx,%rdi
  100bac:	0f b6 b7 6d 0f 10 00 	movzbl 0x100f6d(%rdi),%esi
  100bb3:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100bb6:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100bbd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100bc1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100bc5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100bc9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100bcd:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100bd1:	4c 89 d2             	mov    %r10,%rdx
  100bd4:	8b 3d 22 84 fb ff    	mov    -0x47bde(%rip),%edi        # b8ffc <cursorpos>
  100bda:	e8 69 fe ff ff       	call   100a48 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100bdf:	3d 30 07 00 00       	cmp    $0x730,%eax
  100be4:	ba 00 00 00 00       	mov    $0x0,%edx
  100be9:	0f 4d c2             	cmovge %edx,%eax
  100bec:	89 05 0a 84 fb ff    	mov    %eax,-0x47bf6(%rip)        # b8ffc <cursorpos>
    }
}
  100bf2:	c9                   	leave  
  100bf3:	c3                   	ret    

0000000000100bf4 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100bf4:	55                   	push   %rbp
  100bf5:	48 89 e5             	mov    %rsp,%rbp
  100bf8:	53                   	push   %rbx
  100bf9:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100c00:	48 89 fb             	mov    %rdi,%rbx
  100c03:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100c07:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100c0b:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100c0f:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100c13:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100c17:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100c1e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100c22:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100c26:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100c2a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100c2e:	ba 07 00 00 00       	mov    $0x7,%edx
  100c33:	be 37 0f 10 00       	mov    $0x100f37,%esi
  100c38:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100c3f:	e8 ab f5 ff ff       	call   1001ef <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100c44:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100c48:	48 89 da             	mov    %rbx,%rdx
  100c4b:	be 99 00 00 00       	mov    $0x99,%esi
  100c50:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100c57:	e8 67 fe ff ff       	call   100ac3 <vsnprintf>
  100c5c:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100c5f:	85 d2                	test   %edx,%edx
  100c61:	7e 0f                	jle    100c72 <panic+0x7e>
  100c63:	83 c0 06             	add    $0x6,%eax
  100c66:	48 98                	cltq   
  100c68:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100c6f:	0a 
  100c70:	75 29                	jne    100c9b <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100c72:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100c79:	ba 3f 0f 10 00       	mov    $0x100f3f,%edx
  100c7e:	be 00 c0 00 00       	mov    $0xc000,%esi
  100c83:	bf 30 07 00 00       	mov    $0x730,%edi
  100c88:	b8 00 00 00 00       	mov    $0x0,%eax
  100c8d:	e8 fb fd ff ff       	call   100a8d <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100c92:	bf 00 00 00 00       	mov    $0x0,%edi
  100c97:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100c99:	eb fe                	jmp    100c99 <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100c9b:	48 63 c2             	movslq %edx,%rax
  100c9e:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100ca4:	0f 94 c2             	sete   %dl
  100ca7:	0f b6 d2             	movzbl %dl,%edx
  100caa:	48 29 d0             	sub    %rdx,%rax
  100cad:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100cb4:	ff 
  100cb5:	be 00 0d 10 00       	mov    $0x100d00,%esi
  100cba:	e8 f2 f5 ff ff       	call   1002b1 <strcpy>
  100cbf:	eb b1                	jmp    100c72 <panic+0x7e>

0000000000100cc1 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100cc1:	55                   	push   %rbp
  100cc2:	48 89 e5             	mov    %rsp,%rbp
  100cc5:	48 89 f9             	mov    %rdi,%rcx
  100cc8:	41 89 f0             	mov    %esi,%r8d
  100ccb:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100cce:	ba 48 0f 10 00       	mov    $0x100f48,%edx
  100cd3:	be 00 c0 00 00       	mov    $0xc000,%esi
  100cd8:	bf 30 07 00 00       	mov    $0x730,%edi
  100cdd:	b8 00 00 00 00       	mov    $0x0,%eax
  100ce2:	e8 a6 fd ff ff       	call   100a8d <console_printf>
    asm volatile ("int %0" : /* no result */
  100ce7:	bf 00 00 00 00       	mov    $0x0,%edi
  100cec:	cd 30                	int    $0x30
 loop: goto loop;
  100cee:	eb fe                	jmp    100cee <assert_fail+0x2d>
