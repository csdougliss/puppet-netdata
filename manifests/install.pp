class netdata::install inherits netdata {

  $netdata_ubuntu_packages = [

    'zlib1g-dev', 'uuid-dev', 'libmnl-dev', 'gcc', 'make', 'git',
    'autoconf', 'autoconf-archive', 'autogen', 'automake', 'pkg-config',
    'curl'
  ]

  package { $netdata_ubuntu_packages:
    ensure => 'present'
  }

  $netdata_centos_packages = [

    'autoconf', 'automake', 'curl', 'gcc', 'git', 'libmnl-devel', 'libuuid-devel', 'lm_sensors',
    'make', 'MySQL-python', 'nc', 'pkgconfig', 'python', 'python-psycopg2',
    'PyYAML', 'zlib-devel'
  ]

  case $::operatingsystem {
    /(?i:debian|ubuntu)/: {
      package { $netdata_ubuntu_packages:
        ensure => 'present'
      }
    }
    /(?i:redhat|centos)/: {
      package { $netdata_centos_packages:
        ensure => 'present'
      }
    }
    default: {
      fail("Module ${module_name} has no config for ${::operatingsystem}")
    }
  }
}
