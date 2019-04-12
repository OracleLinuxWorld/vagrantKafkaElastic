Vagrant.configure("2") do |config|

  # Create a base box with OL7 and pre-install the latest Kafka 5.x and Elasticsearch 6.xcomponents
  config.vm.define "devboxKafkaElastic" do |devboxKafkaElastic|
    devboxKafkaElastic.vm.synced_folder "./vagrant", "/vagrant"
    devboxKafkaElastic.vm.box = "ol76"
    devboxKafkaElastic.vm.hostname = 'kafka-elastic-singlenode'
    devboxKafkaElastic.vm.box_url = "http://yum.oracle.com/boxes/oraclelinux/ol76/ol76.box"
    devboxKafkaElastic.vm.network :"private_network", type: "dhcp"

    # Kafka Broker port
    devboxKafkaElastic.vm.network "forwarded_port", guest: 9092, host: 19092, protocol: "tcp"

    # Kafka REST proxy port
    devboxKafkaElastic.vm.network "forwarded_port", guest: 8082, host: 18082, protocol: "tcp"

    # Elasticsearch port
    devboxKafkaElastic.vm.network "forwarded_port", guest: 9200, host: 19200, protocol: "tcp"

    devboxKafkaElastic.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 4096]
      v.customize ["modifyvm", :id, "--cpus", "4"]
      v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      v.customize ["modifyvm", :id, "--usb", "off"]
      v.customize ["modifyvm", :id, "--audio", "none"]
      v.customize ["modifyvm", :id, "--name", "devboxKafkaElastic"]
    end # End of "devboxKafkaElastic.vm.provider"
  end   # End of config.vm.define "devboxKafkaElastic"


    # Set auto_update to false
    # This will not automatically update the guest additions on VM boot
    # Set to "true" if you want auto-updates
    # config.vbguest.auto_update = false

    config.vm.provision "default", type:'ansible_local' do |ansible|
          ansible.verbose = "v"
          ansible.playbook = "ansible-playbook.yml"
    end   # End of "config.vm.provision"

    config.vm.provision "restart_kafka", type:'ansible_local', run: "always" do |restart_kafka|
          restart_kafka.verbose = "v"
          restart_kafka.playbook = "ansible-playbook_restart_kafka.yml"
    end   # End of "config.vm.restart_kafka"

    config.vm.provision "restart_elasticsearch", type:'ansible_local', run: "never" do |restart_elasticsearch|
          restart_elasticsearch.verbose = "v"
          restart_elasticsearch.playbook = "ansible-playbook_restart_elasticsearch.yml"
    end   # End of "config.vm.restart_elasticsearch"


end       # End of "Vagrant.configure"
