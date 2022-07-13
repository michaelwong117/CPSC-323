
bomb:     file format elf32-i386


Disassembly of section .init:

08049000 <_init>:
 8049000:	f3 0f 1e fb          	endbr32 
 8049004:	53                   	push   %ebx
 8049005:	83 ec 08             	sub    $0x8,%esp
 8049008:	e8 63 02 00 00       	call   8049270 <__x86.get_pc_thunk.bx>
 804900d:	81 c3 f3 4f 00 00    	add    $0x4ff3,%ebx
 8049013:	8b 83 fc ff ff ff    	mov    -0x4(%ebx),%eax
 8049019:	85 c0                	test   %eax,%eax
 804901b:	74 02                	je     804901f <_init+0x1f>
 804901d:	ff d0                	call   *%eax
 804901f:	83 c4 08             	add    $0x8,%esp
 8049022:	5b                   	pop    %ebx
 8049023:	c3                   	ret    

Disassembly of section .plt:

08049030 <.plt>:
 8049030:	ff 35 04 e0 04 08    	pushl  0x804e004
 8049036:	ff 25 08 e0 04 08    	jmp    *0x804e008
 804903c:	00 00                	add    %al,(%eax)
	...

08049040 <strcmp@plt>:
 8049040:	ff 25 0c e0 04 08    	jmp    *0x804e00c
 8049046:	68 00 00 00 00       	push   $0x0
 804904b:	e9 e0 ff ff ff       	jmp    8049030 <.plt>

08049050 <read@plt>:
 8049050:	ff 25 10 e0 04 08    	jmp    *0x804e010
 8049056:	68 08 00 00 00       	push   $0x8
 804905b:	e9 d0 ff ff ff       	jmp    8049030 <.plt>

08049060 <printf@plt>:
 8049060:	ff 25 14 e0 04 08    	jmp    *0x804e014
 8049066:	68 10 00 00 00       	push   $0x10
 804906b:	e9 c0 ff ff ff       	jmp    8049030 <.plt>

08049070 <fflush@plt>:
 8049070:	ff 25 18 e0 04 08    	jmp    *0x804e018
 8049076:	68 18 00 00 00       	push   $0x18
 804907b:	e9 b0 ff ff ff       	jmp    8049030 <.plt>

08049080 <memmove@plt>:
 8049080:	ff 25 1c e0 04 08    	jmp    *0x804e01c
 8049086:	68 20 00 00 00       	push   $0x20
 804908b:	e9 a0 ff ff ff       	jmp    8049030 <.plt>

08049090 <fgets@plt>:
 8049090:	ff 25 20 e0 04 08    	jmp    *0x804e020
 8049096:	68 28 00 00 00       	push   $0x28
 804909b:	e9 90 ff ff ff       	jmp    8049030 <.plt>

080490a0 <signal@plt>:
 80490a0:	ff 25 24 e0 04 08    	jmp    *0x804e024
 80490a6:	68 30 00 00 00       	push   $0x30
 80490ab:	e9 80 ff ff ff       	jmp    8049030 <.plt>

080490b0 <sleep@plt>:
 80490b0:	ff 25 28 e0 04 08    	jmp    *0x804e028
 80490b6:	68 38 00 00 00       	push   $0x38
 80490bb:	e9 70 ff ff ff       	jmp    8049030 <.plt>

080490c0 <alarm@plt>:
 80490c0:	ff 25 2c e0 04 08    	jmp    *0x804e02c
 80490c6:	68 40 00 00 00       	push   $0x40
 80490cb:	e9 60 ff ff ff       	jmp    8049030 <.plt>

080490d0 <strcpy@plt>:
 80490d0:	ff 25 30 e0 04 08    	jmp    *0x804e030
 80490d6:	68 48 00 00 00       	push   $0x48
 80490db:	e9 50 ff ff ff       	jmp    8049030 <.plt>

080490e0 <gethostname@plt>:
 80490e0:	ff 25 34 e0 04 08    	jmp    *0x804e034
 80490e6:	68 50 00 00 00       	push   $0x50
 80490eb:	e9 40 ff ff ff       	jmp    8049030 <.plt>

080490f0 <getenv@plt>:
 80490f0:	ff 25 38 e0 04 08    	jmp    *0x804e038
 80490f6:	68 58 00 00 00       	push   $0x58
 80490fb:	e9 30 ff ff ff       	jmp    8049030 <.plt>

08049100 <malloc@plt>:
 8049100:	ff 25 3c e0 04 08    	jmp    *0x804e03c
 8049106:	68 60 00 00 00       	push   $0x60
 804910b:	e9 20 ff ff ff       	jmp    8049030 <.plt>

08049110 <puts@plt>:
 8049110:	ff 25 40 e0 04 08    	jmp    *0x804e040
 8049116:	68 68 00 00 00       	push   $0x68
 804911b:	e9 10 ff ff ff       	jmp    8049030 <.plt>

08049120 <exit@plt>:
 8049120:	ff 25 44 e0 04 08    	jmp    *0x804e044
 8049126:	68 70 00 00 00       	push   $0x70
 804912b:	e9 00 ff ff ff       	jmp    8049030 <.plt>

08049130 <strlen@plt>:
 8049130:	ff 25 48 e0 04 08    	jmp    *0x804e048
 8049136:	68 78 00 00 00       	push   $0x78
 804913b:	e9 f0 fe ff ff       	jmp    8049030 <.plt>

08049140 <__libc_start_main@plt>:
 8049140:	ff 25 4c e0 04 08    	jmp    *0x804e04c
 8049146:	68 80 00 00 00       	push   $0x80
 804914b:	e9 e0 fe ff ff       	jmp    8049030 <.plt>

08049150 <fprintf@plt>:
 8049150:	ff 25 50 e0 04 08    	jmp    *0x804e050
 8049156:	68 88 00 00 00       	push   $0x88
 804915b:	e9 d0 fe ff ff       	jmp    8049030 <.plt>

08049160 <write@plt>:
 8049160:	ff 25 54 e0 04 08    	jmp    *0x804e054
 8049166:	68 90 00 00 00       	push   $0x90
 804916b:	e9 c0 fe ff ff       	jmp    8049030 <.plt>

08049170 <strcasecmp@plt>:
 8049170:	ff 25 58 e0 04 08    	jmp    *0x804e058
 8049176:	68 98 00 00 00       	push   $0x98
 804917b:	e9 b0 fe ff ff       	jmp    8049030 <.plt>

08049180 <__isoc99_x@plt>:
 8049180:	ff 25 5c e0 04 08    	jmp    *0x804e05c
 8049186:	68 a0 00 00 00       	push   $0xa0
 804918b:	e9 a0 fe ff ff       	jmp    8049030 <.plt>

08049190 <fopen@plt>:
 8049190:	ff 25 60 e0 04 08    	jmp    *0x804e060
 8049196:	68 a8 00 00 00       	push   $0xa8
 804919b:	e9 90 fe ff ff       	jmp    8049030 <.plt>

080491a0 <__errno_location@plt>:
 80491a0:	ff 25 64 e0 04 08    	jmp    *0x804e064
 80491a6:	68 b0 00 00 00       	push   $0xb0
 80491ab:	e9 80 fe ff ff       	jmp    8049030 <.plt>

080491b0 <sprintf@plt>:
 80491b0:	ff 25 68 e0 04 08    	jmp    *0x804e068
 80491b6:	68 b8 00 00 00       	push   $0xb8
 80491bb:	e9 70 fe ff ff       	jmp    8049030 <.plt>

080491c0 <socket@plt>:
 80491c0:	ff 25 6c e0 04 08    	jmp    *0x804e06c
 80491c6:	68 c0 00 00 00       	push   $0xc0
 80491cb:	e9 60 fe ff ff       	jmp    8049030 <.plt>

080491d0 <gethostbyname@plt>:
 80491d0:	ff 25 70 e0 04 08    	jmp    *0x804e070
 80491d6:	68 c8 00 00 00       	push   $0xc8
 80491db:	e9 50 fe ff ff       	jmp    8049030 <.plt>

080491e0 <strtol@plt>:
 80491e0:	ff 25 74 e0 04 08    	jmp    *0x804e074
 80491e6:	68 d0 00 00 00       	push   $0xd0
 80491eb:	e9 40 fe ff ff       	jmp    8049030 <.plt>

080491f0 <connect@plt>:
 80491f0:	ff 25 78 e0 04 08    	jmp    *0x804e078
 80491f6:	68 d8 00 00 00       	push   $0xd8
 80491fb:	e9 30 fe ff ff       	jmp    8049030 <.plt>

08049200 <close@plt>:
 8049200:	ff 25 7c e0 04 08    	jmp    *0x804e07c
 8049206:	68 e0 00 00 00       	push   $0xe0
 804920b:	e9 20 fe ff ff       	jmp    8049030 <.plt>

08049210 <__ctype_b_loc@plt>:
 8049210:	ff 25 80 e0 04 08    	jmp    *0x804e080
 8049216:	68 e8 00 00 00       	push   $0xe8
 804921b:	e9 10 fe ff ff       	jmp    8049030 <.plt>

Disassembly of section .text:

08049220 <_start>:
 8049220:	f3 0f 1e fb          	endbr32 
 8049224:	31 ed                	xor    %ebp,%ebp
 8049226:	5e                   	pop    %esi
 8049227:	89 e1                	mov    %esp,%ecx
 8049229:	83 e4 f0             	and    $0xfffffff0,%esp
 804922c:	50                   	push   %eax
 804922d:	54                   	push   %esp
 804922e:	52                   	push   %edx
 804922f:	e8 23 00 00 00       	call   8049257 <_start+0x37>
 8049234:	81 c3 cc 4d 00 00    	add    $0x4dcc,%ebx
 804923a:	8d 83 20 c9 ff ff    	lea    -0x36e0(%ebx),%eax
 8049240:	50                   	push   %eax
 8049241:	8d 83 b0 c8 ff ff    	lea    -0x3750(%ebx),%eax
 8049247:	50                   	push   %eax
 8049248:	51                   	push   %ecx
 8049249:	56                   	push   %esi
 804924a:	c7 c0 36 93 04 08    	mov    $0x8049336,%eax
 8049250:	50                   	push   %eax
 8049251:	e8 ea fe ff ff       	call   8049140 <__libc_start_main@plt>
 8049256:	f4                   	hlt    
 8049257:	8b 1c 24             	mov    (%esp),%ebx
 804925a:	c3                   	ret    

0804925b <.annobin_lto>:
 804925b:	66 90                	xchg   %ax,%ax
 804925d:	66 90                	xchg   %ax,%ax
 804925f:	90                   	nop

08049260 <_dl_relocate_static_pie>:
 8049260:	f3 0f 1e fb          	endbr32 
 8049264:	c3                   	ret    

08049265 <.annobin__dl_relocate_static_pie.end>:
 8049265:	66 90                	xchg   %ax,%ax
 8049267:	66 90                	xchg   %ax,%ax
 8049269:	66 90                	xchg   %ax,%ax
 804926b:	66 90                	xchg   %ax,%ax
 804926d:	66 90                	xchg   %ax,%ax
 804926f:	90                   	nop

08049270 <__x86.get_pc_thunk.bx>:
 8049270:	8b 1c 24             	mov    (%esp),%ebx
 8049273:	c3                   	ret    
 8049274:	66 90                	xchg   %ax,%ax
 8049276:	66 90                	xchg   %ax,%ax
 8049278:	66 90                	xchg   %ax,%ax
 804927a:	66 90                	xchg   %ax,%ax
 804927c:	66 90                	xchg   %ax,%ax
 804927e:	66 90                	xchg   %ax,%ax

08049280 <deregister_tm_clones>:
 8049280:	b8 e0 e7 04 08       	mov    $0x804e7e0,%eax
 8049285:	3d e0 e7 04 08       	cmp    $0x804e7e0,%eax
 804928a:	74 24                	je     80492b0 <deregister_tm_clones+0x30>
 804928c:	b8 00 00 00 00       	mov    $0x0,%eax
 8049291:	85 c0                	test   %eax,%eax
 8049293:	74 1b                	je     80492b0 <deregister_tm_clones+0x30>
 8049295:	55                   	push   %ebp
 8049296:	89 e5                	mov    %esp,%ebp
 8049298:	83 ec 14             	sub    $0x14,%esp
 804929b:	68 e0 e7 04 08       	push   $0x804e7e0
 80492a0:	ff d0                	call   *%eax
 80492a2:	83 c4 10             	add    $0x10,%esp
 80492a5:	c9                   	leave  
 80492a6:	c3                   	ret    
 80492a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80492ae:	66 90                	xchg   %ax,%ax
 80492b0:	c3                   	ret    
 80492b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80492b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80492bf:	90                   	nop

080492c0 <register_tm_clones>:
 80492c0:	b8 e0 e7 04 08       	mov    $0x804e7e0,%eax
 80492c5:	2d e0 e7 04 08       	sub    $0x804e7e0,%eax
 80492ca:	89 c2                	mov    %eax,%edx
 80492cc:	c1 e8 1f             	shr    $0x1f,%eax
 80492cf:	c1 fa 02             	sar    $0x2,%edx
 80492d2:	01 d0                	add    %edx,%eax
 80492d4:	d1 f8                	sar    %eax
 80492d6:	74 20                	je     80492f8 <register_tm_clones+0x38>
 80492d8:	ba 00 00 00 00       	mov    $0x0,%edx
 80492dd:	85 d2                	test   %edx,%edx
 80492df:	74 17                	je     80492f8 <register_tm_clones+0x38>
 80492e1:	55                   	push   %ebp
 80492e2:	89 e5                	mov    %esp,%ebp
 80492e4:	83 ec 10             	sub    $0x10,%esp
 80492e7:	50                   	push   %eax
 80492e8:	68 e0 e7 04 08       	push   $0x804e7e0
 80492ed:	ff d2                	call   *%edx
 80492ef:	83 c4 10             	add    $0x10,%esp
 80492f2:	c9                   	leave  
 80492f3:	c3                   	ret    
 80492f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 80492f8:	c3                   	ret    
 80492f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

08049300 <__do_global_dtors_aux>:
 8049300:	f3 0f 1e fb          	endbr32 
 8049304:	80 3d 08 e8 04 08 00 	cmpb   $0x0,0x804e808
 804930b:	75 1b                	jne    8049328 <__do_global_dtors_aux+0x28>
 804930d:	55                   	push   %ebp
 804930e:	89 e5                	mov    %esp,%ebp
 8049310:	83 ec 08             	sub    $0x8,%esp
 8049313:	e8 68 ff ff ff       	call   8049280 <deregister_tm_clones>
 8049318:	c6 05 08 e8 04 08 01 	movb   $0x1,0x804e808
 804931f:	c9                   	leave  
 8049320:	c3                   	ret    
 8049321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8049328:	c3                   	ret    
 8049329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

08049330 <frame_dummy>:
 8049330:	f3 0f 1e fb          	endbr32 
 8049334:	eb 8a                	jmp    80492c0 <register_tm_clones>

