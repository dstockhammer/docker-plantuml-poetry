FROM dstockhammer/plantuml:1.2021.13 as plantuml
FROM eclipse-temurin:17 as jdk
FROM python:3.10.0-slim

COPY --from=plantuml /app/plantuml.jar /opt/plantuml.jar

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=jdk $JAVA_HOME $JAVA_HOME

ENV PYTHONFAULTHANDLER=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONHASHSEED=random
ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
      graphviz \
      fonts-dejavu \
 && rm -rf /var/lib/apt/lists/*

RUN pip install poetry \
 && poetry config virtualenvs.create false

COPY plantuml.sh /usr/local/bin/plantuml
