
# Define an exec resource to kill the process named "killmenow"
exec { 'killmenow_process':
  command     => 'pkill -f killmenow',
  path        => '/usr/bin:/bin', # Modify this path according to your system's environment
  refreshonly => true,
}

