# non interactive-shell ends here
if not status --is-interactive; exit; end 

status job-control full

# set -e SHELL
# if test -f /bin/dash
#   set -gx SHELL /bin/dash
# else if test -f /bin/bash
#   set -gx SHELL /bin/bash
# end

# set -gx SHELL /bin/dash

# vars {{{

if not set -q init_fish
    set -gx init_fish
    set -gx LIBVIRT_DEFAULT_URI "qemu:///system"
    set -gx VIRSH_DEFAULT_CONNECT_URI "qemu:///system"

    # In case TERM=xterm-256color not exists
    if [ "$USER" = "ubuntu" ]; set -gx TERM linux; end

    # nord
    set -gx fish_color_normal normal
    set -gx fish_color_command 81a1c1
    set -gx fish_color_quote a3be8c
    set -gx fish_color_redirection b48ead
    set -gx fish_color_end 88c0d0
    set -gx fish_color_error ebcb8b
    set -gx fish_color_param eceff4
    set -gx fish_color_comment 434c5e
    set -gx fish_color_match --background=brblue
    set -gx fish_color_selection white --bold --background=brblack
    set -gx fish_color_search_match bryellow --background=brblack
    set -gx fish_color_history_current --bold
    set -gx fish_color_operator 00a6b2
    set -gx fish_color_escape 00a6b2
    set -gx fish_color_cwd green
    set -gx fish_color_cwd_root red
    set -gx fish_color_valid_path --underline
    set -gx fish_color_autosuggestion 4c566a
    set -gx fish_color_user brgreen
    set -gx fish_color_host normal
    set -gx fish_color_cancel -r
    set -gx fish_pager_color_completion normal
    set -gx fish_pager_color_description B3A06D yellow
    set -gx fish_pager_color_prefix white --bold --underline
    set -gx fish_pager_color_progress brwhite --background=cyan

    # uname is too slow
    if [ -d /Users ] 
      set -gx _uname darwin
    else
      set -gx _uname linux
    end

    set CDPATH .
    set -gx GTK_IM_MODULE fcitx
    set -gx QT_IM_MODULE fcitx
    set -gx XMODIFIERS "@im=fcitx"

    # set -gx _SRC "$HOME/src"
    # set -gx _TMP "$HOME/tmp"
    # set -gx _SHELL "fish"

    set -gx ASDF_DIR $HOME/.asdf
    set -gx GHQ_ROOT $HOME/src
    set -gx MANPAGER 'nvim +Man!'
    set -gx MANWIDTH '88'
    
    set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
    set -gx BROWSER google-chrome
    set -gx COLORTERM truecolor
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx GOPATH "$HOME"
    set -gx GOPROXY direct

    set -gx LANG en_US.UTF-8
    set -gx LANGUAGE en_US.UTF-8
    set -gx LC_ALL en_US.UTF-8

    # set -q SSH_CLIENT && set -gx TERM xterm
    set -gx XDG_CONFIG_HOME "$HOME/.config"

    #  colorful man
    # set -gx LESS_TERMCAP_mb (printf "\033[01;31m")
    # set -gx LESS_TERMCAP_md (printf "\033[01;31m")
    # set -gx LESS_TERMCAP_me (printf "\033[0m")
    # set -gx LESS_TERMCAP_se (printf "\033[0m")
    # set -gx LESS_TERMCAP_so (printf "\033[01;44;33m")
    # set -gx LESS_TERMCAP_ue (printf "\033[0m")
    # set -gx LESS_TERMCAP_us (printf "\033[01;32m")

    set -gx MAN_DISABLE_SECCOMP 1 # man page issues
    # set -gx _JAVA_AWT_WM_NONREPARENTING 1 # jetbrains, set /etc/profile.d/jre.sh

    # vivid generate molokai 
    # https://github.com/sharkdp/vivid

    set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f'
    set -gx FZF_DEFAULT_OPTS '--reverse --color "gutter:-1" --inline-info --cycle -m --bind ctrl-a:toggle-all --bind ctrl-j:down --bind ctrl-k:up'
    set -gx FZF_CTRL_T_COMMAND 'fd --hidden'
    set -gx FZF_ALT_C_COMMAND 'fd --hidden --type d --max-depth 10'

    set -px PATH $HOME/bin
    set -px PATH $HOME/.bin
    set -px PATH $HOME/.bin/$_uname

    if [ -d $HOME/.krew/bin ]                             ; set -x --append PATH $HOME/.krew/bin                              ; end
    if [ -d $HOME/.raku/bin ]                             ; set -x --append PATH $HOME/.raku/bin                              ; end
    if [ -d $HOME/.linkerd2/bin ]                         ; set -x --append PATH $HOME/.linkerd2/bin                          ; end
    if [ -d $HOME/src/k8s.io/kubernetes/third_party/etcd ]; set -x --append PATH $HOME/src/k8s.io/kubernetes/third_party/etcd ; end
    if [ -d $HOME/sdk/gotip/bin ]                         ; set -x --append PATH $HOME/sdk/gotip/bin                          ; end
    if [ -d $HOME/xxx/bin ]                               ; set -x --append PATH $HOME/xxx/bin                                ; end
    if [ -d /usr/local/opt/coreutils/libexec/gnubin ]     ; set -x --append PATH /usr/local/opt/coreutils/libexec/gnubin      ; end
    if [ -d $HOME/.local/bin ]                            ; set -x --append PATH $HOME/.local/bin                             ; end
    if [ -d $HOME/.cargo/bin ]                            ; set -x --append PATH $HOME/.cargo/bin                             ; end
    if [ -d $HOME/.nix-profile/bin ]                      ; set -x --append PATH $HOME/.nix-profile/bin                       ; end
    if [ -d /opt/local/bin ]                              ; set -x --append PATH /opt/local/bin                               ; end
    if [ -d /opt/local/sbin ]                             ; set -x --append PATH /opt/local/sbin                              ; end
    if [ -d /usr/local/opt/llvm/bin ]                     ; set -x --append PATH /usr/local/opt/llvm/bin                      ; end
    if [ -d $HOME/src/go.googlesource.com/go/bin ]        ; set -x --append PATH $HOME/src/go.googlesource.com/go/bin         ; end
