b 74
run
7777777
p/x 7777777 // name of input, can be random at first
$1 = 0x76adf1
si
info register
dashboard // can see the dashboard
// get the value of the memory address
x $eax
x $esp+0x2c
x 0x804e880
s // steps through function, not just one machine instruction
https://github.com/cyrus-and/gdb-dashboard/wiki/Choose-the-syntax-highlighting-style


 804951b:	e8 60 fc ff ff       	call   8049180 <__isoc99_sscanf@plt>

 // really helpful to see what the input format
 // fscanf in C parses variables from text

 dashboard assembly scroll +1

 in x86 the caller pushes the arguments to the callee on the stack in reverse
 order they're passed in and the callee can retrieve them with ESP '

 The caller pushed stuff onto the stack.

 The callee gets rid of that space at the end. 

 whatever was pushed on, the add    $0x1c,%esp skips over it

 ebx, ebi, general purpose registers: if the callee uses a general purpose register
 the caller needs to restore it later

 Fscanf takes a string that youre parsing, how you are going to parse that string,
and the variables that youre gonna put that stuff into
// Arguments passed in reverse
8049511:	50                   	push   %eax // the add. of variable that you're putting that stuff into (third)
 8049512:	68 40 b4 04 08       	push   $0x804b440 // the format "%d, %s" of the input (second)
 8049517:	ff 74 24 2c          	pushl  0x2c(%esp) // the string that you're parsing (first)
  804951b:	e8 60 fc ff ff       	call   8049180 <__isoc99_sscanf@plt> // fscanf
// this is now wiping the variables off the stack by 0x10
// hex conversion: just same as binary but multiply by 16: 0x10 -> 1 * 16^1 + 0 * 16^0
   8049520:	83 c4 10             	add    $0x10,%esp

// if you know what arguments the bomb accepts are, you can figure out what you should write

Push all of these variables onto the stack.

// making sure you can't die (figure out gdbinit to auto do this?)
b explode_bomb

x/s
// x is a print and dereference and s is in string format

// registers are in a percent sign in assembly, $ sign in gdb

x/s 0x804b440 // print the string
x // dereferences
p // prints, versatile
p *(add) // can cast this, print dereferences

0x804b440:      "%d" // the input is one number

// stuff in registers could be addresses, could be anything ( a number )

// deference and print integer
x/d 0x2c + $esp
0xffffc764:     52

// Use the assembly versions of gdb commands
// avoid s! try doing ni

>>> b phase_1
Breakpoint 1 at 0x8049502
>>> b explode_bomb
Breakpoint 2 at 0x8049c2f
// comparing 1 to %eax
 0x08049523  ? cmp    $0x1,%eax


// %eax is where return values of functions are stored
// if fscanf returns 1 (in $eax) you know it was successful and found 1 value
// if it returns 3 found 3 values
// you can check man sscanf

// address of instruction ; hex (can ignore); instruction
 8049523:	83 f8 01             	cmp    $0x1,%eax
 8049526:	75 0e                	jne    8049536 <phase_1+0x34>

 // compare 1 with $eax, 
 // compare loaded into the e flags into a special register that is used by the jump function
 // the jump function si going to check the value in that register and jump based on it
 // cmp takes the values and subtracts them, puts them into the special register
 // jump not equal: does a not equal comparison and if the value in that register is 0,
 // then they're equal.

// jump greater, etc.

// in this case, if your input is not just one integer 
// meaning comp does not equal 1 ($0x1,%eax)
// it will go to explode bomb
// (%esp) 
// (%esp) for lea (load effective address) not a dereference
// otherwise () is a dereference
// for 0xc(%esp)
// add 0xc to the address at %esp, then dereference

0x08049528  ? cmpl   $0x35e,0xc(%esp)
 0x08049530  ? jne    0x804953d <phase_1+59>

// compare long and jne (jump not equal)
// compare long comparing 0x35e = 862 and 0xc(%esp) = 12 + (%esp)
p 0x35e
// printing the integer val at address %esp + 0xc
// x only dereferences direct memory address
// Lucas recommends p! the goat
p *(int)($esp + 0xc)
$6 = 7777777

