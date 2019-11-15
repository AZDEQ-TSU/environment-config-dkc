#
# Tomcat
#

class profile::tomcat {

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
        source_url    => 'puppet:///modules/profile/apache-tomcat-9.0.24.tar.gz',
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
}
