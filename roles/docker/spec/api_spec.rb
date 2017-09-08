require 'spec_helper'

describe file('/lib/systemd/system/docker.service') do
  it { should contain "ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:#{property['docker_api_port']}" }
end

describe port(property['docker_api_port']) do
  it { should be_listening.on('::').with('tcp6') }
end
