#!/usr/bin/awk -f
BEGIN{}
function mmax(val,cur){
	if(cur==0)return val;

	split(cur,c,":");
	split(val,v,":");
	if(c[1]*3600.0+c[2]*60+c[3]<v[1]*3600+v[2]*60+v[3])return val;
	else return cur;
}
function mmin(val,cur){
	if(cur==0)return val;

	split(cur,c,":");
	split(val,v,":");
	if(c[1]*3600.0+c[2]*60+c[3]>v[1]*3600+v[2]*60+v[3])return val;
	else return cur;
}

{
	#get a,b
	sub(":","",$5);
	split($5,a,".");
	$5=a[1]"."a[2]"."a[3]"."a[4]":"a[5];
	split($3,a,".");
	$3=a[1]"."a[2]"."a[3]"."a[4]":"a[5];

	#a-->b and b-->a
	i=$3"@"$5;
	j=$5"@"$3;

	#packets
	pc[i]++;

	#datapacket
	if($NF != 0)dp[i]++;

	#data
	dat[i]+=$NF;

	#min
	max[i]=mmax($1,max[i]);
	max[j]=mmax($1,max[j]);

	min[i]=mmin($1,min[i]);
	min[j]=mmin($1,min[j]);

	#retransmission
	if($8=="seq"&& $9~/:/){ #packet transferred

		split($9,pck,":");
		sub(",","",pck[2]);

		for(k=pck[1];k<pck[2];k++)
			if(dum[i"@"k]==1)ret[i]++;
			else dum[i"@"k]=1;
	}
}

END{
	for(i in pc)if(pc[i]!=0){
		split(i,a,"@");
		j=a[2]"@"a[1];
		
		split(max[i],x,":");
		split(min[i],y,":");

		diff=x[1]*3600+x[2]*60+x[3]-y[1]*3600-y[2]*60-y[3];

		print "Connection (A="a[1]" "a[2]")"
		#print "________________________________"

		#printf a[1]"-->"a[2]
		printf"A-->B "
		printf "#packets=%d,#datapackets=%d,#bytes=%d",pc[i],dp[i],dat[i];
		printf ",#retrans=%d,xput=%d bytes/sec\n",ret[i],(dat[i]-ret[i]+0)/(diff)

		#printf a[2]"-->"a[1]
		printf"B-->A "
		printf "#packets=%d,#datapackets=%d,#bytes%d",pc[j],dp[j],dat[j];
		printf ",#retrans=%d,xput=%d bytes/sec\n",ret[j],(dat[j]-ret[j]+0)/(diff)

		pc[j]=0;
	}
}