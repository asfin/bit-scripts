#!/usr/bin/perl
use 5.012;

my @exclude = ("43", "5", "107");
my @out = `sudo nmap -sn 10.10.10.0/24 | grep -i -B 2 -A 0 -P "^MAC.*B8:27:EB"`;
my @res = ();

for (@out) {
	my $ip = $1 if m/10.10.10.(\d+).*$/;
	push(@res, $ip) unless ($ip eq '' || $ip ~~ @exclude);
}

print("@res\n");
for my $ip (@res) {
	system("scp ./watch.sh .screenrc 10.10.10.$ip:");
	system("ssh 10.10.10.$ip chmod +x ~/watch.sh");
	system("xterm -e 'ssh -t 10.10.10.$ip -o StrictHostKeyChecking=no ~/watch.sh' &");
}