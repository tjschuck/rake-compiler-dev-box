script = <<-SCRIPT
    bash /vagrant/bootstrap.sh
SCRIPT

http_proxy = ENV['http_proxy']
if http_proxy
    script.prepend <<-SCRIPT
      home='/home/vagrant'
      echo 'Acquire::http::Proxy "#{http_proxy}";' > /etc/apt/apt.conf.d/40proxy
      if ! grep -q http_proxy $home/.bash_profile; then
          echo 'export http_proxy=#{http_proxy}' >> $home/.bash_profile
      fi
    SCRIPT
end

Vagrant.configure('2') do |config|
  config.vm.box      = 'precise64'
  config.vm.box_url  = 'http://files.vagrantup.com/precise64.box'

  config.vm.provision :shell, :inline => script
end
