# -*- mode: ruby -*-
# vi: set ft=ruby ts=2 sw=2 tw=0 et :

role = File.basename(File.expand_path(File.dirname(__FILE__)))

ENV['ANSIBLE_ROLES_PATH'] = "../"
ENV["VAGRANT_OLD_ENV_OBJC_DISABLE_INITIALIZE_FORK_SAFETY"] = "YES"

boxes = [
  {
    :name => "ubuntu-1804",
    :box => "ubuntu/bionic64",
    :ip => '10.0.0.10',
    :cpu => "20",
    :ram => "256"
  },
]

Vagrant.configure("2") do |config|
  boxes.each do |box|
    config.vm.define box[:name] do |vms|
      vms.vm.box = box[:box]
      vms.vm.box_url = box[:url]

      vms.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--cpuexecutioncap", box[:cpu]]
        v.customize ["modifyvm", :id, "--memory", box[:ram]]
      end

      vms.vm.network :private_network, ip: box[:ip]

      vms.vm.provision :ansible do |ansible|
        ansible.galaxy_role_file = "requirements.yml"
        ansible.playbook = "tests/test.yml"
        ansible.verbose = "vv"
        ansible.host_vars = {
          "ubuntu-1804" => {
            "ansible_python_interpreter" => "/usr/bin/python3",
          }
        }
        ansible.raw_arguments  = [
          "--diff",
        ]
      end
    end
  end
end
