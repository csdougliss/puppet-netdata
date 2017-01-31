# puppet-netdata

Instructions:

class { "::netdata":
}

Optional Params:

class { "::netdata":
    memory_de_depulication => true
}

Options:

install_python_mysqldb - for monitoring mysql
install_python_requests - for monitoring elastic search

Requirements:

https://github.com/puppetlabs/puppetlabs-stdlib
https://github.com/puppetlabs/puppetlabs-vcsrepo
https://github.com/Element84/puppet-make
https://github.com/example42/puppet-sysctl
