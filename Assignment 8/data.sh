#!/bin/bash

file1=$(<params.txt)

file2=$(<threads.txt)

> "data.txt"
>"avg.txt"
>"avg2.txt"
avg=0

for param in $file1
do
	for thread in $file2
	do
		for i in {1..100}
		do
			out=$(./app $param $thread 2>&1)
			var=$(echo $out | grep -o -P '(?<== ).*(?= m)')
			echo -e "$param $thread $var" >> "data.txt"
			avg=$((avg+var))
		done
		avg=$((avg/100))
		echo -e "$param $thread $avg" >> "avg.txt"
		avg=0
	done
done

for thread in $file2
do
	for param in $file1
	do
		for i in {1..100}
		do
			out=$(./app $param $thread 2>&1)
			var=$(echo $out | grep -o -P '(?<== ).*(?= m)')
			avg=$((avg+var))
		done
		avg=$((avg/100))
		echo -e "$param $thread $avg" >> "avg2.txt"
		avg=0
	done
done
