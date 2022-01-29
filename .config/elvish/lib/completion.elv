# set edit:completion:arg-completer[kubectl] = {|@args|
#     var all-packages = [1 2 3]
#     var n = (count $args)
#     if (== $n 2) {
#         # apt x<Tab> -- complete a subcommand name
#         put install uninstall install2
#     } elif (== $n 3) {
#         put $@all-packages
#     }
# }
