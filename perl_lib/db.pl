#!/usr/bin/perl -w
package db;
use strict;
use warnings;
use DBI;

#测试
#my $str="insert into uicomponenttype(name) values('perl-defjlksdjsldkf')";
#executeSql($str);

sub readSql(){

	my $dbh=DBI->connect("DBI:mysql:database=test;host=localhost","root","",
	{RaiseError => 1,AutoCommit => 0}) || die "Database connection not made: $DBI::errstr";

	my $sql = qq{ SELECT * FROM uicomponent };
	my $sth = $dbh->prepare( $sql );
	$sth->execute();

	my( $id,$name);
	$sth->bind_columns( undef, \$id, \$name,undef,undef);
	while( $sth->fetch() ) {
		print "$id,$name\n";
	}
	$sth->finish();

	$dbh->disconnect();
}

sub executeSql(){
	my ($sql)=@_;
	my $dbh=DBI->connect("DBI:mysql:database=test;host=localhost;port=3306","root","",{RaiseError => 1,AutoCommit => 1}) || die "Database connection not made:     $DBI::errstr"; 
	$dbh->do("SET NAMES utf8");  #重要：在select和insert之前先设置一下编码，防止mysql设置正确，但客户端却插入了乱码
	# execute INSERT query
	#my $sql="INSERT INTO uicomponenttype (name) VALUES ( 'eygle'    )";
	my $rows = $dbh->do($sql);
	print "$rows row(s) affected ";

	$dbh->disconnect();
}

sub quote(){
	my ($string)=@_;
	my $dbh=DBI->connect("DBI:mysql:database=test;host=localhost","root","",{RaiseError => 1,AutoCommit => 1}) || die "Database connection not made:     $DBI::errstr"; 

	my $ret=$dbh->quote($string);

	$dbh->disconnect();
	return $ret;
}

1;

