FROM ubuntu:14.04

RUN apt-get update && apt-get -y install curl

# JAVA
ARG JAVA_ARCHIVE=http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
ENV JAVA_HOME /usr/local/jdk1.8.0_131

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" $JAVA_ARCHIVE \
  | tar -xz -C /usr/local/ && ln -s $JAVA_HOME /usr/local/java

# SPARK
ARG SPARK_ARCHIVE=http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
RUN curl -s $SPARK_ARCHIVE | tar -xz -C /usr/local/

ENV SPARK_HOME /usr/local/spark-2.1.0-bin-hadoop2.7
ENV PATH $PATH:$SPARK_HOME/bin

EXPOSE 4040 6066 7077 8080

WORKDIR $SPARK_HOME
