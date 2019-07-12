#
#Install and configure MySQL Server
#

# Class: profile::mysql
#
#
class profile::mysql {
  package { 'mysql-server':
    ensure => 'present'
  }
}
