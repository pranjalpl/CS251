#!/bin/bash

num_sentences () {
	local a=$(( `grep -o -n '[.?!]' $1 | wc -w` ))
	local b=$(( `grep -o -n '[0-9].[0-9]' $1 | wc -w` ))
	local c=$(( a-b ))
	echo -n $c
}

num_integers () {
	local a=$(( `grep -o -n '[0-9] ' $1 | wc -w` ))
	local b=$(( `grep -o -n '[0-9].' $1 | wc -w` ))
	local d=$(( `grep -o -n '[0-9]?' $1 | wc -w` ))
	local e=$(( `grep -o -n '[0-9]!' $1 | wc -w` ))
	local g=$(( `grep -o -n '[0-9]$' $1 | wc -w` ))
	local f=$(( `grep -o -n '[0-9].[0-9]' $1 | wc -w` ))
	local c=$(( a+b+d+e-3*f+g ))
	echo -n $c			
}

search_sentences () {
	local sum_subtree=0
	if [[ -d $1 ]]; then
		cd $1
		for i in $(ls -F | grep /); do
			local subdir=$(( $(search_sentences $i) ))
			sum_subtree=$(( sum_subtree+$(( `search_sentences $i` )) ))	
		done

		for i in $(ls -p | grep -v /); do
			 sum_subtree=$(( sum_subtree+$(( `num_sentences $i` )) ))
		done
	fi
	echo -n $sum_subtree
}

search_integers () {
	local sum_subtree=0
	if [[ -d $1 ]]; then
		cd $1
		for i in $(ls -F | grep /); do
			local subdir=$(( $(search_integers $i) ))
			sum_subtree=$(( sum_subtree+$(( `search_integers $i` )) ))	

		done
		for i in $(ls -p | grep -v /); do
			sum_subtree=$(( sum_subtree+$(( `num_integers $i` )) ))
		done
	fi
	echo -n $sum_subtree
}

main () {
	local depth=$1
	for i in $(ls -F | grep /); do
		for (( j=0; j<=$depth; j++ )); do
			echo -n "	"
		done
		echo -n "(D)"
		echo -n "$i"
		echo -n "-"
		echo -n $(search_sentences $i)
		echo -n "-"
		echo $(search_integers $i)
		cd $i
		main $(( depth+1 )) 
		cd ..
	done
	for i in $(ls -p | grep -v /); do
		for (( j=0; j<=$depth; j++ )); do
			echo -n "	"
		done
		echo -n "(F)"
		echo -n "$i"
		echo -n "-"
		echo -n $(num_sentences $i)
		echo -n "-"
		echo $(num_integers $i)
	done
}

read path1
cd $path1

main 0

ni=0
ns=0

for i in $(ls -F | grep /); do
	ns=$(( ns+`search_sentences $i` ))
done

for i in $(ls -p | grep -v /); do
	ns=$(( ns+`num_sentences $i` ))
done

for i in $(ls -F | grep /); do
	ni=$(( ni+`search_integers $i` ))
done

for i in $(ls -p | grep -v /); do
	ni=$(( ni+`num_integers $i` ))
done

name=`basename $path1`

echo -n "(D)"
echo -n $name
echo -n "-"
echo -n "$ns"
echo -n "-"
echo -n "$ni"