require 'spec_helper'

describe file('/etc/systemd/journald.conf') do
  it { should contain 'Storage=persistent' }
end

describe file('/var/log/journal') do
  it { should be_directory }
  it { should be_mode 2755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'systemd-journal' }
end
