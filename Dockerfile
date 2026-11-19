FROM eclipse-temurin:21-jre
WORKDIR /app
COPY build/libs/DockerProject-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]kubectl rollout restart deployment/spring-app