08049336 <main>:
 8049336:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 804933a:	83 e4 f0             	and    $0xfffffff0,%esp
 804933d:	ff 71 fc             	pushl  -0x4(%ecx)
 8049340:	55                   	push   %ebp
 8049341:	89 e5                	mov    %esp,%ebp
 8049343:	53                   	push   %ebx
 8049344:	51                   	push   %ecx
 8049345:	8b 01                	mov    (%ecx),%eax
 8049347:	8b 59 04             	mov    0x4(%ecx),%ebx
 804934a:	83 f8 01             	cmp    $0x1,%eax
 804934d:	0f 84 67 01 00 00    	je     80494ba <main+0x184>
 8049353:	83 f8 02             	cmp    $0x2,%eax
 8049356:	0f 85 8b 01 00 00    	jne    80494e7 <main+0x1b1>
 804935c:	83 ec 08             	sub    $0x8,%esp
 804935f:	68 0c b0 04 08       	push   $0x804b00c
 8049364:	ff 73 04             	pushl  0x4(%ebx)
 8049367:	e8 24 fe ff ff       	call   8049190 <fopen@plt>
 804936c:	a3 0c e8 04 08       	mov    %eax,0x804e80c
 8049371:	83 c4 10             	add    $0x10,%esp
 8049374:	85 c0                	test   %eax,%eax
 8049376:	0f 84 4d 01 00 00    	je     80494c9 <main+0x193>
 804937c:	e8 e5 06 00 00       	call   8049a66 <initialize_bomb>
 8049381:	83 ec 0c             	sub    $0xc,%esp
 8049384:	68 9c b0 04 08       	push   $0x804b09c
 8049389:	e8 82 fd ff ff       	call   8049110 <puts@plt>
 804938e:	c7 04 24 d8 b0 04 08 	movl   $0x804b0d8,(%esp)
 8049395:	e8 76 fd ff ff       	call   8049110 <puts@plt>
 804939a:	e8 08 09 00 00       	call   8049ca7 <read_line>
 804939f:	89 04 24             	mov    %eax,(%esp)
 80493a2:	e8 5b 01 00 00       	call   8049502 <phase_1>
 80493a7:	e8 f5 09 00 00       	call   8049da1 <phase_defused>
 80493ac:	c7 04 24 04 b1 04 08 	movl   $0x804b104,(%esp)
 80493b3:	e8 58 fd ff ff       	call   8049110 <puts@plt>
 80493b8:	e8 ea 08 00 00       	call   8049ca7 <read_line>
 80493bd:	89 04 24             	mov    %eax,(%esp)
 80493c0:	e8 7f 01 00 00       	call   8049544 <phase_2>
 80493c5:	e8 d7 09 00 00       	call   8049da1 <phase_defused>
 80493ca:	c7 04 24 45 b0 04 08 	movl   $0x804b045,(%esp)
 80493d1:	e8 3a fd ff ff       	call   8049110 <puts@plt>
 80493d6:	e8 cc 08 00 00       	call   8049ca7 <read_line>
 80493db:	89 04 24             	mov    %eax,(%esp)
 80493de:	e8 84 01 00 00       	call   8049567 <phase_3>
 80493e3:	e8 b9 09 00 00       	call   8049da1 <phase_defused>
 80493e8:	c7 04 24 63 b0 04 08 	movl   $0x804b063,(%esp)
 80493ef:	e8 1c fd ff ff       	call   8049110 <puts@plt>
 80493f4:	e8 ae 08 00 00       	call   8049ca7 <read_line>
 80493f9:	89 04 24             	mov    %eax,(%esp)
 80493fc:	e8 fe 01 00 00       	call   80495ff <phase_4>
 8049401:	e8 9b 09 00 00       	call   8049da1 <phase_defused>
 8049406:	c7 04 24 30 b1 04 08 	movl   $0x804b130,(%esp)
 804940d:	e8 fe fc ff ff       	call   8049110 <puts@plt>
 8049412:	e8 90 08 00 00       	call   8049ca7 <read_line>
 8049417:	89 04 24             	mov    %eax,(%esp)
 804941a:	e8 31 02 00 00       	call   8049650 <phase_5>
 804941f:	e8 7d 09 00 00       	call   8049da1 <phase_defused>
 8049424:	c7 04 24 74 b0 04 08 	movl   $0x804b074,(%esp)
 804942b:	e8 e0 fc ff ff       	call   8049110 <puts@plt>
 8049430:	e8 72 08 00 00       	call   8049ca7 <read_line>
 8049435:	89 04 24             	mov    %eax,(%esp)
 8049438:	e8 27 03 00 00       	call   8049764 <phase_6>
 804943d:	e8 5f 09 00 00       	call   8049da1 <phase_defused>
 8049442:	c7 04 24 54 b1 04 08 	movl   $0x804b154,(%esp)
 8049449:	e8 c2 fc ff ff       	call   8049110 <puts@plt>
 804944e:	e8 54 08 00 00       	call   8049ca7 <read_line>
 8049453:	89 04 24             	mov    %eax,(%esp)
 8049456:	e8 60 03 00 00       	call   80497bb <phase_7>
 804945b:	e8 41 09 00 00       	call   8049da1 <phase_defused>
 8049460:	c7 04 24 74 b1 04 08 	movl   $0x804b174,(%esp)
 8049467:	e8 a4 fc ff ff       	call   8049110 <puts@plt>
 804946c:	e8 36 08 00 00       	call   8049ca7 <read_line>
 8049471:	89 04 24             	mov    %eax,(%esp)
 8049474:	e8 8e 03 00 00       	call   8049807 <phase_8>
 8049479:	e8 23 09 00 00       	call   8049da1 <phase_defused>
 804947e:	c7 04 24 92 b0 04 08 	movl   $0x804b092,(%esp)
 8049485:	e8 86 fc ff ff       	call   8049110 <puts@plt>
 804948a:	e8 18 08 00 00       	call   8049ca7 <read_line>
 804948f:	89 04 24             	mov    %eax,(%esp)
 8049492:	e8 9c 04 00 00       	call   8049933 <phase_9>
 8049497:	e8 05 09 00 00       	call   8049da1 <phase_defused>
 804949c:	c7 04 24 94 b1 04 08 	movl   $0x804b194,(%esp)
 80494a3:	e8 68 fc ff ff       	call   8049110 <puts@plt>
 80494a8:	83 c4 10             	add    $0x10,%esp
 80494ab:	b8 00 00 00 00       	mov    $0x0,%eax
 80494b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 80494b3:	59                   	pop    %ecx
 80494b4:	5b                   	pop    %ebx
 80494b5:	5d                   	pop    %ebp
 80494b6:	8d 61 fc             	lea    -0x4(%ecx),%esp
 80494b9:	c3                   	ret    
 80494ba:	a1 00 e8 04 08       	mov    0x804e800,%eax
 80494bf:	a3 0c e8 04 08       	mov    %eax,0x804e80c
 80494c4:	e9 b3 fe ff ff       	jmp    804937c <main+0x46>
 80494c9:	83 ec 04             	sub    $0x4,%esp
 80494cc:	ff 73 04             	pushl  0x4(%ebx)
 80494cf:	ff 33                	pushl  (%ebx)
 80494d1:	68 0e b0 04 08       	push   $0x804b00e
 80494d6:	e8 85 fb ff ff       	call   8049060 <printf@plt>
 80494db:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 80494e2:	e8 39 fc ff ff       	call   8049120 <exit@plt>
 80494e7:	83 ec 08             	sub    $0x8,%esp
 80494ea:	ff 33                	pushl  (%ebx)
 80494ec:	68 2b b0 04 08       	push   $0x804b02b
 80494f1:	e8 6a fb ff ff       	call   8049060 <printf@plt>
 80494f6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 80494fd:	e8 1e fc ff ff       	call   8049120 <exit@plt>

08049502 <phase_1>: name of function
address		instruction hex code    instruction
 8049502:	83 ec 20             	sub    $0x20,%esp
 8049505:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 804950c:	00 
 804950d:	8d 44 24 10          	lea    0x10(%esp),%eax
 8049511:	50                   	push   %eax
 8049512:	68 40 b4 04 08       	push   $0x804b440
 8049517:	ff 74 24 2c          	pushl  0x2c(%esp)
 804951b:	e8 60 fc ff ff       	call   8049180 <__isoc99_sscanf@plt>
 8049520:	83 c4 10             	add    $0x10,%esp
 8049523:	83 f8 01             	cmp    $0x1,%eax
 8049526:	75 0e                	jne    8049536 <phase_1+0x34>
 8049528:	81 7c 24 0c 5e 03 00 	cmpl   $0x35e,0xc(%esp)
 804952f:	00 
 8049530:	75 0b                	jne    804953d <phase_1+0x3b>
 8049532:	83 c4 1c             	add    $0x1c,%esp
 8049535:	c3                   	ret    
 8049536:	e8 f4 06 00 00       	call   8049c2f <explode_bomb>
 804953b:	eb eb                	jmp    8049528 <phase_1+0x26>
 804953d:	e8 ed 06 00 00       	call   8049c2f <explode_bomb>
 8049542:	eb ee                	jmp    8049532 <phase_1+0x30>

08049544 <phase_2>:
 8049544:	83 ec 14             	sub    $0x14,%esp
 8049547:	68 ba b1 04 08       	push   $0x804b1ba
 804954c:	ff 74 24 1c          	pushl  0x1c(%esp)
 8049550:	e8 b9 04 00 00       	call   8049a0e <strings_not_equal>
 8049555:	83 c4 10             	add    $0x10,%esp
 8049558:	85 c0                	test   %eax,%eax
 804955a:	75 04                	jne    8049560 <phase_2+0x1c>
 804955c:	83 c4 0c             	add    $0xc,%esp
 804955f:	c3                   	ret    
 8049560:	e8 ca 06 00 00       	call   8049c2f <explode_bomb>
 8049565:	eb f5                	jmp    804955c <phase_2+0x18>

08049567 <phase_3>:
 8049567:	83 ec 18             	sub    $0x18,%esp
 804956a:	68 d8 b1 04 08       	push   $0x804b1d8
 804956f:	e8 7c 04 00 00       	call   80499f0 <string_length>
 8049574:	83 c0 01             	add    $0x1,%eax
 8049577:	89 04 24             	mov    %eax,(%esp)
 804957a:	e8 81 fb ff ff       	call   8049100 <malloc@plt>
 804957f:	c7 00 57 68 79 20    	movl   $0x20796857,(%eax)
 8049585:	c7 40 04 6d 61 6b 65 	movl   $0x656b616d,0x4(%eax)
 804958c:	c7 40 08 20 74 72 69 	movl   $0x69727420,0x8(%eax)
 8049593:	c7 40 0c 6c 6c 69 6f 	movl   $0x6f696c6c,0xc(%eax)
 804959a:	c7 40 10 6e 73 20 77 	movl   $0x7720736e,0x10(%eax)
 80495a1:	c7 40 14 68 65 6e 20 	movl   $0x206e6568,0x14(%eax)
 80495a8:	c7 40 18 77 65 20 63 	movl   $0x63206577,0x18(%eax)
 80495af:	c7 40 1c 6f 75 6c 64 	movl   $0x646c756f,0x1c(%eax)
 80495b6:	c7 40 20 20 6d 61 6b 	movl   $0x6b616d20,0x20(%eax)
 80495bd:	c7 40 24 65 2e 2e 2e 	movl   $0x2e2e2e65,0x24(%eax)
 80495c4:	c7 40 28 20 62 69 6c 	movl   $0x6c696220,0x28(%eax)
 80495cb:	c7 40 2c 6c 69 6f 6e 	movl   $0x6e6f696c,0x2c(%eax)
 80495d2:	66 c7 40 30 73 3f    	movw   $0x3f73,0x30(%eax)
 80495d8:	c6 40 32 00          	movb   $0x0,0x32(%eax)
 80495dc:	c6 40 13 61          	movb   $0x61,0x13(%eax)
 80495e0:	83 c4 08             	add    $0x8,%esp
 80495e3:	50                   	push   %eax
 80495e4:	ff 74 24 1c          	pushl  0x1c(%esp)
 80495e8:	e8 21 04 00 00       	call   8049a0e <strings_not_equal>
 80495ed:	83 c4 10             	add    $0x10,%esp
 80495f0:	85 c0                	test   %eax,%eax
 80495f2:	75 04                	jne    80495f8 <phase_3+0x91>
 80495f4:	83 c4 0c             	add    $0xc,%esp
 80495f7:	c3                   	ret    
 80495f8:	e8 32 06 00 00       	call   8049c2f <explode_bomb>
 80495fd:	eb f5                	jmp    80495f4 <phase_3+0x8d>

080495ff <phase_4>:
 80495ff:	56                   	push   %esi
 8049600:	53                   	push   %ebx
 8049601:	83 ec 2c             	sub    $0x2c,%esp
 8049604:	8d 44 24 10          	lea    0x10(%esp),%eax
 8049608:	50                   	push   %eax
 8049609:	ff 74 24 3c          	pushl  0x3c(%esp)
 804960d:	e8 5a 06 00 00       	call   8049c6c <read_six_numbers>
 8049612:	83 c4 10             	add    $0x10,%esp
 8049615:	83 7c 24 08 05       	cmpl   $0x5,0x8(%esp)
 804961a:	75 07                	jne    8049623 <phase_4+0x24>
 804961c:	83 7c 24 0c 08       	cmpl   $0x8,0xc(%esp)
 8049621:	74 05                	je     8049628 <phase_4+0x29>
 8049623:	e8 07 06 00 00       	call   8049c2f <explode_bomb>
 8049628:	8d 5c 24 08          	lea    0x8(%esp),%ebx
 804962c:	8d 74 24 18          	lea    0x18(%esp),%esi
 8049630:	eb 07                	jmp    8049639 <phase_4+0x3a>
 8049632:	83 c3 04             	add    $0x4,%ebx
 8049635:	39 f3                	cmp    %esi,%ebx
 8049637:	74 11                	je     804964a <phase_4+0x4b>
 8049639:	8b 43 04             	mov    0x4(%ebx),%eax
 804963c:	03 03                	add    (%ebx),%eax
 804963e:	39 43 08             	cmp    %eax,0x8(%ebx)
 8049641:	74 ef                	je     8049632 <phase_4+0x33>
 8049643:	e8 e7 05 00 00       	call   8049c2f <explode_bomb>
 8049648:	eb e8                	jmp    8049632 <phase_4+0x33>
 804964a:	83 c4 24             	add    $0x24,%esp
 804964d:	5b                   	pop    %ebx
 804964e:	5e                   	pop    %esi
 804964f:	c3                   	ret    

