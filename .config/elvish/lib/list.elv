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
  put $nil # error?
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

# var f = { |x y| put ( + $x $y ) }
# use list; put [1 2 3 4] | list:reduce { |x y| put ( + $x $y ) };
# use list; var arr = [1 2 3 4]; list:reduce $arr { |x y| put ( + $x $y ) } 0;
fn reduce { |@args|
  var lst
  var f
  var acc = $nil
  if (not-eq (kind-of $args[0]) list) {
    set lst = (one) 
    set f = $args[0]
    if (eq (count $args) 2) {
      set acc = $args[1]
    } else {
      set acc = $lst[0]
    }
  } else {
    set lst = $args[0]
    set f = $args[1]
    if (eq (count $args) 3) {
      set acc = $args[2]
    } else {
      set acc = $lst[0]
    }
  }

  for i $lst[1..] {
    set acc = ($f $acc $i)
  }
  put $acc
}
