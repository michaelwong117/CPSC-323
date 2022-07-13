

./ref_proj1 usertests/ex1.in 

./proj1 usertests/ex1.in 

valgrind --leak-check=full --show-leak-kinds=all 

valgrind --leak-check=full --show-leak-kinds=all ./proj1 usertests/ex1.in 

chmod -R 777 run_usertests.sh // need to run to use bash file
chmod -R 777 run_valgrind.sh 

./run_valgrind.sh > valgrind.txt

/c/cs323/proj1/run_tests.pl

/c/cs323/proj1/run_tests.pl 01 02 04

User Testing so far
// ex 1 to 9, bounds, comment, t1 and t5, run with no valgrind erros and match ref_proj1

// for (int i = 0; i < expandedVALUE->size; i++)
// {
//     if (expandedVALUE->data[i] == 'Q') printf("Q found!\n");
//     else printf("%c", expandedVALUE->data[i]);
// }
// printf("\n");

/**
 * \def{testMacro}{some text #}
 * \def{macroFragment}{goes #}
 * \testMacro{\macroFragment}{here}
**/

// macroNAME is testMacro
// macroVALUE is some text #
// customVALUE is \macroFragment


Turns out there is a way to run all these commands from a file.

Put all your gdb commands into a file

12345678910
file ./proj1
b 528
b 620
b 724
run tests/t01.in
display n
display list[0]
display list[1]
display list[2]
display list[3]
Run gdb like this gdb -x <command-file>

The official documentation can be found here. Hope this helps!