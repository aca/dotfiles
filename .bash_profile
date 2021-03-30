[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
if [ -e /home/rok/.nix-profile/etc/profile.d/nix.sh ]; then . /home/rok/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ -e /Users/rok/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/rok/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
