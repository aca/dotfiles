function ansible.source -d 'ansible.source host'
  cd ~/src/github.com/aca/setup
  ansible-playbook source.yml -v -i "$argv[1]," --extra-vars "dir=$argv[2]" 
end
