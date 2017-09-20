require 'spec_helper'

describe docker_image('telegraf') do
  it { should exist }
end

describe docker_container("telegraf") do
  it { should exist }
  it { should be_running }
  it { should have_volume('/etc/telegraf', "/etc/docker/telegraf") }
end
