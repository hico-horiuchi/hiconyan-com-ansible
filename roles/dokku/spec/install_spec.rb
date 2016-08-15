require 'spec_helper'

describe package('dokku') do
  it { should be_installed }
end

describe command('dokku plugin | grep dokku\ core | wc -l') do
  its(:stdout) { should eq "24\n" }
  its(:exit_status) { should eq 0 }
end
