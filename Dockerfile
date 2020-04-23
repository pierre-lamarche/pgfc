FROM postgres
USER root
MAINTAINER Pierre Lamarche lamarche.p@gmail.com

ENV annee=2016

RUN apt-get update \
    && apt-get install -y zip curl postgresql-client-common postgresql-client

COPY /home/dl_donnees.sh
RUN /bin/bash -s 'chmod +x /home/dl_donnees.sh'
COPY get_and_load_data.sh /docker-entrypoint-initdb.d/
CMD ["/bin/sh", "/home.dl_donnees.sh"]
#RUN /bin/bash -s 'chmod +x /home/get_and_load_data.sh'
#CMD ["/bin/sh", "/home/get_and_load_data.sh"]
