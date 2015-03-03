class puppetmaster::package {

  package { 'puppetmaster':
    ensure  => installed,
    require => Apt::Source['puppetlabs'],
  }

}
