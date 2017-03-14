# == Class: kibana5::service
#
# Manages the Kibana5 service and restarts it as necessary.
#
# === Parameters
#
# See the kibana5 class
#
# === Authors
#
# Matt Wise <matt@nextdoor.com>
#
class kibana5::service (
  $ensure           = $kibana5::service_ensure,
  $enable           = $kibana5::service_enable,
  $provider         = $kibana5::service_provider,
  $service_name     = $kibana5::service_name,
  $service_template = $kibana5::service_template,
) inherits kibana5 {

  if ($kibana5::manage_service_file) {
    file { "/lib/systemd/system/${service_name}.service":
      ensure  => present,
      mode    => '0644',
      content => template($service_template),
      group   => 'root',
      owner   => 'root',
    }
    $require = File["/lib/systemd/system/${service_name}.service"]
  } else {
    $require = undef
  }

  service { $service_name:
    ensure     => $ensure,
    enable     => $enable,
    name       => 'kibana',
    provider   => $provider,
    hasstatus  => true,
    hasrestart => true,
    require    => $require,
  }
}
