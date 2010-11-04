define ssh::sshkey ($host_aliases) {
    # Now add the key, if we've got one
    case $sshrsakey {
        '': { 
            notify { "no sshrsakey on $fqdn": }
            err("no sshrsakey on $fqdn")
        }
        default: {
            case $host_aliases {
                '': {
                    @@sshkey { "$fqdn":
                        type         => ssh-rsa,
                        key          => $sshrsakey,
                        ensure       => present,
                        require      => Package["openssh-client"],
                    }
                }
                default: {
                    @@sshkey { "$fqdn":
                        type         => ssh-rsa,
                        key          => $sshrsakey,
                        ensure       => present,
                        host_aliases => $host_aliases,
                        require      => Package["openssh-client"],
                    }
                }
            }
        }
    }
}

# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=4:et:
