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
class profilelinux::mydeqtomcat {

group { 'tomcat':
  gid => 1008,
}
-> user { 'tomcat':
  ensure     => present,
  uid        => '1008',
  gid        => '1008',
  groups     => 'tomcat',
  comment    => 'Tomcat Service App account',
  shell      => '/bin/bash',
  home       => '/data/tomcat',
  managehome => true,
}
-> file_line { 'check-bash-profile-JAVA_OPTS':
    ensure  => present,
    path    => '/data/tomcat/.bash_profile',
    replace => true,
    line    => 'export JAVA_OPTS="-Dspring.profiles.active=prod"',
    match   => 'export JAVA_OPTS=.*$',
}
-> file_line { 'check-bash-profile-umask':
    ensure  => present,
    path    => '/data/tomcat/.bash_profile',
    replace => true,
    line    => 'export UMASK=0002',
    match   => 'export UMASK.*$',
}
-> tomcat::install { '/data/tomcat':
        source_url    => 'puppet:///modules/profile/bin/apache-tomcat-9.0.24.tar.gz',
        catalina_home => '/data/tomcat',
        manage_user   => false,
        manage_group  => false,
}
-> tomcat::instance { 'tomcat':
        catalina_home => '/data/tomcat',
        manage_dirs   => true,
        dir_list      => ['bin','conf','lib','logs','temp','webapps','work'],
        dir_mode      => '0755',
}
