# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "prod" do |prod|

    prod.vm.hostname = "prod"
    prod.vm.box = "puppetlabs/centos-7.0-64-nocm"

    prod.vm.network "private_network", ip: "10.42.42.42"

    prod.vm.synced_folder "./scripts", "/scripts"

    prod.vm.provision "shell", inline: <<-SHELL
      echo Installing prerequisites.
      yum -y install http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
      yum -y install ansible
      echo Running ansible playbook.
      ansible-playbook -v -S /scripts/setup_mysql.yml -e @/scripts/prod_vars.yml
    SHELL

  end

  config.vm.define "test" do |test|
    test.vm.hostname = "test"
    test.vm.box = "puppetlabs/centos-7.0-64-nocm"

    test.vm.network "private_network", ip: "10.42.42.43"

    test.vm.synced_folder "./scripts", "/scripts"

    test.vm.provision "shell", inline: <<-SHELL
      echo Installing prerequisites.
      yum -y install http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
      yum -y install ansible
      echo Running ansible playbook.
      ansible-playbook -v -S /scripts/setup_mysql.yml -e @/scripts/test_vars.yml 
    SHELL

  end

end


