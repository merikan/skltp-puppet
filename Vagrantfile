# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos-6.3"
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  #config.vm.provision :puppet, :module_path => "puppet/modules"


  # config for the appserver box
  config.vm.define :appserver do |app|
    app.vm.network :hostonly, "33.33.33.20"
    app.vm.host_name = "appserver.local"
    app.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "appserver.pp"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define :dbserver do |db|
      db.vm.network :hostonly, "33.33.33.30"
      db.vm.host_name = "dbserver.local"
      db.vm.provision  :puppet do  |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "dbserver.pp"
      puppet.options = "--verbose --debug"
      end
  end

end
