#!/bin/bash

read number

if [ "$number" -eq "$number" ] 2>/dev/null; then
	  echo 
else
	  echo Not a Number
	  exit
fi

new=$(echo $number | sed 's/^0*//')

if [ $number -eq 0 ]
then
	echo zero
	exit
fi

newn=$(printf "%.11d" "$new")

on=('' one two three four five six seven eight nine) 
ten=(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
tens=(zero ten twenty thirty forty fifty sixty seventy eighty ninety)
hun=hundred 
tho=thousand 
lc=lakh 
cr=crore

if [ ${newn:0:1} -eq 0 ]
then
	echo -ne
else
	echo -ne ${on[${newn:0:1}]} $tho\   
fi

if [ ${newn:1:1} -eq 0 ]
then
	echo -ne
else
	echo -ne ${on[${newn:1:1}]} $hun\ 
fi

if [ ${newn:2:1} -eq 0 ]
then
	if [ ${newn:3:1} -eq 0 ]
	then
		echo -ne
	else 
		echo -ne ${on[${newn:3:1}]} 
	fi
elif [ ${newn:2:1} -eq 1 ]
then
	echo -ne ${ten[${newn:3:1}]} 
else
	echo -ne ${tens[${newn:2:1}]} ${on[${newn:3:1}]}
fi


if [ ${newn:0:1} -ne 0 ] || [ ${newn:1:1} -ne 0 ] || [ ${newn:2:1} -ne 0 ] || [ ${newn:3:1} -ne 0 ]
then
	echo -ne ' '$cr' '
fi

if [ ${newn:4:1} -eq 0 ]
then
	if [ ${newn:5:1} -eq 0 ]
	then
		echo -ne
	else 
		echo -ne ${on[${newn:5:1}]} 
	fi
elif [ ${newn:4:1} -eq 1 ]
then
	echo -ne ${ten[${newn:5:1}]} 
else
	echo -ne ${tens[${newn:4:1}]} ${on[${newn:5:1}]}
fi

if [ ${newn:4:1} -ne 0 ] || [ ${newn:5:1} -ne 0 ]
then
	echo -ne ' '$lc' '
fi

if [ ${newn:6:1} -eq 0 ]
then
	if [ ${newn:7:1} -eq 0 ]
	then
		echo -ne
	else 
		echo -ne ${on[${newn:7:1}]} 
	fi
elif [ ${newn:6:1} -eq 1 ]
then
	echo -ne ${ten[${newn:7:1}]} 
else
	echo -ne ${tens[${newn:6:1}]} ${on[${newn:7:1}]}
fi

if [ ${newn:6:1} -ne 0 ] || [ ${newn:7:1} -ne 0 ]
then
	echo -ne ' '$tho' '
fi

if [ ${newn:8:1} -eq 0 ]
then
	echo -ne
else
	echo -ne ${on[${newn:8:1}]} $hun\ 
fi

if [ ${newn:9:1} -eq 0 ]
then
	if [ ${newn:10:1} -eq 0 ]
	then
		echo -ne
	else 
		echo -ne ${on[${newn:10:1}]} 
	fi
elif [ ${newn:9:1} -eq 1 ]
then
	echo -ne ${ten[${newn:10:1}]} 
else
	echo -ne ${tens[${newn:9:1}]} ${on[${newn:10:1}]}
fi
