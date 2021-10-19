FROM dstockhammer/plantuml:1.2021.12 as plantuml
FROM eclipse-temurin:17 as jdk
FROM python:3.10.0-slim

ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV JAVA_HOME=/opt/java/openjdk

COPY --from=plantuml /app/plantuml.jar /opt/plantuml.jar
COPY --from=jdk $JAVA_HOME $JAVA_HOME

RUN mkdir -p /usr/share/man/man1 \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    git \
    graphviz \
 && rm -rf /var/lib/apt/lists/*

RUN pip install poetry

COPY plantuml.sh /usr/local/bin/plantuml
