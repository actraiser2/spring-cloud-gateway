FROM maven:3.9-eclipse-temurin-17 as build
LABEL maintainer=jmbesada
WORKDIR /src
COPY . /src/
RUN mvn package



FROM eclipse-temurin:17
ENV APP_NAME=spring-cloud-gateway
WORKDIR /app
COPY --from=build /src/target/*.jar /app/${APP_NAME}.jar
EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -jar ${APP_NAME}.jar"]