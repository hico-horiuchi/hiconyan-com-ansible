require 'spec_helper'

describe command("ufw status | grep 8086/tcp") do
  its(:stdout) { should match /8086\/tcp\s+ALLOW\s+Anywhere/ }
  its(:exit_status) { should eq 0 }
end

describe port(8086) do
  it {  should be_listening.on('::').with('tcp6') }
end
