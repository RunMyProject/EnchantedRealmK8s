package com.enchantedk8srealm.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class EnchantedAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(EnchantedAppApplication.class, args);
		System.out.println("Hello, Enchanted Kubernetes Realm!");
	}

}
