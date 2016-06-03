#!/usr/bin/perl -w 
use strict;
#use DBI;
#use Encode;
#$re = Encode::decode('GB2312', '中国');
#$in = Encode::decode('GB2312', $ARGV[0]);

#if( $in =~/.*$re.*/ ) {
#   print $ARGV[0], "\n";
#}

#引入外部文件中的正则表达式定义
require "./perl_lib/regex_lib.pl";

#$/=".\n";	#设定特殊的块模式（chunk-mode），一块文本的终结为点号和换行符的开始

#没有给变量赋值的<>作为while的条件使用时，它能够把字符串的内容赋给一个特殊的默认变量,该变量保存了s\\\x和print作用的默认字符串。这样写可以减少冗余代码
#while(<>){
#	如果没有任何替换，next unless会导致perl中断处理当前字符串(转而开始下一个字符串)
#	next unless s\\\x;
#	pirnt;
#s/^(?:[^\e]*\n)+//mg;	#去掉所有未标记的行
#s/^/$ARGV:/mg;			#在每行开头加上文件名
#}

#undef $/;	#进入文件读取模式
#$text =<>;	#读入命令行中指定的第一个文件名
#\e表示ASCII的转义字符，\e[7m用于标注高亮的开始，\e[m用于标注高亮的结束
#s{}{\e[7m$1\e[m$2\e[7m$3\e[m}gix

#列表变量出现在标量环境中,就传回列表的长度
my $argCount=@ARGV;
print @ARGV;

print "\n$argCount\n";
#print "$ARGV[1]\n";
my $regex_test;
if ($argCount>=2){
	$regex_test=$ARGV[1];
	print "$regex_test\n";
}
my $lineNumber=0;
my $line;
while($line=<>){
	$lineNumber++;	#设定行编号

	#if($line =~ m/^\s*$/){ #匹配空行
	#	last; #停止while循环内的处理，跳出循环
	#}
	
	#$line =~ s/\b(\d{3,})\b/\e[7m$1\e[m/gix;
	if(defined $regex_test){
		$line =~ s/$regex_test/\e[7m$1\e[m/gix;

		next unless ($line =~ m/\e/);	#去掉所有未标记的行
	}
	#####打印结果区####
	#print "$ARGV($lineNumber):$line";
	printf "%s(%.4d)",$ARGV,$lineNumber;
	print $line;
	if(not defined($line)){	#如果##变量没定义，则退出程序
		die "couldn't glean the required information!";
	}
}
