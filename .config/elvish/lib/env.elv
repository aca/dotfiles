use platform

if (eq $E:WEZTERM_PANE "") {
  set E:NVIM_LISTEN_ADDRESS = "/tmp/nvim$WETERM_PANE"
}

if (eq $E:_ELVISH_ENV "") {
    set E:_ELVISH_ENV = 1

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

    set E:NPM_CONFIG_GLOBALCONFIG = $E:HOME/.npmrc.global
    set E:RIPGREP_CONFIG_PATH = $E:HOME/.ripgreprc
    set E:BROWSER = google-chrome
    set E:COLORTERM = truecolor
    set E:EDITOR = nvim
    set E:VISUAL = nvim
    set E:GOPATH = $E:HOME
    set E:GOPROXY = direct

    set E:LANG = en_US.UTF-8
    set E:LANGUAGE = en_US.UTF-8
    set E:LC_ALL = en_US.UTF-8

    set E:MAN_DISABLE_SECCOMP = 1 # man page issues

    set E:FZF_DEFAULT_COMMAND = 'fd --hidden --type f'
    set E:FZF_DEFAULT_OPTS = '--reverse --color "gutter:-1" --inline-info --cycle -m --bind ctrl-a:toggle-all --bind ctrl-j:down --bind ctrl-k:up'
    set E:FZF_CTRL_T_COMMAND = 'fd --hidden'
    set E:FZF_ALT_C_COMMAND = 'fd --hidden --type d --max-depth 10 --no-ignore'


    set paths = [
      # ~/on/rakudo-star-*[nomatch-ok]/install/{bin,share/perl6/site/bin}
      ~/.cargo/bin
      ~/.local/bin
      ~/bin
      ~/.nix-profile/bin
      ~/.krew/bin
      ~/.raku/bin
      ~/.bin
      ~/.bin/$platform:os
      ~/.asdf/bin
      ~/.asdf/shims
      $@paths
    ]
}

