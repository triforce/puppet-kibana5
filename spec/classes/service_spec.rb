require 'spec_helper'

describe 'kibana5::service', :type => 'class' do
  context 'ubuntu' do
    let(:facts) { UBUNTU_FACTS }
    it do
      should compile.with_all_deps
      should contain_service('kibana5').with(
        'ensure'           => true,
        'enable'           => true,
        'provider'         => 'debian',
        'service_name'     => 'kibana',
        'service_template' => 'kibana5/kibana.service.erb')
    end
  end

  context 'redhat-7' do
    let(:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystemmajrelease => '7',
    }}
    it do
      should compile.with_all_deps
      should contain_service('kibana5').with(
        'ensure'           => true,
        'enable'           => true,
        'provider'         => 'systemd',
        'service_name'     => 'kibana',
        'service_template' => 'kibana5/kibana.service.erb')
    end
  end

  context 'redhat-8' do
    let(:facts) {{
      :osfamily                  => 'RedHat',
      :operatingsystemmajrelease => '8',
    }}
    it do
      should compile.with_all_deps
      should contain_service('kibana5').with(
        'ensure'           => true,
        'enable'           => true,
        'provider'         => 'init',
        'service_name'     => 'kibana',
        'service_template' => 'kibana5/kibana.service.erb')
    end
  end

end
