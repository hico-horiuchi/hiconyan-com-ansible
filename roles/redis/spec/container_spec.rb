describe docker_container('redis') do
  its(['HostConfig.PortBindings.6379/tcp']) { should eq [{ 'HostIp' => '0.0.0.0', 'HostPort' => '6379' }] }
  its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
  its(['HostConfig.RestartPolicy.MaximumRetryCount']) { should eq 0 }
  it { should exist }
  it { should be_running }
  it { should have_volume('/data', '/var/redis') }
  it { should have_volume('/usr/local/etc/redis/redis.conf', '/etc/redis/redis.conf') }
end

describe port(6379) do
  it { should be_listening.on('::').with('tcp6') }
end
