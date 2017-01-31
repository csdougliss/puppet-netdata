# puppet-netdata

Instructions:

class { "::netdata":
}

Optional Params:

class { "::netdata":
    memory_de_depulication => true
}

Requirements:

https://github.com/puppetlabs/puppetlabs-stdlib
https://github.com/puppetlabs/puppetlabs-vcsrepo
https://github.com/Element84/puppet-make
