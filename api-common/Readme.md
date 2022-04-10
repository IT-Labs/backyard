# Read Me First
The following was discovered as part of building this project:

open the terminal and navigate to the directory where this file is located.
```
export JAVA_HOME="C:\\Program Files\\Java\\jdk-17.0.1"
export MAVEN_OPTS='--add-exports=java.base/jdk.internal.module=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED'
./mvnw versions:set -DnewVersion=1.0.4
./mvnw clean spotless:apply deploy -Dmaven.test.skip=true -P dev -s settings.xml
```

# Getting Started

### Reference Documentation
For further reference, please consider the following sections:

* [Official Gradle documentation](https://docs.gradle.org)
* [Spring Boot Gradle Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.5.10/gradle-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/2.5.10/gradle-plugin/reference/html/#build-image)
* [Spring Boot DevTools](https://docs.spring.io/spring-boot/docs/2.5.10/reference/htmlsingle/#using-boot-devtools)
* [maven deploy to nexus](https://www.youtube.com/watch?v=RcWSch8r3Zw)

### Additional Links
These additional references should also help you:

* [Gradle Build Scans – insights for your project's build](https://scans.gradle.com#gradle)
