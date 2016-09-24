require 'spec_helper'

describe command('hostname') do
  its(:stdout) { should match /^#{ENV['TARGET_HOST']}$/ }
  its(:exit_status) { should eq 0 }
end
