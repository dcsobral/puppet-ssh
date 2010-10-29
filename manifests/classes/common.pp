# ssh/manifests/init.pp - common ssh related components
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

class ssh::common {
    file { '/etc/ssh':
        ensure => directory,
        mode => 0755,
        owner => 'root',
        group => 'root',
    }
    group { 'ssh':
        gid => 204,
        allowdupe => false,
    }
}

# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=4:et:
