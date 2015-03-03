class puppetmaster::nginx_passenger_package {

  package { 'apt-transport-https':
    ensure => installed,
  }

  apt::source { 'phusionpassenger':
    location    => 'https://oss-binaries.phusionpassenger.com/apt/passenger',
    repos       => 'main',
    key         => '561F9B9CAC40B2F7',
    key_server  => 'keyserver.ubuntu.com',
    include_src => false,
    require     => Package['apt-transport-https'],
  }

  package { 'nginx-extras':
    ensure  => installed,
    require => Apt::Source['phusionpassenger'],
  }

  package { 'passenger':
    ensure  => installed,
    require => Apt::Source['phusionpassenger'],
  }

}
