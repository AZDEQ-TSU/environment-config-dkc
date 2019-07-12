#
# This role contains all the profiles for webserver
# 

class role::webserver {

#All roles should include the base profile
  include profile::base
  include profile::apache
  include profile::mysql
}
