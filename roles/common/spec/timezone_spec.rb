require 'spec_helper'

describe command('timedatectl') do
  its(:stdout) { should match /Time zone: Asia\/Tokyo \(JST, \+0900\)/ }
  its(:exit_status) { should eq 0 }
end
