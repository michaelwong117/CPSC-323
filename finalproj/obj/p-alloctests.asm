
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 6a 03 00 00       	call   2c0385 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 b8 0c 00 00       	call   2c0cdd <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 7e 0d 00 00       	call   2c0dc2 <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 f4 0c 00 00       	call   2c0d60 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 ae 0f 00 00       	call   2c1039 <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 40 13 2c 00       	mov    $0x2c1340,%edx
  2c00bc:	be 1a 00 00 00       	mov    $0x1a,%esi
  2c00c1:	bf 4e 13 2c 00       	mov    $0x2c134e,%edi
  2c00c6:	e8 3a 12 00 00       	call   2c1305 <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 5d 13 2c 00       	mov    $0x2c135d,%edx
  2c00d0:	be 22 00 00 00       	mov    $0x22,%esi
  2c00d5:	bf 4e 13 2c 00       	mov    $0x2c134e,%edi
  2c00da:	e8 26 12 00 00       	call   2c1305 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 80 13 2c 00       	mov    $0x2c1380,%edx
  2c00e4:	be 29 00 00 00       	mov    $0x29,%esi
  2c00e9:	bf 4e 13 2c 00       	mov    $0x2c134e,%edi
  2c00ee:	e8 12 12 00 00       	call   2c1305 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 6c 13 2c 00       	mov    $0x2c136c,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 a0 10 00 00       	call   2c11a7 <app_printf>
    }
    // app_printf(p, "finished heap_info\n");

    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 65 0b 00 00       	call   2c0c74 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 5d 0b 00 00       	call   2c0c74 <free>

    // app_printf(p, "finished free\n");


    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14


    // allocate pages till no more memory
    while (1) {
        uint64_t time = rdtsc();
        void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 a8 0b 00 00       	call   2c0cdd <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
        total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
        if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
            break;
        total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
        *((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>

    }
    // app_printf(p, "done!\n");


    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be b0 13 2c 00       	mov    $0x2c13b0,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 2b 10 00 00       	call   2c11a7 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c0180:	48 89 f9             	mov    %rdi,%rcx
  2c0183:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c0185:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  2c018c:	00 
  2c018d:	72 08                	jb     2c0197 <console_putc+0x17>
        cp->cursor = console;
  2c018f:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  2c0196:	00 
    }
    if (c == '\n') {
  2c0197:	40 80 fe 0a          	cmp    $0xa,%sil
  2c019b:	74 16                	je     2c01b3 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  2c019d:	48 8b 41 08          	mov    0x8(%rcx),%rax
  2c01a1:	48 8d 50 02          	lea    0x2(%rax),%rdx
  2c01a5:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  2c01a9:	40 0f b6 f6          	movzbl %sil,%esi
  2c01ad:	09 fe                	or     %edi,%esi
  2c01af:	66 89 30             	mov    %si,(%rax)
    }
}
  2c01b2:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  2c01b3:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  2c01b7:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  2c01be:	4c 89 c6             	mov    %r8,%rsi
  2c01c1:	48 d1 fe             	sar    %rsi
  2c01c4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c01cb:	66 66 66 
  2c01ce:	48 89 f0             	mov    %rsi,%rax
  2c01d1:	48 f7 ea             	imul   %rdx
  2c01d4:	48 c1 fa 05          	sar    $0x5,%rdx
  2c01d8:	49 c1 f8 3f          	sar    $0x3f,%r8
  2c01dc:	4c 29 c2             	sub    %r8,%rdx
  2c01df:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  2c01e3:	48 c1 e2 04          	shl    $0x4,%rdx
  2c01e7:	89 f0                	mov    %esi,%eax
  2c01e9:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  2c01eb:	83 cf 20             	or     $0x20,%edi
  2c01ee:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c01f2:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  2c01f6:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c01fa:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  2c01fd:	83 c0 01             	add    $0x1,%eax
  2c0200:	83 f8 50             	cmp    $0x50,%eax
  2c0203:	75 e9                	jne    2c01ee <console_putc+0x6e>
  2c0205:	c3                   	ret    

00000000002c0206 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  2c0206:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c020a:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  2c020e:	73 0b                	jae    2c021b <string_putc+0x15>
        *sp->s++ = c;
  2c0210:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0214:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  2c0218:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  2c021b:	c3                   	ret    

00000000002c021c <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  2c021c:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c021f:	48 85 d2             	test   %rdx,%rdx
  2c0222:	74 17                	je     2c023b <memcpy+0x1f>
  2c0224:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  2c0229:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  2c022e:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0232:	48 83 c1 01          	add    $0x1,%rcx
  2c0236:	48 39 d1             	cmp    %rdx,%rcx
  2c0239:	75 ee                	jne    2c0229 <memcpy+0xd>
}
  2c023b:	c3                   	ret    

00000000002c023c <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  2c023c:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  2c023f:	48 39 fe             	cmp    %rdi,%rsi
  2c0242:	72 1d                	jb     2c0261 <memmove+0x25>
        while (n-- > 0) {
  2c0244:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c0249:	48 85 d2             	test   %rdx,%rdx
  2c024c:	74 12                	je     2c0260 <memmove+0x24>
            *d++ = *s++;
  2c024e:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  2c0252:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  2c0256:	48 83 c1 01          	add    $0x1,%rcx
  2c025a:	48 39 ca             	cmp    %rcx,%rdx
  2c025d:	75 ef                	jne    2c024e <memmove+0x12>
}
  2c025f:	c3                   	ret    
  2c0260:	c3                   	ret    
    if (s < d && s + n > d) {
  2c0261:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  2c0265:	48 39 cf             	cmp    %rcx,%rdi
  2c0268:	73 da                	jae    2c0244 <memmove+0x8>
        while (n-- > 0) {
  2c026a:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  2c026e:	48 85 d2             	test   %rdx,%rdx
  2c0271:	74 ec                	je     2c025f <memmove+0x23>
            *--d = *--s;
  2c0273:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  2c0277:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  2c027a:	48 83 e9 01          	sub    $0x1,%rcx
  2c027e:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  2c0282:	75 ef                	jne    2c0273 <memmove+0x37>
  2c0284:	c3                   	ret    

00000000002c0285 <memset>:
void* memset(void* v, int c, size_t n) {
  2c0285:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0288:	48 85 d2             	test   %rdx,%rdx
  2c028b:	74 12                	je     2c029f <memset+0x1a>
  2c028d:	48 01 fa             	add    %rdi,%rdx
  2c0290:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  2c0293:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0296:	48 83 c1 01          	add    $0x1,%rcx
  2c029a:	48 39 ca             	cmp    %rcx,%rdx
  2c029d:	75 f4                	jne    2c0293 <memset+0xe>
}
  2c029f:	c3                   	ret    

00000000002c02a0 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  2c02a0:	80 3f 00             	cmpb   $0x0,(%rdi)
  2c02a3:	74 10                	je     2c02b5 <strlen+0x15>
  2c02a5:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  2c02aa:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  2c02ae:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  2c02b2:	75 f6                	jne    2c02aa <strlen+0xa>
  2c02b4:	c3                   	ret    
  2c02b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c02ba:	c3                   	ret    

00000000002c02bb <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  2c02bb:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c02be:	ba 00 00 00 00       	mov    $0x0,%edx
  2c02c3:	48 85 f6             	test   %rsi,%rsi
  2c02c6:	74 11                	je     2c02d9 <strnlen+0x1e>
  2c02c8:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  2c02cc:	74 0c                	je     2c02da <strnlen+0x1f>
        ++n;
  2c02ce:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c02d2:	48 39 d0             	cmp    %rdx,%rax
  2c02d5:	75 f1                	jne    2c02c8 <strnlen+0xd>
  2c02d7:	eb 04                	jmp    2c02dd <strnlen+0x22>
  2c02d9:	c3                   	ret    
  2c02da:	48 89 d0             	mov    %rdx,%rax
}
  2c02dd:	c3                   	ret    

00000000002c02de <strcpy>:
char* strcpy(char* dst, const char* src) {
  2c02de:	48 89 f8             	mov    %rdi,%rax
  2c02e1:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  2c02e6:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  2c02ea:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  2c02ed:	48 83 c2 01          	add    $0x1,%rdx
  2c02f1:	84 c9                	test   %cl,%cl
  2c02f3:	75 f1                	jne    2c02e6 <strcpy+0x8>
}
  2c02f5:	c3                   	ret    

00000000002c02f6 <strcmp>:
    while (*a && *b && *a == *b) {
  2c02f6:	0f b6 07             	movzbl (%rdi),%eax
  2c02f9:	84 c0                	test   %al,%al
  2c02fb:	74 1a                	je     2c0317 <strcmp+0x21>
  2c02fd:	0f b6 16             	movzbl (%rsi),%edx
  2c0300:	38 c2                	cmp    %al,%dl
  2c0302:	75 13                	jne    2c0317 <strcmp+0x21>
  2c0304:	84 d2                	test   %dl,%dl
  2c0306:	74 0f                	je     2c0317 <strcmp+0x21>
        ++a, ++b;
  2c0308:	48 83 c7 01          	add    $0x1,%rdi
  2c030c:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  2c0310:	0f b6 07             	movzbl (%rdi),%eax
  2c0313:	84 c0                	test   %al,%al
  2c0315:	75 e6                	jne    2c02fd <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  2c0317:	3a 06                	cmp    (%rsi),%al
  2c0319:	0f 97 c0             	seta   %al
  2c031c:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  2c031f:	83 d8 00             	sbb    $0x0,%eax
}
  2c0322:	c3                   	ret    

00000000002c0323 <strchr>:
    while (*s && *s != (char) c) {
  2c0323:	0f b6 07             	movzbl (%rdi),%eax
  2c0326:	84 c0                	test   %al,%al
  2c0328:	74 10                	je     2c033a <strchr+0x17>
  2c032a:	40 38 f0             	cmp    %sil,%al
  2c032d:	74 18                	je     2c0347 <strchr+0x24>
        ++s;
  2c032f:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  2c0333:	0f b6 07             	movzbl (%rdi),%eax
  2c0336:	84 c0                	test   %al,%al
  2c0338:	75 f0                	jne    2c032a <strchr+0x7>
        return NULL;
  2c033a:	40 84 f6             	test   %sil,%sil
  2c033d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0342:	48 0f 44 c7          	cmove  %rdi,%rax
}
  2c0346:	c3                   	ret    
  2c0347:	48 89 f8             	mov    %rdi,%rax
  2c034a:	c3                   	ret    

00000000002c034b <rand>:
    if (!rand_seed_set) {
  2c034b:	83 3d ba 1c 00 00 00 	cmpl   $0x0,0x1cba(%rip)        # 2c200c <rand_seed_set>
  2c0352:	74 1b                	je     2c036f <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0354:	69 05 aa 1c 00 00 0d 	imul   $0x19660d,0x1caa(%rip),%eax        # 2c2008 <rand_seed>
  2c035b:	66 19 00 
  2c035e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0363:	89 05 9f 1c 00 00    	mov    %eax,0x1c9f(%rip)        # 2c2008 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0369:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c036e:	c3                   	ret    
    rand_seed = seed;
  2c036f:	c7 05 8f 1c 00 00 9e 	movl   $0x30d4879e,0x1c8f(%rip)        # 2c2008 <rand_seed>
  2c0376:	87 d4 30 
    rand_seed_set = 1;
  2c0379:	c7 05 89 1c 00 00 01 	movl   $0x1,0x1c89(%rip)        # 2c200c <rand_seed_set>
  2c0380:	00 00 00 
}
  2c0383:	eb cf                	jmp    2c0354 <rand+0x9>

00000000002c0385 <srand>:
    rand_seed = seed;
  2c0385:	89 3d 7d 1c 00 00    	mov    %edi,0x1c7d(%rip)        # 2c2008 <rand_seed>
    rand_seed_set = 1;
  2c038b:	c7 05 77 1c 00 00 01 	movl   $0x1,0x1c77(%rip)        # 2c200c <rand_seed_set>
  2c0392:	00 00 00 
}
  2c0395:	c3                   	ret    

