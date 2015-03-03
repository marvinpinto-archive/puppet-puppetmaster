class puppetmaster {

  include 'puppetmaster::puppet_package'
  include 'puppetmaster::nginx_passenger_package'
  include 'puppetmaster::configure'

}
