#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

command -v ghq 1>/dev/null

# vim
# nvim -c 'PlugUpgrade | qa!' || true
# nvim -c 'PlugUpdate | qa!' || true

# asdf
asdf update --head
asdf plugin-update --all

# repos
ghq get -u "git@github.com:aaron-williamson/base16-alacritty.git"
ghq get -u "git@github.com:jonniek/mpv-playlistmanager.git"
ghq get -u "git@github.com:zenyd/mpv-scripts.git"
ghq get -u "git@github.com:VideoPlayerCode/mpv-tools.git"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    fwupdmgr update
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew update
    brew upgrade
    brew cleanup
    #brew list > brew/brew.list
    #brew cask list > brew/brew.cask.list
fi