end

function _prepend_path
   set -l index (contains -i -- $argv[1] $PATH)
   if set -q index[1]
     set -e PATH[$index]
   end
   set -px PATH $argv[1]
end

_prepend_path $HOME/.asdf/shims 
_prepend_path $HOME/.asdf/bin

# }}}
# Section: alias {{{

# "alias" makes fish init too slow, keep it minimal and use function instead
# abbr --global v 'nvim'
abbr --global g 'rg -i'
abbr --global pu 'pueue'
abbr --global cmd 'command'
abbr --global k 'kubectl'
abbr --global os 'openstack'
abbr --global ta 'tmux attach -t'
abbr --global ci 'pbcopy'
abbr --global co 'pbpaste'
# abbr --global tm 'tmux'
# abbr --global td 'tmux detach'
abbr --global gcm git commit --allow-empty-message -m
abbr --global gacm git commit -a --allow-empty-message -m
# abbr --global gacm2  git commit -a --allow-empty-message -m
# abbr --global gacm3  git commit -a --allow-empty-message -m
# abbr --global gacm4  git commit -a --allow-empty-message -m
# abbr --global gacm5  git commit -a --allow-empty-message -m
# abbr --global gacm6  git commit -a --allow-empty-message -m
# abbr --global gacm7  git commit -a --allow-empty-message -m
# abbr --global gacm8  git commit -a --allow-empty-message -m

# }}}
# hooks {{{
#
# share history
# function _save_history --on-event fish_postexec; history --save; end 

# # virtualenv
# function _activate_venv --on-event fish_preexec
#     if set gitdir (git rev-parse --show-toplevel 2>/dev/null) && test -d $gitdir/venv
#       if test \( -z "$VIRTUAL_ENV" -o "$VIRTUAL_ENV" != "$gitdir/venv" \)
#           source $gitdir/venv/bin/activate.fish
#       end

#       if test -n "$VIRTUAL_ENV" -a "$VIRTUAL_ENV" != "$gitdir/venv"
#           deactivate
#       end
#     else 
#       if set -q VIRTUAL_ENV
#           deactivate
#       end
#     end
# end

function _postexec --on-event fish_postexec

  switch $argv
    case 'ghq get *'
      set_color red; echo "[HOOK] updating source database"; set_color normal;
      _update_src &
    case 'pip install *'
      set_color red; echo "[HOOK] asdf reshim"; set_color normal;
      asdf reshim &
    case 'pip3 install *'
      set_color red; echo "[HOOK] asdf reshim"; set_color normal;
      asdf reshim &
  end
end
# }}}
# OS specific {{{
switch $_uname
    case linux
        abbr --global svc 'sudo systemctl'
        abbr --global svcu 'systemctl --user'
        set -gx BROWSER google-chrome-stable
    case darwin
        # if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc ]; source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc; end
        abbr --global svc 'brew services'
        abbr --global svcu 'brew services'
end
# }}}

# update: zoxide init fish > ~/src/configs/dotfiles/.config/fish/zoxide.fish
if command -sq zoxide
  source $HOME/.config/fish/zoxide.fish
end

if not set -q $TMUX_PANE 
  set -x NVIM_LISTEN_ADDRESS "/tmp/nvim$TMUX_PANE"
end

# if [ -e /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc ]
#   source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
# end

