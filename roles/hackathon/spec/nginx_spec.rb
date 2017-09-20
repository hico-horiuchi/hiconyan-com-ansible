require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe command('ufw status | grep Nginx\ Full') do
  its(:stdout) { should match /Nginx Full\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end

%w(80 443).each do |item|
  describe port(item) do
    it {  should be_listening.on('0.0.0.0').with('tcp') }
  end
end

describe file('/etc/nginx/nginx.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/nginx/sites-enabled/default') do
  it { should_not exist }
end
