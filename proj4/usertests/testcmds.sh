Run all simultaneously with /c/cs323/proj4/Bash

echo hi > log.txt
echo hi >> log.txt
# hi hi

cat << END
some input
hi
hello
END

cat < log.txt
# some input
# hi
# hello

echo hi | cat
# hi
echo hi | cat | wc
# 1       1     3

true && echo hi 
# hi

false && echo hi
# no output

true || echo hi
# no output

false || echo hi
# hi

false ; echo hi
# hi

true ; echo hi
# hi

sleep 1
# hangs for 1 second

sleep 4 & 

# background process 

(sleep 4 ; echo hi)

# after 4 seconds echo hi

printenv ?

# print exit status of prev command

MY_VAR=1 printenv MY_VAR

# prints 1

pushd #new directory
# prints new directory and old

popd 
# can return to where you were before pushd

sleep 4
# control c doesn't exit bash during sleep, just exits sleep

cat -n > numbered.txt << HERE
SOME TEST
HERE

cat -n > answer.txt < log.txt

echo purr | cat -n
// 1 purr

true && false || false && false
printenv ?
#1

true && echo hi || true && echo hello
#hi
#hello

true && echo hi || echo test && echo hello
#hi
#hello

var=1 (echo hi) 
#look at DUMPTREE

var=1 (echo hi ; echo wow) & 
# just backgrounded the whole command
# echo hi
# echo wow
# wait for next command

var=1 (echo hi && printenv var)
#subcmd
#hi
#1

(sleep 1 | false | sleep 2 | sleep 1) || echo NOT PARALLEL

echo hi ; sleep 2 &
# CMD (Depth = 2):  SIMPLE,  argv[0] = echo,  argv[1] = hi
# CMD (Depth = 1):  SEP_END
# CMD (Depth = 2):  SIMPLE,  argv[0] = sleep,  argv[1] = 2
# CMD (Depth = 0):  SEP_BG

#hi 
#Backgrounded: 310199


sleep 2 &
# CMD (Depth = 1):  SIMPLE,  argv[0] = sleep,  argv[1] = 2
# CMD (Depth = 0):  SEP_BG

#Backgrounded: 310800
#Completed: 310199 (0)

echo a & echo b & sleep 1
# CMD (Depth = 2):  SIMPLE,  argv[0] = echo,  argv[1] = a
# CMD (Depth = 1):  SEP_BG
# CMD (Depth = 2):  SIMPLE,  argv[0] = echo,  argv[1] = b
# CMD (Depth = 0):  SEP_BG
# CMD (Depth = 1):  SIMPLE,  argv[0] = sleep,  argv[1] = 1

#Backgrounded: 312155
#Backgrounded: 312157

sleep 1 ; sleep 10 & sleep 1
# should sleep 1 second

sleep 10 & sleep 10 & sleep 1
# should sleep 1 second

sleep 3 &
# should not sleep


VAR1=10 VAR2=20 (printenv VAR2 ; printenv VAR1)
# 20
# 10

pushd / 

pushd /home/accts/mjw223 > output.txt
# didn't change directory
cat output.txt
# /home/accts/mjw223
pwd
#home

#SECOND COMPLEX CASE
pushd / 
#/ /home/classes/cs323/class/wong.michael.mjw223/proj4/starter-code
pwd
#/
pushd /home/accts/mjw223 > output.txt
#Bad Open: Permission denied
popd > output.txt
#Bad Open: Permission denied
cd /home/accts/mjw223/cs323/proj4/starter-code
popd > output.txt ; cat output.txt
#/home/classes/cs323/class/wong.michael.mjw223/proj4/starter-code

pushd /home/accts/mjw223 > /boot/delete.me
# permission denied
# still didn't change directories

(cat) < log.txt
# hi
# hi
# hi
# shouldn't return (2)$ (2)$


VAR1=10 VAR2=20 (printenv VAR2 ; printenv VAR1) < log.txt > output.txt
cat output.txt

echo hi | (echo nice && echo fun) | cat
# nice
# fun

VAR=17 (printenv VAR | cat -n)
    #  1	17

echo hello && VAR=17 (printenv VAR | cat -n) || echo test
# hello
#      1	17


(echo A &) &

#issue!
# resolved! epic
# two backgrounds, upon last command one complete
# Backgrounded: 2579041
# (2)$ Backgrounded: 2579042
# A
# sleep 1
# Completed: 2579041 (0)

(sleep 1 ; sleep 1 &)

pushd debugging

ls & cd .. & ls

(echo hi ; sleep 5) & echo hello ; (echo alloy ; sleep 10) & sleep 1

(wow ; echo hi) & echo hello
# should echo hi and hello

(false && echo hi) & sleep 1
# should not echo hi

echo "da da da" | /usr/bin/fmt -2
pstree mjw223 -p ; sleep 1 & pstree mjw223 -p; (sleep 0.5; pstree mjw223 -p; sleep 2)
wow ; sleep 1 & wow ;
ps ; sleep 1 && true & ps ;
(echo A &) &
pstree mjw223 -p ; sleep 1.4 & sleep 1.3 & sleep 1.2 & true ; sleep 1 ; pstree mjw223 -p
echo "da da da" | sleep 4 &
echo "da da da" | (sleep 3 ; cat) &


echo "a" ; echo "b" ; (sleep 3 ; echo "d") & echo "c"
(sleep 2 ; each "b") & (sleep 1 ; echo "a") & (sleep 3 ; echo "c") & ((sleep 4 ; echo "d") &)
(sleep 2 ; echo "c") & (sleep 1 ; echo "b") & (sleep 3 ; echo "d") & ((sleep 4 ; (sleep 1 ; echo "f"); echo "e") &) & echo "g" ; echo "h"
sleep 1 | sleep 2 | sleep 1 | sleep 1 | sleep 1 | sleep 1 | sleep 1
sleep 10 # then ctrl c x2
sleep 1 && sleep 1; sleep 2

echo "Hi" > example.txt
ls -la


pushd debugging > output.txt

cd > a1.txt
cd cs323/proj4/starter-code > b1.txt
pushd debugging > c1.txt
popd > d1.txt
cd > a2.txt
cd cs323/proj4/starter-code > b2.txt
pushd debugging > c2.txt
popd > d2.txt
diff a1.txt a2.txt
diff b1.txt b2.txt
diff c1.txt c2.txt
diff d1.txt d2.txt

cd /
pushd /home/classes/cs323/class/wong.michael.mjw223/proj4/starter-code > output.txt
# Permission denied
pwd
#/
popd
#stack directory is empty: No child processes

cd /
pushd /home/classes/cs323/class/wong.michael.mjw223/proj4/starter-code > output.txt
# Permission denied
pwd
#/
popd > output.txt
#stack directory is empty: No child processes


