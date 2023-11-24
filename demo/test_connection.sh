#!/bin/bash

KAFKA_BOOTSTRAP_SERVERS=my-cluster-kafka-bootstrap
KAFKA_PORT=9092
OUTPUT_FILE=./connection_test_output.txt

# Debug information
echo "Connecting to Kafka bootstrap servers: $KAFKA_BOOTSTRAP_SERVERS:$KAFKA_PORT"

# Attempt connection and capture output to a file
nc -zv $KAFKA_BOOTSTRAP_SERVERS $KAFKA_PORT > $OUTPUT_FILE 2>&1

# Write a message using curl and append the output to the file
curl -i http://localhost:7777/produce/Hello_Kafka >> $OUTPUT_FILE

# Read messages using curl, format JSON with jq, and append the output to the file
curl http://localhost:7777/consume | jq >> $OUTPUT_FILE

# Check the content of the output file
echo "Content of $OUTPUT_FILE:"
cat $OUTPUT_FILE

# Add a newline for clarity
echo "Test finished"
