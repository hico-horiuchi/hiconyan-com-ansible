require 'spec_helper'

describe command('apt-key list | grep packagecloud') do
  its(:stdout) { should contain 'packagecloud ops' }
  its(:exit_status) { should eq 0 }
end

describe file('/etc/apt/sources.list.d/dokku.list') do
  it { should be_file }
  it { should contain "deb https://packagecloud.io/dokku/dokku/#{host_inventory['platform']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
