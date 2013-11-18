script = <<-SCRIPT
    bash /vagrant/bootstrap.sh
SCRIPT

%w[http https ftp].each do |proto|
  proxy = ENV[proto+"_proxy"]
  if proxy
      script.prepend <<-SCRIPT
        home='/home/vagrant'
        echo 'Acquire::#{proto}::Proxy "#{proxy}";' > /etc/apt/apt.conf.d/40#{proto}_proxy
        if ! grep -q #{proto}_proxy $home/.bash_profile; then
            echo 'Using #{proto}_proxy=#{proxy}'
            echo 'export #{proto}_proxy=#{proxy}' >> $home/.bash_profile
        fi
      SCRIPT
  end
end

Vagrant.configure('2') do |config|
  config.vm.box      = 'precise64'
  config.vm.box_url  = 'http://files.vagrantup.com/precise64.box'

  config.vm.provision :shell, :inline => script
end
