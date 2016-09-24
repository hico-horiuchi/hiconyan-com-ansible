require 'spec_helper'

describe command('ufw status verbose') do
  its(:stdout) { should match /^Status: active$/ }
  its(:stdout) { should match /^Default: deny \(incoming\), allow \(outgoing\), deny \(routed\)$/ }
  its(:exit_status) { should eq 0 }
end