08049650 <phase_5>:
 8049650:	83 ec 1c             	sub    $0x1c,%esp
 8049653:	8d 44 24 08          	lea    0x8(%esp),%eax
 8049657:	50                   	push   %eax
 8049658:	8d 44 24 10          	lea    0x10(%esp),%eax
 804965c:	50                   	push   %eax
 804965d:	68 3d b4 04 08       	push   $0x804b43d
 8049662:	ff 74 24 2c          	pushl  0x2c(%esp)
 8049666:	e8 15 fb ff ff       	call   8049180 <__isoc99_sscanf@plt>
 804966b:	83 c4 10             	add    $0x10,%esp
 804966e:	83 f8 01             	cmp    $0x1,%eax
 8049671:	7e 16                	jle    8049689 <phase_5+0x39>
 8049673:	83 7c 24 0c 07       	cmpl   $0x7,0xc(%esp)
 8049678:	0f 87 81 00 00 00    	ja     80496ff <phase_5+0xaf>
 804967e:	8b 44 24 0c          	mov    0xc(%esp),%eax
 8049682:	ff 24 85 20 b2 04 08 	jmp    *0x804b220(,%eax,4)
 8049689:	e8 a1 05 00 00       	call   8049c2f <explode_bomb>
 804968e:	eb e3                	jmp    8049673 <phase_5+0x23>
 8049690:	b8 ec 01 00 00       	mov    $0x1ec,%eax
 8049695:	2d e8 00 00 00       	sub    $0xe8,%eax
 804969a:	05 e5 01 00 00       	add    $0x1e5,%eax
 804969f:	2d 93 03 00 00       	sub    $0x393,%eax
 80496a4:	05 93 03 00 00       	add    $0x393,%eax
 80496a9:	2d 93 03 00 00       	sub    $0x393,%eax
 80496ae:	05 93 03 00 00       	add    $0x393,%eax
 80496b3:	2d 93 03 00 00       	sub    $0x393,%eax
 80496b8:	83 7c 24 0c 05       	cmpl   $0x5,0xc(%esp)
 80496bd:	7f 06                	jg     80496c5 <phase_5+0x75>
 80496bf:	39 44 24 08          	cmp    %eax,0x8(%esp)
 80496c3:	74 05                	je     80496ca <phase_5+0x7a>
 80496c5:	e8 65 05 00 00       	call   8049c2f <explode_bomb>
 80496ca:	83 c4 1c             	add    $0x1c,%esp
 80496cd:	c3                   	ret    
 80496ce:	b8 00 00 00 00       	mov    $0x0,%eax
 80496d3:	eb c0                	jmp    8049695 <phase_5+0x45>
 80496d5:	b8 00 00 00 00       	mov    $0x0,%eax
 80496da:	eb be                	jmp    804969a <phase_5+0x4a>
 80496dc:	b8 00 00 00 00       	mov    $0x0,%eax
 80496e1:	eb bc                	jmp    804969f <phase_5+0x4f>
 80496e3:	b8 00 00 00 00       	mov    $0x0,%eax
 80496e8:	eb ba                	jmp    80496a4 <phase_5+0x54>
 80496ea:	b8 00 00 00 00       	mov    $0x0,%eax
 80496ef:	eb b8                	jmp    80496a9 <phase_5+0x59>
 80496f1:	b8 00 00 00 00       	mov    $0x0,%eax
 80496f6:	eb b6                	jmp    80496ae <phase_5+0x5e>
 80496f8:	b8 00 00 00 00       	mov    $0x0,%eax
 80496fd:	eb b4                	jmp    80496b3 <phase_5+0x63>
 80496ff:	e8 2b 05 00 00       	call   8049c2f <explode_bomb>
 8049704:	b8 00 00 00 00       	mov    $0x0,%eax
 8049709:	eb ad                	jmp    80496b8 <phase_5+0x68>

0804970b <func6>:
 804970b:	53                   	push   %ebx
 804970c:	83 ec 08             	sub    $0x8,%esp
 804970f:	8b 44 24 10          	mov    0x10(%esp),%eax
 8049713:	8b 4c 24 18          	mov    0x18(%esp),%ecx
 8049717:	89 ca                	mov    %ecx,%edx
 8049719:	2b 54 24 14          	sub    0x14(%esp),%edx
 804971d:	89 d3                	mov    %edx,%ebx
 804971f:	c1 eb 1f             	shr    $0x1f,%ebx
 8049722:	01 d3                	add    %edx,%ebx
 8049724:	d1 fb                	sar    %ebx
 8049726:	03 5c 24 14          	add    0x14(%esp),%ebx
 804972a:	39 c3                	cmp    %eax,%ebx
 804972c:	7f 09                	jg     8049737 <func6+0x2c>
 804972e:	7c 1f                	jl     804974f <func6+0x44>
 8049730:	89 d8                	mov    %ebx,%eax
 8049732:	83 c4 08             	add    $0x8,%esp
 8049735:	5b                   	pop    %ebx
 8049736:	c3                   	ret    
 8049737:	83 ec 04             	sub    $0x4,%esp
 804973a:	8d 53 ff             	lea    -0x1(%ebx),%edx
 804973d:	52                   	push   %edx
 804973e:	ff 74 24 1c          	pushl  0x1c(%esp)
 8049742:	50                   	push   %eax
 8049743:	e8 c3 ff ff ff       	call   804970b <func6>
 8049748:	83 c4 10             	add    $0x10,%esp
 804974b:	01 c3                	add    %eax,%ebx
 804974d:	eb e1                	jmp    8049730 <func6+0x25>
 804974f:	83 ec 04             	sub    $0x4,%esp
 8049752:	51                   	push   %ecx
 8049753:	8d 53 01             	lea    0x1(%ebx),%edx
 8049756:	52                   	push   %edx
 8049757:	50                   	push   %eax
 8049758:	e8 ae ff ff ff       	call   804970b <func6>
 804975d:	83 c4 10             	add    $0x10,%esp
 8049760:	01 c3                	add    %eax,%ebx
 8049762:	eb cc                	jmp    8049730 <func6+0x25>

08049764 <phase_6>:
 8049764:	83 ec 1c             	sub    $0x1c,%esp
 8049767:	8d 44 24 08          	lea    0x8(%esp),%eax
 804976b:	50                   	push   %eax
 804976c:	8d 44 24 10          	lea    0x10(%esp),%eax
 8049770:	50                   	push   %eax
 8049771:	68 3d b4 04 08       	push   $0x804b43d
 8049776:	ff 74 24 2c          	pushl  0x2c(%esp)
 804977a:	e8 01 fa ff ff       	call   8049180 <__isoc99_sscanf@plt>
 804977f:	83 c4 10             	add    $0x10,%esp
 8049782:	83 f8 02             	cmp    $0x2,%eax
 8049785:	75 07                	jne    804978e <phase_6+0x2a>
 8049787:	83 7c 24 0c 0e       	cmpl   $0xe,0xc(%esp)
 804978c:	76 05                	jbe    8049793 <phase_6+0x2f>
 804978e:	e8 9c 04 00 00       	call   8049c2f <explode_bomb>
 8049793:	83 ec 04             	sub    $0x4,%esp
 8049796:	6a 0e                	push   $0xe
 8049798:	6a 00                	push   $0x0
 804979a:	ff 74 24 18          	pushl  0x18(%esp)
 804979e:	e8 68 ff ff ff       	call   804970b <func6>
 80497a3:	83 c4 10             	add    $0x10,%esp
 80497a6:	83 f8 13             	cmp    $0x13,%eax
 80497a9:	75 07                	jne    80497b2 <phase_6+0x4e>
 80497ab:	83 7c 24 08 13       	cmpl   $0x13,0x8(%esp)
 80497b0:	74 05                	je     80497b7 <phase_6+0x53>
 80497b2:	e8 78 04 00 00       	call   8049c2f <explode_bomb>
 80497b7:	83 c4 1c             	add    $0x1c,%esp
 80497ba:	c3                   	ret    

080497bb <phase_7>:
 80497bb:	53                   	push   %ebx
 80497bc:	83 ec 14             	sub    $0x14,%esp
 80497bf:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 80497c3:	53                   	push   %ebx
 80497c4:	e8 27 02 00 00       	call   80499f0 <string_length>
 80497c9:	83 c4 10             	add    $0x10,%esp
 80497cc:	83 f8 06             	cmp    $0x6,%eax
 80497cf:	75 28                	jne    80497f9 <phase_7+0x3e>
 80497d1:	89 d8                	mov    %ebx,%eax
 80497d3:	83 c3 06             	add    $0x6,%ebx
 80497d6:	b9 00 00 00 00       	mov    $0x0,%ecx
 80497db:	0f b6 10             	movzbl (%eax),%edx
 80497de:	83 e2 0f             	and    $0xf,%edx
 80497e1:	03 0c 95 40 b2 04 08 	add    0x804b240(,%edx,4),%ecx
 80497e8:	83 c0 01             	add    $0x1,%eax
 80497eb:	39 d8                	cmp    %ebx,%eax
 80497ed:	75 ec                	jne    80497db <phase_7+0x20>
 80497ef:	83 f9 30             	cmp    $0x30,%ecx
 80497f2:	75 0c                	jne    8049800 <phase_7+0x45>
 80497f4:	83 c4 08             	add    $0x8,%esp
 80497f7:	5b                   	pop    %ebx
 80497f8:	c3                   	ret    
 80497f9:	e8 31 04 00 00       	call   8049c2f <explode_bomb>
 80497fe:	eb d1                	jmp    80497d1 <phase_7+0x16>
 8049800:	e8 2a 04 00 00       	call   8049c2f <explode_bomb>
 8049805:	eb ed                	jmp    80497f4 <phase_7+0x39>

08049807 <phase_8>:
 8049807:	55                   	push   %ebp
 8049808:	57                   	push   %edi
 8049809:	56                   	push   %esi
 804980a:	53                   	push   %ebx
 804980b:	83 ec 44             	sub    $0x44,%esp
 804980e:	8d 7c 24 20          	lea    0x20(%esp),%edi
 8049812:	57                   	push   %edi
 8049813:	ff 74 24 5c          	pushl  0x5c(%esp)
 8049817:	e8 50 04 00 00       	call   8049c6c <read_six_numbers>
 804981c:	83 c4 10             	add    $0x10,%esp
 804981f:	bd 00 00 00 00       	mov    $0x0,%ebp
 8049824:	eb 21                	jmp    8049847 <phase_8+0x40>
 8049826:	e8 04 04 00 00       	call   8049c2f <explode_bomb>
 804982b:	eb 26                	jmp    8049853 <phase_8+0x4c>
 804982d:	83 c3 01             	add    $0x1,%ebx
 8049830:	83 fb 06             	cmp    $0x6,%ebx
 8049833:	74 0f                	je     8049844 <phase_8+0x3d>


 8049835:	8b 44 9c 18          	mov    0x18(%esp,%ebx,4),%eax
 8049839:	39 06                	cmp    %eax,(%esi)
 804983b:	75 f0                	jne    804982d <phase_8+0x26>


 804983d:	e8 ed 03 00 00       	call   8049c2f <explode_bomb>
 8049842:	eb e9                	jmp    804982d <phase_8+0x26>


 8049844:	83 c7 04             	add    $0x4,%edi
 8049847:	89 fe                	mov    %edi,%esi
 8049849:	8b 07                	mov    (%edi),%eax
 804984b:	83 e8 01             	sub    $0x1,%eax
 804984e:	83 f8 05             	cmp    $0x5,%eax
 8049851:	77 d3                	ja     8049826 <phase_8+0x1f>
 8049853:	83 c5 01             	add    $0x1,%ebp
 8049856:	83 fd 05             	cmp    $0x5,%ebp
 8049859:	7f 04                	jg     804985f <phase_8+0x58>
 

 804985b:	89 eb                	mov    %ebp,%ebx
 804985d:	eb d6                	jmp    8049835 <phase_8+0x2e>


 804985f:	bb 00 00 00 00       	mov    $0x0,%ebx
 8049864:	89 de                	mov    %ebx,%esi
 8049866:	8b 4c 9c 18          	mov    0x18(%esp,%ebx,4),%ecx
 804986a:	b8 01 00 00 00       	mov    $0x1,%eax
 804986f:	ba 74 e1 04 08       	mov    $0x804e174,%edx
 8049874:	83 f9 01             	cmp    $0x1,%ecx
 8049877:	7e 0a                	jle    8049883 <phase_8+0x7c>
 8049879:	8b 52 08             	mov    0x8(%edx),%edx
 804987c:	83 c0 01             	add    $0x1,%eax
 804987f:	39 c8                	cmp    %ecx,%eax
 8049881:	75 f6                	jne    8049879 <phase_8+0x72>
 8049883:	89 14 b4             	mov    %edx,(%esp,%esi,4)
 8049886:	83 c3 01             	add    $0x1,%ebx
 8049889:	83 fb 06             	cmp    $0x6,%ebx
 804988c:	75 d6                	jne    8049864 <phase_8+0x5d>
 // just ignore this! you're trying to assign some order to these numbers.
 804988e:	8b 1c 24             	mov    (%esp),%ebx
 8049891:	8b 44 24 04          	mov    0x4(%esp),%eax
 8049895:	89 43 08             	mov    %eax,0x8(%ebx)
 8049898:	8b 54 24 08          	mov    0x8(%esp),%edx
 804989c:	89 50 08             	mov    %edx,0x8(%eax)
 804989f:	8b 44 24 0c          	mov    0xc(%esp),%eax
 80498a3:	89 42 08             	mov    %eax,0x8(%edx)
 80498a6:	8b 54 24 10          	mov    0x10(%esp),%edx
 80498aa:	89 50 08             	mov    %edx,0x8(%eax)
 80498ad:	8b 44 24 14          	mov    0x14(%esp),%eax
 80498b1:	89 42 08             	mov    %eax,0x8(%edx)
 80498b4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
 80498bb:	be 05 00 00 00       	mov    $0x5,%esi
 80498c0:	eb 08                	jmp    80498ca <phase_8+0xc3>

 // look at what this is doing
 80498c2:	8b 5b 08             	mov    0x8(%ebx),%ebx
 80498c5:	83 ee 01             	sub    $0x1,%esi

 // ending jump
 80498c8:	74 10                	je     80498da <phase_8+0xd3>
 80498ca:	8b 43 08             	mov    0x8(%ebx),%eax
 80498cd:	8b 00                	mov    (%eax),%eax
  // look at this
 80498cf:	39 03                	cmp    %eax,(%ebx)
 80498d1:	7e ef                	jle    80498c2 <phase_8+0xbb>
 80498d3:	e8 57 03 00 00       	call   8049c2f <explode_bomb>
 80498d8:	eb e8                	jmp    80498c2 <phase_8+0xbb>
 80498da:	83 c4 3c             	add    $0x3c,%esp
 80498dd:	5b                   	pop    %ebx
 80498de:	5e                   	pop    %esi
 80498df:	5f                   	pop    %edi
 80498e0:	5d                   	pop    %ebp
 80498e1:	c3                   	ret    

