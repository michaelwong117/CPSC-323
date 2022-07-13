#!/bin/bash
FILES="/home/accts/mjw223/cs323/proj1/usertests/*"
echo "###########################################################################################
######################################################################################################
######################################################################################################
######################################################################################################
                        STARTING TESTING            
######################################################################################################
######################################################################################################
######################################################################################################
"
for f in $FILES
do
  echo "Test Case $f
  "
  # take action on each file. $f store current file name
  echo "PROJ1 OUTPUT-----------------------------------------"
  ./proj1 $f
  echo "
  "
  echo "REFERENCE OUTPUT---------------------------------------"
  ./ref_proj1 $f
  echo "
  "
  
  echo "RESULT-------------------------------------------------"


  output="$(diff <(./proj1 $f) <(./ref_proj1 $f))"
  echo $output

  echo "-------------------------------------------------------"
  echo "
  "
done