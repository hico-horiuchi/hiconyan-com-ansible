require 'spec_helper'

describe command('timedatectl') do
  its(:stdout) { should match /Time zone: #{property['timezone']}/ }
  its(:exit_status) { should eq 0 }
end