// 0xc is 12 bytes
// we pass in the argument, the esp, then the ebp
// as phase_1 is called

 8049528:	81 7c 24 0c 5e 03 00 	cmpl   $0x35e,0xc(%esp)
 // these are not the same, so it will explode
 // our input should be 0x35e or 862

 jne    804953d <phase_1+0x3b>
 // 804953d is the location it jumps to if not equal

gdb --args bomb mysolution.txt // remember to add a new line after new input


// disassembly line 832 8049a11:	8b 5c 24 10          	mov    0x10(%esp),%ebx

>>> p 0x14 + $esp
$35 = (void *) 0xffffc734
>>> x/a 0xffffc734
0xffffc734:     0x804b1ba
>>> x/s 0x804b1ba
0x804b1ba:      "Crikey! I have lost my mojo!"

// disassembly line 833  8049a15:	8b 74 24 14          	mov    0x14(%esp),%esi
// how to examine the string inside an address

>>> p 0x14 + $esp
$34 = (void *) 0xffffc734
>>> x/a 0xffffc730
0xffffc730:     0x804e8d0 <input_strings+80>
>>> x/s 0x804e8d0
0x804e8d0 <input_strings+80>:   "7777777"


https://stackoverflow.com/questions/22801152/understand-cmpb-and-loops-in-assembly-language
 This is a loop
 // basically, keep looking at the next character of edx at index eax 
 // until it compares equal to void, eax is your return value
 80499fe:	83 c0 01             	add    $0x1,%eax
 8049a01:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 8049a05:	75 f7                	jne    80499fe <string_length+0xe>

>>> x ($edx + $eax)
0x804e8d1 <input_strings+81>:   0x72

print strings

(gdb) x/s **((char ***) (0xc + $ebp))
0xbfffedc8:  "/var/tmp/SO-attempt-to-dereference-generic-pointer/example"
(gdb) x/s *(*((char ***) (0xc + $ebp)) + 1)
0xbfffee03:  "first"
(gdb) x/s *(*((char ***) (0xc + $ebp)) + 2)
0xbfffee09:  "second"

You can use the finish command.

finish: Continue running until just after function in the selected stack frame returns.
 Print the returned value (if any). This command can be abbreviated as fin.

p/c $al
$29 = 114 'r'

test $al, $al
The test instruction performs a logical and of the two operands and sets
the CPU flags register according to the result (which is not stored anywhere).
If al is zero, the anded result is zero and that sets the Z flag. If al is nonzero, 
it clears the Z flag. (Other flags, such as Carry, oVerflow, Sign, Parity, etc. are affected too, 
but this code has no instruction testing them.)

The jne instruction alters EIP if the Z flag is not set. 
There is another mnemonic for the same operation called jnz.

x/s 0x804b1d8
0x804b1d8:      "Why make trillions when we could make... billions?"

length of 0x804b1d8

p $eax
$1 = 50
added 1, $eax = 51

jmp    *0x804e03c
x/a 0x804e03c -> 0x8049106

jmp to 0x8049106

08049030 <.plt>:
 8049030:	ff 35 04 e0 04 08    	pushl  0x804e004
 8049036:	ff 25 08 e0 04 08    	jmp    *0x804e008
 804903c:	00 00                	add    %al,(%eax)

>>> x $esp
0xffffc734:     "p\004\005\b$\310\377\377J\235\004\b$\310\377\377\002"
>>> x/ $esp + 0x1c
0xffffc750:     " \351\004\b$\310\377\377\002"
>>> x/a $esp + 0x1c
0xffffc750:     0x804e920 <input_strings+160>

p(int*)(addr)10

if test $eax, $eax when $eax is 0, jump will be equal.
jne will not jump

>>> x 0x10 + $esp
0xffffc730:     0x804e920 <input_strings+160>
>>> x 0x14 + $esp
0xffffc734:     0x8050470
>>> x/s 0x8050470
0x8050470:      "Why make trillions ahen we could make... billions?"

>>> p/s *(char*) 0xffffca2d
$10 = 47 '/'

