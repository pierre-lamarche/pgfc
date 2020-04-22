#!/bin/sh

## create schema rp2016

psql -h localhost -p 5432 -c 'CREATE SCHEMA rp2016'

## load logement table
curl -o logement.zip https://www.insee.fr/fr/statistiques/fichier/4229099/RP2016_LOGEMT_csv.zip
unzip logement.zip
PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB load_logement.sql
rm logement.zip
rm FD_LOGEMT_2016.csv 
