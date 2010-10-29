# ssh/manifests/classes/server.pp - common ssh related components
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

# Require:
#
# - $host_aliases: additional host aliases

class ssh::server inherits ssh::client {
    package { 'openssh-server':
            ensure => installed,
            require => [ File["/etc/ssh"], User[sshd] ],
    }

    user { 'sshd':
            uid       => 204, gid => 65534,
            home      => "/var/run/sshd",
            shell     => "/usr/sbin/nologin",
            allowdupe => false,
    }

    service { 'ssh':
            ensure    => running,
            pattern   => "sshd",
            require   => Package["openssh-server"],
            subscribe => [ User['sshd'], Group['ssh'] ]
    }

    $default_aliases = ["$hostname", "$ipaddress"]
    $host_aliases += $default_aliases 

    ssh::sshkey { "$fqdn": host_aliases => $host_aliases }
}

# vim modeline - have 'set modeline' and 'syntax on' in your ~/.vimrc.
# vi:syntax=puppet:filetype=puppet:ts=4:et:
