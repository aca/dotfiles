use platform

# if (and (has-env WEZTERM_PANE) (not (has-env NVIM_LISTEN_ADDRESS))) {
#   set E:NVIM_LISTEN_ADDRESS = "/tmp/nvim"$E:WEZTERM_PANE
# }

if (eq $E:_ELVISH_ENV "") {
    set-env _ELVISH_ENV 1

    set-env LANG en_US.UTF-8
    set-env LANGUAGE en_US.UTF-8
    set-env LC_ALL en_US.UTF-8

    if (not (has-env HOSTNAME)) { set-env HOSTNAME (platform:hostname &strip-domain=$false) }
        
    # if (eq $platform:os "linux") {
    #     if (and (not (has-env WAYLAND_DISPLAY)) (not (has-env DISPLAY))) {
    #         if ?(pgrep sway >/dev/null) { set-env WAYLAND_DISPLAY "wayland-1" }
    #     }
    # }

    # this should be set by terminal emulator(e.g. alacritty) or tmux
    # xterm-color is for SSH session
    if (not (has-env TERM)) {
      set-env TERM xterm-color
    }

    set-env PYTHONSTARTUP ~/.bin/pythonstartup
    set-env XDG_CONFIG_HOME ~/.config

    # if (eq $E:HOSTNAME "rok-te3") {
    #   set E:LIBVIRT_DEFAULT_URI = "qemu:///system"
    #   set E:VIRSH_DEFAULT_CONNECT_URI = "qemu:///system"
    # } else {
    #   set E:LIBVIRT_DEFAULT_URI = "qemu+ssh://rok@aca/system"
    #   set E:VIRSH_DEFAULT_CONNECT_URI = "qemu+ssh://rok@aca/system"
    # }

    # vivid generate molokai
    # set E:LS_COLORS = ''

    # set E:EXA_COLORS = ""
    # set E:EXA_ICON_SPACING = 2

    set E:GKSwstype = "iterm"
    set E:MPLBACKEND = "module://itermplot"
    set E:SHELL = "/bin/sh"

    if (eq $platform:os "linux") {
      set-env XMODIFIERS "@im=fcitx5"
      set-env GTK_IM_MODULE fcitx5
      set-env QT_IM_MODULE fcitx5
    }

    set-env ASDF_DIR $E:HOME/.asdf
    set-env GHQ_ROOT $E:HOME/src
    set-env MANPAGER 'nvim +Man!'
    set-env MANWIDTH '88'

    set-env RIPGREP_CONFIG_PATH $E:HOME/.ripgreprc
    set-env BROWSER google-chrome-stable
    set-env COLORTERM truecolor
    set-env EDITOR nvim
    set-env VISUAL nvim
    set-env GOPATH $E:HOME
    set-env GOPROXY direct

    # node
    # set-env NODE_OPTIONS "--experimental-fetch --experimental-top-level-await --experimental-modules --no-warnings"
    set-env NPM_CONFIG_GLOBALCONFIG $E:HOME/.npmrc.global

    set-env MAN_DISABLE_SECCOMP 1 # man page issues

    set-env FZF_DEFAULT_COMMAND 'fd -L --hidden --type f'
    set-env FZF_DEFAULT_OPTS '--min-height 15 --reverse --color "gutter:-1" --inline-info --cycle -m --bind ctrl-a:toggle-all --bind ctrl-n:down --bind ctrl-p:up --bind ctrl-w:toggle-preview --prompt "» " --preview "bat {}" --preview-window "hidden"'
    set-env FZF_CTRL_T_COMMAND 'fd -L --hidden'
    set-env FZF_ALT_C_COMMAND 'fd --hidden --type d --max-depth 10 --no-ignore'

    set paths = [
      # ~/on/rakudo-star-*[nomatch-ok]/install/{bin,share/perl6/site/bin}

      ~/.asdf/bin
      ~/.asdf/shims

      ~/.gem/ruby/*[nomatch-ok]/bin

      ~/.bun/bin

      ~/bin

      ~/xxx/bin

      ~/.bin
      ~/.bin/lib
      ~/.bin/v
      ~/.bin/$platform:os

      ~/.cargo/bin
      ~/.local/bin
      # ~/.nix-profile/bin
      ~/.krew/bin
      ~/.raku/bin
      /usr/local/bin

      $@paths
    ]
}

