FROM openjdk:17-jdk-slim-buster

RUN apt-get update
ENV MAVEN_OPTS="--add-exports=java.base/jdk.internal.module=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED   --add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED"


