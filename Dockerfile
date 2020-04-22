FROM postgres
USER root

RUN apt-get update \
    && apt-get install -y zip curl postgresql-client-common postgresql-client

ADD get_and_load_data.sh /home/
RUN /bin/bash -s 'chmod +x /home/get_and_load_data.sh'
CMD ["/bin/bash", "/home/get_and_load_data.sh"]
