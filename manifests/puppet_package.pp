class puppetmaster::puppet_package {

  package { 'puppetmaster':
    ensure  => installed,
    require => Apt::Source['puppetlabs'],
  }

  service { 'puppetmaster':
    ensure  => stopped,
    enable  => false,
    require => Package['puppetmaster'],
  }

  file_line { 'etc-default-puppetmaster-start':
    path  => '/etc/default/puppetmaster',
    line  => 'START=no',
    match => '^START=.*$',
  }

}
