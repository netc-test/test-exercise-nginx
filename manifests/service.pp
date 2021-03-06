class nginx::service inherits nginx {

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require => Package['nginx'],
  }

}