080498e2 <fun9>:
 80498e2:	53                   	push   %ebx
 80498e3:	83 ec 08             	sub    $0x8,%esp
 80498e6:	8b 54 24 10          	mov    0x10(%esp),%edx
 80498ea:	8b 4c 24 14          	mov    0x14(%esp),%ecx
 80498ee:	85 d2                	test   %edx,%edx
 80498f0:	74 3a                	je     804992c <fun9+0x4a>
 80498f2:	8b 1a                	mov    (%edx),%ebx
 80498f4:	39 cb                	cmp    %ecx,%ebx
 80498f6:	7f 0c                	jg     8049904 <fun9+0x22>
 80498f8:	b8 00 00 00 00       	mov    $0x0,%eax
 80498fd:	75 18                	jne    8049917 <fun9+0x35>
 80498ff:	83 c4 08             	add    $0x8,%esp
 8049902:	5b                   	pop    %ebx
 8049903:	c3                   	ret    
 8049904:	83 ec 08             	sub    $0x8,%esp
 8049907:	51                   	push   %ecx
 8049908:	ff 72 04             	pushl  0x4(%edx)
 804990b:	e8 d2 ff ff ff       	call   80498e2 <fun9>
 8049910:	83 c4 10             	add    $0x10,%esp
 8049913:	01 c0                	add    %eax,%eax
 8049915:	eb e8                	jmp    80498ff <fun9+0x1d>
 8049917:	83 ec 08             	sub    $0x8,%esp
 804991a:	51                   	push   %ecx
 804991b:	ff 72 08             	pushl  0x8(%edx)
 804991e:	e8 bf ff ff ff       	call   80498e2 <fun9>
 8049923:	83 c4 10             	add    $0x10,%esp
 8049926:	8d 44 00 01          	lea    0x1(%eax,%eax,1),%eax
 804992a:	eb d3                	jmp    80498ff <fun9+0x1d>
 804992c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 8049931:	eb cc                	jmp    80498ff <fun9+0x1d>

08049933 <phase_9>:
 8049933:	53                   	push   %ebx
 8049934:	83 ec 0c             	sub    $0xc,%esp
 8049937:	6a 0a                	push   $0xa
 8049939:	6a 00                	push   $0x0
 804993b:	ff 74 24 1c          	pushl  0x1c(%esp)
 804993f:	e8 9c f8 ff ff       	call   80491e0 <strtol@plt>
 8049944:	89 c3                	mov    %eax,%ebx
 8049946:	8d 40 ff             	lea    -0x1(%eax),%eax
 8049949:	83 c4 10             	add    $0x10,%esp
 804994c:	3d ec 03 00 00       	cmp    $0x3ec,%eax
 8049951:	77 1b                	ja     804996e <phase_9+0x3b>
 8049953:	83 ec 08             	sub    $0x8,%esp
 8049956:	53                   	push   %ebx
 8049957:	68 c0 e0 04 08       	push   $0x804e0c0
 804995c:	e8 81 ff ff ff       	call   80498e2 <fun9>
 8049961:	83 c4 10             	add    $0x10,%esp
 8049964:	83 f8 07             	cmp    $0x7,%eax
 8049967:	75 0c                	jne    8049975 <phase_9+0x42>
 8049969:	83 c4 08             	add    $0x8,%esp
 804996c:	5b                   	pop    %ebx
 804996d:	c3                   	ret    
 804996e:	e8 bc 02 00 00       	call   8049c2f <explode_bomb>
 8049973:	eb de                	jmp    8049953 <phase_9+0x20>
 8049975:	e8 b5 02 00 00       	call   8049c2f <explode_bomb>
 804997a:	eb ed                	jmp    8049969 <phase_9+0x36>

0804997c <sig_handler>:
 804997c:	83 ec 18             	sub    $0x18,%esp
 804997f:	68 80 b2 04 08       	push   $0x804b280
 8049984:	e8 87 f7 ff ff       	call   8049110 <puts@plt>
 8049989:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 8049990:	e8 1b f7 ff ff       	call   80490b0 <sleep@plt>
 8049995:	c7 04 24 b9 b3 04 08 	movl   $0x804b3b9,(%esp)
 804999c:	e8 bf f6 ff ff       	call   8049060 <printf@plt>
 80499a1:	83 c4 04             	add    $0x4,%esp
 80499a4:	ff 35 04 e8 04 08    	pushl  0x804e804
 80499aa:	e8 c1 f6 ff ff       	call   8049070 <fflush@plt>
 80499af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 80499b6:	e8 f5 f6 ff ff       	call   80490b0 <sleep@plt>
 80499bb:	c7 04 24 c1 b3 04 08 	movl   $0x804b3c1,(%esp)
 80499c2:	e8 49 f7 ff ff       	call   8049110 <puts@plt>
 80499c7:	c7 04 24 10 00 00 00 	movl   $0x10,(%esp)
 80499ce:	e8 4d f7 ff ff       	call   8049120 <exit@plt>

080499d3 <invalid_phase>:
 80499d3:	83 ec 14             	sub    $0x14,%esp
 80499d6:	ff 74 24 18          	pushl  0x18(%esp)
 80499da:	68 c9 b3 04 08       	push   $0x804b3c9
 80499df:	e8 7c f6 ff ff       	call   8049060 <printf@plt>
 80499e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 80499eb:	e8 30 f7 ff ff       	call   8049120 <exit@plt>

080499f0 <string_length>:
 80499f0:	8b 54 24 04          	mov    0x4(%esp),%edx
 80499f4:	80 3a 00             	cmpb   $0x0,(%edx)
 80499f7:	74 0f                	je     8049a08 <string_length+0x18>
 80499f9:	b8 00 00 00 00       	mov    $0x0,%eax
 80499fe:	83 c0 01             	add    $0x1,%eax
 8049a01:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 8049a05:	75 f7                	jne    80499fe <string_length+0xe>
 8049a07:	c3                   	ret    
 8049a08:	b8 00 00 00 00       	mov    $0x0,%eax
 8049a0d:	c3                   	ret    

08049a0e <strings_not_equal>:
 8049a0e:	57                   	push   %edi
 8049a0f:	56                   	push   %esi
 8049a10:	53                   	push   %ebx
 8049a11:	8b 5c 24 10          	mov    0x10(%esp),%ebx
 8049a15:	8b 74 24 14          	mov    0x14(%esp),%esi
 8049a19:	53                   	push   %ebx
 8049a1a:	e8 d1 ff ff ff       	call   80499f0 <string_length>
 8049a1f:	89 c7                	mov    %eax,%edi
 8049a21:	89 34 24             	mov    %esi,(%esp)
 8049a24:	e8 c7 ff ff ff       	call   80499f0 <string_length>
 8049a29:	83 c4 04             	add    $0x4,%esp
 8049a2c:	89 c2                	mov    %eax,%edx
 8049a2e:	b8 01 00 00 00       	mov    $0x1,%eax
 8049a33:	39 d7                	cmp    %edx,%edi
 8049a35:	75 2b                	jne    8049a62 <strings_not_equal+0x54>
 8049a37:	0f b6 03             	movzbl (%ebx),%eax
 8049a3a:	84 c0                	test   %al,%al
 8049a3c:	74 18                	je     8049a56 <strings_not_equal+0x48>
 8049a3e:	38 06                	cmp    %al,(%esi)
 8049a40:	75 1b                	jne    8049a5d <strings_not_equal+0x4f>
 8049a42:	83 c3 01             	add    $0x1,%ebx
 8049a45:	83 c6 01             	add    $0x1,%esi
 8049a48:	0f b6 03             	movzbl (%ebx),%eax
 8049a4b:	84 c0                	test   %al,%al
 8049a4d:	75 ef                	jne    8049a3e <strings_not_equal+0x30>
 8049a4f:	b8 00 00 00 00       	mov    $0x0,%eax
 8049a54:	eb 0c                	jmp    8049a62 <strings_not_equal+0x54>
 8049a56:	b8 00 00 00 00       	mov    $0x0,%eax
 8049a5b:	eb 05                	jmp    8049a62 <strings_not_equal+0x54>
 8049a5d:	b8 01 00 00 00       	mov    $0x1,%eax
 8049a62:	5b                   	pop    %ebx
 8049a63:	5e                   	pop    %esi
 8049a64:	5f                   	pop    %edi
 8049a65:	c3                   	ret    

08049a66 <initialize_bomb>:
 8049a66:	56                   	push   %esi
 8049a67:	53                   	push   %ebx
 8049a68:	81 ec 4c 20 00 00    	sub    $0x204c,%esp
 8049a6e:	68 7c 99 04 08       	push   $0x804997c
 8049a73:	6a 02                	push   $0x2
 8049a75:	e8 26 f6 ff ff       	call   80490a0 <signal@plt>
 8049a7a:	83 c4 08             	add    $0x8,%esp
 8049a7d:	6a 40                	push   $0x40
 8049a7f:	8d 84 24 0c 20 00 00 	lea    0x200c(%esp),%eax
 8049a86:	50                   	push   %eax
 8049a87:	e8 54 f6 ff ff       	call   80490e0 <gethostname@plt>
 8049a8c:	83 c4 10             	add    $0x10,%esp
 8049a8f:	85 c0                	test   %eax,%eax
 8049a91:	75 4a                	jne    8049add <initialize_bomb+0x77>
 8049a93:	89 c3                	mov    %eax,%ebx
 8049a95:	a1 e0 e5 04 08       	mov    0x804e5e0,%eax
 8049a9a:	8d b4 24 00 20 00 00 	lea    0x2000(%esp),%esi
 8049aa1:	85 c0                	test   %eax,%eax
 8049aa3:	74 1f                	je     8049ac4 <initialize_bomb+0x5e>
 8049aa5:	83 ec 08             	sub    $0x8,%esp
 8049aa8:	56                   	push   %esi
 8049aa9:	50                   	push   %eax
 8049aaa:	e8 c1 f6 ff ff       	call   8049170 <strcasecmp@plt>
 8049aaf:	83 c4 10             	add    $0x10,%esp
 8049ab2:	85 c0                	test   %eax,%eax
 8049ab4:	74 5e                	je     8049b14 <initialize_bomb+0xae>
 8049ab6:	83 c3 01             	add    $0x1,%ebx
 8049ab9:	8b 04 9d e0 e5 04 08 	mov    0x804e5e0(,%ebx,4),%eax
 8049ac0:	85 c0                	test   %eax,%eax
 8049ac2:	75 e1                	jne    8049aa5 <initialize_bomb+0x3f>
 8049ac4:	83 ec 0c             	sub    $0xc,%esp
 8049ac7:	68 f0 b2 04 08       	push   $0x804b2f0
 8049acc:	e8 3f f6 ff ff       	call   8049110 <puts@plt>
 8049ad1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8049ad8:	e8 43 f6 ff ff       	call   8049120 <exit@plt>
 8049add:	83 ec 0c             	sub    $0xc,%esp
 8049ae0:	68 b8 b2 04 08       	push   $0x804b2b8
 8049ae5:	e8 26 f6 ff ff       	call   8049110 <puts@plt>
 8049aea:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8049af1:	e8 2a f6 ff ff       	call   8049120 <exit@plt>
 8049af6:	83 ec 08             	sub    $0x8,%esp
 8049af9:	8d 44 24 08          	lea    0x8(%esp),%eax
 8049afd:	50                   	push   %eax
 8049afe:	68 da b3 04 08       	push   $0x804b3da
 8049b03:	e8 58 f5 ff ff       	call   8049060 <printf@plt>
 8049b08:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8049b0f:	e8 0c f6 ff ff       	call   8049120 <exit@plt>
 8049b14:	83 ec 0c             	sub    $0xc,%esp
 8049b17:	8d 44 24 0c          	lea    0xc(%esp),%eax
 8049b1b:	50                   	push   %eax
 8049b1c:	e8 57 0b 00 00       	call   804a678 <init_driver>
 8049b21:	83 c4 10             	add    $0x10,%esp
 8049b24:	85 c0                	test   %eax,%eax
 8049b26:	78 ce                	js     8049af6 <initialize_bomb+0x90>
 8049b28:	81 c4 44 20 00 00    	add    $0x2044,%esp
 8049b2e:	5b                   	pop    %ebx
 8049b2f:	5e                   	pop    %esi
 8049b30:	c3                   	ret    

08049b31 <initialize_bomb_solve>:
 8049b31:	c3                   	ret    

08049b32 <blank_line>:
 8049b32:	56                   	push   %esi
 8049b33:	53                   	push   %ebx
 8049b34:	83 ec 04             	sub    $0x4,%esp
 8049b37:	8b 74 24 10          	mov    0x10(%esp),%esi
 8049b3b:	0f b6 1e             	movzbl (%esi),%ebx
 8049b3e:	84 db                	test   %bl,%bl
 8049b40:	74 1b                	je     8049b5d <blank_line+0x2b>
 8049b42:	e8 c9 f6 ff ff       	call   8049210 <__ctype_b_loc@plt>
 8049b47:	83 c6 01             	add    $0x1,%esi
 8049b4a:	0f be db             	movsbl %bl,%ebx
 8049b4d:	8b 00                	mov    (%eax),%eax
 8049b4f:	f6 44 58 01 20       	testb  $0x20,0x1(%eax,%ebx,2)
 8049b54:	75 e5                	jne    8049b3b <blank_line+0x9>
 8049b56:	b8 00 00 00 00       	mov    $0x0,%eax
 8049b5b:	eb 05                	jmp    8049b62 <blank_line+0x30>
 8049b5d:	b8 01 00 00 00       	mov    $0x1,%eax
 8049b62:	83 c4 04             	add    $0x4,%esp
 8049b65:	5b                   	pop    %ebx
 8049b66:	5e                   	pop    %esi
 8049b67:	c3                   	ret    

08049b68 <skip>:
 8049b68:	53                   	push   %ebx
 8049b69:	83 ec 08             	sub    $0x8,%esp
 8049b6c:	83 ec 04             	sub    $0x4,%esp
 8049b6f:	ff 35 0c e8 04 08    	pushl  0x804e80c
 8049b75:	6a 50                	push   $0x50
 8049b77:	a1 70 e8 04 08       	mov    0x804e870,%eax
 8049b7c:	8d 04 80             	lea    (%eax,%eax,4),%eax
 8049b7f:	c1 e0 04             	shl    $0x4,%eax
 8049b82:	05 80 e8 04 08       	add    $0x804e880,%eax
 8049b87:	50                   	push   %eax
 8049b88:	e8 03 f5 ff ff       	call   8049090 <fgets@plt>
 8049b8d:	89 c3                	mov    %eax,%ebx
 8049b8f:	83 c4 10             	add    $0x10,%esp
 8049b92:	85 c0                	test   %eax,%eax
 8049b94:	74 10                	je     8049ba6 <skip+0x3e>
 8049b96:	83 ec 0c             	sub    $0xc,%esp
 8049b99:	50                   	push   %eax
 8049b9a:	e8 93 ff ff ff       	call   8049b32 <blank_line>
 8049b9f:	83 c4 10             	add    $0x10,%esp
 8049ba2:	85 c0                	test   %eax,%eax
 8049ba4:	75 c6                	jne    8049b6c <skip+0x4>
 8049ba6:	89 d8                	mov    %ebx,%eax
 8049ba8:	83 c4 08             	add    $0x8,%esp
 8049bab:	5b                   	pop    %ebx
 8049bac:	c3                   	ret    

