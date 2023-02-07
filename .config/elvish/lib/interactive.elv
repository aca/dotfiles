use str
use path
set edit:command-abbr['gco'] = 'git checkout'

set edit:command-abbr['c'] = 'cd'
set edit:command-abbr['k'] = 'kubectl'
set edit:command-abbr['ke'] = 'kubectl edit'
set edit:command-abbr['kg'] = 'kubectl get'
set edit:command-abbr['kgd'] = 'kubectl get deploy'
set edit:command-abbr['kgp'] = 'kubectl get pod'

set edit:command-abbr['gi'] = 'grep -i'

set edit:command-abbr['os'] = 'openstack '
set edit:command-abbr['ta'] = 'tmux attach -t'
set edit:command-abbr['elv'] = 'elvish'
set edit:command-abbr['mkdir'] = 'mkdir -p'
set edit:command-abbr['dc'] = 'cd'
set edit:command-abbr['cp'] = 'cp -rpvn'
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

fn asdf-available {
    # if (path:is-dir $pwd/.asdf) {
    #     return
    #     # fail 1
    # } 

    var tmppath = $pwd

    {
        for i [0 0 0 0] {
            {
                if (eq $tmppath $E:HOME) {
                    fail 1 
                }
                if (path:is-regular $tmppath/.tool-versions) {
                    return
                } 
                if (path:is-dir $tmppath/.git) {
                    fail 1
                } 
                if (path:is-dir $tmppath/.asdf) {
                    fail 1
                } 
            }
            set tmppath = $tmppath/../
        }
    }

    fail 1
}

set edit:before-readline = [
    # osc7 escape sequence
    { printf "\e]7;file://"$E:HOSTNAME$pwd"\e\\" }

    # this is fix for asdf performance issue
    {
        set paths = [(
            if ?(asdf-available) {
                put $@paths | { 
                    put ~/.asdf/bin ~/.asdf/shims
                    each { |x|
                        if (not (str:contains $x "/.asdf")) { 
                            put $x
                        } 
                    }; 
                }
            } else {
                put $@paths | { 
                    each { |x| 
                        if (not (str:contains $x "/.asdf")) { 
                            put $x
                        } 
                    }; 
                    put ~/.asdf/bin ~/.asdf/shims
                }
            }
        )]
    }
]
