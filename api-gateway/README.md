# Getting Started

# Run

execute ./infrastructure.sh to setup common service

## localhost run

./gradlew bootRun

# Build

- docker-compose -f docker-compose-build.yml up

# Test

- docker-compose -f docker-compose-test.yml up
- ./gradlew clean test
- Check test results -> /build/reports/tests/test/index.html

## docker

### create volume if not exist

docker-compose up
docker-compose down

## Check latest plugin dependencies

     gradlew dependencyUpdates
## Trigger refresh event  
All configuration which are marked with @RefreshScope will be refreshed.
All beans which are marked with @RefreshScope will be recreated on next call.

```curl -X POST 'http://localhost:5001/v1/actuator/refresh'```

### Reference Documentation

For further reference, please consider the following sections:

- [Spring boot cloud api gateway](https://spring.io/projects/spring-cloud-gateway)
- [Official Gradle documentation](https://docs.gradle.org)
- [Spring Boot Gradle Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.2.5.RELEASE/gradle-plugin/reference/html/)
- [Spring Web](https://docs.spring.io/spring-boot/docs/2.2.5.RELEASE/reference/htmlsingle/#boot-features-developing-web-applications)
- [Spring Boot Actuator](https://docs.spring.io/spring-boot/docs/2.2.5.RELEASE/reference/htmlsingle/#production-ready)
- [Spring Boot DevTools](https://docs.spring.io/spring-boot/docs/2.2.5.RELEASE/reference/htmlsingle/#using-boot-devtools)

- [Spring Data Redis (Access+Driver)](https://docs.spring.io/spring-boot/docs/2.2.5.RELEASE/reference/htmlsingle/#boot-features-redis)

- [Gradle versions plugin](https://github.com/ben-manes/gradle-versions-plugin)

### Guidelines

The following guidelines illustrate how to use some features specifically:

- [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)
- [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
- [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
- [Building REST services with Spring](https://spring.io/guides/tutorials/bookmarks/)
- [Building a RESTful Web Service with Spring Boot Actuator](https://spring.io/guides/gs/actuator-service/)
- [Messaging with Redis](https://spring.io/guides/gs/messaging-redis/)
- [JVM (Micrometer)](https://grafana.com/grafana/dashboards/4701)

### Additional Links

These additional references should also help you:

- [Gradle Build Scans – insights for your project's build](https://scans.gradle.com#gradle)
