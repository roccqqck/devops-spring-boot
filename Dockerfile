FROM maven:3.6.3-jdk-8 as BUILD

COPY src /usr/src/myapp/src
COPY pom.xml /usr/src/myapp
RUN mvn -f /usr/src/myapp/pom.xml clean package ; \
    ls /usr/src/myapp/target/

FROM adoptopenjdk/openjdk8:ubuntu-jre

COPY --from=BUILD /usr/src/myapp/target/myapp_server-0.0.1-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
