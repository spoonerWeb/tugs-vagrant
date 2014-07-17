# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/debian-7.4"

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.network "private_network", ip: "192.168.150.5"

  config.vm.synced_folder "www/", "/var/www", :owner => 'vagrant', :group => 'www-data', :mount_options => ['dmode=775,fmode=664']
end
