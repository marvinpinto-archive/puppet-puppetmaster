class puppetmaster::nginx_service {

  require 'puppetmaster::configure'

  service { 'nginx':
    ensure    => running,
    enable    => true,
    restart   => '/usr/sbin/nginx reload',
    subscribe => Class['puppetmaster::configure'],
  }

}
