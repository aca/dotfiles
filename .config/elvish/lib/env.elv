use platform
var platform_os = $platform:os

# set-env SHELL "/bin/sh"

if (not (has-env HOSTNAME)) { set-env HOSTNAME (platform:hostname &strip-domain=$false) }

# this should be set by terminal emulator(e.g. alacritty) or tmux
# xterm-color is for SSH session
if (not (has-env TERM)) { set-env TERM xterm-color }

if (eq $E:HOSTNAME "rok-txxx-nix") {
    set-env DISPLAY ":0"
}

if (not (has-env VIM_OSC52_ENABLE)) {
    if ?(pgrep qemu-ga >/dev/null) {
        set-env VIM_OSC52_ENABLE 0 
    }
}


if (not (has-env IN_NIX_SHELL)) {
    set paths = [
      # clean up this mess
      # ~/src/github.com/golang/go/bin
      ~/bin/git
      ~/bin/dev
      ~/bin/lib
      ~/bin/v
      ~/bin/installations
      ~/bin/abbr
      ~/bin/$platform:os
      ~/bin/host_$E:HOSTNAME
      ~/src/xxx/bin
      # ~/.cargo/bin

      $@paths

      # nix
      /etc/profiles/per-user/$E:USER/bin
    ]
}
