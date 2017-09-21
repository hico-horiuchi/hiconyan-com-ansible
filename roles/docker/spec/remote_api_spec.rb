require 'spec_helper'

%w(ca.pem server-cert.pem server-key.pem).each do |item|
  describe file("/etc/docker/#{item}") do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

describe file('/lib/systemd/system/docker.service') do
  it { should contain "ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:#{property['docker_remote_api_port']} --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem" }
end

describe port(property['docker_remote_api_port']) do
  it { should be_listening.on('::').with('tcp6') }
end