>>> printf "%s\n", 0xffffca2d
/home/classes/cs323/class/wong.michael.mjw223/proj2/bomb58/bomb

>>> p/s (char *)0xffffca2d
$12 = 0xffffca2d "/home/classes/cs323/class/wong.michael.mjw223/proj2/bomb58/bomb"

>>> x/i 0xffffc714 
   0xffffc714:  sub    %al,%bh

>>> p $al
$31 = 40
>>> p $bh
$32 = -56

 8049c6c:	83 ec 0c             	sub    $0xc,%esp
 8049c6f:	8b 44 24 14          	mov    0x14(%esp),%eax 
  // x $eax = inc %eax
 8049c73:	8d 50 14             	lea    0x14(%eax),%edx
 // x $edx = dec %eax
 8049c76:	52                   	push   %edx
 8049c77:	8d 50 10             	lea    0x10(%eax),%edx
 // and    $0xc8,%al
 // p $al = 40
 8049c7a:	52                   	push   %edx
 8049c7b:	8d 50 0c             	lea    0xc(%eax),%edx
 // jo     0xffffc73a
 8049c7e:	52                   	push   %edx
 8049c7f:	8d 50 08             	lea    0x8(%eax),%edx
 // jo     0xffffc71b
 8049c82:	52                   	push   %edx
 8049c83:	8d 50 04             	lea    0x4(%eax),%edx
 // into
 // INTO NP Invalid Valid Interrupt 4—if overflow flag is 1.
 8049c86:	52                   	push   %edx
 8049c87:	50                   	push   %eax
 // the ad.. of the variable you're pushing stuff into
 8049c88:	68 31 b4 04 08       	push   $0x804b431
 // >>> x/s 0x804b431
// 0x804b431:      "%d %d %d %d %d %d"
 8049c8d:	ff 74 24 2c          	pushl  0x2c(%esp)
 // 0xffffc710:     0x70
 // x/a 0xffffc710
// 0xffffc710:     0x804e970 <input_strings+240>
// >>> x/s 0x804e970
// 0x804e970 <input_strings+240>:  "7777777"
 8049c91:	e8 ea f4 ff ff       	call   8049180 <__isoc99_sscanf@plt>
 8049c96:	83 c4 20             	add    $0x20,%esp
 8049c99:	83 f8 05             	cmp    $0x5,%eax
 8049c9c:	7e 04                	jle    8049ca2 <read_six_numbers+0x36>
 8049c9e:	83 c4 0c             	add    $0xc,%esp
 8049ca1:	c3                   	ret    
 8049ca2:	e8 88 ff ff ff       	call   8049c2f <explode_bomb>

 >>> x 0x2c + $esp
0xffffc710:     0x70
>>> p 0xffffc710
$53 = 4294952720
>>> x/s 0xffffc710
0xffffc710:     "p\351\004\b(\307\377\377\002"
>>> x/a 0xffffc710
0xffffc710:     0x804e970 <input_strings+240>

 8049612:	83 c4 10             	add    $0x10,%esp
 8049615:	83 7c 24 08 05       	cmpl   $0x5,0x8(%esp)

 // $esp is input_string
 // p $esp $1 = (void *) 0xffffc710

 given input 1 2 3 4 5

 >>> x/a 0x8 + $esp
0xffffc728:     0x1
>>> x $esp
0xffffc720:     0x804e970 <input_strings+240>
>>> x $esp + 0x8
0xffffc728:     0x1
>>> x $esp + 0x4
0xffffc724:     0x50
>>> x $esp + 0xc
0xffffc72c:     0x2
>>> x $esp + 0x10
0xffffc730:     0x3

 8049628:	8d 5c 24 08          	lea    0x8(%esp),%ebx
 804962c:	8d 74 24 18          	lea    0x18(%esp),%esi
 8049630:	eb 07                	jmp    8049639 <phase_4+0x3a>
 8049632:	83 c3 04             	add    $0x4,%ebx
 8049635:	39 f3                	cmp    %esi,%ebx

 8049639:	8b 43 04             	mov    0x4(%ebx),%eax // eax now is third element
 804963c:	03 03                	add    (%ebx),%eax // sum first and third elements, equals 8 + 0
 804963e:	39 43 08             	cmp    %eax,0x8(%ebx) 
 8049641:	74 ef                	je     8049632 <phase_4+0x33>
 8049643:	e8 e7 05 00 00       	call   8049c2f <explode_bomb>
 8049648:	eb e8                	jmp    8049632 <phase_4+0x33>
 804964a:	83 c4 24             	add    $0x24,%esp

 for this part: 

