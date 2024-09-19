# Stop the Kafka container if running
docker stop kafka_container
echo "Kafka container stopped if exists..."
# Rmeove the Kafka container if existing
docker rm kafka_container
echo "Kafka container removed if exists..."

# Start running the Kafka container
docker run -d --name kafka_container confluentinc/confluent-local:7.6.0 
echo "Kafka container started..."

# Stop any local run of Kafka instance
confluent local kafka stop 
echo "Local Kafka instance stoped if exists..."

# Start local run of Kafka
confluent local kafka start | tee kafka_output.log
echo "Local Kafka instance started, output logged to kafka_output.log..."

# Grab Plaintext Port for input into Kafka producers, consumers
grep -E "\|[[:space:]]*Plaintext Ports[[:space:]]*\|[[:space:]]*[0-9]+[[:space:]]*\|" kafka_output.log | grep -o "[0-9]\+" > extracted_plaintext_port.txt
echo "Plaintext Port dumped into extracted_plaintext_port.txt..."


