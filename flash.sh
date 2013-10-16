#!/bin/sh

dd if=/home/user/pi_ro_sd.img of=/dev/sd$1 bs=1M count=2048 oflag=sync
sudo mount /dev/sd$12 /mnt/piflash$1
sudo sh -c "echo $2 > /mnt/piflash$1/etc/hostname"
sudo umount /mnt/piflash$1
