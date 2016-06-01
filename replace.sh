#!/bin/bash

echo "参数数量:"
echo $#
echo ${#*}
echo ${#@}
echo \n

for arg in "$*"
do
	echo $arg
done

for arg in "$@"
do
	echo $arg
done
#perl -w temps.pl
#-p 对目标文件的每一行进行查找和替换
#-e 整个程序接在命令的后面（命令行应用，perl独有的简单方式）
#-i 将替换的结果写回到文件
#perl -p -i -e 's/sysread/read/g' file
