# put [ 1 3 ] | list:index 3 # (num 1)
# list:index [ 1 3 ] 3       # (num 1)
# list:index [ 1 3 ] 4       # (num -1)
fn index { | @args | 
  var lst = $nil
  var elem = $nil
  var idx = 0
  if (== 1 (count $args)) {
    set lst = (all)
    set elem = $args[0]
  } else {
    set lst = $args[0]
    set elem = $args[1]
  }

  for i $lst {
    if (not-eq $i $elem) {
      set idx = (+ 1 $idx) 
    } else {
      put $idx
      return # NOTES: is return an error?
    }
  }
  put (num -1)
}


# var arr = [3 4 5]; use list; list:remove $arr 4; # [3 5]
# use list; put [ 3 4 5 ] | list:remove 4; # [3 5]
fn remove { |@args|
  var lst = $nil
  var elem = $nil
  var idx = 0
  if (== 1 (count $args)) {
    set lst = (all)
    set elem = $args[0]
  } else {
    set lst = $args[0]
    set elem = $args[1]
  }

  var idx = (index $lst $elem)
  put [ (all $lst[0..$idx]) (all $lst[( + 1 $idx )..(count $lst)]) ]
}
