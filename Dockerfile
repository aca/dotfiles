FROM archlinux:base-devel

# pacman
RUN pacman -Sy reflector --noconfirm
RUN reflector --country "South Korea" --country Japan  --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm --needed git stow archlinux-keyring fd fzf vifm ripgrep stow go nodejs python tmux zsh fish elvish moreutils

# setup yay
RUN groupadd -r rok && useradd --create-home --no-log-init -r -g rok rok
RUN echo 'rok ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rok
USER rok
WORKDIR /home/rok
RUN git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm

# yay pkgs
RUN yay -Sy --noconfirm neovim-git ghq-bin ttyd

# clean
RUN sudo pacman -Scc

# dotfiles
RUN git clone --recurse-submodules -j32 https://github.com/aca/dotfiles ~/src/configs/dotfiles
RUN bash ~/src/configs/dotfiles/.bin/setup.stow
RUN nvim --headless -c ':TSInstallSync all' -c ':q'
