#!/usr/bin/perl -w
use strict;
use warnings;

use Cwd;

my $dir=getcwd; #获取当前pl所在目录，这样你可以将这个pl文件放在任意文件夹下运行以获得文件总数。


my $n = 0;
readsub($dir);
print "Found $n file(s)!\n";   #打印你发现的所有文件数目

exit;

sub readsub {
  my ($file_t) = @_;
  if (-f $file_t) {                      #如果是文件        

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
		   readsub("$file_t/$file_to_act"); 
	   }
     }
  }
}
