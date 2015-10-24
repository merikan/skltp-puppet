# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos-6.3-64bit-puppet-vbox"
  #config.vm.box_url = "http://packages.vstone.eu/vagrant-boxes/centos/6.3/centos-6.3-64bit-puppet-vbox.4.2.6.box"

#  config.vm.define :esbserver do |esb|
#    esb.vm.network :private_network, ip: "33.33.33.15"
#    esb.vm.hostname = "esbserver.local"
#    esb.vm.provision :puppet do |puppet|
#      puppet.manifests_path = "puppet/manifests"
#      puppet.module_path = "puppet/modules"
#      puppet.manifest_file = "esbserver.pp"
#      puppet.working_directory = "/vagrant/puppet/manifests"
#      puppet.options = "--verbose --debug"
#    end
#    # Activemq default port
#    esb.vm.forward_port 61616, 61616
#    # Activemq web console
#    esb.vm.forward_port 8161, 8161
#  end

#  config.vm.define :appserver do |app|
#    app.vm.network :private_network, ip: "33.33.33.20"
#    app.vm.hostname = "appserver.local"
#    app.vm.provision :puppet do |puppet|
#      puppet.manifests_path = "puppet/manifests"
#      puppet.module_path = "puppet/modules"
#      puppet.manifest_file = "appserver.pp"
#      puppet.working_directory = "/vagrant/puppet/manifests"
#      puppet.options = "--verbose --debug"
#    end
#    # tomcat
#    app.vm.forward_port 8080, 8080
#    # jboss
#    app.vm.forward_port 10002, 8082
#  end

#  config.vm.define :dbserver do |db|
#    db.vm.network :private_network, ip: "33.33.33.25"
#    db.vm.hostname = "dbserver.local"
#    db.vm.provision  :puppet do  |puppet|
#      puppet.manifests_path = "puppet/manifests"
#      puppet.module_path = "puppet/modules"
#      puppet.manifest_file = "dbserver.pp"
#      puppet.working_directory = "/vagrant/puppet/manifests"
#      puppet.options = "--verbose --debug"
#    end
#    # Mysql
#    db.vm.forward_port 3306, 3306
#  end

  config.vm.define :singleserver do |single|
    single.vm.box = "merikan/centos6.4-32bit-puppet"
    #single.vm.box_url = "ftp://skltp%40merikan.com:skltp@merikan.com/vagrant-boxes/centos-6.4-32bit-puppet-vbox.box"
    single.vm.network :private_network, ip: "33.33.33.33"
    single.vm.hostname = "singleserver.local"
    single.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
    single.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "singleserver.pp"
      puppet.working_directory = "/vagrant/puppet/manifests"
      puppet.options = "--verbose --debug"

    end
  end

  config.vm.define :debian do |debian|
    debian.vm.box = "merikan/debian6.0-32bit-puppet-vbox"
    debian.vm.network :private_network, ip: "33.33.33.33"
    debian.vm.hostname = "singleserver.local"
    debian.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--memory", 2048]
    end
    debian.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "singleserver.pp"
      puppet.working_directory = "/vagrant/puppet/manifests"
      puppet.options = "--verbose --debug"

    end
  end

  config.vm.define :desktop do |desktop|
    desktop.vm.box = "merikan/centos6.5-32bit-desktop-puppet"
    desktop.vm.network :private_network, ip: "33.33.33.33"
    desktop.vm.hostname = "desktop.local"
    desktop.vm.boot_timeout = 150
    desktop.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--vram", "24"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    desktop.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "desktop.pp"
      puppet.working_directory = "/vagrant/puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define :devreactive do |desktop|
    desktop.vm.box = "merikan/centos6.5-32bit-desktop-puppet"
    desktop.vm.network :private_network, ip: "33.33.33.35"
    desktop.vm.hostname = "desktop.local"
    desktop.vm.boot_timeout = 150
    desktop.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--vram", "24"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    desktop.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "devreactive.pp"
      puppet.working_directory = "/vagrant/puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define :microservices do |desktop|   
    desktop.vm.box = "merikan/centos6.5-32bit-desktop-puppet"
# 
#    desktop.vm.box = "puppetlabs/centos-7.0-64-puppet"
#    desktop.vm.box_version = "=1.0.1"
#    Seems to be a problem with the latest version of the box, puppetlabs/centos-7.0-64-puppet v1.0.2.
#    Error message: Error: Could not parse application options: invalid option: --manifestdir
#    For details, see https://tickets.puppetlabs.com/browse/PUP-4974
#    Using v1.0.1 for now

#    Other boxes I've tried...
#    https://vagrantcloud.com/box-cutter/boxes/centos70-docker
#    desktop.vm.box = "box-cutter/centos70-docker" 
#    desktop.vm.box_version = "=2.0.3"
#    desktop.vm.box = "boxcutter/centos71-desktop"

    desktop.vm.network :private_network, ip: "33.33.33.36"
    desktop.vm.hostname = "desktop.local"
    desktop.vm.boot_timeout = 150
    desktop.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.memory = 4096
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--vram", "24"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    desktop.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
#      puppet.manifest_file = "devreactive.pp"
      puppet.manifest_file = "microservices.pp"
      puppet.working_directory = "/vagrant/puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define :shibboleth do |shibboleth|
    shibboleth.vm.box = "centos-6.4-32bit-puppet-vbox"
    #shibboleth.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-i386-v20130427.box"
    shibboleth.vm.box_url = "ftp://skltp%40merikan.com:skltp@merikan.com/vagrant-boxes/centos-6.4-32bit-puppet-vbox.box"

    shibboleth.vm.network :private_network, ip: "33.33.33.33"
    shibboleth.vm.hostname = "desktop.local"
    shibboleth.vm.boot_timeout = 150
    shibboleth.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--vram", "24"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    shibboleth.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "shibboleth.pp"
      puppet.working_directory = "/vagrant/puppet/manifests"
      puppet.options = "--verbose --debug"
    end
  end

end
