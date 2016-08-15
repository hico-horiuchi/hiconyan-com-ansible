require 'spec_helper'

%w(/etc/redis /var/redis).each do |item|
  describe file(item) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_grouped_into 'root' }
  end
end

describe file('/etc/redis/redis.conf') do
  it { should be_file }
  it { should contain "requirepass #{property['redis_password']}" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command("redis-cli -a #{property['redis_password']} INFO") do
  its(:exit_status) { should eq 0 }
end
