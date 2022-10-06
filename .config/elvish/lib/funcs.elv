
fn virsh.rm { |domain| 
    sudo virsh snapshot-list --domain $domain --name | xargs virsh snapshot-delete --domain $domain
    sudo virsh undefine --remove-all-storage $domain
}

fn virsh.snapshot { |domain|
    virsh snapshot-create-as --domain $domain --name (date '+%Y%m%dT%H%M%S')
}

fn virsh.new { |VM|
    sudo virt-clone --original debian --name $VM --auto-clone
    sudo virt-customize -a /var/lib/libvirt/images/$VM.qcow2 --hostname $VM
}
