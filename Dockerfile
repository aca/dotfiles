FROM alpine:3
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --no-cache \
      build-base \
      ca-certificates \
      curl \
      tar \
      git \
      sudo \
      tmux \
      stow \
      moreutils \
      ttyd@community \
      jq \
      fd@community \
      openssh \
      fzf \
      vifm \
      ripgrep \
      bash \
      zsh \
      fish \
      npm \
      nodejs \
      coreutils \
      tcpdump \
      socat \
      tree \
      kubectl@testing \
      delta@community \
      helm@testing \
      tree-sitter@community \
      go \
      github-cli@community \
      docker-cli \
      kubectx \
      unzip \
      gron@testing \
      bash-completion \
      neovim@community
      # make cmake gettext-dev gperf libtermkey-dev libuv-dev libvterm-dev lua5.1-lpeg lua5.1-mpack msgpack-c-dev unibilium-dev libluv-dev tree-sitter-dev luajit-dev

# RUN addgroup -S rok
# RUN adduser -S -D -G rok -h /home/rok -s /bin/bash rok
# RUN echo 'rok ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rok
# USER rok
# ENV GOPATH /home/rok

# nvim
# RUN git clone -j8 https://github.com/neovim/neovim.git ~/src/configs/github.com/neovim/neovim
# RUN cd ~/src/configs/github.com/neovim/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install && rm -rf ~/src/configs/github.com/neovim/neovim

# stow
RUN git clone --recurse-submodules -j8 https://github.com/aca/dotfiles ~/src/configs/dotfiles --depth 1 && rm -rf ~/src/configs/dotfiles/.git
RUN bash ~/src/configs/dotfiles/.bin/setup.stow

# RUN nvim --headless -c ':TSInstallSync! bash c cpp css go html javascript lua make markdown python tsx typescript yaml' -c ':q'
# RUN nvim --headless -c ':LspInstall --sync gopls' -c ':q'

ENV GOPATH /root
RUN go install github.com/x-motemen/ghq@latest
RUN go install src.elv.sh/cmd/elvish@latest
RUN go install github.com/stern/stern@latest
RUN go install github.com/slok/agebox/cmd/agebox@latest
RUN go get github.com/oauth2-proxy/oauth2-proxy/v7

RUN sudo mv /root/bin/* /usr/local/bin
RUN sudo rm -rf ~/go || true
RUN sudo rm -rf ~/pkg || true
RUN sudo rm -rf ~/.cache || true
RUN sudo rm -rf ~/.npm || true

RUN apk del go --force-broken-world

WORKDIR /root
CMD ["/usr/local/bin/elvish"]
