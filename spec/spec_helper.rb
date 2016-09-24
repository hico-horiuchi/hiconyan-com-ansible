require 'ansible/vault'
require 'ansible_spec'
require 'net/ssh'
require 'serverspec'
require 'yaml'

host = ENV['TARGET_HOST']
hosts = ENV['TARGET_HOSTS']
group_idx = ENV['TARGET_GROUP_INDEX'].to_i

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail 'highline is not available. Try installing it.'
  end
  set :sudo_password, ask('Enter sudo password: ') { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

options = Net::SSH::Config.for(host)
options[:user] ||= ENV['TARGET_USER']
options[:port] ||= ENV['TARGET_PORT']
options[:keys] ||= ENV['TARGET_PRIVATE_KEY']

set :backend,     :ssh
set :host,        options[:host_name] || host
set :ssh_options, options

vars = AnsibleSpec.get_variables(host, group_idx, hosts)
property = AnsibleSpec.get_properties[group_idx]
ansible_cfg = File.expand_path('../ansible.cfg', File.dirname(__FILE__))
vault_password_file = ''
vault_password = ''

File.open(ansible_cfg, 'r') do |f|
  vault_password_file = f.read.match(/^vault_password_file = (.+)$/)[1]
end

File.open(File.expand_path(vault_password_file), 'r') do |f|
  vault_password = f.read.chomp
end

property['roles'].each do |role|
  secret = "roles/#{role}/vars/secret.yml"
  if File.exist?(secret)
    vars.merge! YAML.load(Ansible::Vault.read(path: secret, password: vault_password))
  end
end

set_property vars