08049bad <send_msg>:
 8049bad:	53                   	push   %ebx
 8049bae:	81 ec 10 40 00 00    	sub    $0x4010,%esp
 8049bb4:	8b 0d 70 e8 04 08    	mov    0x804e870,%ecx
 8049bba:	8d 44 89 fb          	lea    -0x5(%ecx,%ecx,4),%eax
 8049bbe:	c1 e0 04             	shl    $0x4,%eax
 8049bc1:	05 80 e8 04 08       	add    $0x804e880,%eax
 8049bc6:	83 bc 24 18 40 00 00 	cmpl   $0x0,0x4018(%esp)
 8049bcd:	00 
 8049bce:	ba f4 b3 04 08       	mov    $0x804b3f4,%edx
 8049bd3:	bb fc b3 04 08       	mov    $0x804b3fc,%ebx
 8049bd8:	0f 44 d3             	cmove  %ebx,%edx
 8049bdb:	50                   	push   %eax
 8049bdc:	51                   	push   %ecx
 8049bdd:	52                   	push   %edx
 8049bde:	ff 35 c0 e5 04 08    	pushl  0x804e5c0
 8049be4:	68 05 b4 04 08       	push   $0x804b405
 8049be9:	8d 9c 24 1c 20 00 00 	lea    0x201c(%esp),%ebx
 8049bf0:	53                   	push   %ebx
 8049bf1:	e8 ba f5 ff ff       	call   80491b0 <sprintf@plt>
 8049bf6:	83 c4 20             	add    $0x20,%esp
 8049bf9:	54                   	push   %esp
 8049bfa:	6a 00                	push   $0x0
 8049bfc:	53                   	push   %ebx
 8049bfd:	68 c0 e1 04 08       	push   $0x804e1c0
 8049c02:	e8 27 0c 00 00       	call   804a82e <driver_post>
 8049c07:	83 c4 10             	add    $0x10,%esp
 8049c0a:	85 c0                	test   %eax,%eax
 8049c0c:	78 08                	js     8049c16 <send_msg+0x69>
 8049c0e:	81 c4 08 40 00 00    	add    $0x4008,%esp
 8049c14:	5b                   	pop    %ebx
 8049c15:	c3                   	ret    
 8049c16:	83 ec 0c             	sub    $0xc,%esp
 8049c19:	8d 44 24 0c          	lea    0xc(%esp),%eax
 8049c1d:	50                   	push   %eax
 8049c1e:	e8 ed f4 ff ff       	call   8049110 <puts@plt>
 8049c23:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8049c2a:	e8 f1 f4 ff ff       	call   8049120 <exit@plt>

08049c2f <explode_bomb>:
 8049c2f:	83 ec 18             	sub    $0x18,%esp
 8049c32:	68 11 b4 04 08       	push   $0x804b411
 8049c37:	e8 d4 f4 ff ff       	call   8049110 <puts@plt>
 8049c3c:	c7 04 24 1a b4 04 08 	movl   $0x804b41a,(%esp)
 8049c43:	e8 c8 f4 ff ff       	call   8049110 <puts@plt>
 8049c48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8049c4f:	e8 59 ff ff ff       	call   8049bad <send_msg>
 8049c54:	c7 04 24 28 b3 04 08 	movl   $0x804b328,(%esp)
 8049c5b:	e8 b0 f4 ff ff       	call   8049110 <puts@plt>
 8049c60:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8049c67:	e8 b4 f4 ff ff       	call   8049120 <exit@plt>

08049c6c <read_six_numbers>:
 8049c6c:	83 ec 0c             	sub    $0xc,%esp
 8049c6f:	8b 44 24 14          	mov    0x14(%esp),%eax
 8049c73:	8d 50 14             	lea    0x14(%eax),%edx
 8049c76:	52                   	push   %edx
 8049c77:	8d 50 10             	lea    0x10(%eax),%edx
 8049c7a:	52                   	push   %edx
 8049c7b:	8d 50 0c             	lea    0xc(%eax),%edx
 8049c7e:	52                   	push   %edx
 8049c7f:	8d 50 08             	lea    0x8(%eax),%edx
 8049c82:	52                   	push   %edx
 8049c83:	8d 50 04             	lea    0x4(%eax),%edx
 8049c86:	52                   	push   %edx
 8049c87:	50                   	push   %eax
 8049c88:	68 31 b4 04 08       	push   $0x804b431
 8049c8d:	ff 74 24 2c          	pushl  0x2c(%esp)
 8049c91:	e8 ea f4 ff ff       	call   8049180 <__isoc99_sscanf@plt>
 8049c96:	83 c4 20             	add    $0x20,%esp
 8049c99:	83 f8 05             	cmp    $0x5,%eax
 8049c9c:	7e 04                	jle    8049ca2 <read_six_numbers+0x36>
 8049c9e:	83 c4 0c             	add    $0xc,%esp
 8049ca1:	c3                   	ret    
 8049ca2:	e8 88 ff ff ff       	call   8049c2f <explode_bomb>

08049ca7 <read_line>:
 8049ca7:	57                   	push   %edi
 8049ca8:	56                   	push   %esi
 8049ca9:	53                   	push   %ebx
 8049caa:	e8 b9 fe ff ff       	call   8049b68 <skip>
 8049caf:	85 c0                	test   %eax,%eax
 8049cb1:	74 44                	je     8049cf7 <read_line+0x50>
 8049cb3:	8b 1d 70 e8 04 08    	mov    0x804e870,%ebx
 8049cb9:	8d 34 9b             	lea    (%ebx,%ebx,4),%esi
 8049cbc:	c1 e6 04             	shl    $0x4,%esi
 8049cbf:	81 c6 80 e8 04 08    	add    $0x804e880,%esi
 8049cc5:	83 ec 0c             	sub    $0xc,%esp
 8049cc8:	56                   	push   %esi
 8049cc9:	e8 62 f4 ff ff       	call   8049130 <strlen@plt>
 8049cce:	83 c4 10             	add    $0x10,%esp
 8049cd1:	83 f8 4e             	cmp    $0x4e,%eax
 8049cd4:	0f 8f 91 00 00 00    	jg     8049d6b <read_line+0xc4>
 8049cda:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
 8049cdd:	c1 e2 04             	shl    $0x4,%edx
 8049ce0:	c6 84 10 7f e8 04 08 	movb   $0x0,0x804e87f(%eax,%edx,1)
 8049ce7:	00 
 8049ce8:	83 c3 01             	add    $0x1,%ebx
 8049ceb:	89 1d 70 e8 04 08    	mov    %ebx,0x804e870
 8049cf1:	89 f0                	mov    %esi,%eax
 8049cf3:	5b                   	pop    %ebx
 8049cf4:	5e                   	pop    %esi
 8049cf5:	5f                   	pop    %edi
 8049cf6:	c3                   	ret    
 8049cf7:	a1 00 e8 04 08       	mov    0x804e800,%eax
 8049cfc:	39 05 0c e8 04 08    	cmp    %eax,0x804e80c
 8049d02:	74 1e                	je     8049d22 <read_line+0x7b>
 8049d04:	83 ec 0c             	sub    $0xc,%esp
 8049d07:	68 61 b4 04 08       	push   $0x804b461
 8049d0c:	e8 df f3 ff ff       	call   80490f0 <getenv@plt>
 8049d11:	83 c4 10             	add    $0x10,%esp
 8049d14:	85 c0                	test   %eax,%eax
 8049d16:	74 23                	je     8049d3b <read_line+0x94>
 8049d18:	83 ec 0c             	sub    $0xc,%esp
 8049d1b:	6a 00                	push   $0x0
 8049d1d:	e8 fe f3 ff ff       	call   8049120 <exit@plt>
 8049d22:	83 ec 0c             	sub    $0xc,%esp
 8049d25:	68 43 b4 04 08       	push   $0x804b443
 8049d2a:	e8 e1 f3 ff ff       	call   8049110 <puts@plt>
 8049d2f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8049d36:	e8 e5 f3 ff ff       	call   8049120 <exit@plt>
 8049d3b:	a1 00 e8 04 08       	mov    0x804e800,%eax
 8049d40:	a3 0c e8 04 08       	mov    %eax,0x804e80c
 8049d45:	e8 1e fe ff ff       	call   8049b68 <skip>
 8049d4a:	85 c0                	test   %eax,%eax
 8049d4c:	0f 85 61 ff ff ff    	jne    8049cb3 <read_line+0xc>
 8049d52:	83 ec 0c             	sub    $0xc,%esp
 8049d55:	68 43 b4 04 08       	push   $0x804b443
 8049d5a:	e8 b1 f3 ff ff       	call   8049110 <puts@plt>
 8049d5f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8049d66:	e8 b5 f3 ff ff       	call   8049120 <exit@plt>
 8049d6b:	83 ec 0c             	sub    $0xc,%esp
 8049d6e:	68 6c b4 04 08       	push   $0x804b46c
 8049d73:	e8 98 f3 ff ff       	call   8049110 <puts@plt>
 8049d78:	a1 70 e8 04 08       	mov    0x804e870,%eax
 8049d7d:	8d 50 01             	lea    0x1(%eax),%edx
 8049d80:	89 15 70 e8 04 08    	mov    %edx,0x804e870
 8049d86:	6b c0 50             	imul   $0x50,%eax,%eax
 8049d89:	05 80 e8 04 08       	add    $0x804e880,%eax
 8049d8e:	be 87 b4 04 08       	mov    $0x804b487,%esi
 8049d93:	b9 04 00 00 00       	mov    $0x4,%ecx
 8049d98:	89 c7                	mov    %eax,%edi
 8049d9a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
 8049d9c:	e8 8e fe ff ff       	call   8049c2f <explode_bomb>

08049da1 <phase_defused>:
 8049da1:	83 ec 18             	sub    $0x18,%esp
 8049da4:	6a 01                	push   $0x1
 8049da6:	e8 02 fe ff ff       	call   8049bad <send_msg>
 8049dab:	83 c4 10             	add    $0x10,%esp
 8049dae:	83 3d 70 e8 04 08 0b 	cmpl   $0xb,0x804e870
 8049db5:	74 04                	je     8049dbb <phase_defused+0x1a>
 8049db7:	83 c4 0c             	add    $0xc,%esp
 8049dba:	c3                   	ret    
 8049dbb:	83 ec 0c             	sub    $0xc,%esp
 8049dbe:	68 4c b3 04 08       	push   $0x804b34c
 8049dc3:	e8 48 f3 ff ff       	call   8049110 <puts@plt>
 8049dc8:	c7 04 24 78 b3 04 08 	movl   $0x804b378,(%esp)
 8049dcf:	e8 3c f3 ff ff       	call   8049110 <puts@plt>
 8049dd4:	83 c4 10             	add    $0x10,%esp
 8049dd7:	eb de                	jmp    8049db7 <phase_defused+0x16>

08049dd9 <sigalrm_handler>:
 8049dd9:	83 ec 10             	sub    $0x10,%esp
 8049ddc:	6a 00                	push   $0x0
 8049dde:	68 20 b8 04 08       	push   $0x804b820
 8049de3:	ff 35 e0 e7 04 08    	pushl  0x804e7e0
 8049de9:	e8 62 f3 ff ff       	call   8049150 <fprintf@plt>
 8049dee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8049df5:	e8 26 f3 ff ff       	call   8049120 <exit@plt>

08049dfa <rio_readlineb>:
 8049dfa:	55                   	push   %ebp
 8049dfb:	57                   	push   %edi
 8049dfc:	56                   	push   %esi
 8049dfd:	53                   	push   %ebx
 8049dfe:	83 ec 1c             	sub    $0x1c,%esp
 8049e01:	89 d7                	mov    %edx,%edi
 8049e03:	83 f9 01             	cmp    $0x1,%ecx
 8049e06:	76 7e                	jbe    8049e86 <rio_readlineb+0x8c>
 8049e08:	89 c3                	mov    %eax,%ebx
 8049e0a:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
 8049e0e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 8049e12:	bd 01 00 00 00       	mov    $0x1,%ebp
 8049e17:	8d 73 0c             	lea    0xc(%ebx),%esi
 8049e1a:	eb 4f                	jmp    8049e6b <rio_readlineb+0x71>
 8049e1c:	e8 7f f3 ff ff       	call   80491a0 <__errno_location@plt>
 8049e21:	83 38 04             	cmpl   $0x4,(%eax)
 8049e24:	75 4e                	jne    8049e74 <rio_readlineb+0x7a>
 8049e26:	83 ec 04             	sub    $0x4,%esp
 8049e29:	68 00 20 00 00       	push   $0x2000
 8049e2e:	56                   	push   %esi
 8049e2f:	ff 33                	pushl  (%ebx)
 8049e31:	e8 1a f2 ff ff       	call   8049050 <read@plt>
 8049e36:	89 43 04             	mov    %eax,0x4(%ebx)
 8049e39:	83 c4 10             	add    $0x10,%esp
 8049e3c:	85 c0                	test   %eax,%eax
 8049e3e:	78 dc                	js     8049e1c <rio_readlineb+0x22>
 8049e40:	74 37                	je     8049e79 <rio_readlineb+0x7f>
 8049e42:	89 73 08             	mov    %esi,0x8(%ebx)
 8049e45:	8b 53 08             	mov    0x8(%ebx),%edx
 8049e48:	0f b6 0a             	movzbl (%edx),%ecx
 8049e4b:	83 c2 01             	add    $0x1,%edx
 8049e4e:	89 53 08             	mov    %edx,0x8(%ebx)
 8049e51:	83 e8 01             	sub    $0x1,%eax
 8049e54:	89 43 04             	mov    %eax,0x4(%ebx)
 8049e57:	83 c7 01             	add    $0x1,%edi
 8049e5a:	88 4f ff             	mov    %cl,-0x1(%edi)
 8049e5d:	80 f9 0a             	cmp    $0xa,%cl
 8049e60:	74 2f                	je     8049e91 <rio_readlineb+0x97>
 8049e62:	83 c5 01             	add    $0x1,%ebp
 8049e65:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
 8049e69:	74 22                	je     8049e8d <rio_readlineb+0x93>
 8049e6b:	8b 43 04             	mov    0x4(%ebx),%eax
 8049e6e:	85 c0                	test   %eax,%eax
 8049e70:	7e b4                	jle    8049e26 <rio_readlineb+0x2c>
 8049e72:	eb d1                	jmp    8049e45 <rio_readlineb+0x4b>
 8049e74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 8049e79:	85 c0                	test   %eax,%eax
 8049e7b:	75 21                	jne    8049e9e <rio_readlineb+0xa4>
 8049e7d:	83 fd 01             	cmp    $0x1,%ebp
 8049e80:	75 0f                	jne    8049e91 <rio_readlineb+0x97>
 8049e82:	89 c5                	mov    %eax,%ebp
 8049e84:	eb 0e                	jmp    8049e94 <rio_readlineb+0x9a>
 8049e86:	bd 01 00 00 00       	mov    $0x1,%ebp
 8049e8b:	eb 04                	jmp    8049e91 <rio_readlineb+0x97>
 8049e8d:	8b 7c 24 0c          	mov    0xc(%esp),%edi
 8049e91:	c6 07 00             	movb   $0x0,(%edi)
 8049e94:	89 e8                	mov    %ebp,%eax
 8049e96:	83 c4 1c             	add    $0x1c,%esp
 8049e99:	5b                   	pop    %ebx
 8049e9a:	5e                   	pop    %esi
 8049e9b:	5f                   	pop    %edi
 8049e9c:	5d                   	pop    %ebp
 8049e9d:	c3                   	ret    
 8049e9e:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
 8049ea3:	eb ef                	jmp    8049e94 <rio_readlineb+0x9a>

