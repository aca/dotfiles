function x --description "scratch"
    cd ~/src/scratch
    if [ (count $argv) -eq 0 ]
      FZF_TMUX_HEIGHT='100%' FZF_ALT_C_OPTS='--preview "exa --tree --level 3 {}"' FZF_ALT_C_COMMAND='fd --hidden --type d --max-depth 1 ' fzf-cd-widget
      return
    end

    set d (date +%Y%m%d_$argv)
    mkdir $d
    cd $d
end
