require 'spec_helper'

describe command('ufw status | grep 8888/tcp') do
  its(:stdout) { should match /8888\/tcp\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end

describe port(8888) do
  it {  should be_listening.on('::').with('tcp6') }
end
