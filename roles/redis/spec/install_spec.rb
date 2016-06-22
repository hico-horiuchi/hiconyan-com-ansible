require 'spec_helper'

describe package('redis-server') do
  it { should be_installed }
end

describe service('redis-server') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/ufw/applications.d/redis-server') do
  it { should be_file }
  it { should contain 'ports=6379/tcp' }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command('ufw status | grep Redis') do
  its(:stdout) { should match /Redis\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end
