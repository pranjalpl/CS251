#!/bin/bash

file=$(<error.txt)

param=0

var1=0
var2=0
var3=0
var4=0
var5=0
count1=0
count2=0
>"error.txt"

for data in $file 
do
	if [ $count1 -eq 0 ]
	then
		param=$data
		count1=$((count1+1))
		continue
	fi
	if [ $count1 -eq 1 ]
	then
		count1=$((count1+1))
		continue
	fi
	count1=0
	if [ $count2 -eq 0 ]
	then
		var1=$data
		count2=$((count2+1))
		continue
	fi
	if [ $count2 -eq 1 ]
        then
                var2=$data
		count2=$((count2+1))	
		continue						 
	fi
	if [ $count2 -eq 2 ]
        then
                var3=$data
		count2=$((count2+1))
		continue							 
	fi
	if [ $count2 -eq 3 ]
        then
                var4=$data
		count2=$((count2+1))							 
		continue
	fi
	if [ $count2 -eq 4 ]
        then
                var5=$data	
		echo -e "$param $var1 $var2 $var3 $var4 $var5" >> "error.txt"
		count2=0
		continue						 
	fi
done

