require 'spec_helper'

describe user(ENV['TARGET_USER']) do
  it { should belong_to_group 'sudo' }
end
