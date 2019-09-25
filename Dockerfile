FROM leanivets/openshift-jenkins-slave-jdk:11.0.3 as builder
ENV JAVA_HOME="/usr/lib/jdk-11.0.3"
COPY . .
RUN mv pom_build pom.xml && \
mvn clean package

FROM openshift/jenkins-2-centos7:v3.11 as jenkins-oauth
COPY --chown=1001 --from=builder /var/lib/origin/target/oic-auth.hpi /opt/openshift/plugins/oic-auth.hpi
COPY --chown=1001 run /usr/libexec/s2i/run
