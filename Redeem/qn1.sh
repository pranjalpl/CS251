#!/bin/bash

input="$1"

makefolder="no"
makefile="no"
allocatemem="no"
counter=1

while IFS= read -r var
do

  if [[ $(echo $var | grep -o -P '(?<=<).*(?=>)') == "dir" ]] ; then 
  	makefolder="yes"
  	continue
  fi	

  if [[ $makefolder == "yes" ]] ; then
  	name=$(echo $var | grep -o -P '(?<=<name> ).*(?= </name>)')
  	mkdir "$name"
  	cd "$name"
  	makefolder="no"
  	continue
  fi

  if [[ $(echo $var | grep -o -P '(?<=<).*(?=>)') == "/dir" ]] ; then
  	cd ..
  fi	  

  if [[ $(echo $var | grep -o -P '(?<=<).*(?=>)') == "file" ]] ; then
  	makefile="yes"
  	continue
  fi	  	

  if [[ $makefile == "yes" ]] ; then
  	name=$(echo $var | grep -o -P '(?<=<name> ).*(?= </name>)')
  	truncate -s 8 "$name"
  	allocatemem="yes"
  	makefile="no"
  	continue
  fi

  if [[ $allocatemem == "yes" ]] ; then
  	size=$(echo $var | grep -o -P '(?<=<size> ).*(?= </size>)')
  	truncate -s "$size" "$name"
  	allocatemem="no"
  	continue
  fi

  if [[ $(echo $var | grep -o -P '(?<=<).*(?=>)') == "/file" ]] ; then
  	continue
  fi

done < "$input"