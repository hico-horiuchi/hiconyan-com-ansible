## hiconyan.com Ansible Playbooks

#### Preparations

    $ brew install ansible git
    $ sudo gem install bundler
    $ git clone git@github.com:hico-horiuchi/hiconyan-com-ansible.git

#### Ansible

    $ cd hiconyan-com-ansible
    $ cp hosts_samples/hosts.conoha hosts
    $ vi ~/.vault_password
    $ ansible-playbook -i hosts site.yml

#### Serverspec

    $ cd hiconyan-com-ansible
    $ bundle install --jobs=4 --path=vendor/bundler --binstubs=vendor/bin
    $ bundle exec rake serverspec:all
