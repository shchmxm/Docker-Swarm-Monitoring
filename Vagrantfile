# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
config.vm.box = "hashicorp-education/ubuntu-24-04"
config.vm.box_version = "0.1.0"
config.vm.synced_folder ".", "/home/vagrant/app_src", create: true

config.vm.provider "virtualbox" do |vb|
  vb.cpus = 2
  vb.memory = 4096
end

  config.vm.define :manager01 do |manager01|
    manager01.vm.hostname = "manager01" 
    manager01.vm.provision :shell, path: "./initVM_files/initVM.sh", env: {"SWARM_NODE_TYPE" => "manager", "SWARM_MANAGER_IP" => "192.168.56.10"}
    manager01.vm.network "private_network", ip: "192.168.56.10", hostname: true
    manager01.vm.network "forwarded_port", guest: 3100, host: 3100  # Loki
    manager01.vm.network "forwarded_port", guest: 9090, host: 9090  # Prometheus
    manager01.vm.network "forwarded_port", guest: 3000, host: 3000  # Grafana
  end

  config.vm.define :worker01 do |worker01|
    worker01.vm.hostname = "worker01" 
    worker01.vm.provision :shell, path: "./initVM_files/initVM.sh", env: {"SWARM_NODE_TYPE" => "worker", "SWARM_MANAGER_IP" => "192.168.56.10"}
    worker01.vm.network "private_network", ip: "192.168.56.11", hostname: true
    worker01.vm.network "forwarded_port", guest: 12345, host: 12301 # Alloy worker01
  end
  
  config.vm.define :worker02 do |worker02|
    worker02.vm.hostname = "worker02" 
    worker02.vm.provision :shell, path: "./initVM_files/initVM.sh", env: {"SWARM_NODE_TYPE" => "worker", "SWARM_MANAGER_IP" => "192.168.56.10"}
    worker02.vm.network "private_network", ip: "192.168.56.12", hostname: true
    worker02.vm.network "forwarded_port", guest: 12345, host: 12302 # Alloy worker02
  end
end
