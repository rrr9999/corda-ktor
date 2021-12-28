FROM openjdk:8-alpine

COPY . /app

WORKDIR app

USER root

# 途中
RUN apk add bash curl \
    && ./gradlew runPartyAServer

CMD ["/bin/bash"]


