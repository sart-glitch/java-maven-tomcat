FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package
FROM tomcat:9.0.80-jdk17
COPY --from=build /home/app/target/*.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
