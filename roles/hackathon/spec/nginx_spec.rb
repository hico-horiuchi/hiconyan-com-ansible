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

describe file('/etc/nginx/nginx.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/nginx/sites-enabled/default') do
  it { should_not exist }
end

describe file('/etc/nginx/sites-enabled/letsencrypt') do
  it { should be_file }
  it { should contain "server_name #{ENV['TARGET_HOST']};" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/nginx/sites-enabled/hackathon') do
  it { should be_file }
  it { should contain "server_name #{ENV['TARGET_HOST']};" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
