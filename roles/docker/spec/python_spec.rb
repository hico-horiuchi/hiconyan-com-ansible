require 'spec_helper'

%w(python-pip python3-pip).each do |item|
  describe package(item) do
    it { should be_installed }
  end
end

%w(pip pip3).each do |item|
  describe command("#{item} list | grep docker-py") do
    its(:stdout) { should match /^docker-py \([0-9.]+\)$/ }
    its(:exit_status) { should eq 0 }
  end
end
