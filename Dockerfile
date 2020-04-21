FROM postgres

USER root
ADD get_and_load_data.sh /home/

CMD ["/home/get_and_load_data.sh"]
