FROM maven:3.8.6-openjdk-11-slim AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests


FROM tomcat:9.0.64-jdk11-openjdk-slim

WORKDIR /app

COPY --from=build /app/target/*.war /app/

EXPOSE 8080

RUN chown -R tomcat:tomcat /app

RUN rm -rf ROOT

ENTRYPOINT ["java", "-jar", "/app/*.war"]
