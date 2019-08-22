#
# Install and configure apache
#
# Class: profile:apache
#
#
class profile::apache {
  package { 'httpd':
    ensure => present,
  }
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  package { 'php':
    ensure => present
  }
  file { '/var/www/html/phpinfo.php':
    ensure  => present,
    notify  => Service['httpd'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "<?php\nphpinfo();\n?>"
  }
  file { '/var/www/html/index.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "<html>\n<a href=phpinfo.php>PHP Information</a>\n</html>"
  }
  file { '/var/www/html/NUTRITION.pdf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/profile/NUTRITION.pdf',
    }
  file { '/var/www/html/ojdbc6.jar':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/profile/ojdbc6.jar',
    }
}
