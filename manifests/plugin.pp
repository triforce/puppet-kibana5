# == Definition: kibana5::plugin
#
# Manages a Kibana5 plugin
#
# === Parameters
#
# ...
#
# === Authors
#
# Matt Wise <matt@nextdoor.com>
#
define kibana5::plugin (
  $ensure             = 'present',
  $plugin_dest_dir    = undef,
  $kibana5_plugin_dir = '/opt/kibana/installedPlugins',
  $url                = undef,
) {
}
