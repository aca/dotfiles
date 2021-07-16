#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

update_src() {
  ghq get -u "$1"
}

isLinux() { if [[ "$OSTYPE" == "linux-gnu"* ]]; then return 0; else return 1; fi; }
isDarwin() { if [[ "$OSTYPE" == "darwin"* ]]; then return 0; else return 1; fi; }

# asdf
asdf update --head
asdf plugin-update --all

# alacritty
update_src "git@github.com:alacritty/alacritty.git"
if isDarwin; then
bash << EOF
set -euo pipefail
cd ~/src/github.com/alacritty/alacritty
make app
cp -r target/release/osx/Alacritty.app /Applications/
EOF
fi

update_src "git@github.com:aaron-williamson/base16-alacritty.git"
update_src "git@github.com:jonniek/mpv-playlistmanager.git"
update_src "git@github.com:zenyd/mpv-scripts.git"
update_src "git@github.com:VideoPlayerCode/mpv-tools.git"

if isLinux; then
    fwupdmgr update
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
fi

if isDarwin; then
    brew update
    brew upgrade
    brew cleanup
    #brew list > brew/brew.list
    #brew cask list > brew/brew.cask.list

    brew reinstall neovim
    brew reinstall tmux
fi

# npm
npm update -g
asdf reshim

# pip
python3 -m pip install -U pip
python3 << EOF
import pkg_resources
from subprocess import call

packages = [dist.project_name for dist in pkg_resources.working_set]

for pkg in packages:
    call(f"pip install --upgrade {pkg}", shell=True)
EOF
