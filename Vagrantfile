# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "prod" do |prod|

    prod.vm.hostname = "prod"
    prod.vm.box = "puppetlabs/centos-7.0-64-nocm"

    prod.vm.network "forwarded_port", guest: 3306, host: 3307
    prod.vm.network "private_network", ip: "192.168.33.10"

    prod.vm.synced_folder "./scripts", "/scripts"

    prod.vm.provision "shell", inline: <<-SHELL
      yum -y update
      yum -y install http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
      yum -y install ansible
      ansible-playbook -S /scripts/setup_mysql.yml --extra-vars "db_name=prod db_user=prod_user\
        db_password=prod_password create_db_schema=true add_cron=yes"
      sudo echo "192.168.33.11 dev >> /etc/hosts"
    SHELL

  end

  config.vm.define "dev" do |dev|
    dev.vm.hostname = "dev"
    dev.vm.box = "puppetlabs/centos-7.0-64-nocm"

    dev.vm.network "forwarded_port", guest: 3306, host: 3308
    dev.vm.network "private_network", ip: "192.168.33.11"

    dev.vm.synced_folder "./scripts", "/scripts"

    dev.vm.provision "shell", inline: <<-SHELL
      yum -y update
      yum -y install http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
      yum -y install ansible
      ansible-playbook -S /scripts/setup_mysql.yml --extra-vars "db_name=dev db_user=dev_user db_password=dev_password"
    SHELL

  end

end


