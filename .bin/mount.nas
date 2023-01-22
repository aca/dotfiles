#!/bin/sh

sudo mount -v -t nfs 192.168.0.205:/Public /mnt/nas2/ &
sudo mount -v -t nfs 192.168.0.203:/volume1/root /mnt/nas
