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
