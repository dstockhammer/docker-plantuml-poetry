FROM plantuml/plantuml:1.2026.2 AS plantuml
FROM eclipse-temurin:25 AS jdk
FROM dstockhammer/python-poetry:3.14.3-2.3.2

COPY --from=plantuml /opt/plantuml.jar /opt/plantuml.jar

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=jdk $JAVA_HOME $JAVA_HOME

RUN apt-get update \
 && apt-get install -qq --yes --no-install-recommends \
      git \
      graphviz \
      fonts-dejavu \
      curl \
 && rm -rf /var/lib/apt/lists/*

COPY plantuml.sh /usr/local/bin/plantuml
