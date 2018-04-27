#!/usr/bin/python

import sys 

nb = sys.argv[1]
b = sys.argv[2]

num1 = 0
num2 = 0

#check for invalid input
for i in range (1,len(nb)-1):
	if(((nb[i] >= 'A') and (nb[i] <= 'Z')) or ((nb[i] >= '0') and (nb[i] <= '9')) or (nb[i] == '.')):
		continue
	else:
		print('"Invalid Input"')
		sys.exit()
		
dotcount = 0
minuscount = 0

#count number of . and -
for i in range (0,len(nb)-1):
    if(nb[i] == '.'):
        dotcount = dotcount + 1
    if(nb[i] == '-'):
        minuscount = minuscount + 1

if((dotcount > 1) or (minuscount > 1)):
    print("Invalid Input")
    sys.exit()


#check if string has a '.'
checkdot = 0
for i in range (0,len(nb)-1):
    if(nb[i] == '.'):
        checkdot = 1
        break

#add '.' if it doesn't
if(checkdot == 0):
    nb = nb+'.'

#check if number is negative
if(nb[0] == '-'):
	j = 1
else:
	j = 0

#create dictionary for getting integer base
dict = {'0':0,'1':1,'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9,'10':10,'11':11,'12':12,'13':13,'14':14,
            '15':15,'16':16,'17':17,'18':18,'19':19,'20':20,'21':21,'22':22,'23':23,'24':24,'25':25,'26':26,'27': 27,
                '28':28,'29':29,'30':30,'31':31,'32':32,'33':33,'34':34,'35':35,'36':36}

base = dict[b]

#create dictionary for getting integer digits
dict = {'0':0,'1':1,'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9,'A':10,'B':11,'C':12,'D':13,'E':14,
            'F':15,'G':16,'H':17,'I':18,'J':19,'K':20,'L':21,'M':22,'N':23,'O':24,'P':25,'Q':26,'R': 27,
                'S':28,'T':29,'U':30,'V':31,'W':32,'X':33,'Y':34,'Z':35}

#check for invalid input
for i in range (j,len(nb)-1):
    if(nb[i] != '.'):
        if(dict[nb[i]] >= base):
            print('"Invalid Input"')
            sys.exit()
        else:
            continue

#loops
for i in range (j,len(nb)-1):
    if(nb[i] != '.'):
        num1 = num1*base + dict[nb[i]]
    else:
        break

for i in range (0,len(nb)-1):
    if(nb[-(i+1)] != '.'):
        num2 = num2/base + dict[nb[-(i+1)]]/base
    else:
        break
   
#make final number
if(j == 0):
    nd = num1+num2
if(j == 1):
    nd = (-1)*(num1+num2)

#print
print(nd)

