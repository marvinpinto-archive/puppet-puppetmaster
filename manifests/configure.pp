class puppetmaster::configure {

  require 'puppetmaster::puppet_package'
  require 'puppetmaster::nginx_passenger_package'

  file { '/etc/puppet/rack':
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0755',
  }

  file { '/etc/puppet/rack/public':
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0755',
  }

  file { '/etc/puppet/rack/tmp':
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0755',
  }

  file { '/etc/puppet/rack/config.ru':
    ensure => file,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0644',
    source => 'puppet:///modules/puppetmaster/config.ru',
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    content => template('puppetmaster/puppet.conf.erb'),
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source => 'puppet:///modules/puppetmaster/nginx.conf',
  }

  file { '/etc/nginx/conf.d/puppet.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppetmaster/nginx-puppet.conf.erb'),
  }

  $generate_ca_cmd = [
    '/usr/bin/puppet',
    'cert',
    'generate',
    $::fqdn,
  ]

  exec { 'generate-puppet-ca-cert':
    command   => shellquote($generate_ca_cmd),
    creates   => "/var/lib/puppet/ssl/certs/${::fqdn}.pem",
    logoutput => on_failure,
    umask     => '0022',
  }

}
