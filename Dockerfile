FROM dstockhammer/plantuml:1.2023.8 as plantuml
FROM eclipse-temurin:17 as jdk
FROM python:3.12.0b2-slim

COPY --from=plantuml /app/plantuml.jar /opt/plantuml.jar

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=jdk $JAVA_HOME $JAVA_HOME

ENV PYTHONFAULTHANDLER=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONHASHSEED=random
ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV POETRY_NO_INTERACTION=1
ENV POETRY_VIRTUALENVS_CREATE=false

RUN apt-get update \
 && apt-get install -qq --yes --no-install-recommends \
      git \
      graphviz \
      fonts-dejavu \
 && rm -rf /var/lib/apt/lists/* \
 && pip install poetry

COPY plantuml.sh /usr/local/bin/plantuml
