# https://www.github.com/justb4/docker-jmeter 
FROM alpine:3.12

ARG JMETER_VERSION="5.3"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_MANAGER_VERSION 1.4
ENV CMDRUNNER_VERSION 2.2

ARG TZ="Europe/Amsterdam"
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk8-jre tzdata curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies \
	&& cd opt/apache-jmeter-${JMETER_VERSION} \
	&& wget https://jmeter-plugins.org/get/ -O lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar \
	&& wget http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar -O lib/cmdrunner-${CMDRUNNER_VERSION}.jar \
	&& java -cp lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
	&& bin/PluginsManagerCMD.sh install jpgc-webdriver

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN




