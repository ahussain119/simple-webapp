# Stage 1: Build the Java application
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create a minimal image with the built application
FROM tomcat:9.0.64-jdk11-openjdk-slim
WORKDIR /app
COPY --from=build /app/target/simple-webapp-1.0-SNAPSHOT.war /app/simple-webapp.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/simple-webapp.war"]
