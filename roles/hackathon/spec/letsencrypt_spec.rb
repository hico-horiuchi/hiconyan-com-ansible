require 'spec_helper'

describe package('letsencrypt') do
  it { should be_installed }
end

['/var/www/letsencrypt', "/etc/letsencrypt/live/#{ENV['TARGET_HOST']}"].each do |item|
  describe file(item) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

describe file('/etc/nginx/dhparams.pem') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
