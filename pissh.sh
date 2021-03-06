#!/bin/sh
ssh -t -o StrictHostKeyChecking=no -o IdentityFile=~/.ssh/id_rsa_cg pi@10.10.10.$1 "\
perl -e '
  @res = \`sudo ifconfig eth0\`;
  for (@res) {
  	\$MAC = \$1 if m/HWaddr (.{17})/;
	\$IP = \$1 if m/addr:(.*?) /;
  }
  \$MAC = substr(\$MAC, -6);
  @ar = split(/\./, \$IP);
  \$IP = \$ar[-1];
  \$IP = \".\$IP\";
  print \"PS1=\\\"\$MAC->\$IP: \\\[\\\033[01;34m\\\] \\\w \\\$\\\[\\\033[00m\\\] \\\"\n\";
'>> .bashrc; bash; grep -v -P \"^PS1.*?->\" ~/.bashrc > .bashrc.ungr; mv .bashrc.ungr ~/.bashrc"
