FROM debian:stable

ARG AWS_CORRETTO_VERSION="11.0.15.9.1"

ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y curl wget procps net-tools

RUN mkdir -p /apps/neo4j

WORKDIR /app/neo4j

RUN wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.11-unix.tar.gz

RUN tar -xf artifact.php?name\=neo4j-community-4.4.11-unix.tar.gz

WORKDIR /app

# Install Amazon Corretto 11
RUN wget -nv "https://corretto.aws/downloads/resources/${AWS_CORRETTO_VERSION}/amazon-corretto-${AWS_CORRETTO_VERSION}-linux-x64.tar.gz"

RUN tar -xzvf "amazon-corretto-${AWS_CORRETTO_VERSION}-linux-x64.tar.gz"

RUN mv amazon-corretto-${AWS_CORRETTO_VERSION}-linux-x64 /usr/local/

ENV PATH="/usr/local/amazon-corretto-${AWS_CORRETTO_VERSION}-linux-x64/bin:${PATH}"

ENV JAVA_HOME="/usr/local/amazon-corretto-${AWS_CORRETTO_VERSION}-linux-x64"

ENV NEO4J_HOME="/app/neo4j/neo4j-community-4.4.11/"


# neo4j.conf was required to expose services on 0.0.0.0 instead of localhost
COPY neo4j.conf /app/neo4j/neo4j-community-4.4.11/conf

COPY start_neo4j.sh .

RUN chmod 755 /app/start_neo4j.sh

EXPOSE 7474
EXPOSE 7687


#CMD ["/app/start_neo4j.sh"]
ENTRYPOINT ["tail","-f","/dev/null"]
