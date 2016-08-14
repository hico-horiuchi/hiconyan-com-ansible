require 'spec_helper'

describe file('/etc/redis/redis.conf') do
  it { should be_file }
  it { should contain 'bind 0.0.0.0' }
  it { should contain "requirepass #{property['redis_password']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe port(6379) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end

describe command("redis-cli -a #{property['redis_password']} INFO") do
  its(:stdout) { should contain 'tcp_port:6379' }
  its(:exit_status) { should eq 0 }
end
