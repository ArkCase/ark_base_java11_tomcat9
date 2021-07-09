FROM 345280441424.dkr.ecr.ap-south-1.amazonaws.com/ark_base_java11:latest
RUN useradd -r -g tomcat tomcat

ENV TOMCAT_VERSION=9.0.22  \
    TOMCAT_MAJOR_VERSION=9

ADD  https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz /tmp

RUN cd /tmp && \
    tar -xf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} /opt/tomcat/ && \
    chown -R tomcat: /opt/tomcat && \
    chmod +x /opt/tomcat/bin/*.sh

ENV CATALINA_HOME /opt/tomcat/
ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV PATH=/opt/tomcat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
USER tomcat
EXPOSE 8080
CMD ["catalina.sh","run"]






