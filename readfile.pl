#undef $/;	#进入文件读取模式
#$text =<>;	#读入命令行中指定的第一个文件名

#$HostnameRegex=;

while($line=<>){
	if($line =~ m/^\s*$/){
		last; #停止while循环内的处理，跳出循环
	}

	print $line;
	if(not defined($line)){	#如果##变量没定义，则退出程序
		die "couldn't glean the required information!";
	}
}
