## hiconyan.com Ansible Playbooks

#### Qiita

- [ConoHa + DokkuでプライベートPaaS構築](http://qiita.com/hiconyan/items/e4c6de6c2466bd3880c4)
- [Serverspecでansible-vaultの情報を使う](http://qiita.com/hiconyan/items/ea34da410a971bfa28ae)

#### Preparations

    $ brew install git
    $ easy_install pip
    $ pip install virtualenv
    $ sudo gem install bundler
    $ git clone git@github.com:hico-horiuchi/hiconyan-com-ansible.git

#### Ansible

    $ cd hiconyan-com-ansible
    $ virtualenv venv
    $ source venv/bin/activate
    $ pip install -r requirements.txt
    $ rehash
    $ cp hosts_samples/hosts.conoha hosts
    $ vi ~/.vault_password
    $ ansible-playbook -i hosts site.yml

#### Serverspec

    $ cd hiconyan-com-ansible
    $ bundle install --jobs=4 --path=vendor/bundler --binstubs=vendor/bin
    $ bundle exec rake serverspec:all
