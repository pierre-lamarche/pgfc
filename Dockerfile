FROM postgres
USER root

RUN apt-get install zip curl postgresql-client-common

ADD get_and_load_data.sh /home/
RUN /bin/bash -s 'chmod +x /home/get_and_load_data.sh'
CMD ["/bin/bash", "/home/get_and_load_data.sh"]
