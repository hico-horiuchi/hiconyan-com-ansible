require 'spec_helper'

describe package('dokku') do
  it { should be_installed }
end

describe command('dokku plugin | grep dokku\ core | wc -l') do
  its(:stdout) { should eq "24\n" }
  its(:exit_status) { should eq 0 }
end

describe command('ufw status | grep Nginx\ Full') do
  its(:stdout) { should match /Nginx Full\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end

describe port(80) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end