08049ea5 <submitr>:
 8049ea5:	55                   	push   %ebp
 8049ea6:	57                   	push   %edi
 8049ea7:	56                   	push   %esi
 8049ea8:	53                   	push   %ebx
 8049ea9:	81 ec 50 a0 00 00    	sub    $0xa050,%esp
 8049eaf:	c7 84 24 24 20 00 00 	movl   $0x0,0x2024(%esp)
 8049eb6:	00 00 00 00 
 8049eba:	6a 00                	push   $0x0
 8049ebc:	6a 01                	push   $0x1
 8049ebe:	6a 02                	push   $0x2
 8049ec0:	e8 fb f2 ff ff       	call   80491c0 <socket@plt>
 8049ec5:	83 c4 10             	add    $0x10,%esp
 8049ec8:	85 c0                	test   %eax,%eax
 8049eca:	0f 88 46 01 00 00    	js     804a016 <submitr+0x171>
 8049ed0:	89 c5                	mov    %eax,%ebp
 8049ed2:	83 ec 0c             	sub    $0xc,%esp
 8049ed5:	ff b4 24 6c a0 00 00 	pushl  0xa06c(%esp)
 8049edc:	e8 ef f2 ff ff       	call   80491d0 <gethostbyname@plt>
 8049ee1:	83 c4 10             	add    $0x10,%esp
 8049ee4:	85 c0                	test   %eax,%eax
 8049ee6:	0f 84 7f 01 00 00    	je     804a06b <submitr+0x1c6>
 8049eec:	8d 9c 24 30 a0 00 00 	lea    0xa030(%esp),%ebx
 8049ef3:	c7 84 24 30 a0 00 00 	movl   $0x0,0xa030(%esp)
 8049efa:	00 00 00 00 
 8049efe:	c7 84 24 34 a0 00 00 	movl   $0x0,0xa034(%esp)
 8049f05:	00 00 00 00 
 8049f09:	c7 84 24 38 a0 00 00 	movl   $0x0,0xa038(%esp)
 8049f10:	00 00 00 00 
 8049f14:	c7 84 24 3c a0 00 00 	movl   $0x0,0xa03c(%esp)
 8049f1b:	00 00 00 00 
 8049f1f:	66 c7 84 24 30 a0 00 	movw   $0x2,0xa030(%esp)
 8049f26:	00 02 00 
 8049f29:	83 ec 04             	sub    $0x4,%esp
 8049f2c:	ff 70 0c             	pushl  0xc(%eax)
 8049f2f:	8b 40 10             	mov    0x10(%eax),%eax
 8049f32:	ff 30                	pushl  (%eax)
 8049f34:	8d 84 24 40 a0 00 00 	lea    0xa040(%esp),%eax
 8049f3b:	50                   	push   %eax
 8049f3c:	e8 3f f1 ff ff       	call   8049080 <memmove@plt>
 8049f41:	0f b7 84 24 74 a0 00 	movzwl 0xa074(%esp),%eax
 8049f48:	00 
 8049f49:	66 c1 c0 08          	rol    $0x8,%ax
 8049f4d:	66 89 84 24 42 a0 00 	mov    %ax,0xa042(%esp)
 8049f54:	00 
 8049f55:	83 c4 0c             	add    $0xc,%esp
 8049f58:	6a 10                	push   $0x10
 8049f5a:	53                   	push   %ebx
 8049f5b:	55                   	push   %ebp
 8049f5c:	e8 8f f2 ff ff       	call   80491f0 <connect@plt>
 8049f61:	83 c4 10             	add    $0x10,%esp
 8049f64:	85 c0                	test   %eax,%eax
 8049f66:	0f 88 72 01 00 00    	js     804a0de <submitr+0x239>
 8049f6c:	83 ec 0c             	sub    $0xc,%esp
 8049f6f:	ff b4 24 80 a0 00 00 	pushl  0xa080(%esp)
 8049f76:	e8 b5 f1 ff ff       	call   8049130 <strlen@plt>
 8049f7b:	83 c4 04             	add    $0x4,%esp
 8049f7e:	89 c3                	mov    %eax,%ebx
 8049f80:	ff b4 24 74 a0 00 00 	pushl  0xa074(%esp)
 8049f87:	e8 a4 f1 ff ff       	call   8049130 <strlen@plt>
 8049f8c:	83 c4 04             	add    $0x4,%esp
 8049f8f:	89 c7                	mov    %eax,%edi
 8049f91:	ff b4 24 78 a0 00 00 	pushl  0xa078(%esp)
 8049f98:	e8 93 f1 ff ff       	call   8049130 <strlen@plt>
 8049f9d:	83 c4 04             	add    $0x4,%esp
 8049fa0:	89 c6                	mov    %eax,%esi
 8049fa2:	ff b4 24 7c a0 00 00 	pushl  0xa07c(%esp)
 8049fa9:	e8 82 f1 ff ff       	call   8049130 <strlen@plt>
 8049fae:	83 c4 10             	add    $0x10,%esp
 8049fb1:	89 c2                	mov    %eax,%edx
 8049fb3:	8d 84 37 80 00 00 00 	lea    0x80(%edi,%esi,1),%eax
 8049fba:	01 d0                	add    %edx,%eax
 8049fbc:	8d 14 5b             	lea    (%ebx,%ebx,2),%edx
 8049fbf:	01 d0                	add    %edx,%eax
 8049fc1:	3d 00 20 00 00       	cmp    $0x2000,%eax
 8049fc6:	0f 87 77 01 00 00    	ja     804a143 <submitr+0x29e>
 8049fcc:	8d 94 24 24 40 00 00 	lea    0x4024(%esp),%edx
 8049fd3:	b9 00 08 00 00       	mov    $0x800,%ecx
 8049fd8:	b8 00 00 00 00       	mov    $0x0,%eax
 8049fdd:	89 d7                	mov    %edx,%edi
 8049fdf:	f3 ab                	rep stos %eax,%es:(%edi)
 8049fe1:	83 ec 0c             	sub    $0xc,%esp
 8049fe4:	ff b4 24 80 a0 00 00 	pushl  0xa080(%esp)
 8049feb:	e8 40 f1 ff ff       	call   8049130 <strlen@plt>
 8049ff0:	83 c4 10             	add    $0x10,%esp
 8049ff3:	89 c7                	mov    %eax,%edi
 8049ff5:	85 c0                	test   %eax,%eax
 8049ff7:	0f 84 56 02 00 00    	je     804a253 <submitr+0x3ae>
 8049ffd:	8b 9c 24 74 a0 00 00 	mov    0xa074(%esp),%ebx
 804a004:	8d b4 24 24 40 00 00 	lea    0x4024(%esp),%esi
 804a00b:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
 804a00f:	89 dd                	mov    %ebx,%ebp
 804a011:	e9 bf 01 00 00       	jmp    804a1d5 <submitr+0x330>
 804a016:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a01d:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a023:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
 804a02a:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
 804a031:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
 804a038:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
 804a03f:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
 804a046:	c7 40 18 63 72 65 61 	movl   $0x61657263,0x18(%eax)
 804a04d:	c7 40 1c 74 65 20 73 	movl   $0x73206574,0x1c(%eax)
 804a054:	c7 40 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%eax)
 804a05b:	66 c7 40 24 74 00    	movw   $0x74,0x24(%eax)
 804a061:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a066:	e9 8d 04 00 00       	jmp    804a4f8 <submitr+0x653>
 804a06b:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a072:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a078:	c7 40 04 72 3a 20 44 	movl   $0x44203a72,0x4(%eax)
 804a07f:	c7 40 08 4e 53 20 69 	movl   $0x6920534e,0x8(%eax)
 804a086:	c7 40 0c 73 20 75 6e 	movl   $0x6e752073,0xc(%eax)
 804a08d:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
 804a094:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
 804a09b:	c7 40 18 72 65 73 6f 	movl   $0x6f736572,0x18(%eax)
 804a0a2:	c7 40 1c 6c 76 65 20 	movl   $0x2065766c,0x1c(%eax)
 804a0a9:	c7 40 20 73 65 72 76 	movl   $0x76726573,0x20(%eax)
 804a0b0:	c7 40 24 65 72 20 61 	movl   $0x61207265,0x24(%eax)
 804a0b7:	c7 40 28 64 64 72 65 	movl   $0x65726464,0x28(%eax)
 804a0be:	66 c7 40 2c 73 73    	movw   $0x7373,0x2c(%eax)
 804a0c4:	c6 40 2e 00          	movb   $0x0,0x2e(%eax)
 804a0c8:	83 ec 0c             	sub    $0xc,%esp
 804a0cb:	55                   	push   %ebp
 804a0cc:	e8 2f f1 ff ff       	call   8049200 <close@plt>
 804a0d1:	83 c4 10             	add    $0x10,%esp
 804a0d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a0d9:	e9 1a 04 00 00       	jmp    804a4f8 <submitr+0x653>
 804a0de:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a0e5:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a0eb:	c7 40 04 72 3a 20 55 	movl   $0x55203a72,0x4(%eax)
 804a0f2:	c7 40 08 6e 61 62 6c 	movl   $0x6c62616e,0x8(%eax)
 804a0f9:	c7 40 0c 65 20 74 6f 	movl   $0x6f742065,0xc(%eax)
 804a100:	c7 40 10 20 63 6f 6e 	movl   $0x6e6f6320,0x10(%eax)
 804a107:	c7 40 14 6e 65 63 74 	movl   $0x7463656e,0x14(%eax)
 804a10e:	c7 40 18 20 74 6f 20 	movl   $0x206f7420,0x18(%eax)
 804a115:	c7 40 1c 74 68 65 20 	movl   $0x20656874,0x1c(%eax)
 804a11c:	c7 40 20 73 65 72 76 	movl   $0x76726573,0x20(%eax)
 804a123:	66 c7 40 24 65 72    	movw   $0x7265,0x24(%eax)
 804a129:	c6 40 26 00          	movb   $0x0,0x26(%eax)
 804a12d:	83 ec 0c             	sub    $0xc,%esp
 804a130:	55                   	push   %ebp
 804a131:	e8 ca f0 ff ff       	call   8049200 <close@plt>
 804a136:	83 c4 10             	add    $0x10,%esp
 804a139:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a13e:	e9 b5 03 00 00       	jmp    804a4f8 <submitr+0x653>
 804a143:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a14a:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a150:	c7 40 04 72 3a 20 52 	movl   $0x52203a72,0x4(%eax)
 804a157:	c7 40 08 65 73 75 6c 	movl   $0x6c757365,0x8(%eax)
 804a15e:	c7 40 0c 74 20 73 74 	movl   $0x74732074,0xc(%eax)
 804a165:	c7 40 10 72 69 6e 67 	movl   $0x676e6972,0x10(%eax)
 804a16c:	c7 40 14 20 74 6f 6f 	movl   $0x6f6f7420,0x14(%eax)
 804a173:	c7 40 18 20 6c 61 72 	movl   $0x72616c20,0x18(%eax)
 804a17a:	c7 40 1c 67 65 2e 20 	movl   $0x202e6567,0x1c(%eax)
 804a181:	c7 40 20 49 6e 63 72 	movl   $0x72636e49,0x20(%eax)
 804a188:	c7 40 24 65 61 73 65 	movl   $0x65736165,0x24(%eax)
 804a18f:	c7 40 28 20 53 55 42 	movl   $0x42555320,0x28(%eax)
 804a196:	c7 40 2c 4d 49 54 52 	movl   $0x5254494d,0x2c(%eax)
 804a19d:	c7 40 30 5f 4d 41 58 	movl   $0x58414d5f,0x30(%eax)
 804a1a4:	c7 40 34 42 55 46 00 	movl   $0x465542,0x34(%eax)
 804a1ab:	83 ec 0c             	sub    $0xc,%esp
 804a1ae:	55                   	push   %ebp
 804a1af:	e8 4c f0 ff ff       	call   8049200 <close@plt>
 804a1b4:	83 c4 10             	add    $0x10,%esp
 804a1b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a1bc:	e9 37 03 00 00       	jmp    804a4f8 <submitr+0x653>
 804a1c1:	3c 5f                	cmp    $0x5f,%al
 804a1c3:	75 6e                	jne    804a233 <submitr+0x38e>
 804a1c5:	88 06                	mov    %al,(%esi)
 804a1c7:	8d 76 01             	lea    0x1(%esi),%esi
 804a1ca:	83 c3 01             	add    $0x1,%ebx
 804a1cd:	8d 44 3d 00          	lea    0x0(%ebp,%edi,1),%eax
 804a1d1:	39 c3                	cmp    %eax,%ebx
 804a1d3:	74 7a                	je     804a24f <submitr+0x3aa>
 804a1d5:	0f b6 03             	movzbl (%ebx),%eax
 804a1d8:	8d 50 d6             	lea    -0x2a(%eax),%edx
 804a1db:	80 fa 0f             	cmp    $0xf,%dl
 804a1de:	77 e1                	ja     804a1c1 <submitr+0x31c>
 804a1e0:	b9 d9 ff 00 00       	mov    $0xffd9,%ecx
 804a1e5:	0f a3 d1             	bt     %edx,%ecx
 804a1e8:	72 db                	jb     804a1c5 <submitr+0x320>
 804a1ea:	3c 5f                	cmp    $0x5f,%al
 804a1ec:	74 d7                	je     804a1c5 <submitr+0x320>
 804a1ee:	8d 50 e0             	lea    -0x20(%eax),%edx
 804a1f1:	80 fa 5f             	cmp    $0x5f,%dl
 804a1f4:	76 08                	jbe    804a1fe <submitr+0x359>
 804a1f6:	3c 09                	cmp    $0x9,%al
 804a1f8:	0f 85 ec 03 00 00    	jne    804a5ea <submitr+0x745>
 804a1fe:	83 ec 04             	sub    $0x4,%esp
 804a201:	0f b6 c0             	movzbl %al,%eax
 804a204:	50                   	push   %eax
 804a205:	68 2a b9 04 08       	push   $0x804b92a
 804a20a:	8d 44 24 24          	lea    0x24(%esp),%eax
 804a20e:	50                   	push   %eax
 804a20f:	e8 9c ef ff ff       	call   80491b0 <sprintf@plt>
 804a214:	0f b6 44 24 28       	movzbl 0x28(%esp),%eax
 804a219:	88 06                	mov    %al,(%esi)
 804a21b:	0f b6 44 24 29       	movzbl 0x29(%esp),%eax
 804a220:	88 46 01             	mov    %al,0x1(%esi)
 804a223:	0f b6 44 24 2a       	movzbl 0x2a(%esp),%eax
 804a228:	88 46 02             	mov    %al,0x2(%esi)
 804a22b:	83 c4 10             	add    $0x10,%esp
 804a22e:	8d 76 03             	lea    0x3(%esi),%esi
 804a231:	eb 97                	jmp    804a1ca <submitr+0x325>
 804a233:	89 c2                	mov    %eax,%edx
 804a235:	83 e2 df             	and    $0xffffffdf,%edx
 804a238:	83 ea 41             	sub    $0x41,%edx
 804a23b:	80 fa 19             	cmp    $0x19,%dl
 804a23e:	76 85                	jbe    804a1c5 <submitr+0x320>
 804a240:	3c 20                	cmp    $0x20,%al
 804a242:	75 aa                	jne    804a1ee <submitr+0x349>
 804a244:	c6 06 2b             	movb   $0x2b,(%esi)
 804a247:	8d 76 01             	lea    0x1(%esi),%esi
 804a24a:	e9 7b ff ff ff       	jmp    804a1ca <submitr+0x325>
 804a24f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
 804a253:	83 ec 08             	sub    $0x8,%esp
 804a256:	8d 84 24 2c 40 00 00 	lea    0x402c(%esp),%eax
 804a25d:	50                   	push   %eax
 804a25e:	ff b4 24 7c a0 00 00 	pushl  0xa07c(%esp)
 804a265:	ff b4 24 7c a0 00 00 	pushl  0xa07c(%esp)
 804a26c:	ff b4 24 7c a0 00 00 	pushl  0xa07c(%esp)
 804a273:	68 b8 b8 04 08       	push   $0x804b8b8
 804a278:	8d 9c 24 40 60 00 00 	lea    0x6040(%esp),%ebx
 804a27f:	53                   	push   %ebx
 804a280:	e8 2b ef ff ff       	call   80491b0 <sprintf@plt>
 804a285:	83 c4 14             	add    $0x14,%esp
 804a288:	53                   	push   %ebx
 804a289:	e8 a2 ee ff ff       	call   8049130 <strlen@plt>
 804a28e:	83 c4 10             	add    $0x10,%esp
 804a291:	89 c3                	mov    %eax,%ebx
 804a293:	8d b4 24 24 60 00 00 	lea    0x6024(%esp),%esi
 804a29a:	bf 00 00 00 00       	mov    $0x0,%edi
 804a29f:	85 c0                	test   %eax,%eax
 804a2a1:	0f 85 34 01 00 00    	jne    804a3db <submitr+0x536>
 804a2a7:	89 ac 24 24 80 00 00 	mov    %ebp,0x8024(%esp)
 804a2ae:	c7 84 24 28 80 00 00 	movl   $0x0,0x8028(%esp)
 804a2b5:	00 00 00 00 
 804a2b9:	8d 84 24 30 80 00 00 	lea    0x8030(%esp),%eax
 804a2c0:	89 84 24 2c 80 00 00 	mov    %eax,0x802c(%esp)
 804a2c7:	b9 00 20 00 00       	mov    $0x2000,%ecx
 804a2cc:	8d 94 24 24 60 00 00 	lea    0x6024(%esp),%edx
 804a2d3:	8d 84 24 24 80 00 00 	lea    0x8024(%esp),%eax
 804a2da:	e8 1b fb ff ff       	call   8049dfa <rio_readlineb>
 804a2df:	85 c0                	test   %eax,%eax
 804a2e1:	0f 8e 18 01 00 00    	jle    804a3ff <submitr+0x55a>
 804a2e7:	83 ec 0c             	sub    $0xc,%esp
 804a2ea:	8d 44 24 2c          	lea    0x2c(%esp),%eax
 804a2ee:	50                   	push   %eax
 804a2ef:	8d 84 24 30 20 00 00 	lea    0x2030(%esp),%eax
 804a2f6:	50                   	push   %eax
 804a2f7:	8d 84 24 38 20 00 00 	lea    0x2038(%esp),%eax
 804a2fe:	50                   	push   %eax
 804a2ff:	68 31 b9 04 08       	push   $0x804b931
 804a304:	8d 84 24 40 60 00 00 	lea    0x6040(%esp),%eax
 804a30b:	50                   	push   %eax
 804a30c:	e8 6f ee ff ff       	call   8049180 <__isoc99_sscanf@plt>
 804a311:	8b 84 24 40 20 00 00 	mov    0x2040(%esp),%eax
 804a318:	83 c4 20             	add    $0x20,%esp
 804a31b:	3d c8 00 00 00       	cmp    $0xc8,%eax
 804a320:	0f 85 53 01 00 00    	jne    804a479 <submitr+0x5d4>
 804a326:	8d 9c 24 24 60 00 00 	lea    0x6024(%esp),%ebx
 804a32d:	83 ec 08             	sub    $0x8,%esp
 804a330:	68 42 b9 04 08       	push   $0x804b942
 804a335:	53                   	push   %ebx
 804a336:	e8 05 ed ff ff       	call   8049040 <strcmp@plt>
 804a33b:	83 c4 10             	add    $0x10,%esp
 804a33e:	85 c0                	test   %eax,%eax
 804a340:	0f 84 5c 01 00 00    	je     804a4a2 <submitr+0x5fd>
 804a346:	b9 00 20 00 00       	mov    $0x2000,%ecx
 804a34b:	89 da                	mov    %ebx,%edx
 804a34d:	8d 84 24 24 80 00 00 	lea    0x8024(%esp),%eax
 804a354:	e8 a1 fa ff ff       	call   8049dfa <rio_readlineb>
 804a359:	85 c0                	test   %eax,%eax
 804a35b:	7f d0                	jg     804a32d <submitr+0x488>
 804a35d:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a364:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a36a:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
 804a371:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
 804a378:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
 804a37f:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
 804a386:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
 804a38d:	c7 40 18 72 65 61 64 	movl   $0x64616572,0x18(%eax)
 804a394:	c7 40 1c 20 68 65 61 	movl   $0x61656820,0x1c(%eax)
 804a39b:	c7 40 20 64 65 72 73 	movl   $0x73726564,0x20(%eax)
 804a3a2:	c7 40 24 20 66 72 6f 	movl   $0x6f726620,0x24(%eax)
 804a3a9:	c7 40 28 6d 20 73 65 	movl   $0x6573206d,0x28(%eax)
 804a3b0:	c7 40 2c 72 76 65 72 	movl   $0x72657672,0x2c(%eax)
 804a3b7:	c6 40 30 00          	movb   $0x0,0x30(%eax)
 804a3bb:	83 ec 0c             	sub    $0xc,%esp
 804a3be:	55                   	push   %ebp
 804a3bf:	e8 3c ee ff ff       	call   8049200 <close@plt>
 804a3c4:	83 c4 10             	add    $0x10,%esp
 804a3c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a3cc:	e9 27 01 00 00       	jmp    804a4f8 <submitr+0x653>
 804a3d1:	01 c6                	add    %eax,%esi
 804a3d3:	29 c3                	sub    %eax,%ebx
 804a3d5:	0f 84 cc fe ff ff    	je     804a2a7 <submitr+0x402>
 804a3db:	83 ec 04             	sub    $0x4,%esp
 804a3de:	53                   	push   %ebx
 804a3df:	56                   	push   %esi
 804a3e0:	55                   	push   %ebp
 804a3e1:	e8 7a ed ff ff       	call   8049160 <write@plt>
 804a3e6:	83 c4 10             	add    $0x10,%esp
 804a3e9:	85 c0                	test   %eax,%eax
 804a3eb:	7f e4                	jg     804a3d1 <submitr+0x52c>
 804a3ed:	e8 ae ed ff ff       	call   80491a0 <__errno_location@plt>
 804a3f2:	83 38 04             	cmpl   $0x4,(%eax)
 804a3f5:	0f 85 86 01 00 00    	jne    804a581 <submitr+0x6dc>
 804a3fb:	89 f8                	mov    %edi,%eax
 804a3fd:	eb d2                	jmp    804a3d1 <submitr+0x52c>
 804a3ff:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a406:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a40c:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
 804a413:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
 804a41a:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
 804a421:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
 804a428:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
 804a42f:	c7 40 18 72 65 61 64 	movl   $0x64616572,0x18(%eax)
 804a436:	c7 40 1c 20 66 69 72 	movl   $0x72696620,0x1c(%eax)
 804a43d:	c7 40 20 73 74 20 68 	movl   $0x68207473,0x20(%eax)
 804a444:	c7 40 24 65 61 64 65 	movl   $0x65646165,0x24(%eax)
 804a44b:	c7 40 28 72 20 66 72 	movl   $0x72662072,0x28(%eax)
 804a452:	c7 40 2c 6f 6d 20 73 	movl   $0x73206d6f,0x2c(%eax)
 804a459:	c7 40 30 65 72 76 65 	movl   $0x65767265,0x30(%eax)
 804a460:	66 c7 40 34 72 00    	movw   $0x72,0x34(%eax)
 804a466:	83 ec 0c             	sub    $0xc,%esp
 804a469:	55                   	push   %ebp
 804a46a:	e8 91 ed ff ff       	call   8049200 <close@plt>
 804a46f:	83 c4 10             	add    $0x10,%esp
 804a472:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a477:	eb 7f                	jmp    804a4f8 <submitr+0x653>
 804a479:	8d 54 24 20          	lea    0x20(%esp),%edx
 804a47d:	52                   	push   %edx
 804a47e:	50                   	push   %eax
 804a47f:	68 44 b8 04 08       	push   $0x804b844
 804a484:	ff b4 24 84 a0 00 00 	pushl  0xa084(%esp)
 804a48b:	e8 20 ed ff ff       	call   80491b0 <sprintf@plt>
 804a490:	89 2c 24             	mov    %ebp,(%esp)
 804a493:	e8 68 ed ff ff       	call   8049200 <close@plt>
 804a498:	83 c4 10             	add    $0x10,%esp
 804a49b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a4a0:	eb 56                	jmp    804a4f8 <submitr+0x653>
 804a4a2:	b9 00 20 00 00       	mov    $0x2000,%ecx
 804a4a7:	8d 94 24 24 60 00 00 	lea    0x6024(%esp),%edx
 804a4ae:	8d 84 24 24 80 00 00 	lea    0x8024(%esp),%eax
 804a4b5:	e8 40 f9 ff ff       	call   8049dfa <rio_readlineb>
 804a4ba:	85 c0                	test   %eax,%eax
 804a4bc:	7e 45                	jle    804a503 <submitr+0x65e>
 804a4be:	83 ec 08             	sub    $0x8,%esp
 804a4c1:	8d 84 24 2c 60 00 00 	lea    0x602c(%esp),%eax
 804a4c8:	50                   	push   %eax
 804a4c9:	ff b4 24 84 a0 00 00 	pushl  0xa084(%esp)
 804a4d0:	e8 fb eb ff ff       	call   80490d0 <strcpy@plt>
 804a4d5:	89 2c 24             	mov    %ebp,(%esp)
 804a4d8:	e8 23 ed ff ff       	call   8049200 <close@plt>
 804a4dd:	83 c4 08             	add    $0x8,%esp
 804a4e0:	68 45 b9 04 08       	push   $0x804b945
 804a4e5:	ff b4 24 84 a0 00 00 	pushl  0xa084(%esp)
 804a4ec:	e8 4f eb ff ff       	call   8049040 <strcmp@plt>
 804a4f1:	83 c4 10             	add    $0x10,%esp
 804a4f4:	f7 d8                	neg    %eax
 804a4f6:	19 c0                	sbb    %eax,%eax
 804a4f8:	81 c4 4c a0 00 00    	add    $0xa04c,%esp
 804a4fe:	5b                   	pop    %ebx
 804a4ff:	5e                   	pop    %esi
 804a500:	5f                   	pop    %edi
 804a501:	5d                   	pop    %ebp
 804a502:	c3                   	ret    
 804a503:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a50a:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a510:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
 804a517:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
 804a51e:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
 804a525:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
 804a52c:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
 804a533:	c7 40 18 72 65 61 64 	movl   $0x64616572,0x18(%eax)
 804a53a:	c7 40 1c 20 73 74 61 	movl   $0x61747320,0x1c(%eax)
 804a541:	c7 40 20 74 75 73 20 	movl   $0x20737574,0x20(%eax)
 804a548:	c7 40 24 6d 65 73 73 	movl   $0x7373656d,0x24(%eax)
 804a54f:	c7 40 28 61 67 65 20 	movl   $0x20656761,0x28(%eax)
 804a556:	c7 40 2c 66 72 6f 6d 	movl   $0x6d6f7266,0x2c(%eax)
 804a55d:	c7 40 30 20 73 65 72 	movl   $0x72657320,0x30(%eax)
 804a564:	c7 40 34 76 65 72 00 	movl   $0x726576,0x34(%eax)
 804a56b:	83 ec 0c             	sub    $0xc,%esp
 804a56e:	55                   	push   %ebp
 804a56f:	e8 8c ec ff ff       	call   8049200 <close@plt>
 804a574:	83 c4 10             	add    $0x10,%esp
 804a577:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a57c:	e9 77 ff ff ff       	jmp    804a4f8 <submitr+0x653>
 804a581:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a588:	c7 00 45 72 72 6f    	movl   $0x6f727245,(%eax)
 804a58e:	c7 40 04 72 3a 20 43 	movl   $0x43203a72,0x4(%eax)
 804a595:	c7 40 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%eax)
 804a59c:	c7 40 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%eax)
 804a5a3:	c7 40 10 61 62 6c 65 	movl   $0x656c6261,0x10(%eax)
 804a5aa:	c7 40 14 20 74 6f 20 	movl   $0x206f7420,0x14(%eax)
 804a5b1:	c7 40 18 77 72 69 74 	movl   $0x74697277,0x18(%eax)
 804a5b8:	c7 40 1c 65 20 74 6f 	movl   $0x6f742065,0x1c(%eax)
 804a5bf:	c7 40 20 20 74 68 65 	movl   $0x65687420,0x20(%eax)
 804a5c6:	c7 40 24 20 73 65 72 	movl   $0x72657320,0x24(%eax)
 804a5cd:	c7 40 28 76 65 72 00 	movl   $0x726576,0x28(%eax)
 804a5d4:	83 ec 0c             	sub    $0xc,%esp
 804a5d7:	55                   	push   %ebp
 804a5d8:	e8 23 ec ff ff       	call   8049200 <close@plt>
 804a5dd:	83 c4 10             	add    $0x10,%esp
 804a5e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a5e5:	e9 0e ff ff ff       	jmp    804a4f8 <submitr+0x653>
 804a5ea:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
 804a5ee:	a1 74 b8 04 08       	mov    0x804b874,%eax
 804a5f3:	8b 8c 24 78 a0 00 00 	mov    0xa078(%esp),%ecx
 804a5fa:	89 01                	mov    %eax,(%ecx)
 804a5fc:	a1 b3 b8 04 08       	mov    0x804b8b3,%eax
 804a601:	8b 8c 24 78 a0 00 00 	mov    0xa078(%esp),%ecx
 804a608:	89 41 3f             	mov    %eax,0x3f(%ecx)
 804a60b:	8b 84 24 78 a0 00 00 	mov    0xa078(%esp),%eax
 804a612:	8d 78 04             	lea    0x4(%eax),%edi
 804a615:	83 e7 fc             	and    $0xfffffffc,%edi
 804a618:	29 f8                	sub    %edi,%eax
 804a61a:	be 74 b8 04 08       	mov    $0x804b874,%esi
 804a61f:	29 c6                	sub    %eax,%esi
 804a621:	83 c0 43             	add    $0x43,%eax
 804a624:	c1 e8 02             	shr    $0x2,%eax
 804a627:	89 c1                	mov    %eax,%ecx
 804a629:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
 804a62b:	83 ec 0c             	sub    $0xc,%esp
 804a62e:	55                   	push   %ebp
 804a62f:	e8 cc eb ff ff       	call   8049200 <close@plt>
 804a634:	83 c4 10             	add    $0x10,%esp
 804a637:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a63c:	e9 b7 fe ff ff       	jmp    804a4f8 <submitr+0x653>

