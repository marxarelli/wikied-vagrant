# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'debian/contrib-jessie64'

  config.vm.provider 'virtualbox' do |vb, override|
    vb.memory = '1024'
    override.vm.network :private_network, ip: '10.11.12.14'
  end

  config.vm.provision :shell, inline: 'apt-get update && apt-get install -y puppet'

  config.vm.provision :puppet do |puppet|
    puppet.hiera_config_path = 'hiera.yaml'
    puppet.module_path = 'modules'
    puppet.facter = { environment: 'development' }

    puppet.options << '--debug' if ENV.include?('DEBUG')
  end

  config.vm.network :forwarded_port, guest: 3000, host:3000
end
