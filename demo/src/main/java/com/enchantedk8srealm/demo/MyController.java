package com.enchantedk8srealm.demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
public class MyController {

	private final List<String> messageList = new ArrayList<>();
	@Autowired
	private KafkaTemplate<String, String> kafkaTemplate;

	@Value("${SPRING_KAFKA_CONSUMER_BOOTSTRAP_SERVERS}")
	private String bootstrapServers;

	@Value("${SPRING_KAFKA_PRODUCER_BOOTSTRAP_SERVERS}")
	private String bootstrapProducerServers;

	@Value("${SPRING_KAFKA_CONSUMER_GROUP_ID}")
	private String groupId;

	@Value("${SPRING_KAFKA_CONSUMER_AUTO_OFFSET_RESET}")
	private String autoOffsetReset;

	@Value("${SPRING_KAFKA_CONSUMER_FETCH_MAX_WAIT}")
	private String fetchMaxWait;

	@Value("${SPRING_KAFKA_TOPIC}")
	private String topic;

	@KafkaListener(topics = "${SPRING_KAFKA_TOPIC}", groupId = "${SPRING_KAFKA_CONSUMER_GROUP_ID}")
	public void consume(String m) {
		log.info("Hello Kafka! - Message consumed: {}", m);
		messageList.add(m);
	}

	@GetMapping("/produce/{m}")
	public void produce(@PathVariable String m) {
		log.info("Hello Kafka!  - Message produced: {}", m);
		kafkaTemplate.send(topic, "${SPRING_KAFKA_KEY}", m);
	}

	@GetMapping("/consume")
	public ResponseEntity<List<String>> getAllMessages() {
		log.info("Hello Kafka! - messageList size: " + messageList.size());
		List<String> getList = new ArrayList<>(messageList);
		messageList.clear();
		return new ResponseEntity<>(getList, HttpStatus.OK);
	}

	@GetMapping("/my-endpoint")
	public ResponseEntity<String> hello() {
		String message = "Hello, world!";
		return new ResponseEntity<>(message, HttpStatus.OK);
	}

	@GetMapping("/myconfig")
	public Map<String, String> getConfig() {
		Map<String, String> configMap = new HashMap<>();
		configMap.put("bootstrapServers", bootstrapServers);
		configMap.put("bootstrapProducerServers", bootstrapProducerServers);
		configMap.put("groupId", groupId);
		configMap.put("topic", topic);
		configMap.put("autoOffsetReset", autoOffsetReset);
		configMap.put("fetchMaxWait", fetchMaxWait);
		return configMap;
	}
}
