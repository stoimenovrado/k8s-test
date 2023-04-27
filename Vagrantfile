
  Vagrant.configure("2") do |config|

    config.vm.define "kubernetes" do |kubernetes|
        kubernetes.vm.box="shekeriev/ubuntu-20-04-server"
        kubernetes.vm.hostname = "kubernetes.do1.exam"
        kubernetes.vm.network "private_network", ip: "192.168.69.201"
        kubernetes.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
        kubernetes.vm.provision "shell", path: "k8s.sh"
        kubernetes.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "3072", "--cpus", "2"]
        end
    end
end