#
# This module manages netdata.
#
# Sample Usage:
#
# node default {
#   include netdata
# }
#
class netdata(
) inherits netdata::params {
  contain netdata::install
  contain netdata::config
  #contain netdata::service

  Class['::netdata::install'] ->
  Class['::netdata::config'] # ~>
  #Class['::netdata::service']
}
