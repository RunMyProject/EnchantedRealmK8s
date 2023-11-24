# Use a base image containing a JRE (Java Runtime Environment)
FROM openjdk:11-jre-slim

# Install netcat and curl for testing Kafka connectivity and making HTTP requests
RUN apt-get update && apt-get install -y netcat curl jq

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file of your project into the working directory
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# Copy the connectivity test script into the working directory
COPY test_connection.sh .

# Grant execution permissions to the script
RUN chmod +x test_connection.sh

# Expose the port on which the application will listen
# for service communication within the Kubernetes cluster
EXPOSE 7777

# Command to start the application inside the container
# to provide default arguments that can be overridden from the
# command line
CMD ["java", "-jar", "app.jar"]

