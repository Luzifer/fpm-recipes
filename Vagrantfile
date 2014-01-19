# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box      = "12.04daily"
  config.vm.box_url  = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "fpm-cookery"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--cpus", 1]
  end

  recipe = ENV["RECIPE"]
  if recipe
    unless File.directory?(File.join("recipes", recipe))
      abort "error: recipe #{recipe} not found"
    end
    # Build packages if recipe is provided
    config.vm.provision :shell, :inline => "cd /vagrant/recipes/#{recipe} && fpm-cook"
  else
    # Install fpm-cookery and dependencies
    config.vm.provision :shell, :inline => <<SCRIPT
set -e -x
test -f /var/lib/apt/periodic/update-success-stamp || apt-get update -y
apt-get install -y update-notifier-common ruby ruby-dev rubygems
gem install --no-ri --no-rdoc fpm-cookery puppet
SCRIPT
  end
end
