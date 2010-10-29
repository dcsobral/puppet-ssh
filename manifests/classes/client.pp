# ssh/manifests/init.pp - common ssh related components
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

class ssh::client inherits ssh::common {
    package { 'openssh-client':
        ensure  => installed,
        require => [ File['/etc/ssh'], Group['ssh'] ],
    }

    # this is needed because the gid might have changed
    file {
        '/usr/bin/ssh-agent':
            group   => 'ssh',
            require => Package['openssh-client'];
        '/etc/ssh/ssh_known_hosts':
            mode  => 0644,
            owner => root,
            group => 0;
    }
    
    # Now collect all server keys
    Sshkey <<||>>
}

# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=4:et:
