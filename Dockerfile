FROM archlinux:base-devel
RUN sudo pacman -Sy --noconfirm --needed base-devel git fd fzf vifm ripgrep stow go nodejs python tmux zsh fish elvish gopls

RUN groupadd -r rok && useradd --create-home --no-log-init -r -g rok rok
RUN echo 'rok ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rok
USER rok
WORKDIR /home/rok
RUN git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm

RUN yay -Sy --noconfirm neovim-git ghq-bin ttyd

# RUN git clone --recurse-submodules -j8 https://github.com/aca/dotfiles ~/src/configs/dotfiles 
RUN mkdir -p ~/src/configs/dotfiles
COPY . /home/rok/src/configs/dotfiles/
RUN bash ~/src/configs/dotfiles/.bin/setup.stow

RUN sudo pacman -Scc
