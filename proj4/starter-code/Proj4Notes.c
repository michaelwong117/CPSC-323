/c/cs323/proj4/run_tests.pl

/c/cs323/proj4/run_tests.pl 01 02 04

/c/cs323/proj4/tests/t01 | diff - /c/cs323/proj4/tests/t01.t

/c/cs323/proj4/tests/t01 | cat -vet

[mjw223@grizzly starter-code]$ make
gcc -c -o process.o process.c -std=c11 -Wall -pedantic -I.
gcc -c -o main.o main.c -std=c11 -Wall -pedantic -I.
gcc -o Bash process.o main.o parse.o -std=c11 -Wall -pedantic -I.
[mjw223@grizzly starter-code]$ ./Bash

ls -la

exit status: 0 is success 1 is failure

REFERENCE: /c/cs323/proj4/Bash

mkstemp: https://pubs.opengroup.org/onlinepubs/009604499/functions/mkstemp.html

valgrind --leak-check=full --show-leak-kinds=all ./Bash

DUMP_TREE=1 DUMP_LIST=1 ./Bash

DUMP_TREE=1 DUMP_LIST=1  /c/cs323/proj4/Bash

// prints out cmd tree and token list

Run with gdb: 


gdb --args ./Bash
set follow-fork-mode child
b process