FROM postgres
USER root
MAINTAINER Pierre Lamarche lamarche.p@gmail.com

ENV annee=2016

RUN apt-get update \
    && apt-get install -y zip curl postgresql-client-common postgresql-client

COPY load_individu_cvi.sql /tmp/
COPY get_and_load_data.sh /docker-entrypoint-initdb.d/
