#undef $/;	#进入文件读取模式
#$text =<>;	#读入命令行中指定的第一个文件名

$HostnameRegex = qr/[-a-z0-9]+(\.[-a-z0-9]+)*\.(com|edu|net|cn)/i;
#这里qr表示将regex声明为regex object，可以在其他regex中引用
#这是构成正则库的非常重要的一条
$EmailRegex = qr/
	\b
	(	#$1
		\w[.\w]*	#username
		\@	# @在perl中是数组引用，所以要转义（$是变量引用，也需要转义）
		$HostnameRegex	#hostname 注意$2在里面
	)
	\b/ix;
$EmptyLineRegex=qr/^\s*$/x;

#test  samples	
#$text="cz_jjq\@163.com";
#$text =~ s/$EmailRegex/<a href="mailto:$1">$1<\/a>/igx;
#print "修改后的邮箱地址为：$text \n";
#exit;

