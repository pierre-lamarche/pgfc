#!/bin/bash

## create schema rp2016

psql -c 'CREATE SCHEMA rp2016'

## load logement table
curl -o logement.zip https://www.insee.fr/fr/statistiques/fichier/4229099/RP2016_LOGEMT_csv.zip
unzip logement.zip
psql load_logement.sql
rm logement.zip
rm FD_LOGEMT_2016.csv 
