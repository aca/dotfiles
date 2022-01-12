# UNIX comm alternative but keep sorted
# list all non md files
# 
#   λ fd --type f | filterline fd --extension 'md' 
# 
fn filterline {
  |@rest|

  var second = [(eval (echo $@rest))]
  from-lines | each { 
    |x|  
    if (not (has-value $second $x)) {
      put $x
    }
  }
}
