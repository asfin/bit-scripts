#!/bin/sh

sudo nmap -sn --system-dns -R 10.10.10.0/24 | grep bot | perl -e 'while (<>) {print "$1\n" if /^.* \((.*)\)$/}' > bots.list
cat bots.list | xargs -I '{}' ssh -o StrictHostKeyChecking=no -i ../id_rsa_cg pi@{} sudo mount / -o remount,rw 
cat bots.list | xargs -I '{}' scp -i ../id_rsa_cg $1 pi@{}:
cat bots.list | xargs -I '{}' ssh -i ../id_rsa_cg pi@{} sudo ./$1
