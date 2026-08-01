# qwer

## subrepocheck
```bash
for d in $(git subrepo status --quiet); do
  dirty=$(git status --porcelain -- "$d" | wc -l)
  parent=$(git config --file "$d/.gitrepo" subrepo.parent 2>/dev/null)
  [ -z "$parent" ] && { echo "NO-GITREPO $d"; continue; }
  cnt=$(git rev-list --count "$parent..HEAD" -- "$d")
  [ "$dirty" -gt 0 ] && echo "DIRTY($dirty) $d"
  [ "$cnt" -gt 1 ] && echo "LOCAL-COMMITS($((cnt-1))) $d"
done
```

## install
```bash
git clone "https://github.com/aca/dotfiles.git" ~/src/github.com/aca/dotfiles --recursive --shallow-submodules -j 4 
git clone "https://github.com/aca/dotfiles.nostow.git" ~/src/github.com/aca/dotfiles.nostow
cd ~/src/github.com/aca

bash -c "stow --delete -v --target $HOME dotfiles"

bash -c "stow -v --target $HOME dotfiles dotfiles.nostow"
bash -c "stow -v --target $HOME dotfiles"
```

## keys
```
curl -L github.com/aca.keys > ~/.ssh/authorized_keys
```
