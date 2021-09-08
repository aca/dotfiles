#!/usr/bin/env bash

if [ -z "$1" ] ;
then
 echo Specify a virtual-machine name.
 exit 1
fi

sudo virt-install \
  --name $1 \
  --ram 4096 \
  --disk path=/var/lib/libvirt/images/$1.img,size=30 \
  --vcpus 2 \
  --os-type linux \
  --os-variant ubuntu20.04 \
  --network default \
  --graphics none \
  --console pty,target_type=serial \
  --cdrom '/home/rok/Downloads/ubuntu-20.04.3-live-server-amd64.iso' 

  # --extra-args 'console=ttyS0,115200n8 serial'


  # --network bridge:br0,model=virtio \
  # --location 'http://gb.archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
# http://gb.archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/


# Running text console command: virsh --connect qemu:///system console k8s-master-1