0804a641 <init_timeout>:
 804a641:	53                   	push   %ebx
 804a642:	83 ec 08             	sub    $0x8,%esp
 804a645:	8b 5c 24 10          	mov    0x10(%esp),%ebx
 804a649:	85 db                	test   %ebx,%ebx
 804a64b:	75 05                	jne    804a652 <init_timeout+0x11>
 804a64d:	83 c4 08             	add    $0x8,%esp
 804a650:	5b                   	pop    %ebx
 804a651:	c3                   	ret    
 804a652:	83 ec 08             	sub    $0x8,%esp
 804a655:	68 d9 9d 04 08       	push   $0x8049dd9
 804a65a:	6a 0e                	push   $0xe
 804a65c:	e8 3f ea ff ff       	call   80490a0 <signal@plt>
 804a661:	85 db                	test   %ebx,%ebx
 804a663:	b8 00 00 00 00       	mov    $0x0,%eax
 804a668:	0f 48 d8             	cmovs  %eax,%ebx
 804a66b:	89 1c 24             	mov    %ebx,(%esp)
 804a66e:	e8 4d ea ff ff       	call   80490c0 <alarm@plt>
 804a673:	83 c4 10             	add    $0x10,%esp
 804a676:	eb d5                	jmp    804a64d <init_timeout+0xc>

