use str
use path

set edit:command-abbr['gco'] = 'git checkout'
set edit:command-abbr['gpr'] = 'git pull --rebase'
set edit:command-abbr['grc'] = 'git rebase --continue'

set edit:command-abbr['c'] = 'cd'
set edit:command-abbr['k'] = 'kubectl'
set edit:command-abbr['j'] = 'just'
set edit:command-abbr['g'] = 'git'
set edit:command-abbr['ke'] = 'kubectl edit'
set edit:command-abbr['kg'] = 'kubectl get'
set edit:command-abbr['kgd'] = 'kubectl get deploy'
set edit:command-abbr['kgp'] = 'kubectl get pod'

set edit:command-abbr['gi'] = 'grep -i'

set edit:command-abbr['os'] = 'openstack '
set edit:command-abbr['ta'] = 'tmux attach -t'
set edit:command-abbr['dr'] = 'deno run -A'
set edit:command-abbr['elv'] = 'elvish'
set edit:command-abbr['mkdir'] = 'mkdir -p'
set edit:command-abbr['dc'] = 'cd'
set edit:command-abbr['cp'] = 'cp -avn'
set edit:command-abbr['ssht'] = 'ssh -t'
set edit:command-abbr['mv'] = 'mv -vn'
set edit:command-abbr['v'] = 'vim'
set edit:command-abbr['svc'] = 'sudo systemctl'
set edit:command-abbr['svcu'] = 'systemctl --user'
set edit:command-abbr['virsh'] = 'sudo virsh'
set edit:command-abbr['virt-customize'] = 'sudo virt-customize'
set edit:command-abbr['virt-clone'] = 'sudo virt-clone'
set edit:command-abbr['virt-install'] = 'sudo virt-install'
set edit:command-abbr['xargsi'] = 'xargs -I@'
set edit:command-abbr['ea'] = 'each { |x|'

# fn asdf-available {
#     var tmppath = $pwd
#     {
#         for i [0 0 0 0] {
#             {
#                 if (eq $tmppath $E:HOME) {
#                     fail 1 
#                 }
#                 if (path:is-regular $tmppath/.tool-versions) {
#                     return
#                 } 
#                 if (path:is-dir $tmppath/.git) {
#                     fail 1
#                 } 
#                 if (path:is-dir $tmppath/.asdf) {
#                     fail 1
#                 } 
#             }
#             set tmppath = $tmppath/../
#         }
#     }
#
#     fail 1
# }
#

# set edit:before-readline = $@edit:before-readline [
#     # osc7 escape sequence
#     # { printf "\e]7;file://"$E:HOSTNAME$pwd"\e\\" }
#
#     # osc1337 escape sequence
#     # { printf "\[\ePtmux;\e\e]1337'CurrentDir="$pwd"\a\e\\\" }
#
#     # # this is fix for asdf performance issue
#     # {
#     #     set paths = [(
#     #         if ?(asdf-available) {
#     #             put $@paths | { 
#     #                 put ~/.asdf/bin ~/.asdf/shims
#     #                 each { |x|
#     #                     if (not (str:contains $x "/.asdf")) { 
#     #                         put $x
#     #                     } 
#     #                 }' 
#     #             }
#     #         } else {
#     #             put $@paths | { 
#     #                 each { |x| 
#     #                     if (not (str:contains $x "/.asdf")) { 
#     #                         put $x
#     #                     } 
#     #                 }; 
#     #                 put ~/.asdf/bin ~/.asdf/shims
#     #             }
#     #         }
#     #     )]
#
# ]

# OSC7
# print "\033]7;file://"$pwd"\033\\" # not work 
# printf "\e]7;"$pwd"\e\\"
# set @after-chdir = $@after-chdir {|_| printf "\e]7;"$pwd"\e\\" > /dev/tty }

set edit:before-readline = $@edit:before-readline [
    # osc7 escape sequence
    # { printf "\e]7;file://"$E:HOSTNAME$pwd"\e\\" }
    { printf "\e]7;"$pwd"\e\\" }
]
