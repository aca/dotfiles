FROM alpine:edge
RUN apk add --no-cache \
      python2 \
      python3 \
      --repository=http://dl-cdn.alpinelinux.org/alpine/v3.15/community
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --no-cache ttyd@community
RUN apk add --no-cache \
      gron@testing \
      fd@community \
      kubectl@testing \
      delta@community \
      helm@testing \
      tree-sitter@community \
      github-cli@community \
      neovim@community \
      bash-completion
RUN apk add --no-cache \
      build-base \
      ca-certificates \
      curl \
      tar \
      git \
      busybox-extras \
      sudo \
      tmux \
      stow \
      yaml \
      moreutils \
      jq \
      openssh \
      fzf \
      vifm \
      ripgrep \
      bash \
      zsh \
      fish \
      npm \
      nodejs \
      py3-netaddr \
      coreutils \
      tcpdump \
      socat \
      go \
      kubectx \
      unzip \
      py3-pip \
      docker-cli
      # docker-cli \ -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker:ro 
      # make cmake gettext-dev gperf libtermkey-dev libuv-dev libvterm-dev lua5.1-lpeg lua5.1-mpack msgpack-c-dev unibilium-dev libluv-dev tree-sitter-dev luajit-dev

RUN pip3 install ansible==5.7.1

# RUN addgroup -S rok
# RUN adduser -S -D -G rok -h /home/rok -s /bin/bash rok
# RUN echo 'rok ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rok
# USER rok
# ENV GOPATH /home/rok

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
RUN go install github.com/stern/stern@latest
RUN go install github.com/aca/agec@latest
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && chmod +x /usr/local/bin/argocd

# RUN nvim --headless -c ':TSInstallSync! bash c cpp css go html javascript lua make markdown python tsx typescript yaml' -c ':q'
# RUN nvim --headless -c ':LspInstall --sync gopls' -c ':q'

RUN sudo mv /root/bin/* /usr/local/bin
RUN sudo rm -rf ~/go || true
RUN sudo rm -rf ~/pkg || true
RUN sudo rm -rf ~/.cache || true
RUN sudo rm -rf ~/.npm || true

RUN apk del go --force-broken-world

WORKDIR /root
CMD ["/usr/local/bin/elvish"]
