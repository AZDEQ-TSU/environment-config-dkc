#
# Install and configure apache
#
# Class: profile:apache
#
#
class profile::apache {
  package { 'httpd':
    ensure => 'present',
  }
  service { 'httpd':
    ensure => 'running',
    enable => true,
  }
  package { 'php':
    ensure => 'present'
  }
  file { '/var/www/html/phpinfo.php':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "<?php\nphpinfo();\n?>"
  }
}
