source ~/.config/fish/init.fish
[ -f "$HOME/.config/fish/secrets.fish" ] && source "$HOME/.config/fish/secrets.fish"
[ -f "$HOME/.config/fish/$hostname.fish" ] && source "$HOME/.config/fish/$hostname.fish"
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; test -f /home/rok/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/rok/.ghcup/bin $PATH # ghcup-env
