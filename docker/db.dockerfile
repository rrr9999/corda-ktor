FROM library/postgres:11-alpine
USER root
ENV POSTGRES_PASSWORD test
COPY ./config.sql /docker-entrypoint-initdb.d/
