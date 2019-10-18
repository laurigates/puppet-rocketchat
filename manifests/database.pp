# Class that install and configures MongoDB database for Rocket.Chat
class rocketchat::database (
  $port,
  $verbose,
  $manage_repos,
){

  if ($manage_repos == true) {
    class { '::mongodb::globals':
      manage_package_repo => true,
      version             => '3.6.12',
      before              => Class['::mongodb::server']
    }
  }

  class {'::mongodb::server':
    port           => $port,
    verbose        => $verbose,
    service_manage => false,
  }
}
