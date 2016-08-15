require 'spec_helper'

describe file('/etc/nginx/conf.d/status.conf') do
  it { should be_file }
  its(:content) { should match /listen\s+8080;/ }
  its(:content) { should match /location\s+\/nginx_status/ }
  its(:content) { should match /stub_status\s+on;/ }
  its(:content) { should match /access_log\s+off;/ }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe command('ufw status | grep Nginx\ Full') do
  its(:stdout) { should match /Nginx Full\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end

describe port(80) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end
