#!/usr/bin/perl -w
use strict;
use warnings;

use 5.010;
#use Switch;	#Switch默认不包含在@inc中
use Cwd;

use Encode;
use utf8;

use JSON;
use Data::Dumper;

my $json=JSON->new->utf8;#new JSON;
sub processJsonFile{
	my ($file)=@_;
	if (open(FH,"$file")){
		local $/=undef;
		my $line=<FH>;
		close(FH);

		#方式1		
		#my $decoded_json=decode_json($line);
		
		#方式2
		my $decoded_json=$json->decode($line);
		print Dumper($decoded_json);

		print $decoded_json->{"data"};

		foreach my $key (keys %{$decoded_json}){
			print "$key\n"
		}

		print %$decoded_json{"name"}."\testeset";
		#print %{$decoded_json}{"name"}."\testeset";

		#print $line;
	}
}
processJsonFile("./uicomponent/component1/info.json");
