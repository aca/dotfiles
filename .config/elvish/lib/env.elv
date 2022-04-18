use platform

# if (and (has-env WEZTERM_PANE) (not (has-env NVIM_LISTEN_ADDRESS))) {
#   set E:NVIM_LISTEN_ADDRESS = "/tmp/nvim"$E:WEZTERM_PANE
# }

if (eq $E:_ELVISH_ENV "") {
    set E:_ELVISH_ENV = 1

    # this should be set by terminal emulator(e.g. alacritty) or tmux
    if (not (has-env TERM )) {
      set-env TERM xterm-color
    }

    set E:PYTHONSTARTUP = ~/.bin/pythonstartup

    if (eq $E:HOSTNAME "rok-te3") {
      set E:LIBVIRT_DEFAULT_URI = "qemu:///system"
      set E:VIRSH_DEFAULT_CONNECT_URI = "qemu:///system"
    } else {
      set E:LIBVIRT_DEFAULT_URI = "qemu+ssh://rok@aca/system"
      set E:VIRSH_DEFAULT_CONNECT_URI = "qemu+ssh://rok@aca/system"
    }

    set E:XDG_CONFIG_HOME = $E:HOME/.config

    # vivid generate molokai
    # set E:LS_COLORS = ''

    # set E:EXA_COLORS = ""
    set E:EXA_ICON_SPACING = 2

    set E:GKSwstype = "iterm"
    set E:MPLBACKEND = "module://itermplot"
    set E:SHELL = "/bin/sh"

    # todo: deprecate
    set E:_uname = $platform:os

    if (eq $platform:os "linux") {
      set E:GTK_IM_MODULE = "fcitx"
      set E:QT_IM_MODULE = "fcitx"
      set E:XMODIFIERS = "@im=fcitx"
    }

    set E:ASDF_DIR = $E:HOME/.asdf
    set E:GHQ_ROOT = $E:HOME/src
    set E:MANPAGER = 'nvim +Man!'
    set E:MANWIDTH = '88'

    set E:RIPGREP_CONFIG_PATH = $E:HOME/.ripgreprc
    set E:BROWSER = google-chrome
    set E:COLORTERM = truecolor
    set E:EDITOR = nvim
    set E:VISUAL = nvim
    set E:GOPATH = $E:HOME
    set E:GOPROXY = direct

    # node
    # set E:NODE_OPTIONS = "--experimental-fetch --experimental-top-level-await --experimental-modules --no-warnings"
    set E:NPM_CONFIG_GLOBALCONFIG = $E:HOME/.npmrc.global

    set E:LANG = en_US.UTF-8
    set E:LANGUAGE = en_US.UTF-8
    set E:LC_ALL = en_US.UTF-8

    set E:MAN_DISABLE_SECCOMP = 1 # man page issues

    set E:FZF_DEFAULT_COMMAND = 'fd -L --hidden --type f'
    set E:FZF_DEFAULT_OPTS = '--reverse --color "gutter:-1" --inline-info --cycle -m --bind ctrl-a:toggle-all --bind ctrl-j:down --bind ctrl-k:up --bind ctrl-p:toggle-preview'
    set E:FZF_CTRL_T_COMMAND = 'fd --hidden -L'
    set E:FZF_ALT_C_COMMAND = 'fd --hidden --type d --max-depth 10 --no-ignore'


    set paths = [
      # ~/on/rakudo-star-*[nomatch-ok]/install/{bin,share/perl6/site/bin}
      ~/.gem/ruby/*[nomatch-ok]/bin
      ~/.xxx/*[nomatch-ok]/bin
      ~/.xxx/bin

      ~/xxx/bin
      ~/.bin
      ~/.bin/lib
      ~/.bin/v
      ~/.bin/install
      ~/.bin/$platform:os
      ~/.cargo/bin
      ~/.local/bin
      ~/bin
      ~/.nix-profile/bin
      ~/.krew/bin
      ~/.raku/bin
      /usr/local/bin

      ~/.asdf/bin
      ~/.asdf/shims

      $@paths
    ]
}

