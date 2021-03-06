#!/usr/bin/perl -w
use strict;

#引入外部文件中的正则表达式定义
require "./perl_lib/regex_lib.pl";

#修改$/将会改变行尾的判断符号
#$/=".\n";	#设定特殊的块模式（chunk-mode），一块文本的终结为点号和换行符的开始

#没有给变量赋值的<>作为while的条件使用时，它能够把字符串的内容赋给一个特殊的默认变量,该变量保存了s\\\x和print作用的默认字符串。这样写可以减少冗余代码
my $lineNumber=0;
while(<>){
	$lineNumber++;

#	如果没有任何替换，next unless会导致perl中断处理当前字符串(转而开始下一个字符串)
	#next unless s\\\x;
	#s/^(?:[^\e]*\n)+//mg;	#去掉所有未标记的行
	s/^/$ARGV:($lineNumber) /mg;			#在每行开头加上文件名
	print;
	#注意这里输出的内容，lineNumber是根据$/作为行尾判断的
}

#undef $/;	#进入文件读取模式
#$text =<>;	#读入命令行中指定的第一个文件名
#\e表示ASCII的转义字符，\e[7m用于标注高亮的开始，\e[m用于标注高亮的结束
