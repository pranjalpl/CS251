#!/bin/bash

function solve() {
	#1 directory
	str=0;cm=0;#string,comment
	if [ -d "$1" ] ; then
		while read fl;
		do
			if [[ "$fl" =~ .*.c.* ]] ; then
				arr=(`awk -f q1.awk "$fl"`)
				str=$((${arr[0]}+str));
				cm=$((${arr[1]}+cm));
			fi
		done< <(find "$1" -type f)
	else
		echo "invalid input";
		exit 1
	fi

	echo "String:"$str",Comments:"$cm;

	return;
}

solve $1