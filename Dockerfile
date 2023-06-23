FROM plantuml/plantuml:1.2023.9 as plantuml
FROM eclipse-temurin:17 as jdk
FROM python:3.11.4-slim

COPY --from=plantuml /opt/plantuml.jar /opt/plantuml.jar

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=jdk $JAVA_HOME $JAVA_HOME

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    POETRY_NO_INTERACTION=1 \
    POETRY_NO_ANSI=1  \
    POETRY_VIRTUALENVS_CREATE=false

RUN apt-get update \
 && apt-get install -qq --yes --no-install-recommends \
      git \
      graphviz \
      fonts-dejavu \
      curl \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir poetry \
 && poetry --version

COPY plantuml.sh /usr/local/bin/plantuml
