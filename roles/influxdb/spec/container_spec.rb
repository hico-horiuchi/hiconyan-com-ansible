require 'spec_helper'

describe file('/var/docker/influxdb') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe docker_image('influxdb') do
  it { should exist }
end

describe docker_container('influxdb') do
  its(['HostConfig.PortBindings.8086/tcp']) { should eq [{ 'HostIp' => '0.0.0.0', 'HostPort' => '8086'}] }
  it { should exist }
  it { should be_running }
  it { should have_volume('/var/lib/influxdb', '/var/docker/influxdb') }
end
