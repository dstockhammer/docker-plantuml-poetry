ARG plantuml_version
ARG python_version="3.8"

FROM dstockhammer/plantuml:${plantuml_version} as plantuml
FROM python:${python_version}-slim

RUN mkdir -p /usr/share/man/man1 \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    graphviz \
    openjdk-11-jre-headless \
 && rm -rf /var/lib/apt/lists/*

RUN pip install poetry

COPY --from=plantuml /app/plantuml.jar /opt/plantuml.jar
COPY plantuml.sh /usr/local/bin/plantuml