the first element at eps + 0x8 must be 5
the second element at eps + 0xc must be 8
[5,8...]
0x8 0xc 0x10 0x14 0x18 0x1c
 ebx is the first element at eps + 0x8
 esi is the fifth element at eps + 0x18
jump
 eax holds ebx + 0x4 or the second element
 after (%ebx),%eax, $eax holds the value of 5 + the second element
 $eax must now compare equal with the third value, $ebx + 0x8,

  add ebx, 0x4 means ebx now equals the second element
 the fifth element adresss must compare equal to ebx + 0x4 or the second element address
 so the fifth element must be 8
 [5,8,x,y,8,z]

 so since $eax must be 5 + 8 = 13, the third element has to be 13
 so the array looks like this

 [5,8,13,a,8,b]

 >>> x $eax
0xd:    Cannot access memory at address 0xd
>>> p $eax
$10 = 13
>>> x 0x8 + $ebx
0xffffc730:     0xd

8049639:	8b 43 04             	mov    0x4(%ebx),%eax
 804963c:	03 03                	add    (%ebx),%eax
 804963e:	39 43 08             	cmp    %eax,0x8(%ebx)

>>> x $esp + 0x8
0xffffc738:     0xffffc824
>>> x 0xffffc824
0xffffc824:     0xffffca2c

>>> x/s 0xffffca2c
0xffffca2c:     "/home/classes/cs323/class/wong.michael.mjw223/proj2/bomb58/bomb"

Phase 5:

Need two elements

>>> p/a 0x804b220 + 4 * $eax
$23 = 0x804b224
>>> x 0x804b224
0x804b224:      0x80496ce <phase_5+126>

eax must be less than or equal to 7
 8049673:	83 7c 24 0c 07       	cmpl   $0x7,0xc(%esp)
 8049678:	0f 87 81 00 00 00    	ja     80496ff <phase_5+0xaf>

>>> p/a 0x804b220 + 4 * $eax
$2 = 0x804b234
>>> p/a 0x804b220 + 4 * 5
$3 = 0x804b234

x 0x804b234
0x804b234:      0x80496ea <phase_5+154>

decide on a value of $eax that leads you to the right spot


80496b8:	83 7c 24 0c 05       	cmpl   $0x5,0xc(%esp)
 80496bd:	7f 06                	jg     80496c5 <phase_5+0x75> // we don't want it to jump
 80496bf:	39 44 24 08          	cmp    %eax,0x8(%esp) // compare $eax with second # in input
 80496c3:	74 05                	je     80496ca <phase_5+0x7a> // want to jump
 80496c5:	e8 65 05 00 00       	call   8049c2f <explode_bomb>
 80496ca:	83 c4 1c             	add    $0x1c,%esp
 80496cd:	c3                   	ret  

 phase 6:
 must be two numbers

  8049787:	83 7c 24 0c 0e       	cmpl   $0xe,0xc(%esp)
 804978c:	76 05                	jbe    8049793 <phase_6+0x2f>

 the first number must be equal or lower than 14

 after this line:

  8049793:	83 ec 04             	sub    $0x4,%esp

$esp + 0xc is the second elmeent
$esp + 0x10 is the first element

 8049796:	6a 0e                	push   $0xe //14
 8049798:	6a 00                	push   $0x0 // 0
 804979a:	ff 74 24 18          	pushl  0x18(%esp) // 1
 
 before any changes to esp

>>> x/a $esp
0xffffc720:     0x804ea10 <input_strings+400>

