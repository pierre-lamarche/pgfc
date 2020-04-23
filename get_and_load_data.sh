#!/bin/sh

## create schema rp2016

PGPASSWORD=$POSTGRES_PASSWORD psql-U $POSTGRES_USER -d $POSTGRES_DB -c 'CREATE SCHEMA rp2016'

## load logement table

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" /home/load_logement.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c 'COPY rp2016.logement FROM "FD_LOGEMT_2016.csv" DELIMITER ";" CSV HEADER ;'
rm /home/logement.zip
rm /home/FD_LOGEMT_2016.csv 