00000000002c0396 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0396:	55                   	push   %rbp
  2c0397:	48 89 e5             	mov    %rsp,%rbp
  2c039a:	41 57                	push   %r15
  2c039c:	41 56                	push   %r14
  2c039e:	41 55                	push   %r13
  2c03a0:	41 54                	push   %r12
  2c03a2:	53                   	push   %rbx
  2c03a3:	48 83 ec 58          	sub    $0x58,%rsp
  2c03a7:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  2c03ab:	0f b6 02             	movzbl (%rdx),%eax
  2c03ae:	84 c0                	test   %al,%al
  2c03b0:	0f 84 b0 06 00 00    	je     2c0a66 <printer_vprintf+0x6d0>
  2c03b6:	49 89 fe             	mov    %rdi,%r14
  2c03b9:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  2c03bc:	41 89 f7             	mov    %esi,%r15d
  2c03bf:	e9 a4 04 00 00       	jmp    2c0868 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  2c03c4:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  2c03c9:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  2c03cf:	45 84 e4             	test   %r12b,%r12b
  2c03d2:	0f 84 82 06 00 00    	je     2c0a5a <printer_vprintf+0x6c4>
        int flags = 0;
  2c03d8:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  2c03de:	41 0f be f4          	movsbl %r12b,%esi
  2c03e2:	bf e1 15 2c 00       	mov    $0x2c15e1,%edi
  2c03e7:	e8 37 ff ff ff       	call   2c0323 <strchr>
  2c03ec:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  2c03ef:	48 85 c0             	test   %rax,%rax
  2c03f2:	74 55                	je     2c0449 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  2c03f4:	48 81 e9 e1 15 2c 00 	sub    $0x2c15e1,%rcx
  2c03fb:	b8 01 00 00 00       	mov    $0x1,%eax
  2c0400:	d3 e0                	shl    %cl,%eax
  2c0402:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  2c0405:	48 83 c3 01          	add    $0x1,%rbx
  2c0409:	44 0f b6 23          	movzbl (%rbx),%r12d
  2c040d:	45 84 e4             	test   %r12b,%r12b
  2c0410:	75 cc                	jne    2c03de <printer_vprintf+0x48>
  2c0412:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  2c0416:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  2c041c:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  2c0423:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  2c0426:	0f 84 a9 00 00 00    	je     2c04d5 <printer_vprintf+0x13f>
        int length = 0;
  2c042c:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  2c0431:	0f b6 13             	movzbl (%rbx),%edx
  2c0434:	8d 42 bd             	lea    -0x43(%rdx),%eax
  2c0437:	3c 37                	cmp    $0x37,%al
  2c0439:	0f 87 c4 04 00 00    	ja     2c0903 <printer_vprintf+0x56d>
  2c043f:	0f b6 c0             	movzbl %al,%eax
  2c0442:	ff 24 c5 f0 13 2c 00 	jmp    *0x2c13f0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  2c0449:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  2c044d:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  2c0452:	3c 08                	cmp    $0x8,%al
  2c0454:	77 2f                	ja     2c0485 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0456:	0f b6 03             	movzbl (%rbx),%eax
  2c0459:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c045c:	80 fa 09             	cmp    $0x9,%dl
  2c045f:	77 5e                	ja     2c04bf <printer_vprintf+0x129>
  2c0461:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  2c0467:	48 83 c3 01          	add    $0x1,%rbx
  2c046b:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  2c0470:	0f be c0             	movsbl %al,%eax
  2c0473:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0478:	0f b6 03             	movzbl (%rbx),%eax
  2c047b:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c047e:	80 fa 09             	cmp    $0x9,%dl
  2c0481:	76 e4                	jbe    2c0467 <printer_vprintf+0xd1>
  2c0483:	eb 97                	jmp    2c041c <printer_vprintf+0x86>
        } else if (*format == '*') {
  2c0485:	41 80 fc 2a          	cmp    $0x2a,%r12b
  2c0489:	75 3f                	jne    2c04ca <printer_vprintf+0x134>
            width = va_arg(val, int);
  2c048b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c048f:	8b 07                	mov    (%rdi),%eax
  2c0491:	83 f8 2f             	cmp    $0x2f,%eax
  2c0494:	77 17                	ja     2c04ad <printer_vprintf+0x117>
  2c0496:	89 c2                	mov    %eax,%edx
  2c0498:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c049c:	83 c0 08             	add    $0x8,%eax
  2c049f:	89 07                	mov    %eax,(%rdi)
  2c04a1:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  2c04a4:	48 83 c3 01          	add    $0x1,%rbx
  2c04a8:	e9 6f ff ff ff       	jmp    2c041c <printer_vprintf+0x86>
            width = va_arg(val, int);
  2c04ad:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c04b1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c04b5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c04b9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c04bd:	eb e2                	jmp    2c04a1 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c04bf:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c04c5:	e9 52 ff ff ff       	jmp    2c041c <printer_vprintf+0x86>
        int width = -1;
  2c04ca:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  2c04d0:	e9 47 ff ff ff       	jmp    2c041c <printer_vprintf+0x86>
            ++format;
  2c04d5:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  2c04d9:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c04dd:	8d 48 d0             	lea    -0x30(%rax),%ecx
  2c04e0:	80 f9 09             	cmp    $0x9,%cl
  2c04e3:	76 13                	jbe    2c04f8 <printer_vprintf+0x162>
            } else if (*format == '*') {
  2c04e5:	3c 2a                	cmp    $0x2a,%al
  2c04e7:	74 33                	je     2c051c <printer_vprintf+0x186>
            ++format;
  2c04e9:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  2c04ec:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  2c04f3:	e9 34 ff ff ff       	jmp    2c042c <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c04f8:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  2c04fd:	48 83 c2 01          	add    $0x1,%rdx
  2c0501:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  2c0504:	0f be c0             	movsbl %al,%eax
  2c0507:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c050b:	0f b6 02             	movzbl (%rdx),%eax
  2c050e:	8d 70 d0             	lea    -0x30(%rax),%esi
  2c0511:	40 80 fe 09          	cmp    $0x9,%sil
  2c0515:	76 e6                	jbe    2c04fd <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  2c0517:	48 89 d3             	mov    %rdx,%rbx
  2c051a:	eb 1c                	jmp    2c0538 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  2c051c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0520:	8b 07                	mov    (%rdi),%eax
  2c0522:	83 f8 2f             	cmp    $0x2f,%eax
  2c0525:	77 23                	ja     2c054a <printer_vprintf+0x1b4>
  2c0527:	89 c2                	mov    %eax,%edx
  2c0529:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c052d:	83 c0 08             	add    $0x8,%eax
  2c0530:	89 07                	mov    %eax,(%rdi)
  2c0532:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  2c0534:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  2c0538:	85 c9                	test   %ecx,%ecx
  2c053a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c053f:	0f 49 c1             	cmovns %ecx,%eax
  2c0542:	89 45 9c             	mov    %eax,-0x64(%rbp)
  2c0545:	e9 e2 fe ff ff       	jmp    2c042c <printer_vprintf+0x96>
                precision = va_arg(val, int);
  2c054a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c054e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0552:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c0556:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c055a:	eb d6                	jmp    2c0532 <printer_vprintf+0x19c>
        switch (*format) {
  2c055c:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c0561:	e9 f3 00 00 00       	jmp    2c0659 <printer_vprintf+0x2c3>
            ++format;
  2c0566:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  2c056a:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  2c056f:	e9 bd fe ff ff       	jmp    2c0431 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0574:	85 c9                	test   %ecx,%ecx
  2c0576:	74 55                	je     2c05cd <printer_vprintf+0x237>
  2c0578:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c057c:	8b 07                	mov    (%rdi),%eax
  2c057e:	83 f8 2f             	cmp    $0x2f,%eax
  2c0581:	77 38                	ja     2c05bb <printer_vprintf+0x225>
  2c0583:	89 c2                	mov    %eax,%edx
  2c0585:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0589:	83 c0 08             	add    $0x8,%eax
  2c058c:	89 07                	mov    %eax,(%rdi)
  2c058e:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0591:	48 89 d0             	mov    %rdx,%rax
  2c0594:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  2c0598:	49 89 d0             	mov    %rdx,%r8
  2c059b:	49 f7 d8             	neg    %r8
  2c059e:	25 80 00 00 00       	and    $0x80,%eax
  2c05a3:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c05a7:	0b 45 a8             	or     -0x58(%rbp),%eax
  2c05aa:	83 c8 60             	or     $0x60,%eax
  2c05ad:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  2c05b0:	41 bc 7d 13 2c 00    	mov    $0x2c137d,%r12d
            break;
  2c05b6:	e9 35 01 00 00       	jmp    2c06f0 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c05bb:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c05bf:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c05c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05c7:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c05cb:	eb c1                	jmp    2c058e <printer_vprintf+0x1f8>
  2c05cd:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05d1:	8b 07                	mov    (%rdi),%eax
  2c05d3:	83 f8 2f             	cmp    $0x2f,%eax
  2c05d6:	77 10                	ja     2c05e8 <printer_vprintf+0x252>
  2c05d8:	89 c2                	mov    %eax,%edx
  2c05da:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c05de:	83 c0 08             	add    $0x8,%eax
  2c05e1:	89 07                	mov    %eax,(%rdi)
  2c05e3:	48 63 12             	movslq (%rdx),%rdx
  2c05e6:	eb a9                	jmp    2c0591 <printer_vprintf+0x1fb>
  2c05e8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05ec:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c05f0:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05f4:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c05f8:	eb e9                	jmp    2c05e3 <printer_vprintf+0x24d>
        int base = 10;
  2c05fa:	be 0a 00 00 00       	mov    $0xa,%esi
  2c05ff:	eb 58                	jmp    2c0659 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0601:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0605:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0609:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c060d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c0611:	eb 60                	jmp    2c0673 <printer_vprintf+0x2dd>
  2c0613:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0617:	8b 07                	mov    (%rdi),%eax
  2c0619:	83 f8 2f             	cmp    $0x2f,%eax
  2c061c:	77 10                	ja     2c062e <printer_vprintf+0x298>
  2c061e:	89 c2                	mov    %eax,%edx
  2c0620:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0624:	83 c0 08             	add    $0x8,%eax
  2c0627:	89 07                	mov    %eax,(%rdi)
  2c0629:	44 8b 02             	mov    (%rdx),%r8d
  2c062c:	eb 48                	jmp    2c0676 <printer_vprintf+0x2e0>
  2c062e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0632:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0636:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c063a:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c063e:	eb e9                	jmp    2c0629 <printer_vprintf+0x293>
  2c0640:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  2c0643:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  2c064a:	bf d0 15 2c 00       	mov    $0x2c15d0,%edi
  2c064f:	e9 e2 02 00 00       	jmp    2c0936 <printer_vprintf+0x5a0>
            base = 16;
  2c0654:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0659:	85 c9                	test   %ecx,%ecx
  2c065b:	74 b6                	je     2c0613 <printer_vprintf+0x27d>
  2c065d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0661:	8b 01                	mov    (%rcx),%eax
  2c0663:	83 f8 2f             	cmp    $0x2f,%eax
  2c0666:	77 99                	ja     2c0601 <printer_vprintf+0x26b>
  2c0668:	89 c2                	mov    %eax,%edx
  2c066a:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c066e:	83 c0 08             	add    $0x8,%eax
  2c0671:	89 01                	mov    %eax,(%rcx)
  2c0673:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  2c0676:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  2c067a:	85 f6                	test   %esi,%esi
  2c067c:	79 c2                	jns    2c0640 <printer_vprintf+0x2aa>
        base = -base;
  2c067e:	41 89 f1             	mov    %esi,%r9d
  2c0681:	f7 de                	neg    %esi
  2c0683:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  2c068a:	bf b0 15 2c 00       	mov    $0x2c15b0,%edi
  2c068f:	e9 a2 02 00 00       	jmp    2c0936 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  2c0694:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0698:	8b 07                	mov    (%rdi),%eax
  2c069a:	83 f8 2f             	cmp    $0x2f,%eax
  2c069d:	77 1c                	ja     2c06bb <printer_vprintf+0x325>
  2c069f:	89 c2                	mov    %eax,%edx
  2c06a1:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c06a5:	83 c0 08             	add    $0x8,%eax
  2c06a8:	89 07                	mov    %eax,(%rdi)
  2c06aa:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c06ad:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  2c06b4:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c06b9:	eb c3                	jmp    2c067e <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  2c06bb:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06bf:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c06c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c06c7:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c06cb:	eb dd                	jmp    2c06aa <printer_vprintf+0x314>
            data = va_arg(val, char*);
  2c06cd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06d1:	8b 01                	mov    (%rcx),%eax
  2c06d3:	83 f8 2f             	cmp    $0x2f,%eax
  2c06d6:	0f 87 a5 01 00 00    	ja     2c0881 <printer_vprintf+0x4eb>
  2c06dc:	89 c2                	mov    %eax,%edx
  2c06de:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c06e2:	83 c0 08             	add    $0x8,%eax
  2c06e5:	89 01                	mov    %eax,(%rcx)
  2c06e7:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  2c06ea:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  2c06f0:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c06f3:	83 e0 20             	and    $0x20,%eax
  2c06f6:	89 45 8c             	mov    %eax,-0x74(%rbp)
  2c06f9:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  2c06ff:	0f 85 21 02 00 00    	jne    2c0926 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0705:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0708:	89 45 88             	mov    %eax,-0x78(%rbp)
  2c070b:	83 e0 60             	and    $0x60,%eax
  2c070e:	83 f8 60             	cmp    $0x60,%eax
  2c0711:	0f 84 54 02 00 00    	je     2c096b <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0717:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c071a:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  2c071d:	48 c7 45 a0 7d 13 2c 	movq   $0x2c137d,-0x60(%rbp)
  2c0724:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0725:	83 f8 21             	cmp    $0x21,%eax
  2c0728:	0f 84 79 02 00 00    	je     2c09a7 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c072e:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  2c0731:	89 f8                	mov    %edi,%eax
  2c0733:	f7 d0                	not    %eax
  2c0735:	c1 e8 1f             	shr    $0x1f,%eax
  2c0738:	89 45 84             	mov    %eax,-0x7c(%rbp)
  2c073b:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c073f:	0f 85 9e 02 00 00    	jne    2c09e3 <printer_vprintf+0x64d>
  2c0745:	84 c0                	test   %al,%al
  2c0747:	0f 84 96 02 00 00    	je     2c09e3 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  2c074d:	48 63 f7             	movslq %edi,%rsi
  2c0750:	4c 89 e7             	mov    %r12,%rdi
  2c0753:	e8 63 fb ff ff       	call   2c02bb <strnlen>
  2c0758:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c075b:	8b 45 88             	mov    -0x78(%rbp),%eax
  2c075e:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  2c0761:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c0768:	83 f8 22             	cmp    $0x22,%eax
  2c076b:	0f 84 aa 02 00 00    	je     2c0a1b <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  2c0771:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0775:	e8 26 fb ff ff       	call   2c02a0 <strlen>
  2c077a:	8b 55 9c             	mov    -0x64(%rbp),%edx
  2c077d:	03 55 98             	add    -0x68(%rbp),%edx
  2c0780:	44 89 e9             	mov    %r13d,%ecx
  2c0783:	29 d1                	sub    %edx,%ecx
  2c0785:	29 c1                	sub    %eax,%ecx
  2c0787:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  2c078a:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c078d:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  2c0791:	75 2d                	jne    2c07c0 <printer_vprintf+0x42a>
  2c0793:	85 c9                	test   %ecx,%ecx
  2c0795:	7e 29                	jle    2c07c0 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  2c0797:	44 89 fa             	mov    %r15d,%edx
  2c079a:	be 20 00 00 00       	mov    $0x20,%esi
  2c079f:	4c 89 f7             	mov    %r14,%rdi
  2c07a2:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c07a5:	41 83 ed 01          	sub    $0x1,%r13d
  2c07a9:	45 85 ed             	test   %r13d,%r13d
  2c07ac:	7f e9                	jg     2c0797 <printer_vprintf+0x401>
  2c07ae:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  2c07b1:	85 ff                	test   %edi,%edi
  2c07b3:	b8 01 00 00 00       	mov    $0x1,%eax
  2c07b8:	0f 4f c7             	cmovg  %edi,%eax
  2c07bb:	29 c7                	sub    %eax,%edi
  2c07bd:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  2c07c0:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c07c4:	0f b6 07             	movzbl (%rdi),%eax
  2c07c7:	84 c0                	test   %al,%al
  2c07c9:	74 22                	je     2c07ed <printer_vprintf+0x457>
  2c07cb:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c07cf:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  2c07d2:	0f b6 f0             	movzbl %al,%esi
  2c07d5:	44 89 fa             	mov    %r15d,%edx
  2c07d8:	4c 89 f7             	mov    %r14,%rdi
  2c07db:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  2c07de:	48 83 c3 01          	add    $0x1,%rbx
  2c07e2:	0f b6 03             	movzbl (%rbx),%eax
  2c07e5:	84 c0                	test   %al,%al
  2c07e7:	75 e9                	jne    2c07d2 <printer_vprintf+0x43c>
  2c07e9:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  2c07ed:	8b 45 9c             	mov    -0x64(%rbp),%eax
  2c07f0:	85 c0                	test   %eax,%eax
  2c07f2:	7e 1d                	jle    2c0811 <printer_vprintf+0x47b>
  2c07f4:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c07f8:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  2c07fa:	44 89 fa             	mov    %r15d,%edx
  2c07fd:	be 30 00 00 00       	mov    $0x30,%esi
  2c0802:	4c 89 f7             	mov    %r14,%rdi
  2c0805:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  2c0808:	83 eb 01             	sub    $0x1,%ebx
  2c080b:	75 ed                	jne    2c07fa <printer_vprintf+0x464>
  2c080d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  2c0811:	8b 45 98             	mov    -0x68(%rbp),%eax
  2c0814:	85 c0                	test   %eax,%eax
  2c0816:	7e 27                	jle    2c083f <printer_vprintf+0x4a9>
  2c0818:	89 c0                	mov    %eax,%eax
  2c081a:	4c 01 e0             	add    %r12,%rax
  2c081d:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c0821:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  2c0824:	41 0f b6 34 24       	movzbl (%r12),%esi
  2c0829:	44 89 fa             	mov    %r15d,%edx
  2c082c:	4c 89 f7             	mov    %r14,%rdi
  2c082f:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  2c0832:	49 83 c4 01          	add    $0x1,%r12
  2c0836:	49 39 dc             	cmp    %rbx,%r12
  2c0839:	75 e9                	jne    2c0824 <printer_vprintf+0x48e>
  2c083b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  2c083f:	45 85 ed             	test   %r13d,%r13d
  2c0842:	7e 14                	jle    2c0858 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  2c0844:	44 89 fa             	mov    %r15d,%edx
  2c0847:	be 20 00 00 00       	mov    $0x20,%esi
  2c084c:	4c 89 f7             	mov    %r14,%rdi
  2c084f:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  2c0852:	41 83 ed 01          	sub    $0x1,%r13d
  2c0856:	75 ec                	jne    2c0844 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  2c0858:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  2c085c:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c0860:	84 c0                	test   %al,%al
  2c0862:	0f 84 fe 01 00 00    	je     2c0a66 <printer_vprintf+0x6d0>
        if (*format != '%') {
  2c0868:	3c 25                	cmp    $0x25,%al
  2c086a:	0f 84 54 fb ff ff    	je     2c03c4 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  2c0870:	0f b6 f0             	movzbl %al,%esi
  2c0873:	44 89 fa             	mov    %r15d,%edx
  2c0876:	4c 89 f7             	mov    %r14,%rdi
  2c0879:	41 ff 16             	call   *(%r14)
            continue;
  2c087c:	4c 89 e3             	mov    %r12,%rbx
  2c087f:	eb d7                	jmp    2c0858 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  2c0881:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0885:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0889:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c088d:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0891:	e9 51 fe ff ff       	jmp    2c06e7 <printer_vprintf+0x351>
            color = va_arg(val, int);
  2c0896:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c089a:	8b 07                	mov    (%rdi),%eax
  2c089c:	83 f8 2f             	cmp    $0x2f,%eax
  2c089f:	77 10                	ja     2c08b1 <printer_vprintf+0x51b>
  2c08a1:	89 c2                	mov    %eax,%edx
  2c08a3:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c08a7:	83 c0 08             	add    $0x8,%eax
  2c08aa:	89 07                	mov    %eax,(%rdi)
  2c08ac:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  2c08af:	eb a7                	jmp    2c0858 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  2c08b1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c08b5:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c08b9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c08bd:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c08c1:	eb e9                	jmp    2c08ac <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  2c08c3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c08c7:	8b 01                	mov    (%rcx),%eax
  2c08c9:	83 f8 2f             	cmp    $0x2f,%eax
  2c08cc:	77 23                	ja     2c08f1 <printer_vprintf+0x55b>
  2c08ce:	89 c2                	mov    %eax,%edx
  2c08d0:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c08d4:	83 c0 08             	add    $0x8,%eax
  2c08d7:	89 01                	mov    %eax,(%rcx)
  2c08d9:	8b 02                	mov    (%rdx),%eax
  2c08db:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  2c08de:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c08e2:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c08e6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  2c08ec:	e9 ff fd ff ff       	jmp    2c06f0 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  2c08f1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c08f5:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c08f9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c08fd:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0901:	eb d6                	jmp    2c08d9 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  2c0903:	84 d2                	test   %dl,%dl
  2c0905:	0f 85 39 01 00 00    	jne    2c0a44 <printer_vprintf+0x6ae>
  2c090b:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  2c090f:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  2c0913:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  2c0917:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c091b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0921:	e9 ca fd ff ff       	jmp    2c06f0 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  2c0926:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  2c092c:	bf d0 15 2c 00       	mov    $0x2c15d0,%edi
        if (flags & FLAG_NUMERIC) {
  2c0931:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  2c0936:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  2c093a:	4c 89 c1             	mov    %r8,%rcx
  2c093d:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  2c0941:	48 63 f6             	movslq %esi,%rsi
  2c0944:	49 83 ec 01          	sub    $0x1,%r12
  2c0948:	48 89 c8             	mov    %rcx,%rax
  2c094b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0950:	48 f7 f6             	div    %rsi
  2c0953:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  2c0957:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  2c095b:	48 89 ca             	mov    %rcx,%rdx
  2c095e:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  2c0961:	48 39 d6             	cmp    %rdx,%rsi
  2c0964:	76 de                	jbe    2c0944 <printer_vprintf+0x5ae>
  2c0966:	e9 9a fd ff ff       	jmp    2c0705 <printer_vprintf+0x36f>
                prefix = "-";
  2c096b:	48 c7 45 a0 e5 13 2c 	movq   $0x2c13e5,-0x60(%rbp)
  2c0972:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0973:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0976:	a8 80                	test   $0x80,%al
  2c0978:	0f 85 b0 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                prefix = "+";
  2c097e:	48 c7 45 a0 e0 13 2c 	movq   $0x2c13e0,-0x60(%rbp)
  2c0985:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0986:	a8 10                	test   $0x10,%al
  2c0988:	0f 85 a0 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                prefix = " ";
  2c098e:	a8 08                	test   $0x8,%al
  2c0990:	ba 7d 13 2c 00       	mov    $0x2c137d,%edx
  2c0995:	b8 ed 15 2c 00       	mov    $0x2c15ed,%eax
  2c099a:	48 0f 44 c2          	cmove  %rdx,%rax
  2c099e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c09a2:	e9 87 fd ff ff       	jmp    2c072e <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  2c09a7:	41 8d 41 10          	lea    0x10(%r9),%eax
  2c09ab:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  2c09b0:	0f 85 78 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  2c09b6:	4d 85 c0             	test   %r8,%r8
  2c09b9:	75 0d                	jne    2c09c8 <printer_vprintf+0x632>
  2c09bb:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  2c09c2:	0f 84 66 fd ff ff    	je     2c072e <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  2c09c8:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  2c09cc:	ba e7 13 2c 00       	mov    $0x2c13e7,%edx
  2c09d1:	b8 e2 13 2c 00       	mov    $0x2c13e2,%eax
  2c09d6:	48 0f 44 c2          	cmove  %rdx,%rax
  2c09da:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c09de:	e9 4b fd ff ff       	jmp    2c072e <printer_vprintf+0x398>
            len = strlen(data);
  2c09e3:	4c 89 e7             	mov    %r12,%rdi
  2c09e6:	e8 b5 f8 ff ff       	call   2c02a0 <strlen>
  2c09eb:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c09ee:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c09f2:	0f 84 63 fd ff ff    	je     2c075b <printer_vprintf+0x3c5>
  2c09f8:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  2c09fc:	0f 84 59 fd ff ff    	je     2c075b <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  2c0a02:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  2c0a05:	89 ca                	mov    %ecx,%edx
  2c0a07:	29 c2                	sub    %eax,%edx
  2c0a09:	39 c1                	cmp    %eax,%ecx
  2c0a0b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a10:	0f 4e d0             	cmovle %eax,%edx
  2c0a13:	89 55 9c             	mov    %edx,-0x64(%rbp)
  2c0a16:	e9 56 fd ff ff       	jmp    2c0771 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  2c0a1b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0a1f:	e8 7c f8 ff ff       	call   2c02a0 <strlen>
  2c0a24:	8b 7d 98             	mov    -0x68(%rbp),%edi
  2c0a27:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  2c0a2a:	44 89 e9             	mov    %r13d,%ecx
  2c0a2d:	29 f9                	sub    %edi,%ecx
  2c0a2f:	29 c1                	sub    %eax,%ecx
  2c0a31:	44 39 ea             	cmp    %r13d,%edx
  2c0a34:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a39:	0f 4d c8             	cmovge %eax,%ecx
  2c0a3c:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  2c0a3f:	e9 2d fd ff ff       	jmp    2c0771 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  2c0a44:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  2c0a47:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c0a4b:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c0a4f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0a55:	e9 96 fc ff ff       	jmp    2c06f0 <printer_vprintf+0x35a>
        int flags = 0;
  2c0a5a:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  2c0a61:	e9 b0 f9 ff ff       	jmp    2c0416 <printer_vprintf+0x80>
}
  2c0a66:	48 83 c4 58          	add    $0x58,%rsp
  2c0a6a:	5b                   	pop    %rbx
  2c0a6b:	41 5c                	pop    %r12
  2c0a6d:	41 5d                	pop    %r13
  2c0a6f:	41 5e                	pop    %r14
  2c0a71:	41 5f                	pop    %r15
  2c0a73:	5d                   	pop    %rbp
  2c0a74:	c3                   	ret    

00000000002c0a75 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c0a75:	55                   	push   %rbp
  2c0a76:	48 89 e5             	mov    %rsp,%rbp
  2c0a79:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  2c0a7d:	48 c7 45 f0 80 01 2c 	movq   $0x2c0180,-0x10(%rbp)
  2c0a84:	00 
        cpos = 0;
  2c0a85:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  2c0a8b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a90:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  2c0a93:	48 63 ff             	movslq %edi,%rdi
  2c0a96:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  2c0a9d:	00 
  2c0a9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c0aa2:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  2c0aa6:	e8 eb f8 ff ff       	call   2c0396 <printer_vprintf>
    return cp.cursor - console;
  2c0aab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0aaf:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c0ab5:	48 d1 f8             	sar    %rax
}
  2c0ab8:	c9                   	leave  
  2c0ab9:	c3                   	ret    

00000000002c0aba <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  2c0aba:	55                   	push   %rbp
  2c0abb:	48 89 e5             	mov    %rsp,%rbp
  2c0abe:	48 83 ec 50          	sub    $0x50,%rsp
  2c0ac2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0ac6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0aca:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  2c0ace:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0ad5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0ad9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0add:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0ae1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c0ae5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0ae9:	e8 87 ff ff ff       	call   2c0a75 <console_vprintf>
}
  2c0aee:	c9                   	leave  
  2c0aef:	c3                   	ret    

00000000002c0af0 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c0af0:	55                   	push   %rbp
  2c0af1:	48 89 e5             	mov    %rsp,%rbp
  2c0af4:	53                   	push   %rbx
  2c0af5:	48 83 ec 28          	sub    $0x28,%rsp
  2c0af9:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  2c0afc:	48 c7 45 d8 06 02 2c 	movq   $0x2c0206,-0x28(%rbp)
  2c0b03:	00 
    sp.s = s;
  2c0b04:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  2c0b08:	48 85 f6             	test   %rsi,%rsi
  2c0b0b:	75 0b                	jne    2c0b18 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  2c0b0d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c0b10:	29 d8                	sub    %ebx,%eax
}
  2c0b12:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0b16:	c9                   	leave  
  2c0b17:	c3                   	ret    
        sp.end = s + size - 1;
  2c0b18:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  2c0b1d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c0b21:	be 00 00 00 00       	mov    $0x0,%esi
  2c0b26:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  2c0b2a:	e8 67 f8 ff ff       	call   2c0396 <printer_vprintf>
        *sp.s = 0;
  2c0b2f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0b33:	c6 00 00             	movb   $0x0,(%rax)
  2c0b36:	eb d5                	jmp    2c0b0d <vsnprintf+0x1d>

