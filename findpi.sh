#!/bin/sh

sudo nmap -sn 10.10.10.0/24 | grep -i -B 2 -A 0 -P "^MAC.*:$1"
