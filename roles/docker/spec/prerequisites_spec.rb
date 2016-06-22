require 'spec_helper'

['apt-transport-https', 'ca-certificates', "linux-image-extra-#{host_inventory['kernel']['release']}"].each do |item|
  describe package(item) do
     it { should be_installed }
  end
end

describe command('apt-key list | grep docker') do
  its(:stdout) { should contain 'Docker Release Tool' }
  its(:exit_status) { should eq 0 }
end

describe file('/etc/apt/sources.list.d/docker.list') do
  it { should be_file }
  it { should contain "deb https://apt.dockerproject.org/repo #{host_inventory['platform']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
