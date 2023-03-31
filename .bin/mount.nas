#!/bin/sh

sudo mount -v -t nfs 192.168.0.10:/Public /mnt/nas2/ &
# sudo mount -v -t nfs 100.115.192.46:/volume1/root /mnt/nas
sudo mount -v -t nfs 192.168.0.9:/volume1/root /mnt/nas

# sudo mount -v -t nfs 192.168.0.10:/Public /mnt/nas2/ &
# sudo mount -v -t nfs 192.168.0.9:/volume1/root /mnt/nas
