# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Gradle wrapper files and the gradle build script
COPY gradlew /app/gradlew
COPY gradle /app/gradle
COPY build.gradle /app/build.gradle
COPY settings.gradle /app/settings.gradle

# Copy the source code to the container
COPY src /app/src

# Grant execute permissions for the Gradle wrapper
RUN chmod +x gradlew

# Build the application
RUN ./gradlew build

# Copy the built application to a new directory
RUN mkdir -p /app/build/libs
RUN cp build/libs/*.jar /app/app.jar

# Define the entry point for the container
ENTRYPOINT ["java","-jar","/app/app.jar"]
