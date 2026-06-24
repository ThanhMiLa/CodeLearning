# Stage 1: Build the JAR file using Maven
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project to package a runnable JAR file, skipping unit tests
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight runtime image using eclipse-temurin JRE
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the built JAR file from Stage 1
COPY --from=build /app/target/*.jar app.jar

# Expose backend port
EXPOSE 8080

# Run the Spring Boot application under the production profile by default
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]
