set -gx SHELL /bin/sh

# vars {{{

if not set -q _FISH_INIT_VAR
    set -gx _FISH_INIT_VAR

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

    # set -gx _SRC "$HOME/src"
    # set -gx _TMP "$HOME/tmp"
    # set -gx _SHELL "fish"

    set -gx GHQ_ROOT $HOME/src
    set -gx MANPAGER 'nvim +Man!'
    set -gx MANWIDTH '88'

    # vivid generate molokai 
    # https://github.com/sharkdp/vivid

    set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f'
    set -gx FZF_DEFAULT_OPTS '--reverse --color "gutter:-1" --inline-info --cycle -m --bind ctrl-a:toggle-all --bind ctrl-j:down --bind ctrl-k:up'
    set -gx FZF_CTRL_T_COMMAND 'fd --hidden'
    set -gx FZF_ALT_C_COMMAND 'fd --hidden --type d --max-depth 10 --no-ignore'

    if not set -q IN_NIX_SHELL
        set -px PATH $HOME/bin
        set -px PATH $HOME/.bin
        # set -px PATH $HOME/.bin/v
        # set -px PATH $HOME/.bin/lib
        # set -px PATH $HOME/.bin/$_uname
    end

    set -gx NPM_CONFIG_GLOBALCONFIG $HOME/.npmrc.global
end

# }}}
# Section: alias {{{

# "alias" makes fish init too slow, keep it minimal and use function instead
# abbr --global v 'nvim'
abbr --global g 'stdbuf -o0 -e0 -i0 rg -i'
abbr --global pu 'pueue'
abbr --global cmd 'command'
abbr --global k 'kubectl'
abbr --global os 'openstack'
abbr --global ta 'tmux attach -t'
abbr --global v 'nvim'
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

# OS specific {{{
switch $_uname
    case linux
        abbr --global svc 'sudo systemctl'
        abbr --global svcu 'systemctl --user'
    case darwin
        # if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc ]; source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc; end
        abbr --global svc 'brew services'
        abbr --global svcu 'brew services'
end
# }}}

# update: zoxide init fish > ~/src/configs/dotfiles/.config/fish/zoxide.fish
# if command -sq zoxide
#   source $HOME/.config/fish/zoxide.fish
# end

if not set -q $WEZTERM_PANE
  set -x NVIM_LISTEN_ADDRESS "/tmp/nvim$WEZTERM_PANE"
end
