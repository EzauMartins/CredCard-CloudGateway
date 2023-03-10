FROM maven:3.8.5-openjdk-11 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests


FROM openjdk:11
WORKDIR /app
COPY --from=build ./app/target/*jar ./app.jar

ARG EUREKA_SERVE=localhost
ARG KEYCLOAK_SERVE=keycloakhost
ARG KEYCLOAK_PORT=keycloackport

ENTRYPOINT java -jar app.jar