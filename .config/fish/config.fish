if not status --is-interactive; exit; end 

source ~/.config/fish/init.fish
[ -f "$HOME/.config/fish/secrets.fish" ] && source "$HOME/.config/fish/secrets.fish"
[ -f "$HOME/.config/fish/local.fish" ] && source "$HOME/.config/fish/local.fish"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/kyungrok.chung/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
