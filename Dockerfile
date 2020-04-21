FROM postgres

ADD get_and_load_data.sh .

CMD ["get_and_load_data.sh"]