00000000002c0b38 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c0b38:	55                   	push   %rbp
  2c0b39:	48 89 e5             	mov    %rsp,%rbp
  2c0b3c:	48 83 ec 50          	sub    $0x50,%rsp
  2c0b40:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0b44:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0b48:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c0b4c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0b53:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0b57:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0b5b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0b5f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c0b63:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0b67:	e8 84 ff ff ff       	call   2c0af0 <vsnprintf>
    va_end(val);
    return n;
}
  2c0b6c:	c9                   	leave  
  2c0b6d:	c3                   	ret    

00000000002c0b6e <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0b6e:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  2c0b73:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  2c0b78:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0b7d:	48 83 c0 02          	add    $0x2,%rax
  2c0b81:	48 39 d0             	cmp    %rdx,%rax
  2c0b84:	75 f2                	jne    2c0b78 <console_clear+0xa>
    }
    cursorpos = 0;
  2c0b86:	c7 05 6c 84 df ff 00 	movl   $0x0,-0x207b94(%rip)        # b8ffc <cursorpos>
  2c0b8d:	00 00 00 
}
  2c0b90:	c3                   	ret    

00000000002c0b91 <grab_payload>:

#define HEADER_SZ sizeof(header_list)

void * grab_payload(header_list * header_pt)
{
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  2c0b91:	48 8d 47 10          	lea    0x10(%rdi),%rax
    return payload;
}
  2c0b95:	c3                   	ret    

