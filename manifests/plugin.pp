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
  $kibana5_plugin_dir = 'plugins',
  $url                = undef,
) {

  include ::kibana5
  include ::kibana5::service
  $_install_dir = $::kibana5::install_dir
  $_bin_dir     = $::kibana5::bin_dir
  $_plugin_dir  = "${_install_dir}/${kibana5_plugin_dir}"

  if !$plugin_dest_dir {
    fail('you must define a plugin destination dir, such as `marvel`')
  }

  case $ensure {
    'present': {
      if !$url {
        exec { "install_kibana_plugin_${name}":
          command => "${_bin_dir}/kibana-plugin install ${name} -d ${_plugin_dir}/${plugin_dest_dir}",
          path    => "${_bin_dir}:/sbin:/bin:/usr/sbin:/usr/bin",
          creates => "${_plugin_dir}/${plugin_dest_dir}",
          notify  => Class['kibana5::service'];
        }
      } else {
        exec { "install_kibana_plugin_${name}":
          command => "${_bin_dir}/kibana-plugin install ${name} -u ${url} -d ${_plugin_dir}/${plugin_dest_dir}",
          path    => "${_bin_dir}:/sbin:/bin:/usr/sbin:/usr/bin",
          unless  => "test -d ${_plugin_dir}/${plugin_dest_dir}",
          notify  => Class['kibana5::service'];
        }
      }
    }

    'absent': {
        exec { "remove_kibana_plugin_${name}":
          command => "rm -rf ${_plugin_dir}/${plugin_dest_dir}",
          path    => '/sbin:/bin:/usr/sbin:/usr/bin',
          unless  => "test ! -d ${_plugin_dir}/${plugin_dest_dir}",
          notify  => Class['kibana5::service'];
        }
    }
    default: {
      fail('`ensure` should be either `present` or `absent`')
    }
  }
}
