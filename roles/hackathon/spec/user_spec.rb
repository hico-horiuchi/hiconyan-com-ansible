require 'spec_helper'

describe user('ninja') do
  it { should exist }
  it { should belong_to_group 'docker' }
  it { should have_login_shell '/bin/bash' }
end
