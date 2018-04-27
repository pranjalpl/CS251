#!/bin/bash

file=$(<avg.txt)

param=0

var1=0
var2=0
var3=0
var4=0
var5=0
count1=0
count2=0
>"speedup.txt"

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
		var2=$(echo "$var1/$var2" | bc -l )
		var3=$(echo "$var1/$var3" | bc -l )
		var4=$(echo "$var1/$var4" | bc -l )
		var5=$(echo "$var1/$var5" | bc -l )
		var1=$(echo "$var1/$var1" | bc -l )
		echo -e "$param $var1 $var2 $var3 $var4 $var5" >> "speedup.txt"
		count2=0
		continue						 
	fi
done

