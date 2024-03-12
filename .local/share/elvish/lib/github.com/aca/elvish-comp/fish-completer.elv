# use edit

fn conv {|@words|
  use str
  printf "complete -C %q" (str:join ' ' $words) | fish | from-lines | each { |x| 
    var cands = [(str:split &max=2 "\t" $x)]
    var n = (count $cands)
    if (== $n 2) {
        edit:complex-candidate $cands[0] &display=(str:join ' | ' $cands)
    } else {
        edit:complex-candidate $cands[0]
    }
  } 
}


fn set {|command|
    set edit:completion:arg-completer[go] = $conv~
} 
