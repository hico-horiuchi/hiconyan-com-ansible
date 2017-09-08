require 'spec_helper'

describe command('ls /root/.*_history /home/ubuntu/.*_history') do
  its(:exit_status) { should eq 2 }
end