00000000002c0b96 <grab_header>:

header_list * grab_header(void * mem_payload)
{
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c0b96:	48 8d 47 f0          	lea    -0x10(%rdi),%rax
    return header;
}
  2c0b9a:	c3                   	ret    

00000000002c0b9b <next_block>:

header_list* next_block(header_list *header)
{ 
    return (header_list*) ((uintptr_t) header + header->size); 
  2c0b9b:	48 89 f8             	mov    %rdi,%rax
  2c0b9e:	48 03 07             	add    (%rdi),%rax
}
  2c0ba1:	c3                   	ret    

00000000002c0ba2 <initialize_malloc>:
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c0ba2:	bf 10 00 00 00       	mov    $0x10,%edi
  2c0ba7:	cd 3a                	int    $0x3a
  2c0ba9:	48 89 05 68 14 00 00 	mov    %rax,0x1468(%rip)        # 2c2018 <result.0>
  2c0bb0:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0bb5:	cd 3a                	int    $0x3a
  2c0bb7:	48 89 05 5a 14 00 00 	mov    %rax,0x145a(%rip)        # 2c2018 <result.0>
int first_run = 1;

int initialize_malloc()
{
    sbrk(sizeof(header_list));
    first_bp = sbrk(0);
  2c0bbe:	48 89 05 4b 14 00 00 	mov    %rax,0x144b(%rip)        # 2c2010 <first_bp>
    
    grab_header(first_bp)->size = 0;
  2c0bc5:	48 c7 40 f0 00 00 00 	movq   $0x0,-0x10(%rax)
  2c0bcc:	00 
    grab_header(first_bp)->allocated = 1;
  2c0bcd:	48 8b 05 3c 14 00 00 	mov    0x143c(%rip),%rax        # 2c2010 <first_bp>
  2c0bd4:	c7 40 f8 01 00 00 00 	movl   $0x1,-0x8(%rax)

    first_run = 0;
  2c0bdb:	c7 05 1b 14 00 00 00 	movl   $0x0,0x141b(%rip)        # 2c2000 <first_run>
  2c0be2:	00 00 00 
    return 0;
}
  2c0be5:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0bea:	c3                   	ret    

00000000002c0beb <expand_heap>:
  2c0beb:	cd 3a                	int    $0x3a
  2c0bed:	48 89 05 24 14 00 00 	mov    %rax,0x1424(%rip)        # 2c2018 <result.0>

int expand_heap(uint64_t block_size)
{
    void *bp = sbrk(block_size);

    if ((uintptr_t) bp == (uintptr_t) -1) return -1;
  2c0bf4:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0bf8:	74 2a                	je     2c0c24 <expand_heap+0x39>
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c0bfa:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
    grab_header(bp)->size = block_size;
  2c0bfe:	48 89 78 f0          	mov    %rdi,-0x10(%rax)
    grab_header(bp)->allocated = 0;
  2c0c02:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%rax)

    next_block(grab_header(bp))->size = 0;
  2c0c09:	48 c7 44 07 f0 00 00 	movq   $0x0,-0x10(%rdi,%rax,1)
  2c0c10:	00 00 
    next_block(grab_header(bp))->allocated = 1;
  2c0c12:	48 8b 40 f0          	mov    -0x10(%rax),%rax
  2c0c16:	c7 44 10 08 01 00 00 	movl   $0x1,0x8(%rax,%rdx,1)
  2c0c1d:	00 
    return 0; // succesfully increased brk and expanded heap
  2c0c1e:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0c23:	c3                   	ret    
    if ((uintptr_t) bp == (uintptr_t) -1) return -1;
  2c0c24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  2c0c29:	c3                   	ret    