>>> x/a $esp + 0x8
0xffffc728:     0xffffc73c
>>> x/d 0xffffc73c
0xffffc73c:     1

>>> x/a $esp + 0xc
0xffffc72c:     0xffffc738
>>> x/d 0xffffc738
0xffffc738:     2

>>> x/a $esp + 0x10
0xffffc730:     0x804ea10 <input_strings+400>
x/s 0x804ea10
0x804ea10 <input_strings+400>:  "1 2"

then we add $0x10,%esp

now $esp is 
>>> x/a $esp
0xffffc730:     0x804ea10 <input_strings+400> 

>>> x/a $esp + 0x8
0xffffc738:     0x2
>>> x/a $esp + 0xc
0xffffc73c:     0x1

now we make more space on stack: sub $0x4, %esp

>>> x/a 0x18 + $esp
0xffffc748:     0x8049220 <_start>

after  
 8049796:	6a 0e                	push   $0xe
 8049798:	6a 00                	push   $0x0
 804979a:	ff 74 24 18          	pushl  0x18(%esp)
>>> x $esp
0xffffc720:     0x1
>>> x $esp + 0x4
0xffffc724:     0x0
>>> x $esp + 0x8
0xffffc728:     0xe

at $esp + 0xc
>>> x/a $esp + 0xc
0xffffc72c:     0xffffc738
>>> x/d 0xffffc738
0xffffc738:     2

>>> x/a $esp + 0x10
0xffffc730:     0x804ea10 <input_strings+400>


 80497a6:	83 f8 13             	cmp    $0x13,%eax
 // we need $eax to be equal to 19
 80497a9:	75 07                	jne    80497b2 <phase_6+0x4e>
 80497ab:	83 7c 24 08 13       	cmpl   $0x13,0x8(%esp)
 // and we need 0x8 + $esp to be equal to 19
  80497b0:	74 05                	je     80497b7 <phase_6+0x53>
 80497b2:	e8 78 04 00 00       	call   8049c2f <explode_bomb>
 80497b7:	83 c4 1c             	add    $0x1c,%esp
 80497ba:	c3                   	ret  

>>> x 0x8 + $esp
0xffffc738:     2

the second element needs to be 19

in case of 6, 19

arguments to func 6
 8049796:	6a 0e                	push   $0xe // 14
 8049798:	6a 00                	push   $0x0 // 0
 804979a:	ff 74 24 18          	pushl  0x18(%esp) // first element, 6

  0x0804970f  ? mov    0x10(%esp),%eax // first argument, 6
  x/d $esp + 0x14 // second argument, 0
 0x08049713  ? mov    0x18(%esp),%ecx // third argument, 14

6, 0, 14

second call:

6, 0, 6

6, 4, 6

6, 6, 6

Phase 7:

Must be a 6 character string

>>> x 0x1c + $esp
0xffffc750:     0x0804ea60
>>> x/s 0x0804ea60
0x804ea60 <input_strings+480>:  "777777"

 0x080497d3  ? add    $0x6,%ebx // accessing ebx[6] which is ""
 0x080497d6  ? mov    $0x0,%ecx // 
 0x080497db  ? movzbl (%eax),%edx

 movzbl  (%eax), %eax
movsbl  %al,%eax

 char fn(char * string, int index)
{
    return string[index];
}
Specifically, the movzbl instruction fetches the byte stored 
at the sum of the two parameters, zero pads it, and stores it into eax.


Win conditions:

cmp    %ebx,%eax // addresses ebx and eax are equal
cmp    $0x30,%ecx // address ecx = 0x30

ebx and eax have a difference of 6

as you loop through, ecx should get incremented by 8 six timees
to go from 0x0 to 0x30 in time (0 to 48)

there is a difference of 6 between $ebx and $eax addresses

 80497d3:	83 c3 06             	add    $0x6,%ebx


>>> x $ebx
0x804ea66 <input_strings+486>:  0x00000000
>>> x $eax
0x804ea60 <input_strings+480>:  0x37373737

0x30 / 0x6 = 48 / 6 = 8

we need to be adding 8 in this command

add    0x804b240(,%edx,4),%ecx
equivalent to
%ecx += [4*%edx + 0x804b240]

