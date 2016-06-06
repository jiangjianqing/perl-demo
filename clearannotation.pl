#!/usr/bin/perl -w
use strict;
use warnings;

use 5.010;
#use Switch;	#Switch默认不包含在@inc中
use Cwd;

my $dir=getcwd; #获取当前pl所在目录，这样你可以将这个pl文件放在任意文件夹下运行以获得文件总数。

if(@ARGV>0){
	$dir=$ARGV[0];
	$dir=~ s/\/$//g;
}
my $n = 0;
readsubdir($dir);
print "Found $n file(s)!\n";   #打印你发现的所有文件数目

exit;

sub readsubdir {
  my ($file_t) = @_;	#获得当前传递进来的参数中
  if (-f $file_t) {                      #如果是文件        
	dispatchFile($file_t);
	$n++;                               #统计文件总数
  }
  if (-d $file_t) {                    #如果是子目录，打开目录读取文件数量
     opendir(AA,$file_t) || return;
     my @list = readdir(AA);
     closedir (AA);
     my $file_to_act;
     foreach $file_to_act (sort @list) {
       if ($file_to_act =~ /^\.|\.$/) { 
		   next; 
	   } else { 
		   readsubdir("$file_t/$file_to_act"); 
	   }
     }
  }
}

sub dispatchFile{
	my ($file)=@_;
	my $file_type;
	given($file){
		when(/\.pl$/i){ 
			$file_type="perl 文件";
		}
		when(/\.java$/i){
			$file_type="java文件";
			processJavaFile($file);
		}
		when(/\.xml$/i){
			$file_type="xml文件";
			processXmlFile($file);
		}
		default{ $file_type="unknow";}
	}
	print "$file:$file_type\n";
}

#处理java文件
sub processJavaFile{
	my ($file)=@_;
	if(open(FH,"$file")){
		local $/=undef;
		my $line=<FH>;
		#chomp($line);
		close(FH);
		
		$line =~ s/^\s*\/\/.*$//mg;
		$line =~ s/(?<!:)\/\/.*$//mg;	#如果前面是：，很有可能是url或者数据库配置字符串
		#这里需要注意//被括号包裹的特列
		$line =~ s/\/\*(?!\w*["]).*?\*\///gs;	#注意点：1、s代表dotall，不需要再加m;2、中间的匹配要用忽略优先量词
		$line =~ s/^\s*(^\s*$)++\s*$//gm;	#空白行清除
		#将处理结果写回文件
		if(open(FH,">$file")){
			print FH "$line\n";
			close(FH);
		}
	}else{
		print "open file error!";
	}
}

sub processXmlFile{
	my ($file)=@_;
	if(open(FH,"$file")){
		local $/=undef;
		my $line=<FH>;
		#chomp($line);
		close(FH);

		$line =~ s/<!--.*?-->//gs;	#注意点：1、s代表dotall，不需要再加m;2、中间的匹配要用忽略优先量词
		$line =~ s/^\s*(^\s*^)+\s*$//gm;
		
		if(open(FH,">$file")){
			print FH "$line\n";
			close(FH);
		}
	}else{
		print "open xml file error";
	}
}