00000000002c0c2a <extend>:

int extend(uint64_t new_size)
{
  2c0c2a:	55                   	push   %rbp
  2c0c2b:	48 89 e5             	mov    %rsp,%rbp
    uint64_t block_size = BLOCK_ALIGN(new_size);
  2c0c2e:	48 81 c7 ff 7f 00 00 	add    $0x7fff,%rdi
  2c0c35:	48 81 e7 00 80 ff ff 	and    $0xffffffffffff8000,%rdi
    if (expand_heap(block_size) == -1) return -1;
  2c0c3c:	e8 aa ff ff ff       	call   2c0beb <expand_heap>
  2c0c41:	83 f8 ff             	cmp    $0xffffffff,%eax
  2c0c44:	0f 94 c0             	sete   %al
  2c0c47:	0f b6 c0             	movzbl %al,%eax
  2c0c4a:	f7 d8                	neg    %eax
    return 0; 
}
  2c0c4c:	5d                   	pop    %rbp
  2c0c4d:	c3                   	ret    

00000000002c0c4e <split>:

void split(header_list *header, uint64_t size)
{
    uint64_t extra_size = header->size - size;
  2c0c4e:	48 8b 07             	mov    (%rdi),%rax
  2c0c51:	48 29 f0             	sub    %rsi,%rax
 
    if (header->size - size > ALIGN(1 + HEADER_SZ))
  2c0c54:	48 83 f8 18          	cmp    $0x18,%rax
  2c0c58:	76 12                	jbe    2c0c6c <split+0x1e>
    {
        header->size = size;        
  2c0c5a:	48 89 37             	mov    %rsi,(%rdi)
        next_block(header)->size = extra_size;
  2c0c5d:	48 89 04 3e          	mov    %rax,(%rsi,%rdi,1)
        next_block(header)->allocated = 0;
  2c0c61:	48 8b 07             	mov    (%rdi),%rax
  2c0c64:	c7 44 38 08 00 00 00 	movl   $0x0,0x8(%rax,%rdi,1)
  2c0c6b:	00 
    }
    header->allocated = 1;
  2c0c6c:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%rdi)
}
  2c0c73:	c3                   	ret    

00000000002c0c74 <free>:

void free(void *firstbyte) {
    if (firstbyte == NULL) return;
  2c0c74:	48 85 ff             	test   %rdi,%rdi
  2c0c77:	74 14                	je     2c0c8d <free+0x19>
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c0c79:	48 8b 15 90 13 00 00 	mov    0x1390(%rip),%rdx        # 2c2010 <first_bp>
  2c0c80:	48 8d 42 f0          	lea    -0x10(%rdx),%rax

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c0c84:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  2c0c88:	48 85 d2             	test   %rdx,%rdx
  2c0c8b:	75 0c                	jne    2c0c99 <free+0x25>
                curr->allocated = 0;
                return;
            }
        }
    }
}
  2c0c8d:	c3                   	ret    
    return (header_list*) ((uintptr_t) header + header->size); 
  2c0c8e:	48 01 d0             	add    %rdx,%rax
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c0c91:	48 8b 10             	mov    (%rax),%rdx
  2c0c94:	48 85 d2             	test   %rdx,%rdx
  2c0c97:	74 f4                	je     2c0c8d <free+0x19>
        if (curr->allocated == 1)
  2c0c99:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  2c0c9d:	75 ef                	jne    2c0c8e <free+0x1a>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  2c0c9f:	48 8d 48 10          	lea    0x10(%rax),%rcx
            if (grab_payload(curr) == firstbyte)
  2c0ca3:	48 39 cf             	cmp    %rcx,%rdi
  2c0ca6:	75 e6                	jne    2c0c8e <free+0x1a>
                curr->allocated = 0;
  2c0ca8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
                return;
  2c0caf:	c3                   	ret    

00000000002c0cb0 <find_free_block>:
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c0cb0:	48 8b 15 59 13 00 00 	mov    0x1359(%rip),%rdx        # 2c2010 <first_bp>
  2c0cb7:	48 8d 42 f0          	lea    -0x10(%rdx),%rax

header_list * find_free_block(uint64_t new_sz)
{
    header_list * curr = grab_header(first_bp);
    for ( curr ; curr->size != 0; curr = next_block(curr))
  2c0cbb:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  2c0cbf:	48 85 d2             	test   %rdx,%rdx
  2c0cc2:	75 0d                	jne    2c0cd1 <find_free_block+0x21>
  2c0cc4:	eb 16                	jmp    2c0cdc <find_free_block+0x2c>
    return (header_list*) ((uintptr_t) header + header->size); 
  2c0cc6:	48 01 d0             	add    %rdx,%rax
    for ( curr ; curr->size != 0; curr = next_block(curr))
  2c0cc9:	48 8b 10             	mov    (%rax),%rdx
  2c0ccc:	48 85 d2             	test   %rdx,%rdx
  2c0ccf:	74 0b                	je     2c0cdc <find_free_block+0x2c>
    {
        if (curr->allocated == 0)
        {
            if (curr->size >= new_sz)
  2c0cd1:	83 78 08 00          	cmpl   $0x0,0x8(%rax)
  2c0cd5:	75 ef                	jne    2c0cc6 <find_free_block+0x16>
  2c0cd7:	48 39 d7             	cmp    %rdx,%rdi
  2c0cda:	77 ea                	ja     2c0cc6 <find_free_block+0x16>
            }
        }
    }
    // otherwise return a header with size zero
    return curr;
}
  2c0cdc:	c3                   	ret    

00000000002c0cdd <malloc>:

void *malloc(uint64_t numbytes)
{
    if (numbytes == 0 || numbytes >= SIZE_MAX)
  2c0cdd:	48 8d 47 ff          	lea    -0x1(%rdi),%rax
  2c0ce1:	48 83 f8 fd          	cmp    $0xfffffffffffffffd,%rax
  2c0ce5:	77 73                	ja     2c0d5a <malloc+0x7d>
{
  2c0ce7:	55                   	push   %rbp
  2c0ce8:	48 89 e5             	mov    %rsp,%rbp
  2c0ceb:	41 54                	push   %r12
  2c0ced:	53                   	push   %rbx
  2c0cee:	48 89 fb             	mov    %rdi,%rbx
    { 
        return NULL; 
    }

    if (first_run) initialize_malloc(); 
  2c0cf1:	83 3d 08 13 00 00 00 	cmpl   $0x0,0x1308(%rip)        # 2c2000 <first_run>
  2c0cf8:	75 42                	jne    2c0d3c <malloc+0x5f>

    uint64_t new_size = ALIGN(numbytes + HEADER_SZ);
  2c0cfa:	48 83 c3 17          	add    $0x17,%rbx
  2c0cfe:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx

    header_list *header = find_free_block(new_size);
  2c0d02:	48 89 df             	mov    %rbx,%rdi
  2c0d05:	e8 a6 ff ff ff       	call   2c0cb0 <find_free_block>
  2c0d0a:	49 89 c4             	mov    %rax,%r12

    if (header->size != 0)
  2c0d0d:	48 83 38 00          	cmpq   $0x0,(%rax)
  2c0d11:	75 35                	jne    2c0d48 <malloc+0x6b>
        split(header, new_size);
        return grab_payload(header);
    }
    else
    {   // otherwise, extend the heap, split the header of zero, and return that payload
        if (extend(new_size) == -1) return NULL;
  2c0d13:	48 89 df             	mov    %rbx,%rdi
  2c0d16:	e8 0f ff ff ff       	call   2c0c2a <extend>
  2c0d1b:	89 c2                	mov    %eax,%edx
  2c0d1d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0d22:	83 fa ff             	cmp    $0xffffffff,%edx
  2c0d25:	74 10                	je     2c0d37 <malloc+0x5a>
        split(header, new_size);
  2c0d27:	48 89 de             	mov    %rbx,%rsi
  2c0d2a:	4c 89 e7             	mov    %r12,%rdi
  2c0d2d:	e8 1c ff ff ff       	call   2c0c4e <split>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  2c0d32:	49 8d 44 24 10       	lea    0x10(%r12),%rax
        return grab_payload(header);
    }
}
  2c0d37:	5b                   	pop    %rbx
  2c0d38:	41 5c                	pop    %r12
  2c0d3a:	5d                   	pop    %rbp
  2c0d3b:	c3                   	ret    
    if (first_run) initialize_malloc(); 
  2c0d3c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0d41:	e8 5c fe ff ff       	call   2c0ba2 <initialize_malloc>
  2c0d46:	eb b2                	jmp    2c0cfa <malloc+0x1d>
        split(header, new_size);
  2c0d48:	48 89 de             	mov    %rbx,%rsi
  2c0d4b:	48 89 c7             	mov    %rax,%rdi
  2c0d4e:	e8 fb fe ff ff       	call   2c0c4e <split>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  2c0d53:	49 8d 44 24 10       	lea    0x10(%r12),%rax
        return grab_payload(header);
  2c0d58:	eb dd                	jmp    2c0d37 <malloc+0x5a>
        return NULL; 
  2c0d5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c0d5f:	c3                   	ret    

00000000002c0d60 <calloc>:

void * calloc(uint64_t num, uint64_t sz) 
{
  2c0d60:	55                   	push   %rbp
  2c0d61:	48 89 e5             	mov    %rsp,%rbp
  2c0d64:	41 54                	push   %r12
  2c0d66:	53                   	push   %rbx
    if (num <= 0 || sz <= 0) return NULL;
  2c0d67:	48 85 ff             	test   %rdi,%rdi
  2c0d6a:	74 4e                	je     2c0dba <calloc+0x5a>
  2c0d6c:	48 85 f6             	test   %rsi,%rsi
  2c0d6f:	74 49                	je     2c0dba <calloc+0x5a>
    if (num >= SIZE_MAX / sz) return NULL;
  2c0d71:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  2c0d78:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d7d:	48 f7 f6             	div    %rsi
  2c0d80:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0d86:	48 39 f8             	cmp    %rdi,%rax
  2c0d89:	76 27                	jbe    2c0db2 <calloc+0x52>

    void * ptr = malloc(num * sz);
  2c0d8b:	48 89 fb             	mov    %rdi,%rbx
  2c0d8e:	48 0f af de          	imul   %rsi,%rbx
  2c0d92:	48 89 df             	mov    %rbx,%rdi
  2c0d95:	e8 43 ff ff ff       	call   2c0cdd <malloc>
  2c0d9a:	49 89 c4             	mov    %rax,%r12

    if (ptr != NULL)
  2c0d9d:	48 85 c0             	test   %rax,%rax
  2c0da0:	74 10                	je     2c0db2 <calloc+0x52>
    {
        memset(ptr, 0, num * sz);
  2c0da2:	48 89 da             	mov    %rbx,%rdx
  2c0da5:	be 00 00 00 00       	mov    $0x0,%esi
  2c0daa:	48 89 c7             	mov    %rax,%rdi
  2c0dad:	e8 d3 f4 ff ff       	call   2c0285 <memset>
    }

    return ptr;
}
  2c0db2:	4c 89 e0             	mov    %r12,%rax
  2c0db5:	5b                   	pop    %rbx
  2c0db6:	41 5c                	pop    %r12
  2c0db8:	5d                   	pop    %rbp
  2c0db9:	c3                   	ret    
    if (num <= 0 || sz <= 0) return NULL;
  2c0dba:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0dc0:	eb f0                	jmp    2c0db2 <calloc+0x52>

