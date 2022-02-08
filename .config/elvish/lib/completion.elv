set edit:completion:arg-completer[cd] = {|@args|
  use path
  edit:complete-filename '' |  each {|x| if (path:is-dir $x[stem]) { put $x[stem] } }
  edit:complete-filename '.' |  each {|x| if (path:is-dir $x[stem]) { put $x[stem] } }
}
