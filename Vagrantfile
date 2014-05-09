Vagrant.require_version '>= 1.6'

Vagrant.configure('2') do |config|
  config.vm.box = 'hashicorp/precise64'
  config.vm.provision :shell, :path => "bootstrap.sh"
end
