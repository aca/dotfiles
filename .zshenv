if [[ $(uname -s) = Darwin ]]; then
  # Override insanely low open file limits on macOS.
  ulimit -n 524288
  ulimit -u 2048
fi

if [ -e /home/rok/.nix-profile/etc/profile.d/nix.sh ]; then . /home/rok/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
