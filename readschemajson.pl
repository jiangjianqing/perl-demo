#!/usr/bin/perl -w
use strict;
use warnings;

use 5.010;
#use Switch;	#Switch默认不包含在@inc中
use Cwd;

use Encode;
use utf8;
#use open ':std', ':encoding(UTF-8)';	#让屏幕上可以正确输出中文(quotemeta处理的结果就需要配置该参数)

require "./perl_lib/db.pl";

my $dir=getcwd; #获取当前pl所在目录，这样你可以将这个pl文件放在任意文件夹下运行以获得文件总数。

#清空一下uicomponent数据表
db::executeSql("delete from uicomponent");

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
			#processJavaFile($file);
		}
		when(/\.xml$/i){
			$file_type="xml文件";
			#processXmlFile($file);
		}
		when(/\.json$/i){
			$file_type="json文件";
			processSchemaJsonFile($file);
		}		
		default{ $file_type="unknow";}
	}
	print "$file:$file_type\n";
}


sub processSchemaJsonFile(){
	my ($file)=@_;
	my $filename=$file;
	$filename =~ s/^(.+)\/(\w+)\.json$/$2/igx;
	#my $sqlstr="insert into uicomponent(name,uicomponenttype_id) values('$filename',1) \n";
	#db::executeSql($sqlstr);

	if(open(FH,"$file")){
		local $/=undef;
		my $line=<FH>;
		close(FH);
		
		$line=db::quote($line);
		#$line=quotemeta($line);#quotemeta将中文处理成了乱码
		print "\n$line\n\n";
		my $sqlstr="insert into uicomponent(name,uicomponenttype_id,componentContent) values('$filename',1,$line) \n";
		db::executeSql($sqlstr);

		#if(open(FH,">>test.sql")){
		#	$line=quotemeta($line);
		#	print FH "$line\n\n\n";
		#	close(FH);
		#}
	
	}else{
		print "open file error!";
	}
}

