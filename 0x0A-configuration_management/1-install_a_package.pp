# 1-install_a_package.pp

package { 'python3-pip':
  ensure => 'installed',
}

exec { 'install-flask':
  command => '/usr/bin/pip3 install Flask==2.1.0',
  creates => '/usr/local/lib/python3.8/dist-packages/Flask-2.1.0.dist-info',
  require => Package['python3-pip'],
}
