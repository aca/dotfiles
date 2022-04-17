FROM archlinux:base-devel

# pacman
RUN pacman -Sy reflector --noconfirm
RUN reflector --country "South Korea" --country Japan  --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm --needed git stow archlinux-keyring fd openssh fzf vifm ripgrep stow go nodejs npm python python-pip tmux zsh fish elvish moreutils jq zoxide xclip tig traceroute tcpdump socat tree xsel kubectl

# setup yay
RUN groupadd -r rok && useradd --create-home --no-log-init -r -g rok rok
RUN echo 'rok ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rok
USER rok
WORKDIR /home/rok
RUN git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm

# yay pkgs
RUN yay -Sy --noconfirm neovim-git ghq-bin ttyd

# clean
RUN sudo pacman -Scc --noconfirm
RUN rm -rf ~/yay-bin
RUN yay -Sc --noconfirm

# stow
RUN git clone --recurse-submodules -j11 https://github.com/aca/dotfiles ~/src/configs/dotfiles --depth 1
RUN bash ~/src/configs/dotfiles/.bin/setup.stow

# nvim
RUN nvim --headless -c ':TSInstallSync all' -c ':q'
RUN nvim --headless -c ':LspInstall --sync gopls bashls tsserver yamlls html jsonls' -c ':q'

RUN sudo rm -rf ~/go
RUN sudo rm -rf ~/.cache
RUN sudo rm -rf ~/.npm
