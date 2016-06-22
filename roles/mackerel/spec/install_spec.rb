require 'spec_helper'

%w(mackerel-agent mackerel-agent-plugins).each do |item|
  describe package(item) do
    it { should be_installed }
  end
end
