require 'spec_helper'

describe service('ssh') do
  it { should be_enabled }
  it { should be_running }
end

describe port(22) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
  it { should be_listening.on('::').with('tcp6') }
end

if property['ssh_disable_password_auth']
  describe file('/etc/ssh/sshd_config') do
    it { should be_file }
    its(:content) { should match /^PasswordAuthentication no$/ }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

describe command('ufw status | grep OpenSSH') do
  its(:stdout) { should match /OpenSSH\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end
