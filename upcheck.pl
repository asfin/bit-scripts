#!/usr/bin/perl

$net = '10.10.10.0/24';
$filename = 'new.scan';

`mv $filename.new $filename.old`;
`nmap -sV -p 22 -oG $filename.new.1 $net`;
`cat $filename.new.1 | grep '22/open' | awk '{print \$2, \$5}' > $filename.new`;
#`rm $filename.new.1`;
print `colordiff -y --suppress-common-lines $filename.old $filename.new`;
