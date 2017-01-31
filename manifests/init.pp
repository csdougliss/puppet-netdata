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
  $install_dir  = $netdata::params::install_dir,
  $memory_de_duplication = $netdata::params::memory_de_duplication
) inherits netdata::params {
  contain netdata::install
  contain netdata::config
  #contain netdata::service

  Class['::netdata::install'] ->
  Class['::netdata::config'] # ~>
  #Class['::netdata::service']
}
