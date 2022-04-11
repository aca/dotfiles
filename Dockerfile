FROM archlinux:base-devel
RUN sudo pacman -Sy --noconfirm --needed base-devel git

RUN groupadd -r rok && useradd --create-home --no-log-init -r -g rok rok
RUN echo 'rok ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rok
USER rok
WORKDIR /home/rok

RUN sh -c 'git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm'
RUN sudo pacman -Sy --noconfirm tmux
RUN yay -Sy --noconfirm neovim-git

RUN sudo pacman -Sy --noconfirm fd fzf vifm ripgrep
RUN sudo pacman -Sy --noconfirm stow
RUN yay -S --noconfirm ghq-bin ttyd

# RUN git clone --recurse-submodules -j8 https://github.com/aca/dotfiles ~/src/configs/dotfiles 
RUN mkdir ~/src/config/dotfiles
COPY . ~/src/config/dotfiles

RUN bash ~/src/configs/dotfiles/.bin/setup.stow


# RUN sudo pacman -Scc
