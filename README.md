This project contains a barebones example webapp that uses Maven to package a web app.

This project is laid out like this:

- `hello-world-maven/`
  - **`pom.xml`** is a Maven [POM file](https://maven.apache.org/pom.html) that defines the project.
  - `src/main/` is a directory that contains the code.
    - `java/` is a directory that contains server-side code.
      - `io.happycoding.servlets.`**`HelloWorldServlet.java`** is a Java servlet that returns some HTML content.
    - `webapp/` is a directory that contains web files.
      - **`index.html`** is an HTML file that shows static content.

You can compile this into a directory and a `.war` file by executing this command:

```
mvn package
```



---------------------------------------------------------------------------------------------------------------

FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package
FROM tomcat:9.0.80-jdk17
RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser
COPY --from=build /home/app/target/*.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]

docker build -t test-image .
[root@ip-172-31-6-91 java-maven-tomcat]# docker run -i -t sarthak:latest /bin/bash
newuser@aba426b16855:~$
