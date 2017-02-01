class netdata::install inherits netdata {

  case $::operatingsystem {
    /(?i:debian|ubuntu)/: {
      ensure_packages(
        ['zlib1g-dev', 'uuid-dev', 'libmnl-dev', 'gcc',
          'autoconf', 'autoconf-archive', 'autogen', 'automake', 'pkg-config',
          'curl'],
        {'ensure' => 'present'})
    }
    /(?i:redhat|centos)/: {
      ensure_packages(
        [ 'autoconf', 'automake', 'curl', 'libmnl-devel', 'libuuid-devel', 'lm_sensors',
          'MySQL-python', 'nc', 'pkgconfig', 'python', 'python-psycopg2',
          'PyYAML', 'zlib-devel'],
        {'ensure' => 'present'})
      if !defined(Package['gcc']) {
        package { 'gcc':
          ensure => installed,
        }
      }
    }
    default: {
      fail("Module ${module_name} has no config for ${::operatingsystem}")
    }
  }

  # git is already defined in puppet module
  # make is already in make module

  # Optional package - used for monitoring mysql databases
  if($netdata::install_python_mysqldb) {
    if !defined(Package['python-mysqldb']) {
      package { 'python-mysqldb':
        ensure => installed,
      }
    }
  }

  # Optional package - used for monitoring elasticsearch
  if($netdata::install_python_requests) {
    if !defined(Package['python-requests']) {
      package { 'python-requests':
        ensure => installed,
      }
    }
  }

  # download it - the directory 'netdata' will be created
  vcsrepo { '/usr/local/src/netdata':
    ensure   => present,
    provider => git,
    source => 'https://github.com/firehol/netdata.git'
  }

  file { '/opt/netdata':
    ensure => 'directory'
  }

  # build it, install it, start it
  # cd netdata
  # ./netdata-installer.sh
  exec { 'exec_install_netdata':
    command => "/usr/local/src/netdata/netdata-installer.sh --install ${install_dir}",
    cwd     => '/usr/local/src/netdata',
    creates => '/etc/netdata',
    require => [ Vcsrepo['/usr/local/src/netdata'], File['/opt/netdata'] ]
  }

  # Memory de-duplication instructions - If you enable it, you will save 40-60% of netdata memory.
  # echo 1 >/sys/kernel/mm/ksm/run
  # echo 1000 >/sys/kernel/mm/ksm/sleep_millisecs
  if($netdata::memory_de_duplication) {
    sysctl::value {
      "kernel.mm.ksm.run": value => "1"
    }
    sysctl::value {
      "kernel.mm.ksm.sleep_millisecs": value => "1000"
    }
  }
}
