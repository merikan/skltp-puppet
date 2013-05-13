# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos-6.3-64bit"
  config.vm.box_url = "http://packages.vstone.eu/vagrant-boxes/centos/6.3/centos-6.3-64bit-puppet.3.x-vbox.4.2.6.box"

  config.vm.define :esbserver do |esb|
    esb.vm.network :hostonly, "33.33.33.15"
    esb.vm.host_name = "esbserver.local"
    esb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "esbserver.pp"
      puppet.options = "--verbose --debug"
    end
    # Activemq default port
    esb.vm.forward_port 61616, 61616
    # Activemq web console
    esb.vm.forward_port 8161, 8161

  end

  config.vm.define :appserver do |app|
    app.vm.network :hostonly, "33.33.33.20"
    app.vm.host_name = "appserver.local"
    app.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "appserver.pp"
      puppet.options = "--verbose --debug"
    end
    # tomcat
    app.vm.forward_port 8080, 8080
    # jboss
    app.vm.forward_port 10002, 8082
  end

  config.vm.define :dbserver do |db|
    db.vm.network :hostonly, "33.33.33.25"
    db.vm.host_name = "dbserver.local"
    db.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "dbserver.pp"
      puppet.options = "--verbose --debug"
    end
    # Mysql
    db.vm.forward_port 3306, 3306
  end

  config.vm.define :singleserver do |single|
    single.vm.network :hostonly, "33.33.33.33"
    single.vm.host_name = "singleserver.local"
    single.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "singleserver.pp"
      puppet.options = "--verbose --debug"
    end
  end

end
