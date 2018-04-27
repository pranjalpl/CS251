#!/usr/bin/awk -f
BEGIN{RS="\f"}

{
	n=split($0,a,"");

	#comments
	for(i=1;i<=n;i++)if(a[i] ~ /"/){
		i++;
		while(i<=n&&a[i]!~/"/){
			#escaped char
			if(a[i]=="\n")break;
			else if(a[i]=="\\"){a[i]="-";a[i+1]="-";i++;}
			else a[i]="-";
			i++;
		}
	}

	#escaped char
	for(i=1;i<n;i++){
		if(i>1&&a[i]~/\\/&&a[i+1]=="\n")a[i+1]=a[i-1];
	}


	cnt=0;
	#multiline comments
	for (i=1;i<n;i++) {
		if(a[i]~/\//&&a[i+1]~/\*/){
			i=i+2;cnt++;
			while(i<n&&!(a[i]~/\*/&&a[i+1]~/\//)){
				if(a[i]~/[\r\n]/)cnt++;
				a[i]="?";i++;
			}
			if(i<n)a[i]="?";
			i++;
			if(i<n)a[i]="?";
		}
	}

	#single line comments
	for(i=1;i<n;i++){
		if(a[i]~/\//&&a[i+1]~/\//){
				cnt++;
				i+=2;
				while(a[i]!~/[\r\n]/){
					a[i]=".";i++;
				}
		}
	}

	#for(i=1;i<=n;i++)printf a[i];#debugging

	str=0;
	for(i=1;i<=n;i++)if(a[i] ~ /"/)str++;
	str=str/2;

	print str " " cnt;
}

END{}