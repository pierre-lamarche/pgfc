FROM postgres

ADD get_and_load_data.sh /home/

CMD ["/home/get_and_load_data.sh"]
