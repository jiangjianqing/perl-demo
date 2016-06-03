#!/usr/bin/perl -w 

print "Enter a temperature(e.g.,32F,100C):\n";
$input=<STDIN>;	#接收用户输入的一行文本
chomp($input);	#去掉$input末尾的换行

if($input =~ m/^([+-]?\d+(\.\d+)?)\s*([cf])$/i){
	#如果运行到此，则已经匹配，$1保存数值，$2保存小数点，$3保存C或者F
	$inputNum=$1;
	$type=$3;
	if($type=~ m/c/i){
		$celsius=$inputNum;
		$fahrenheit=($celsius*9/5)+32;
	}else{
		$fahrenheit=$inputNum;
		$celsius=($fahrenheit-32)*5/9;
	}
	#注意这里是printf
	printf "%.2f C is %.2f F\n",$celsius,$fahrenheit;
}else{
	#开始的表达式无法匹配，发出警报
	print "Expecting a number flowed by \"C\" or \"F\",\n";
	print "so i don't understand \"$input\".\n";
}
