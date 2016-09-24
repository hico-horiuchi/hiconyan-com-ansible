require 'spec_helper'

describe package('python-pip') do
  it { should be_installed }
end

describe command('pip list | grep docker-py') do
  its(:stdout) { should match /^docker-py \([0-9.]+\)$/ }
  its(:exit_status) { should eq 0 }
end
