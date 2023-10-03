# docker run -it -v (pwd):/workspace acadx0/tools:devcontainer

FROM alpine:3.18.2
# RUN apk add --no-cache python2 --repository=http://dl-cdn.alpinelinux.org/alpine/v3.15/community
# RUN apk add --no-cache py2-pip --repository=http://dl-cdn.alpinelinux.org/alpine/v3.11/main
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add --no-cache --force-overwrite \ 
    ttyd@community \
    fd@community \
    delta@community \
    bash-completion \
    stow \
    build-base \
    sshpass \
    curl \
    tar \
    git \
    busybox-extras \
    sudo \
    tmux \
    moreutils \
    jq \
    openssh \
    fzf \
    vifm \
    ripgrep \
    bash \
    zsh \
    coreutils \
    tcpdump \
    socat \
    go \
    unzip \
    docker-cli \
    python3 \
    py3-pip \
    npm \
    nodejs \
    github-cli@community \
    tree-sitter@community \
    neovim@community

RUN sh -c "curl -fsSL https://deno.land/x/install/install.sh | sh"

# kubernetes
# RUN apk add --no-cache --force-overwrite gron@testing
# RUN apk add --no-cache --force-overwrite kubectl@testing
# RUN apk add --no-cache --force-overwrite helm@testing
# RUN apk add --no-cache --force-overwrite k9s@community
# RUN apk add --no-cache --force-overwrite kubectx
# RUN apk add --no-cache --force-overwrite yaml

# database
# RUN apk add --no-cache --force-overwrite pgcli
# RUN apk add --no-cache --force-overwrite mycli

# nvim
# RUN git clone -j8 https://github.com/neovim/neovim.git ~/src/configs/github.com/neovim/neovim
# RUN cd ~/src/configs/github.com/neovim/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install && rm -rf ~/src/configs/github.com/neovim/neovim

# stow
RUN git clone --recurse-submodules -j20 https://github.com/aca/dotfiles ~/src/config/dotfiles --depth 1 && rm -rf ~/src/config/dotfiles/.git

RUN bash ~/src/config/dotfiles/.bin/setup.stow

RUN nvim --headless -c ':packadd nvim-treesitter' -c ':TSInstallSync! bash c cpp css go html javascript lua make markdown python tsx typescript yaml' -c ':q'
# RUN nvim --headless -c ':LspInstall --sync gopls' -c ':q'

ENV GOPATH /root
RUN go install github.com/x-motemen/ghq@latest
RUN go install src.elv.sh/cmd/elvish@master

# RUN nvim --headless -c ':TSInstallSync! bash c cpp css go html javascript lua make markdown python tsx typescript yaml' -c ':q'
# RUN nvim --headless -c ':LspInstall --sync gopls' -c ':q'

RUN sudo rm -rf ~/go || true
RUN sudo rm -rf ~/pkg || true
RUN sudo rm -rf ~/.cache || true
RUN sudo rm -rf ~/.npm || true
RUN sudo rm -rf ~/.local/share/fonts || true
RUN sudo rm -rf ~/.local/share/nvim/site/pack/bundle/opt/markdown-preview.nvim || true

RUN apk del go --force-broken-world

WORKDIR /root
# CMD ["/usr/local/bin/elvish"]
CMD ["/root/bin/elvish"]