00000000002c0dc2 <realloc>:


void * realloc(void * ptr, uint64_t sz) 
{
  2c0dc2:	55                   	push   %rbp
  2c0dc3:	48 89 e5             	mov    %rsp,%rbp
  2c0dc6:	41 55                	push   %r13
  2c0dc8:	41 54                	push   %r12
  2c0dca:	53                   	push   %rbx
  2c0dcb:	48 83 ec 08          	sub    $0x8,%rsp
    // if pointer is null, same as malloc for all sizes
    if (ptr == NULL) return malloc(sz);
  2c0dcf:	48 85 ff             	test   %rdi,%rdi
  2c0dd2:	74 28                	je     2c0dfc <realloc+0x3a>
  2c0dd4:	48 89 fb             	mov    %rdi,%rbx
    // if size is zero and the ptr isn't NULL, simply free ptr
    if (sz == 0)
  2c0dd7:	48 85 f6             	test   %rsi,%rsi
  2c0dda:	74 2d                	je     2c0e09 <realloc+0x47>
    {
        free(ptr); return NULL;
    }
    if (sz >= SIZE_MAX)
  2c0ddc:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
  2c0de0:	74 5c                	je     2c0e3e <realloc+0x7c>
    // the contents will be unchanged in the range from the start of the region up to the
    // minimum of the old and new sizes

    // the start of the region is at ptr
    // if the new size is less than the old size, leave it unchanged
    uint64_t block_sz = grab_header(ptr)->size;  // original size of block at ptr
  2c0de2:	4c 8b 6f f0          	mov    -0x10(%rdi),%r13
    
    if (block_sz > sz) return ptr;
  2c0de6:	49 89 fc             	mov    %rdi,%r12
  2c0de9:	4c 39 ee             	cmp    %r13,%rsi
  2c0dec:	73 28                	jae    2c0e16 <realloc+0x54>

        free(ptr); // free the old pointer

        return new_block;
    }
}
  2c0dee:	4c 89 e0             	mov    %r12,%rax
  2c0df1:	48 83 c4 08          	add    $0x8,%rsp
  2c0df5:	5b                   	pop    %rbx
  2c0df6:	41 5c                	pop    %r12
  2c0df8:	41 5d                	pop    %r13
  2c0dfa:	5d                   	pop    %rbp
  2c0dfb:	c3                   	ret    
    if (ptr == NULL) return malloc(sz);
  2c0dfc:	48 89 f7             	mov    %rsi,%rdi
  2c0dff:	e8 d9 fe ff ff       	call   2c0cdd <malloc>
  2c0e04:	49 89 c4             	mov    %rax,%r12
  2c0e07:	eb e5                	jmp    2c0dee <realloc+0x2c>
        free(ptr); return NULL;
  2c0e09:	e8 66 fe ff ff       	call   2c0c74 <free>
  2c0e0e:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0e14:	eb d8                	jmp    2c0dee <realloc+0x2c>
    header_list * new_block = malloc(sz);
  2c0e16:	48 89 f7             	mov    %rsi,%rdi
  2c0e19:	e8 bf fe ff ff       	call   2c0cdd <malloc>
  2c0e1e:	49 89 c4             	mov    %rax,%r12
    if (new_block == NULL)
  2c0e21:	48 85 c0             	test   %rax,%rax
  2c0e24:	74 c8                	je     2c0dee <realloc+0x2c>
        memcpy(new_block, ptr, block_sz);
  2c0e26:	4c 89 ea             	mov    %r13,%rdx
  2c0e29:	48 89 de             	mov    %rbx,%rsi
  2c0e2c:	48 89 c7             	mov    %rax,%rdi
  2c0e2f:	e8 e8 f3 ff ff       	call   2c021c <memcpy>
        free(ptr); // free the old pointer
  2c0e34:	48 89 df             	mov    %rbx,%rdi
  2c0e37:	e8 38 fe ff ff       	call   2c0c74 <free>
        return new_block;
  2c0e3c:	eb b0                	jmp    2c0dee <realloc+0x2c>
        return NULL;
  2c0e3e:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0e44:	eb a8                	jmp    2c0dee <realloc+0x2c>

00000000002c0e46 <defrag>:
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c0e46:	48 8b 05 c3 11 00 00 	mov    0x11c3(%rip),%rax        # 2c2010 <first_bp>
  2c0e4d:	48 8d 50 f0          	lea    -0x10(%rax),%rdx

void defrag() 
{
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c0e51:	48 8b 48 f0          	mov    -0x10(%rax),%rcx
  2c0e55:	48 85 c9             	test   %rcx,%rcx
  2c0e58:	75 0f                	jne    2c0e69 <defrag+0x23>
        if (curr->allocated == 0 && adj->allocated == 0)
        {
            curr->size += adj->size;
        }
    }
}
  2c0e5a:	c3                   	ret    
    return (header_list*) ((uintptr_t) header + header->size); 
  2c0e5b:	48 03 02             	add    (%rdx),%rax
  2c0e5e:	48 89 c2             	mov    %rax,%rdx
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c0e61:	48 8b 08             	mov    (%rax),%rcx
  2c0e64:	48 85 c9             	test   %rcx,%rcx
  2c0e67:	74 f1                	je     2c0e5a <defrag+0x14>
    return (header_list*) ((uintptr_t) header + header->size); 
  2c0e69:	48 89 d0             	mov    %rdx,%rax
        if (curr->allocated == 0 && adj->allocated == 0)
  2c0e6c:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  2c0e70:	75 e9                	jne    2c0e5b <defrag+0x15>
    return (header_list*) ((uintptr_t) header + header->size); 
  2c0e72:	48 8d 34 0a          	lea    (%rdx,%rcx,1),%rsi
        if (curr->allocated == 0 && adj->allocated == 0)
  2c0e76:	83 7e 08 00          	cmpl   $0x0,0x8(%rsi)
  2c0e7a:	75 df                	jne    2c0e5b <defrag+0x15>
            curr->size += adj->size;
  2c0e7c:	48 03 0e             	add    (%rsi),%rcx
  2c0e7f:	48 89 0a             	mov    %rcx,(%rdx)
  2c0e82:	eb d7                	jmp    2c0e5b <defrag+0x15>

00000000002c0e84 <merge_array>:

void merge_array(long *array, int start, int mid, int end, uintptr_t * ptr_array)  
{
  2c0e84:	55                   	push   %rbp
  2c0e85:	48 89 e5             	mov    %rsp,%rbp
  2c0e88:	41 57                	push   %r15
  2c0e8a:	41 56                	push   %r14
  2c0e8c:	41 55                	push   %r13
  2c0e8e:	41 54                	push   %r12
  2c0e90:	53                   	push   %rbx
  2c0e91:	48 83 ec 08          	sub    $0x8,%rsp
  2c0e95:	41 89 f3             	mov    %esi,%r11d
  2c0e98:	89 d3                	mov    %edx,%ebx
  2c0e9a:	41 89 cc             	mov    %ecx,%r12d
     long sorted[end - start + 1];
  2c0e9d:	89 c8                	mov    %ecx,%eax
  2c0e9f:	29 f0                	sub    %esi,%eax
  2c0ea1:	83 c0 01             	add    $0x1,%eax
  2c0ea4:	48 98                	cltq   
  2c0ea6:	48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
  2c0ead:	00 
  2c0eae:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  2c0eb2:	48 29 c4             	sub    %rax,%rsp
  2c0eb5:	49 89 e1             	mov    %rsp,%r9
     uintptr_t sorted_ptr[end - start + 1];
  2c0eb8:	48 29 c4             	sub    %rax,%rsp
  2c0ebb:	49 89 e2             	mov    %rsp,%r10
     int a = 0;
     int b = start;
     int c = mid + 1;
  2c0ebe:	8d 52 01             	lea    0x1(%rdx),%edx
     while(b <= mid && c <= end)
  2c0ec1:	39 de                	cmp    %ebx,%esi
  2c0ec3:	7f 4f                	jg     2c0f14 <merge_array+0x90>
  2c0ec5:	39 d1                	cmp    %edx,%ecx
  2c0ec7:	7c 4b                	jl     2c0f14 <merge_array+0x90>
     int b = start;
  2c0ec9:	89 f1                	mov    %esi,%ecx
     while(b <= mid && c <= end)
  2c0ecb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0ed0:	eb 1f                	jmp    2c0ef1 <merge_array+0x6d>
                sorted_ptr[a] = ptr_array[b];
                a++; b++;
            }
            else
            {
                sorted[a] = array[c];
  2c0ed2:	4d 89 2c c1          	mov    %r13,(%r9,%rax,8)
                sorted_ptr[a] = ptr_array[c];
  2c0ed6:	4d 8b 2c f0          	mov    (%r8,%rsi,8),%r13
                a++; c++;
  2c0eda:	8d 70 01             	lea    0x1(%rax),%esi
  2c0edd:	83 c2 01             	add    $0x1,%edx
                sorted_ptr[a] = ptr_array[c];
  2c0ee0:	4d 89 2c c2          	mov    %r13,(%r10,%rax,8)
     while(b <= mid && c <= end)
  2c0ee4:	48 83 c0 01          	add    $0x1,%rax
  2c0ee8:	39 d9                	cmp    %ebx,%ecx
  2c0eea:	7f 30                	jg     2c0f1c <merge_array+0x98>
  2c0eec:	44 39 e2             	cmp    %r12d,%edx
  2c0eef:	7f 2b                	jg     2c0f1c <merge_array+0x98>
            if(array[b] > array[c])
  2c0ef1:	4c 63 f1             	movslq %ecx,%r14
  2c0ef4:	4e 8b 3c f7          	mov    (%rdi,%r14,8),%r15
  2c0ef8:	48 63 f2             	movslq %edx,%rsi
  2c0efb:	4c 8b 2c f7          	mov    (%rdi,%rsi,8),%r13
  2c0eff:	4d 39 ef             	cmp    %r13,%r15
  2c0f02:	7e ce                	jle    2c0ed2 <merge_array+0x4e>
                sorted[a] = array[b];
  2c0f04:	4d 89 3c c1          	mov    %r15,(%r9,%rax,8)
                sorted_ptr[a] = ptr_array[b];
  2c0f08:	4f 8b 2c f0          	mov    (%r8,%r14,8),%r13
                a++; b++;
  2c0f0c:	8d 70 01             	lea    0x1(%rax),%esi
  2c0f0f:	83 c1 01             	add    $0x1,%ecx
  2c0f12:	eb cc                	jmp    2c0ee0 <merge_array+0x5c>
     int b = start;
  2c0f14:	44 89 d9             	mov    %r11d,%ecx
     int a = 0;
  2c0f17:	be 00 00 00 00       	mov    $0x0,%esi
            }
     }

     while(b <= mid) 
  2c0f1c:	39 cb                	cmp    %ecx,%ebx
  2c0f1e:	7c 32                	jl     2c0f52 <merge_array+0xce>
  2c0f20:	48 63 c1             	movslq %ecx,%rax
  2c0f23:	4c 63 f6             	movslq %esi,%r14
  2c0f26:	49 29 c6             	sub    %rax,%r14
  2c0f29:	49 c1 e6 03          	shl    $0x3,%r14
  2c0f2d:	4f 8d 3c 31          	lea    (%r9,%r14,1),%r15
  2c0f31:	4d 01 d6             	add    %r10,%r14
     {
         sorted[a] = array[b];
  2c0f34:	4c 8b 2c c7          	mov    (%rdi,%rax,8),%r13
  2c0f38:	4d 89 2c c7          	mov    %r13,(%r15,%rax,8)
         sorted_ptr[a] = ptr_array[b];
  2c0f3c:	4d 8b 2c c0          	mov    (%r8,%rax,8),%r13
  2c0f40:	4d 89 2c c6          	mov    %r13,(%r14,%rax,8)
     while(b <= mid) 
  2c0f44:	48 83 c0 01          	add    $0x1,%rax
  2c0f48:	39 c3                	cmp    %eax,%ebx
  2c0f4a:	7d e8                	jge    2c0f34 <merge_array+0xb0>
  2c0f4c:	8d 74 1e 01          	lea    0x1(%rsi,%rbx,1),%esi
         a++; b++;
  2c0f50:	29 ce                	sub    %ecx,%esi
     }
     while(c <= end)
  2c0f52:	41 39 d4             	cmp    %edx,%r12d
  2c0f55:	7c 35                	jl     2c0f8c <merge_array+0x108>
  2c0f57:	48 63 c2             	movslq %edx,%rax
  2c0f5a:	48 63 de             	movslq %esi,%rbx
  2c0f5d:	48 29 c3             	sub    %rax,%rbx
  2c0f60:	48 c1 e3 03          	shl    $0x3,%rbx
  2c0f64:	4d 8d 2c 19          	lea    (%r9,%rbx,1),%r13
  2c0f68:	4c 01 d3             	add    %r10,%rbx
     {
        sorted[a] = array[c];
  2c0f6b:	48 8b 0c c7          	mov    (%rdi,%rax,8),%rcx
  2c0f6f:	49 89 4c c5 00       	mov    %rcx,0x0(%r13,%rax,8)
        sorted_ptr[a] = ptr_array[c];
  2c0f74:	49 8b 0c c0          	mov    (%r8,%rax,8),%rcx
  2c0f78:	48 89 0c c3          	mov    %rcx,(%rbx,%rax,8)
     while(c <= end)
  2c0f7c:	48 83 c0 01          	add    $0x1,%rax
  2c0f80:	41 39 c4             	cmp    %eax,%r12d
  2c0f83:	7d e6                	jge    2c0f6b <merge_array+0xe7>
  2c0f85:	29 d6                	sub    %edx,%esi
        a++; c++;
  2c0f87:	42 8d 74 26 01       	lea    0x1(%rsi,%r12,1),%esi
     }
     int i;
     for(i = 0; i < a; i++) 
  2c0f8c:	85 f6                	test   %esi,%esi
  2c0f8e:	7e 2d                	jle    2c0fbd <merge_array+0x139>
  2c0f90:	89 f6                	mov    %esi,%esi
  2c0f92:	4d 63 db             	movslq %r11d,%r11
  2c0f95:	49 c1 e3 03          	shl    $0x3,%r11
  2c0f99:	4c 01 df             	add    %r11,%rdi
  2c0f9c:	4d 01 d8             	add    %r11,%r8
  2c0f9f:	b8 00 00 00 00       	mov    $0x0,%eax
     {
        array[i + start] = sorted[i];
  2c0fa4:	49 8b 14 c1          	mov    (%r9,%rax,8),%rdx
  2c0fa8:	48 89 14 c7          	mov    %rdx,(%rdi,%rax,8)
        ptr_array[i + start] = sorted_ptr[i];
  2c0fac:	49 8b 14 c2          	mov    (%r10,%rax,8),%rdx
  2c0fb0:	49 89 14 c0          	mov    %rdx,(%r8,%rax,8)
     for(i = 0; i < a; i++) 
  2c0fb4:	48 83 c0 01          	add    $0x1,%rax
  2c0fb8:	48 39 f0             	cmp    %rsi,%rax
  2c0fbb:	75 e7                	jne    2c0fa4 <merge_array+0x120>
     }
}
  2c0fbd:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  2c0fc1:	5b                   	pop    %rbx
  2c0fc2:	41 5c                	pop    %r12
  2c0fc4:	41 5d                	pop    %r13
  2c0fc6:	41 5e                	pop    %r14
  2c0fc8:	41 5f                	pop    %r15
  2c0fca:	5d                   	pop    %rbp
  2c0fcb:	c3                   	ret    

