package com.enchantedk8srealm.demo;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import java.util.Properties;

public class KafkaTest {
	public static void main(String[] args) {
		Properties props = new Properties();
		props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "my-cluster-kafka-bootstrap:9092");

		try (KafkaProducer<String, String> producer = new KafkaProducer<>(props)) {
			System.out.println("Connected to Kafka successfully.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}