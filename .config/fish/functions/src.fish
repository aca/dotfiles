function src
  pushd .
  cd ~/src

  set -l src_dir ""
  if [ -f ~/src/.src ] 
    set src_dir (cat ~/src/.src | fzf)
  else
    set src_dir (fd --hidden --type d --follow --max-depth 7 . ~/src | fzf)
  end
    
  if not test -z $src_dir
    clear
    cd $src_dir
    pwd
    ll
  else
    popd
  end
  bash -c 'cd ~/src && fd --hidden --type d --follow --max-depth 7 > ~/src/.src' &
end
