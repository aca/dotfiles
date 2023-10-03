if not status --is-interactive; exit; end 

source ~/.config/fish/init.fish
[ -f "$HOME/.config/fish/secrets.fish" ] && source "$HOME/.config/fish/secrets.fish"
[ -f "$HOME/.config/fish/local.fish" ] && source "$HOME/.config/fish/local.fish"
