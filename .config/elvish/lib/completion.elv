use github.com/aca/elvish-compl/fish-completer-apply-all

set edit:completion:arg-completer[@] = { |@args| ls @ | each {|x| edit:complex-candidate $x; } }
set edit:completion:arg-completer[sudo] = $edit:complete-sudo~
