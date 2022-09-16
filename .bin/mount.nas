#!/bin/sh

sudo mount -v -t nfs 192.168.0.31:/Public /mnt/nas2/ &
sudo mount -v -t nfs 192.168.0.20:/volume1/root /mnt/nas
