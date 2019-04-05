#!/bin/sh

export LOCAL_IF=`ip route | grep default | cut -d' '  -f5`
#echo "Local interface is: $LOCAL_IF"

export LOCAL_IP=`ip -f inet addr show dev $LOCAL_IF | grep inet | awk '{print $2}' | cut -d'/' -f1`
#echo "Local IP is: $LOCAL_IP"

function get_kafka_rest_brokers {
echo ""
echo "############## Kafka REST - get list of brokers ##################"
echo ""
curl -s -XGET -H 'Accept: application/vnd.kafka.v2+json' http://$LOCAL_IP:18082/brokers
echo ""
echo ""
echo ""
}

function get_kafka_rest_topics {
echo ""
echo "############## Kafka REST - get list of topics ###################"
echo ""
curl -s -XGET -H 'Accept: application/vnd.kafka.v2+json' http://$LOCAL_IP:18082/topics
echo ""
echo ""
echo ""
}

function get_elasticsearch_health {
echo ""
echo "############## Elasticsearch - cluster health ####################"
echo ""
curl -s -H 'Accept: application/json' -H 'Content-Type: application/json' $LOCAL_IP:19200/_cat/health
echo ""
echo ""
echo ""
}

function get_elasticsearch_indices {
echo ""
echo "############## Elasticsearch - list of indices ###################"
echo ""
curl -s -H 'Accept: application/json' -H 'Content-Type: application/json' $LOCAL_IP:19200/_cat/indices
echo ""
echo ""
echo ""
}


###
### main()
###

get_kafka_rest_brokers
get_kafka_rest_topics
get_elasticsearch_health
get_elasticsearch_indices
