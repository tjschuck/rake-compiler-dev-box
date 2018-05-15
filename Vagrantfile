Vagrant.require_version '>= 1.6'

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.provider 'virtualbox' do |v|
    v.memory = ENV.fetch('RAKE_COMPILER_DEV_BOX_RAM', 2048).to_i
    v.cpus   = ENV.fetch('RAKE_COMPILER_DEV_BOX_CPUS', 2).to_i
  end
end
