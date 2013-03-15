# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos-6.3"
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  #config.vm.provision :puppet, :module_path => "puppet/modules"


  # config for the appserver box
  config.vm.define "appserver" do |app|
    #app.vm.boot_mode = :gui
    app.vm.network :hostonly, "33.33.34.10"
    app.vm.host_name = "appserver01.local"
    app.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file = "appserver.pp"
      puppet.options = "--verbose --debug"
    end
  end

  # config for the dbserver box
  #config.vm.define "dbserver" do |db|
  #  #db.vm.boot_mode = :gui
  #  db.vm.network :hostonly, "33.33.34.11"
  #  db.vm.host_name = "dbserver01.local"
  #  db.vm.provision :puppet do |puppet|
  #    puppet.manifests_path = "puppet/manifests"
  #    puppet.manifest_file = "dbserver.pp"
  #  end
  #end

end
