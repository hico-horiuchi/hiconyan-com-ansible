require 'spec_helper'

describe docker_image('telegraf') do
  it { should exist }
end

property['clone_numbers'].each do |item|
  describe docker_container("telegraf-#{item}") do
    its(['HostConfig.NetworkMode']) { should eq property['docker_network'] }
    it { should exist }
    it { should be_running }
    it { should have_volume('/etc/telegraf', "/etc/docker/telegraf-#{item}") }
  end
end
