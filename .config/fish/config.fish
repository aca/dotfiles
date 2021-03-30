source ~/.config/fish/init.fish
[ -f "$HOME/.config/fish/secrets.fish" ] && source "$HOME/.config/fish/secrets.fish"
[ -f "$HOME/.config/fish/$hostname.fish" ] && source "$HOME/.config/fish/$hostname.fish"
