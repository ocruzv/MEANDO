# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    provider.client_id = 'MPSTBhRef74OyiYe4D4C3' 
    provider.api_key = '45e5cad031e9160e9d62b706ea93dfdb'

    provider.image = "CentOS 6.5 x64"
    provider.region = "New York 2"
    provider.ca_path = "/etc/ssl/certs/ca-certificates.crt"
  end

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", host: 6789, guest: 80

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "./sync", "/vagrant_data"

  config.omnibus.chef_version = :latest


  config.vm.provision :shell, :path => "./scripts/before/rhel.sh" # Uncomment if RHEL
  # config.vm.provision :shell, :path => "./scripts/before/debian.sh" # Uncomment if Debian

  config.vm.provision :shell, :path => "./scripts/before/all.sh"

  config.vm.provision "chef_solo" do |chef|
     chef.cookbooks_path = "cookbooks"
     chef.roles_path = "roles"
     chef.data_bags_path = "data_bags"

     chef.add_recipe "yum"
     chef.add_recipe "rsync"
     chef.add_recipe "nginx"
     chef.add_recipe "mongodb::10gen_repo" #Uncomment if Ubuntu
     chef.add_recipe "mongodb" #Uncomment if Ubuntu
     chef.add_recipe "git"
     chef.add_recipe "nodejs"
     chef.add_recipe "nano"

     chef.json = {
      :mongodb => {
        :dbpath => "/var/lib/mongodb",
        :logpath => "/var/log/mongodb"
      },
      :git => {
        :prefix => "/url/local"
      },
      :nginx => {
        :dir => "/etc/nginx",
        :log_dir => "/var/log/nginx",
        :user => "nginx",
        :init_style => "runit",
        :pid => "/var/run/nginx.pid",
        :worker_connections => "1024"
      },
      :run_list => 
        ["recipe[mongodb::10gen_repo]", "recipe[mongodb]"]
     }
  end

  config.vm.provision :shell, :path => "./scripts/after.sh"

end
