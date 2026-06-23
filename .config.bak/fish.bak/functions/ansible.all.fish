function ansible.all -d 'ansible.dev host'
  cd ~/src/github.com/aca/setup
  echo "ansible-playbook all.yml -v -i \"$argv[1],\""
  ansible-playbook all.yml -v -i "$argv[1],"
end