0804a678 <init_driver>:
 804a678:	57                   	push   %edi
 804a679:	56                   	push   %esi
 804a67a:	53                   	push   %ebx
 804a67b:	83 ec 18             	sub    $0x18,%esp
 804a67e:	8b 74 24 28          	mov    0x28(%esp),%esi
 804a682:	6a 01                	push   $0x1
 804a684:	6a 0d                	push   $0xd
 804a686:	e8 15 ea ff ff       	call   80490a0 <signal@plt>
 804a68b:	83 c4 08             	add    $0x8,%esp
 804a68e:	6a 01                	push   $0x1
 804a690:	6a 1d                	push   $0x1d
 804a692:	e8 09 ea ff ff       	call   80490a0 <signal@plt>
 804a697:	83 c4 08             	add    $0x8,%esp
 804a69a:	6a 01                	push   $0x1
 804a69c:	6a 1d                	push   $0x1d
 804a69e:	e8 fd e9 ff ff       	call   80490a0 <signal@plt>
 804a6a3:	83 c4 0c             	add    $0xc,%esp
 804a6a6:	6a 00                	push   $0x0
 804a6a8:	6a 01                	push   $0x1
 804a6aa:	6a 02                	push   $0x2
 804a6ac:	e8 0f eb ff ff       	call   80491c0 <socket@plt>
 804a6b1:	83 c4 10             	add    $0x10,%esp
 804a6b4:	85 c0                	test   %eax,%eax
 804a6b6:	0f 88 94 00 00 00    	js     804a750 <init_driver+0xd8>
 804a6bc:	89 c3                	mov    %eax,%ebx
 804a6be:	83 ec 0c             	sub    $0xc,%esp
 804a6c1:	68 48 b9 04 08       	push   $0x804b948
 804a6c6:	e8 05 eb ff ff       	call   80491d0 <gethostbyname@plt>
 804a6cb:	83 c4 10             	add    $0x10,%esp
 804a6ce:	85 c0                	test   %eax,%eax
 804a6d0:	0f 84 c5 00 00 00    	je     804a79b <init_driver+0x123>
 804a6d6:	89 e7                	mov    %esp,%edi
 804a6d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 804a6df:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 804a6e6:	00 
 804a6e7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 804a6ee:	00 
 804a6ef:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 804a6f6:	00 
 804a6f7:	66 c7 04 24 02 00    	movw   $0x2,(%esp)
 804a6fd:	83 ec 04             	sub    $0x4,%esp
 804a700:	ff 70 0c             	pushl  0xc(%eax)
 804a703:	8b 40 10             	mov    0x10(%eax),%eax
 804a706:	ff 30                	pushl  (%eax)
 804a708:	8d 44 24 10          	lea    0x10(%esp),%eax
 804a70c:	50                   	push   %eax
 804a70d:	e8 6e e9 ff ff       	call   8049080 <memmove@plt>
 804a712:	66 c7 44 24 12 43 31 	movw   $0x3143,0x12(%esp)
 804a719:	83 c4 0c             	add    $0xc,%esp
 804a71c:	6a 10                	push   $0x10
 804a71e:	57                   	push   %edi
 804a71f:	53                   	push   %ebx
 804a720:	e8 cb ea ff ff       	call   80491f0 <connect@plt>
 804a725:	89 fc                	mov    %edi,%esp
 804a727:	85 c0                	test   %eax,%eax
 804a729:	0f 88 d8 00 00 00    	js     804a807 <init_driver+0x18f>
 804a72f:	83 ec 0c             	sub    $0xc,%esp
 804a732:	53                   	push   %ebx
 804a733:	e8 c8 ea ff ff       	call   8049200 <close@plt>
 804a738:	66 c7 06 4f 4b       	movw   $0x4b4f,(%esi)
 804a73d:	c6 46 02 00          	movb   $0x0,0x2(%esi)
 804a741:	83 c4 10             	add    $0x10,%esp
 804a744:	b8 00 00 00 00       	mov    $0x0,%eax
 804a749:	83 c4 10             	add    $0x10,%esp
 804a74c:	5b                   	pop    %ebx
 804a74d:	5e                   	pop    %esi
 804a74e:	5f                   	pop    %edi
 804a74f:	c3                   	ret    
 804a750:	c7 06 45 72 72 6f    	movl   $0x6f727245,(%esi)
 804a756:	c7 46 04 72 3a 20 43 	movl   $0x43203a72,0x4(%esi)
 804a75d:	c7 46 08 6c 69 65 6e 	movl   $0x6e65696c,0x8(%esi)
 804a764:	c7 46 0c 74 20 75 6e 	movl   $0x6e752074,0xc(%esi)
 804a76b:	c7 46 10 61 62 6c 65 	movl   $0x656c6261,0x10(%esi)
 804a772:	c7 46 14 20 74 6f 20 	movl   $0x206f7420,0x14(%esi)
 804a779:	c7 46 18 63 72 65 61 	movl   $0x61657263,0x18(%esi)
 804a780:	c7 46 1c 74 65 20 73 	movl   $0x73206574,0x1c(%esi)
 804a787:	c7 46 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%esi)
 804a78e:	66 c7 46 24 74 00    	movw   $0x74,0x24(%esi)
 804a794:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a799:	eb ae                	jmp    804a749 <init_driver+0xd1>
 804a79b:	c7 06 45 72 72 6f    	movl   $0x6f727245,(%esi)
 804a7a1:	c7 46 04 72 3a 20 44 	movl   $0x44203a72,0x4(%esi)
 804a7a8:	c7 46 08 4e 53 20 69 	movl   $0x6920534e,0x8(%esi)
 804a7af:	c7 46 0c 73 20 75 6e 	movl   $0x6e752073,0xc(%esi)
 804a7b6:	c7 46 10 61 62 6c 65 	movl   $0x656c6261,0x10(%esi)
 804a7bd:	c7 46 14 20 74 6f 20 	movl   $0x206f7420,0x14(%esi)
 804a7c4:	c7 46 18 72 65 73 6f 	movl   $0x6f736572,0x18(%esi)
 804a7cb:	c7 46 1c 6c 76 65 20 	movl   $0x2065766c,0x1c(%esi)
 804a7d2:	c7 46 20 73 65 72 76 	movl   $0x76726573,0x20(%esi)
 804a7d9:	c7 46 24 65 72 20 61 	movl   $0x61207265,0x24(%esi)
 804a7e0:	c7 46 28 64 64 72 65 	movl   $0x65726464,0x28(%esi)
 804a7e7:	66 c7 46 2c 73 73    	movw   $0x7373,0x2c(%esi)
 804a7ed:	c6 46 2e 00          	movb   $0x0,0x2e(%esi)
 804a7f1:	83 ec 0c             	sub    $0xc,%esp
 804a7f4:	53                   	push   %ebx
 804a7f5:	e8 06 ea ff ff       	call   8049200 <close@plt>
 804a7fa:	83 c4 10             	add    $0x10,%esp
 804a7fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a802:	e9 42 ff ff ff       	jmp    804a749 <init_driver+0xd1>
 804a807:	83 ec 04             	sub    $0x4,%esp
 804a80a:	68 48 b9 04 08       	push   $0x804b948
 804a80f:	68 04 b9 04 08       	push   $0x804b904
 804a814:	56                   	push   %esi
 804a815:	e8 96 e9 ff ff       	call   80491b0 <sprintf@plt>
 804a81a:	89 1c 24             	mov    %ebx,(%esp)
 804a81d:	e8 de e9 ff ff       	call   8049200 <close@plt>
 804a822:	89 fc                	mov    %edi,%esp
 804a824:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 804a829:	e9 1b ff ff ff       	jmp    804a749 <init_driver+0xd1>

0804a82e <driver_post>:
 804a82e:	53                   	push   %ebx
 804a82f:	83 ec 08             	sub    $0x8,%esp
 804a832:	8b 54 24 10          	mov    0x10(%esp),%edx
 804a836:	8b 44 24 18          	mov    0x18(%esp),%eax
 804a83a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 804a83e:	85 c0                	test   %eax,%eax
 804a840:	75 17                	jne    804a859 <driver_post+0x2b>
 804a842:	85 d2                	test   %edx,%edx
 804a844:	74 05                	je     804a84b <driver_post+0x1d>
 804a846:	80 3a 00             	cmpb   $0x0,(%edx)
 804a849:	75 32                	jne    804a87d <driver_post+0x4f>
 804a84b:	66 c7 03 4f 4b       	movw   $0x4b4f,(%ebx)
 804a850:	c6 43 02 00          	movb   $0x0,0x2(%ebx)
 804a854:	83 c4 08             	add    $0x8,%esp
 804a857:	5b                   	pop    %ebx
 804a858:	c3                   	ret    
 804a859:	83 ec 08             	sub    $0x8,%esp
 804a85c:	ff 74 24 1c          	pushl  0x1c(%esp)
 804a860:	68 5a b9 04 08       	push   $0x804b95a
 804a865:	e8 f6 e7 ff ff       	call   8049060 <printf@plt>
 804a86a:	66 c7 03 4f 4b       	movw   $0x4b4f,(%ebx)
 804a86f:	c6 43 02 00          	movb   $0x0,0x2(%ebx)
 804a873:	83 c4 10             	add    $0x10,%esp
 804a876:	b8 00 00 00 00       	mov    $0x0,%eax
 804a87b:	eb d7                	jmp    804a854 <driver_post+0x26>
 804a87d:	83 ec 04             	sub    $0x4,%esp
 804a880:	53                   	push   %ebx
 804a881:	ff 74 24 1c          	pushl  0x1c(%esp)
 804a885:	68 71 b9 04 08       	push   $0x804b971
 804a88a:	52                   	push   %edx
 804a88b:	68 7f b9 04 08       	push   $0x804b97f
 804a890:	68 31 43 00 00       	push   $0x4331
 804a895:	68 48 b9 04 08       	push   $0x804b948
 804a89a:	e8 06 f6 ff ff       	call   8049ea5 <submitr>
 804a89f:	83 c4 20             	add    $0x20,%esp
 804a8a2:	eb b0                	jmp    804a854 <driver_post+0x26>
 804a8a4:	66 90                	xchg   %ax,%ax
 804a8a6:	66 90                	xchg   %ax,%ax
 804a8a8:	66 90                	xchg   %ax,%ax
 804a8aa:	66 90                	xchg   %ax,%ax
 804a8ac:	66 90                	xchg   %ax,%ax
 804a8ae:	66 90                	xchg   %ax,%ax

0804a8b0 <__libc_csu_init>:
 804a8b0:	f3 0f 1e fb          	endbr32 
 804a8b4:	55                   	push   %ebp
 804a8b5:	e8 6b 00 00 00       	call   804a925 <__x86.get_pc_thunk.bp>
 804a8ba:	81 c5 46 37 00 00    	add    $0x3746,%ebp
 804a8c0:	57                   	push   %edi
 804a8c1:	56                   	push   %esi
 804a8c2:	53                   	push   %ebx
 804a8c3:	83 ec 0c             	sub    $0xc,%esp
 804a8c6:	89 eb                	mov    %ebp,%ebx
 804a8c8:	8b 7c 24 28          	mov    0x28(%esp),%edi
 804a8cc:	e8 2f e7 ff ff       	call   8049000 <_init>
 804a8d1:	8d 9d 10 ff ff ff    	lea    -0xf0(%ebp),%ebx
 804a8d7:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
 804a8dd:	29 c3                	sub    %eax,%ebx
 804a8df:	c1 fb 02             	sar    $0x2,%ebx
 804a8e2:	74 29                	je     804a90d <__libc_csu_init+0x5d>
 804a8e4:	31 f6                	xor    %esi,%esi
 804a8e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 804a8ed:	8d 76 00             	lea    0x0(%esi),%esi
 804a8f0:	83 ec 04             	sub    $0x4,%esp
 804a8f3:	57                   	push   %edi
 804a8f4:	ff 74 24 2c          	pushl  0x2c(%esp)
 804a8f8:	ff 74 24 2c          	pushl  0x2c(%esp)
 804a8fc:	ff 94 b5 0c ff ff ff 	call   *-0xf4(%ebp,%esi,4)
 804a903:	83 c6 01             	add    $0x1,%esi
 804a906:	83 c4 10             	add    $0x10,%esp
 804a909:	39 f3                	cmp    %esi,%ebx
 804a90b:	75 e3                	jne    804a8f0 <__libc_csu_init+0x40>
 804a90d:	83 c4 0c             	add    $0xc,%esp
 804a910:	5b                   	pop    %ebx
 804a911:	5e                   	pop    %esi
 804a912:	5f                   	pop    %edi
 804a913:	5d                   	pop    %ebp
 804a914:	c3                   	ret    
 804a915:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 804a91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

0804a920 <__libc_csu_fini>:
 804a920:	f3 0f 1e fb          	endbr32 
 804a924:	c3                   	ret    

0804a925 <__x86.get_pc_thunk.bp>:
 804a925:	8b 2c 24             	mov    (%esp),%ebp
 804a928:	c3                   	ret    

Disassembly of section .fini:

0804a92c <_fini>:
 804a92c:	f3 0f 1e fb          	endbr32 
 804a930:	53                   	push   %ebx
 804a931:	83 ec 08             	sub    $0x8,%esp
 804a934:	e8 37 e9 ff ff       	call   8049270 <__x86.get_pc_thunk.bx>
 804a939:	81 c3 c7 36 00 00    	add    $0x36c7,%ebx
 804a93f:	83 c4 08             	add    $0x8,%esp
 804a942:	5b                   	pop    %ebx
 804a943:	c3                   	ret    
