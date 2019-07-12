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
}