x 0x804b240 + 0x34
0x804b274 <array.0+52>: 8

0x34 = 52

52 / 4 = 13

>>> x 0x804b240 + 0x34
0x804b274 <array.0+52>: 0x00000008
>>> x 0x804b240 + 0xd * 4
0x804b274 <array.0+52>: 0x00000008

9 is 7
7 is 3
4 is 12
3 is 1
a is 10
b is 6

12 + 12 + 12 + 10 + 1 + 1
444a33

binary tree tips: 

every time you go down a left branch, that's a 0
every time you go down a right branch, that's a 1
you'll get a sequence of 0's and 1s. that is a binary number
you basically want the binary number to equal something that is determined
by your assembly. you need to find the correct number of left and rights
to make the right number.

you need to have a binary number such that the number you find
in that tree is equal to the number

b * 0x080497e1

can just do run mysolution.txt

0xffffc718:     0x7
>>> x/a $esp + 0x1c
0xffffc71c:     0x7
>>> x/a $esp + 0x20
0xffffc720:     0x7

phase 8:

>>> x 0x804e174
0x804e174 <node1>:      0x3cd // value of node: 973
>>> x 0x804e174 + 0x4
0x804e178 <node1+4>:    0x1 // value of 1
>>> x 0x804e174 + 0x8
0x804e17c <node1+8>:    0x804e180 <node2> // pointer to the next one
>>> x 0x804e174 + 0x12
0x804e186 <node2+6>:    0xe18c0000

// providing six numbers from 1-6, each node is from 1-6 and has an entry corresponding to it
// and they know which number they are
// each node has a value associated with it
// if each node has a key which has a value associated with it.

// it's probably getting the values, and it's probably doing some operation
// with those values, and figure that out and you can probably solve the phase.

// it also seems to be getting them in some order.

// it's doing them in order: you're fetching that ith nodes value

// make sure you're calling the right values in the right order


0x804e174 <node1>:      0x3cd // 973
>>> x/a 0x804e174 + 0x04
0x804e178 <node1+4>:    0x1
>>> x/a 0x804e174 + 0x08

>>> x/a 0x804e174 + 0x08
0x804e17c <node1+8>:    0x804e180 <node2>

0x804e180 <node2>:      0x18d
>>> p 0x18d
$14 = 397

0x804e18c <node3>:      0x3c4
>>> p 0x3c4
$15 = 964

0x804e198 <node4>:      0x343
>>> p 0x343
$16 = 835

>>> x/a 0x804e1a4
0x804e1a4 <node5>:      0x39b
>>> p 0x39b
$17 = 923

0x804e1b0 <node6>:      0xf7
>>> p 0xf7
$18 = 247

b *0x080498cf

6 2 4 5 3 1

phase 9:

binary tree tips: 

every time you go down a left branch, that's a 0
every time you go down a right branch, that's a 1
you'll get a sequence of 0's and 1s. that is a binary number
you basically want the binary number to equal something that is determined
by your assembly. you need to find the correct number of left and rights
to make the right number.

you need to have a binary number such that the number you find
in that tree is equal to the number

func 9 should return 7!
 8049964:	83 f8 07             	cmp    $0x7,%eax
 8049967:	75 0c                	jne    8049975 <phase_9+0x42>
 8049969:	83 c4 08             	add    $0x8,%esp
 804996c:	5b                   	pop    %ebx
 804996d:	c3                   	ret    

 1001

 b *0x804994c

 x 0x804e0c0
0x804e0c0 <n1>: 0x32

>>> x/a 0x804e0c0 + 0x4
0x804e0c4 <n1+4>:       0x804e0cc <n21>

>>> x/a 0x804e0c0 + 0x8
0x804e0c8 <n1+8>:       0x804e0d8 <n22>

0x804e0cc <n21>:        0x9
>>> x 0x804e0d8

>>> x 0x804e0cc + 0x4
0x804e0d0 <n21+4>:      0x804e0fc <n31>

>>> x 0x804e0fc
0x804e0fc <n31>:        0x7
