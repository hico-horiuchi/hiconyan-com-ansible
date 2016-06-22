require 'spec_helper'

describe command('apt-key list | grep mackerel') do
  its(:stdout) { should contain 'Hatena Inc' }
  its(:exit_status) { should eq 0 }
end

describe file('/etc/apt/sources.list.d/mackerel.list') do
  it { should be_file }
  it { should contain "deb http://apt.mackerel.io/debian/ mackerel contrib" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
