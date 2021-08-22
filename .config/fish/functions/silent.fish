function silent
  sudo systemctl stop sshd
  sudo systemctl stop fail2ban
  sudo systemctl stop docker
end
