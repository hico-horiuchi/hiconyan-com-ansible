require 'spec_helper'

describe file('/var/docker/chronograf') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe docker_image('chronograf') do
  it { should exist }
end

describe docker_container('chronograf') do
  its(['HostConfig.PortBindings.8888/tcp']) { should eq [{ 'HostIp' => '0.0.0.0', 'HostPort' => '8888'}] }
  it { should exist }
  it { should be_running }
  it { should have_volume('/var/lib/chronograf', '/var/docker/chronograf') }
end
