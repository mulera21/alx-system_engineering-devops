# Define a class to install and configure Nginx
class webserver {
  package { 'nginx':
    ensure => 'installed',
  }

  service { 'nginx':
    ensure    => 'running',
    enable    => true,
    require   => Package['nginx'],
  }

  # Configure the Nginx server block for the root path
  file { '/etc/nginx/sites-available/default':
    ensure  => 'file',
    content => template('my_module/nginx_config.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  # Create a custom Nginx configuration file for redirection
  file { '/etc/nginx/sites-available/redirect':
    ensure  => 'file',
    content => template('my_module/redirect_config.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  # Enable the redirect site
  file { '/etc/nginx/sites-enabled/redirect':
    ensure  => 'link',
    target  => '/etc/nginx/sites-available/redirect',
    require => File['/etc/nginx/sites-available/redirect'],
  }
}

# Include the class to apply the Nginx configuration
include webserver
