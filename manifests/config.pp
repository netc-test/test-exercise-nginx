class nginx::config ( $setforwardproxy = 'true') inherits nginx {

  $nginx_dirs = [ '/etc/nginx', '/etc/nginx/conf.d', '/etc/ssl/private']
  file { $nginx_dirs:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
  }  

    
  file { '/etc/nginx/conf.d/ssl.conf':
    path    => '/etc/nginx/conf.d/ssl.conf',
    ensure  => file,
    owner  => "root",
    group =>"root",
    mode   => "644",
    require => [File['/etc/nginx/conf.d'], Exec['Generate self signed certs for nginx']],
    source  => "puppet:///modules/nginx/ssl.conf",
    notify => Service['nginx'],
  }


  exec {"Generate self signed certs for nginx":
    command => "openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj /C=ES/ST=Catalonia/L=Barcelona/O=NC/CN=${fqdn} -keyout /etc/ssl/private/nginx-selfsigned.key  -out /etc/ssl/certs/nginx-selfsigned.crt",
    path    => ["/usr/bin","/usr/sbin","/bin"],
    unless  => "test -e /etc/ssl/certs/nginx-selfsigned.crt",
  }

  if $setforwardproxy == 'true' {
     notify{"Puppet will verify that a forward proxy has been set on this server": }
     file { '/etc/nginx/conf.d/fw-proxy.conf':
     	  path    => '/etc/nginx/conf.d/fw-proxy.conf',
    	  ensure  => file,
    	  owner  => "root",
    	  group =>"root",
    	  mode   => "644",
    	  require => File['/etc/nginx/conf.d/ssl.conf'],
    	  source  => "puppet:///modules/nginx/fw-proxy.conf",
    	  notify => Service['nginx'],
  	  }
  } elsif $setforwardproxy == 'false' {
    	 notify{ "Puppet will remove the forward proxy in case it was set on this server": }
         file { '/etc/nginx/conf.d/fw-proxy.conf':
              path    => '/etc/nginx/conf.d/fw-proxy.conf',
              ensure  => absent,
              notify => Service['nginx'],
         }
  }
  else { notify{"No changes on the forward proxy state on this server": } 
  }


}