00000000002c0fcc <merge_sort>:

void merge_sort(long * array, int start, int end, uintptr_t * ptr_array) {
    int mid = (start + end) / 2;
    if(start < end) {
  2c0fcc:	39 d6                	cmp    %edx,%esi
  2c0fce:	7c 01                	jl     2c0fd1 <merge_sort+0x5>
  2c0fd0:	c3                   	ret    
void merge_sort(long * array, int start, int end, uintptr_t * ptr_array) {
  2c0fd1:	55                   	push   %rbp
  2c0fd2:	48 89 e5             	mov    %rsp,%rbp
  2c0fd5:	41 57                	push   %r15
  2c0fd7:	41 56                	push   %r14
  2c0fd9:	41 55                	push   %r13
  2c0fdb:	41 54                	push   %r12
  2c0fdd:	53                   	push   %rbx
  2c0fde:	48 83 ec 08          	sub    $0x8,%rsp
  2c0fe2:	49 89 fd             	mov    %rdi,%r13
  2c0fe5:	89 f3                	mov    %esi,%ebx
  2c0fe7:	41 89 d4             	mov    %edx,%r12d
  2c0fea:	49 89 cf             	mov    %rcx,%r15
    int mid = (start + end) / 2;
  2c0fed:	8d 04 16             	lea    (%rsi,%rdx,1),%eax
  2c0ff0:	41 89 c6             	mov    %eax,%r14d
  2c0ff3:	41 c1 ee 1f          	shr    $0x1f,%r14d
  2c0ff7:	41 01 c6             	add    %eax,%r14d
  2c0ffa:	41 d1 fe             	sar    %r14d
        merge_sort(array, start, mid, ptr_array);
  2c0ffd:	44 89 f2             	mov    %r14d,%edx
  2c1000:	e8 c7 ff ff ff       	call   2c0fcc <merge_sort>
        merge_sort(array, mid + 1, end, ptr_array);
  2c1005:	41 8d 76 01          	lea    0x1(%r14),%esi
  2c1009:	4c 89 f9             	mov    %r15,%rcx
  2c100c:	44 89 e2             	mov    %r12d,%edx
  2c100f:	4c 89 ef             	mov    %r13,%rdi
  2c1012:	e8 b5 ff ff ff       	call   2c0fcc <merge_sort>
        merge_array(array, start, mid, end, ptr_array);
  2c1017:	4d 89 f8             	mov    %r15,%r8
  2c101a:	44 89 e1             	mov    %r12d,%ecx
  2c101d:	44 89 f2             	mov    %r14d,%edx
  2c1020:	89 de                	mov    %ebx,%esi
  2c1022:	4c 89 ef             	mov    %r13,%rdi
  2c1025:	e8 5a fe ff ff       	call   2c0e84 <merge_array>
    }

}
  2c102a:	48 83 c4 08          	add    $0x8,%rsp
  2c102e:	5b                   	pop    %rbx
  2c102f:	41 5c                	pop    %r12
  2c1031:	41 5d                	pop    %r13
  2c1033:	41 5e                	pop    %r14
  2c1035:	41 5f                	pop    %r15
  2c1037:	5d                   	pop    %rbp
  2c1038:	c3                   	ret    

00000000002c1039 <heap_info>:
//     int free_space;
//     int largest_free_chunk;
// } heap_info_struct;

int heap_info(heap_info_struct * info) 
{
  2c1039:	55                   	push   %rbp
  2c103a:	48 89 e5             	mov    %rsp,%rbp
  2c103d:	41 56                	push   %r14
  2c103f:	41 55                	push   %r13
  2c1041:	41 54                	push   %r12
  2c1043:	53                   	push   %rbx
  2c1044:	49 89 fc             	mov    %rdi,%r12
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c1047:	48 8b 15 c2 0f 00 00 	mov    0xfc2(%rip),%rdx        # 2c2010 <first_bp>
  2c104e:	48 8d 42 f0          	lea    -0x10(%rdx),%rax
    long * size_array = NULL;
    void ** ptr_array = NULL;
    int free_space = 0;
    int largest_free_chunk = 0;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c1052:	48 8b 52 f0          	mov    -0x10(%rdx),%rdx
  2c1056:	48 85 d2             	test   %rdx,%rdx
  2c1059:	74 40                	je     2c109b <heap_info+0x62>
    int num_allocs = 0;
  2c105b:	bb 00 00 00 00       	mov    $0x0,%ebx
    {
        if (curr->allocated == 1) num_allocs++; 
  2c1060:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  2c1064:	0f 94 c1             	sete   %cl
  2c1067:	0f b6 c9             	movzbl %cl,%ecx
  2c106a:	01 cb                	add    %ecx,%ebx
    return (header_list*) ((uintptr_t) header + header->size); 
  2c106c:	48 01 d0             	add    %rdx,%rax
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c106f:	48 8b 10             	mov    (%rax),%rdx
  2c1072:	48 85 d2             	test   %rdx,%rdx
  2c1075:	75 e9                	jne    2c1060 <heap_info+0x27>
    }

    info->num_allocs = num_allocs;
  2c1077:	41 89 1c 24          	mov    %ebx,(%r12)
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c107b:	48 8b 05 8e 0f 00 00 	mov    0xf8e(%rip),%rax        # 2c2010 <first_bp>
  2c1082:	48 8d 50 f0          	lea    -0x10(%rax),%rdx

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c1086:	48 8b 40 f0          	mov    -0x10(%rax),%rax
  2c108a:	48 85 c0             	test   %rax,%rax
  2c108d:	74 2d                	je     2c10bc <heap_info+0x83>
    int largest_free_chunk = 0;
  2c108f:	b9 00 00 00 00       	mov    $0x0,%ecx
    int free_space = 0;
  2c1094:	bf 00 00 00 00       	mov    $0x0,%edi
  2c1099:	eb 12                	jmp    2c10ad <heap_info+0x74>
    int num_allocs = 0;
  2c109b:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c10a0:	eb d5                	jmp    2c1077 <heap_info+0x3e>
    return (header_list*) ((uintptr_t) header + header->size); 
  2c10a2:	48 01 c2             	add    %rax,%rdx
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c10a5:	48 8b 02             	mov    (%rdx),%rax
  2c10a8:	48 85 c0             	test   %rax,%rax
  2c10ab:	74 19                	je     2c10c6 <heap_info+0x8d>
    {   // free space that was not made by heap_info
        if (curr->allocated == 0) 
  2c10ad:	83 7a 08 00          	cmpl   $0x0,0x8(%rdx)
  2c10b1:	75 ef                	jne    2c10a2 <heap_info+0x69>
        {
            free_space += curr->size;
  2c10b3:	01 c7                	add    %eax,%edi
            if (largest_free_chunk < (int) curr->size)
  2c10b5:	39 c1                	cmp    %eax,%ecx
  2c10b7:	0f 4c c8             	cmovl  %eax,%ecx
  2c10ba:	eb e6                	jmp    2c10a2 <heap_info+0x69>
    int largest_free_chunk = 0;
  2c10bc:	b9 00 00 00 00       	mov    $0x0,%ecx
    int free_space = 0;
  2c10c1:	bf 00 00 00 00       	mov    $0x0,%edi
            {
                largest_free_chunk = (int) curr->size;
            }
        }
    }
    info->free_space = free_space;
  2c10c6:	41 89 7c 24 18       	mov    %edi,0x18(%r12)
    info->largest_free_chunk = largest_free_chunk;
  2c10cb:	41 89 4c 24 1c       	mov    %ecx,0x1c(%r12)

    // app_printf(0, "Finished calculating free chunks\n");

    size_array = malloc(sizeof(long) * num_allocs);
  2c10d0:	4c 63 f3             	movslq %ebx,%r14
  2c10d3:	49 c1 e6 03          	shl    $0x3,%r14
  2c10d7:	4c 89 f7             	mov    %r14,%rdi
  2c10da:	e8 fe fb ff ff       	call   2c0cdd <malloc>
  2c10df:	49 89 c5             	mov    %rax,%r13
    ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
  2c10e2:	4c 89 f7             	mov    %r14,%rdi
  2c10e5:	e8 f3 fb ff ff       	call   2c0cdd <malloc>
  2c10ea:	49 89 c6             	mov    %rax,%r14
    // ret_ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
    
    if (num_allocs == 0)
  2c10ed:	85 db                	test   %ebx,%ebx
  2c10ef:	74 2b                	je     2c111c <heap_info+0xe3>
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;        
    }
    // otherwise must be an error in malloc
    else if (size_array == NULL || ptr_array == NULL) return -1;
  2c10f1:	4d 85 ed             	test   %r13,%r13
  2c10f4:	0f 84 a6 00 00 00    	je     2c11a0 <heap_info+0x167>
  2c10fa:	48 85 c0             	test   %rax,%rax
  2c10fd:	0f 84 9d 00 00 00    	je     2c11a0 <heap_info+0x167>
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
  2c1103:	48 8b 15 06 0f 00 00 	mov    0xf06(%rip),%rdx        # 2c2010 <first_bp>
  2c110a:	48 8d 42 f0          	lea    -0x10(%rdx),%rax
    // app_printf(0, "Finished mallocing arrays\n");
    // app_printf(0, "size_array add: %p, start of ptr_array add: %p\n", (uintptr_t) ptr_array, (uintptr_t) size_array);

    uint64_t i = 0;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c110e:	48 83 7a f0 00       	cmpq   $0x0,-0x10(%rdx)
  2c1113:	74 4e                	je     2c1163 <heap_info+0x12a>
    uint64_t i = 0;
  2c1115:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c111a:	eb 31                	jmp    2c114d <heap_info+0x114>
        info->size_array = NULL;
  2c111c:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  2c1123:	00 00 
        info->ptr_array = NULL;
  2c1125:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  2c112c:	00 00 
        return 0;        
  2c112e:	eb 65                	jmp    2c1195 <heap_info+0x15c>
        if (curr->allocated == 1)
        {
            // don't count the size_array and ptr_array malloc
            void * mem_payload = grab_payload(curr);
            if (size_array == mem_payload || ptr_array == mem_payload) continue;
            ptr_array[i] = mem_payload;
  2c1130:	49 89 14 ce          	mov    %rdx,(%r14,%rcx,8)
            size_array[i] = curr->size - HEADER_SZ;
  2c1134:	48 8b 30             	mov    (%rax),%rsi
  2c1137:	48 8d 56 f0          	lea    -0x10(%rsi),%rdx
  2c113b:	49 89 54 cd 00       	mov    %rdx,0x0(%r13,%rcx,8)
            i++;
  2c1140:	48 83 c1 01          	add    $0x1,%rcx
    return (header_list*) ((uintptr_t) header + header->size); 
  2c1144:	48 03 00             	add    (%rax),%rax
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
  2c1147:	48 83 38 00          	cmpq   $0x0,(%rax)
  2c114b:	74 16                	je     2c1163 <heap_info+0x12a>
        if (curr->allocated == 1)
  2c114d:	83 78 08 01          	cmpl   $0x1,0x8(%rax)
  2c1151:	75 f1                	jne    2c1144 <heap_info+0x10b>
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
  2c1153:	48 8d 50 10          	lea    0x10(%rax),%rdx
            if (size_array == mem_payload || ptr_array == mem_payload) continue;
  2c1157:	49 39 d5             	cmp    %rdx,%r13
  2c115a:	74 e8                	je     2c1144 <heap_info+0x10b>
  2c115c:	49 39 d6             	cmp    %rdx,%r14
  2c115f:	75 cf                	jne    2c1130 <heap_info+0xf7>
  2c1161:	eb e1                	jmp    2c1144 <heap_info+0x10b>
    //     app_printf(0, "at idx %d is %p\n", j, ptr_array[j]);
    // }

    // app_printf(0, "Finished filling arrays\n");

    merge_sort(size_array, 0, num_allocs-1, (uintptr_t *) ptr_array);
  2c1163:	8d 53 ff             	lea    -0x1(%rbx),%edx
  2c1166:	4c 89 f1             	mov    %r14,%rcx
  2c1169:	be 00 00 00 00       	mov    $0x0,%esi
  2c116e:	4c 89 ef             	mov    %r13,%rdi
  2c1171:	e8 56 fe ff ff       	call   2c0fcc <merge_sort>

    info->size_array = size_array;
  2c1176:	4d 89 6c 24 08       	mov    %r13,0x8(%r12)
    info->ptr_array = ptr_array; // need to make sure this is sorted in accordance to size
  2c117b:	4d 89 74 24 10       	mov    %r14,0x10(%r12)
    // }


    // app_printf(0, "successful, exiting!\n");

    free(size_array);
  2c1180:	4c 89 ef             	mov    %r13,%rdi
  2c1183:	e8 ec fa ff ff       	call   2c0c74 <free>
    free(ptr_array);
  2c1188:	4c 89 f7             	mov    %r14,%rdi
  2c118b:	e8 e4 fa ff ff       	call   2c0c74 <free>

    return 0;
  2c1190:	bb 00 00 00 00       	mov    $0x0,%ebx
}
  2c1195:	89 d8                	mov    %ebx,%eax
  2c1197:	5b                   	pop    %rbx
  2c1198:	41 5c                	pop    %r12
  2c119a:	41 5d                	pop    %r13
  2c119c:	41 5e                	pop    %r14
  2c119e:	5d                   	pop    %rbp
  2c119f:	c3                   	ret    
    else if (size_array == NULL || ptr_array == NULL) return -1;
  2c11a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  2c11a5:	eb ee                	jmp    2c1195 <heap_info+0x15c>

00000000002c11a7 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c11a7:	55                   	push   %rbp
  2c11a8:	48 89 e5             	mov    %rsp,%rbp
  2c11ab:	48 83 ec 50          	sub    $0x50,%rsp
  2c11af:	49 89 f2             	mov    %rsi,%r10
  2c11b2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c11b6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c11ba:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c11be:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c11c2:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c11c7:	85 ff                	test   %edi,%edi
  2c11c9:	78 2e                	js     2c11f9 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c11cb:	48 63 ff             	movslq %edi,%rdi
  2c11ce:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c11d5:	cc cc cc 
  2c11d8:	48 89 f8             	mov    %rdi,%rax
  2c11db:	48 f7 e2             	mul    %rdx
  2c11de:	48 89 d0             	mov    %rdx,%rax
  2c11e1:	48 c1 e8 02          	shr    $0x2,%rax
  2c11e5:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c11e9:	48 01 c2             	add    %rax,%rdx
  2c11ec:	48 29 d7             	sub    %rdx,%rdi
  2c11ef:	0f b6 b7 1d 16 2c 00 	movzbl 0x2c161d(%rdi),%esi
  2c11f6:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c11f9:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c1200:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1204:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1208:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c120c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c1210:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1214:	4c 89 d2             	mov    %r10,%rdx
  2c1217:	8b 3d df 7d df ff    	mov    -0x208221(%rip),%edi        # b8ffc <cursorpos>
  2c121d:	e8 53 f8 ff ff       	call   2c0a75 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c1222:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c1227:	ba 00 00 00 00       	mov    $0x0,%edx
  2c122c:	0f 4d c2             	cmovge %edx,%eax
  2c122f:	89 05 c7 7d df ff    	mov    %eax,-0x208239(%rip)        # b8ffc <cursorpos>
    }
}
  2c1235:	c9                   	leave  
  2c1236:	c3                   	ret    

