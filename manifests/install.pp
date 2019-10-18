class rocketchat::install(
  $download_path,
  $destination,
  $package_ensure,
  $package_source,
) {
  include archive

  $file_path = "${download_path}/rocket.tgz"

  $source = $package_source ? {
    undef   => "https://download.rocket.chat/${package_ensure}",
    default => "${package_source}/rocket.chat-${package_ensure}.tgz",
  }

  file { $destination:
    ensure => directory,
  }

  archive { 'Download stable Rocket.Chat package':
    path         => $file_path,
    source       => $source,
    extract      => true,
    extract_path => $destination,
    creates      => "${destination}/bundle/server",
    require      => File[$destination],
  }

  exec { 'npm install':
    cwd     => "${destination}/bundle/programs/server/",
    creates => "${destination}/bundle/programs/server/node_modules/",
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin',
    require => [Archive[$file_path], Class['rocketchat::packages']],
  }
}
