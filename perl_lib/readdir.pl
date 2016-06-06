#!/usr/bin/perl -w
package file;
use strict;
use warnings;
my $n;
sub readsubdir {
  my ($file_t) = @_;
  if (-f $file_t) {                      #如果是文件        
	print "$file_t:\n";
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