00000000002c1237 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c1237:	55                   	push   %rbp
  2c1238:	48 89 e5             	mov    %rsp,%rbp
  2c123b:	53                   	push   %rbx
  2c123c:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c1243:	48 89 fb             	mov    %rdi,%rbx
  2c1246:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c124a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c124e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c1252:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c1256:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c125a:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c1261:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1265:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c1269:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c126d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c1271:	ba 07 00 00 00       	mov    $0x7,%edx
  2c1276:	be e7 15 2c 00       	mov    $0x2c15e7,%esi
  2c127b:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c1282:	e8 95 ef ff ff       	call   2c021c <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c1287:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c128b:	48 89 da             	mov    %rbx,%rdx
  2c128e:	be 99 00 00 00       	mov    $0x99,%esi
  2c1293:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c129a:	e8 51 f8 ff ff       	call   2c0af0 <vsnprintf>
  2c129f:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c12a2:	85 d2                	test   %edx,%edx
  2c12a4:	7e 0f                	jle    2c12b5 <kernel_panic+0x7e>
  2c12a6:	83 c0 06             	add    $0x6,%eax
  2c12a9:	48 98                	cltq   
  2c12ab:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c12b2:	0a 
  2c12b3:	75 2a                	jne    2c12df <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c12b5:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c12bc:	48 89 d9             	mov    %rbx,%rcx
  2c12bf:	ba ef 15 2c 00       	mov    $0x2c15ef,%edx
  2c12c4:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c12c9:	bf 30 07 00 00       	mov    $0x730,%edi
  2c12ce:	b8 00 00 00 00       	mov    $0x0,%eax
  2c12d3:	e8 e2 f7 ff ff       	call   2c0aba <console_printf>
    asm volatile ("int %0" : /* no result */
  2c12d8:	48 89 df             	mov    %rbx,%rdi
  2c12db:	cd 30                	int    $0x30
 loop: goto loop;
  2c12dd:	eb fe                	jmp    2c12dd <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c12df:	48 63 c2             	movslq %edx,%rax
  2c12e2:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c12e8:	0f 94 c2             	sete   %dl
  2c12eb:	0f b6 d2             	movzbl %dl,%edx
  2c12ee:	48 29 d0             	sub    %rdx,%rax
  2c12f1:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c12f8:	ff 
  2c12f9:	be 7c 13 2c 00       	mov    $0x2c137c,%esi
  2c12fe:	e8 db ef ff ff       	call   2c02de <strcpy>
  2c1303:	eb b0                	jmp    2c12b5 <kernel_panic+0x7e>

00000000002c1305 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c1305:	55                   	push   %rbp
  2c1306:	48 89 e5             	mov    %rsp,%rbp
  2c1309:	48 89 f9             	mov    %rdi,%rcx
  2c130c:	41 89 f0             	mov    %esi,%r8d
  2c130f:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c1312:	ba f8 15 2c 00       	mov    $0x2c15f8,%edx
  2c1317:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c131c:	bf 30 07 00 00       	mov    $0x730,%edi
  2c1321:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1326:	e8 8f f7 ff ff       	call   2c0aba <console_printf>
    asm volatile ("int %0" : /* no result */
  2c132b:	bf 00 00 00 00       	mov    $0x0,%edi
  2c1330:	cd 30                	int    $0x30
 loop: goto loop;
  2c1332:	eb fe                	jmp    2c1332 <assert_fail+0x2d>
