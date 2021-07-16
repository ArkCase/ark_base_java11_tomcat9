FROM 345280441424.dkr.ecr.ap-south-1.amazonaws.com/ark_base_java11:latest

LABEL ORG="Armedia LLC" \
      VERSION="1.0" \
      IMAGE_SOURCE=https://github.com/ArkCase/ark_base_java11_tomcat9 \
      MAINTAINER="Armedia LLC"

RUN useradd  --system --user-group tomcat

ENV TOMCAT_VERSION=9.0.50  \
    TOMCAT_MAJOR_VERSION=9

ADD  https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz /tmp

RUN cd /tmp && \
    tar -xf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} /opt/tomcat/ && \
    chown -R tomcat:tomcat /opt/tomcat && \
    chmod +x /opt/tomcat/bin/*.sh && \
    # Removal of default/unwanted Applications
    rm -f -r -d /opt/tomcat/webapps/* 

ENV CATALINA_HOME="/opt/tomcat/"\
    CATALINA_PID="/opt/tomcat/temp/tomcat.pid"\
    PATH="/opt/tomcat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
WORKDIR /opt/tomcat
USER tomcat
EXPOSE 8080
# Starting tomcat
CMD ["catalina.sh","run"]