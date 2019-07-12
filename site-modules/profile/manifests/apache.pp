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
  package { 'php':
    ensure => 'present'
  }
}
