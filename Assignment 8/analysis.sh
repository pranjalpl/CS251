#!/bin/bash

file1=$(<data.txt)

file2=$(<avg.txt)
count1=0
count2=0
count3=0
param=0
thread=0
var=0
en1=0
en2=0
>"error.txt"

for data in $file2
do 
	if [ $count1 -eq 0 ]
	then
		param=$data
		count1=$((count1+1))
		continue
	fi
	if [ $count1 -eq 1 ]
	then
		thread=$data
		count1=$((count1+1))
		continue
        fi
	for val in $file1
	do
		if [ $count2 -eq 0 ]
		then
			if [ $param -eq $val ]
			then
				en1=1
			fi
			count2=$((count2+1))
			continue
		fi
		if [ $count2 -eq 1 ]
		then
			if [ $thread -eq $val ]
			then
				en2=1
			fi
			count2=$((count2+1))
			continue
		fi
		if [ $en1 -eq 1 ]
		then
			if [ $en2 -eq 1 ]
			then
				temp=$((val-data))
				temp=$((temp*temp))
                		var=$((var+temp))
				count2=0
			fi
		fi
		en1=0
		en2=0
		count2=0
	done
	var=$((var/100))
	echo -e "$param $thread $var" >> "error.txt"
	count1=0
	var=0
done

