CPU_COUNT = 4
RAM_SIZE = 1024

Vagrant.require_version '>= 1.6'

Vagrant.configure('2') do |config|
  config.vm.box = 'hashicorp/precise64'
  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.provider "virtualbox" do |v|
    v.memory = RAM_SIZE
    v.cpus = CPU_COUNT
  end

  config.vm.provider "vmware_fusion" do |f|
    f.vmx['memsize'] = RAM_SIZE
    f.vmx['numvcpus'] = CPU_COUNT
  end
end
