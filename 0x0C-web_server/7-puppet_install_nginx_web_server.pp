class nginx {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => present,
    content => '
      server {
        listen 80;
        server_name _;
        root /var/www/html;
        
        location / {
          proxy_pass http://localhost:8080;
        }
        
        location /redirect_me {
          return 301 http://www.example.com/;
        }
      }
    ',
    notify  => Service['nginx'],
  }

  file { '/var/www/html/index.html':
    ensure  => present,
    content => 'Hello World!',
    notify  => Service['nginx'],
  }
}

include nginx
