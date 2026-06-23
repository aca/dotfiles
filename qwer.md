# qwer

## update
```bash
set -euxo pipefail
git pull --rebase
git subrepo pull --all
git submodule update --jobs=8 --init --remote --force
```

## packadd

```bash
git subrepo clone "$1" ".local/share/nvim/site/pack/bundle/opt/$(basename $1)"

```

## blink
```bash
cd ~/src/github.com/aca/dotfiles/.local/share/nvim/site/pack/bundle/opt/blink.cmp
cargo build --release
```
