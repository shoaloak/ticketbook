# syntax=docker/dockerfile:1

FROM eclipse-temurin:11.0.12_7-jdk-focal@sha256:3fc0b423f75bd2889434f584c63b23634270b75ddd1c55439af600090dfd4ce2 as base

WORKDIR /app

COPY src ./src
COPY test ./test

COPY .mvn ./.mvn
COPY mvnw pom.xml ./

RUN ./mvnw -B de.qaware.maven:go-offline-maven-plugin:resolve-dependencies
RUN ./mvnw package

##
FROM base as development

EXPOSE 8080

CMD ["./mvnw", "tomcat7:run-war"]

