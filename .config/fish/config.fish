source ~/.config/fish/init.fish
[ -f "$HOME/.config/fish/secrets.fish" ] && source "$HOME/.config/fish/secrets.fish"
[ -f "$HOME/.config/fish/local.fish" ] && source "$HOME/.config/fish/local.fish"

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

