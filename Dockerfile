FROM dstockhammer/plantuml:1.2021.6 as plantuml
FROM python:3.9.5-slim

COPY --from=plantuml /app/plantuml.jar /opt/plantuml.jar

RUN mkdir -p /usr/share/man/man1 \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    git \
    graphviz \
    openjdk-11-jre-headless \
 && rm -rf /var/lib/apt/lists/*

RUN pip install poetry

COPY plantuml.sh /usr/local/bin/plantuml
