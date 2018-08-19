class nginx::install inherits nginx {
 
  $list = [ 'openssl', 'epel-release', 'nginx']
  package { $list:
    ensure => installed,
  }

}