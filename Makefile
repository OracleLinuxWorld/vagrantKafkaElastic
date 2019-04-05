.PHONY: all provision restart brokers topics demo elastic_health elastic_indices elastic_allocation elastic
.DEFAULT_GOAL := provision

provision:
	vagrant provision

test:
	scripts/tests.sh

restart-kafka:
	vagrant provision --provision-with restart_kafka

restart-elasticsearch:
	vagrant provision --provision-with restart_elasticsearch

restart: restart-kafka restart-elasticsearch


brokers:
	curl -s -XGET -H 'Accept: application/vnd.kafka.v2+json' 'http://172.28.129.204:8082/brokers' | jq '.'

topics:
	curl -s -XGET -H 'Accept: application/vnd.kafka.v2+json' 'http://172.28.129.204:8082/topics' | jq '.'

elastic_health:
	curl -s -XGET -H 'Accept: application/json' -H 'Content-Type: application/json' 172.28.129.208:9200/_cat/health | jq '.'

elastic_indices:
	curl -s -XGET -H 'Accept: application/json' -H 'Content-Type: application/json' 172.28.129.208:9200/_cat/indices | jq '.'

elastic_allocation:
	curl -s -XGET -H 'Accept: application/json' -H 'Content-Type: application/json' 172.28.129.208:9200/_cat/allocation | jq '.'

elastic: elastic_health elastic_indices elastic_allocation

restart-dc1:
	ansible-playbook -i vagrant/inventory/hosts vagrant/ansible-playbook_restart_kafka_services.yml  --limit "dc1"

restart-dc2:
	ansible-playbook -i vagrant/inventory/hosts vagrant/ansible-playbook_restart_kafka_services.yml  --limit "dc2"

restart: restart-dc1 restart-dc2

kafka-demo:
	ansible-playbook -i vagrant/inventory/hosts vagrant/ansible-playbook_demo_script.yml  --limit "dc1"
	ansible-playbook -i vagrant/inventory/hosts vagrant/ansible-playbook_demo_script.yml  --limit "dc2"
