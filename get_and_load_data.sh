#!/bin/sh

## create schema rp2016

PGPASSWORD=$POSTGRES_PASSWORD psql -h localhost -p 5432 -U $POSTGRES_USER -d $POSTGRES_DB -c 'CREATE SCHEMA rp2016'

## awk to generate sql script

read_meta () {
	nom_schema=$1
	nom_table=$2
	file_input=$3
	file_output=$4 

	awk -F ";" 'BEGIN{RS = "\r\n" 
			print "CREATE TABLE '$nom_schema'.'$nom_table' \n("} 
			NR > 1 { if ($1 != prev) {
				if ($5 == "CHAR") print "\t" $1 " CHARACTER(" $6 ")"
				if ($5 == "NUM") print "\t" $1 " NUMERIC"
				}
			prev = $1}
			END {print ")"}' $file_input > $file_output
}

## load logement table

curl -o /home/logement.zip https://www.insee.fr/fr/statistiques/fichier/4229099/RP2016_LOGEMT_csv.zip
unzip /home/logement.zip -d /home/
read_meta rp2016 logement /home/varmod_LOGEMT_2016.csv /home/load_logement.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -h localhost -p 5432 -U "$POSTGRES_USER" -d "$POSTGRES_DB" /home/load_logement.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -h localhost -p 5432 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c 'COPY rp2016.logement FROM "FD_LOGEMT_2016.csv" DELIMITER ";" CSV HEADER ;'
rm /home/logement.zip
rm /home/FD_LOGEMT_2016.csv 
