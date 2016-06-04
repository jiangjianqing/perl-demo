#!/usr/bin/perl -w
use strict;
die "Usage: $0 <dir> <extion>\n" unless @ARGV == 2;
my $Dir = $ARGV[0] ;
my $Ext = $ARGV[1] ;
opendir(DH, "$Dir") or die "Can't open: $!\n" ;
#读取指定文件夹下面的指定扩展名的文件名，保存到数组里。
my @list = grep {/$Ext$/ && -f "$Dir/$_" } readdir(DH) ;
closedir(DH) ;
chdir($Dir) or die "Can't cd dir: $!\n" ;
foreach my $file (@list){
	open(FH, "$file") or die "Can't open: $!\n" ;
	print "$file:\n" ;
	while(<FH>){
		print ;
	}
	print "\n";
	close(FH) ;
}
