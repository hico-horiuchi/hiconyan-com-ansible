require 'spec_helper'

describe file('/etc/ssh/sshd_config') do
  it { should be_file }
  its(:content) { should match /^PasswordAuthentication no$/ }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command('ufw status | grep OpenSSH') do
  its(:stdout) { should match /^OpenSSH\s+ALLOW\s+Anywhere$/ }
  its(:exit_status) { should eq 0 }
end

describe port(22) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
  it { should be_listening.on('::').with('tcp6') }
end
