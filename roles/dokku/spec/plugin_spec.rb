require 'spec_helper'

property['dokku_plugins'].each do |item|
  describe command("dokku plugin | grep #{item['name']}") do
    its(:stdout) { should match /#{item['name']}\s+[0-9\.]+\s+enabled/ }
    its(:exit_status) { should eq 0 }
  end
end
