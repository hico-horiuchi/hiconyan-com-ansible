require 'spec_helper'

unless ENV['TARGET_USER'] == 'root'
  describe user(ENV['TARGET_USER']) do
    it { should belong_to_group 'sudo' }
  end
end
