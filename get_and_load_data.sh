#!/bin/sh

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
			END {print ");"}' $file_input > /tmp/temp.txt
    
    awk 'NR==FNR { n+=1 }
	     NR!=FNR { if (FNR > 2 && FNR < n-1) print $0 ","
		    else print $0 }' /tmp/temp.txt /tmp/temp.txt > $file_output

    rm /tmp/temp.txt
}

## create schema rp2016

PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -c 'CREATE SCHEMA rp2016'

## load logement table

curl -o /tmp/logement.zip https://www.insee.fr/fr/statistiques/fichier/4229099/RP2016_LOGEMT_csv.zip
unzip /tmp/logement.zip -d /tmp/
read_meta rp2016 logement /tmp/varmod_LOGEMT_2016.csv /tmp/load_logement.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_logement.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.logement FROM '/tmp/FD_LOGEMT_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/logement.zip
rm /tmp/FD_LOGEMT_2016.csv 

## load individu canton-ou-ville table

##curl -o /tmp/individu_cvi.zip https://www.insee.fr/fr/statistiques/fichier/4229118/RP2016_INDCVI_csv.zip
##unzip /tmp/individu_cvi.zip -d /tmp/
##read_meta rp2016 individu_cvi /tmp/varmod_INDCVI_2016.csv /tmp/load_individu_cvi.sql
##
##PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_individu_cvi.sql
##PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.individu_cvi FROM '/tmp/FD_INDCVI_2016.csv' DELIMITER ';' CSV HEADER ;"
##rm /tmp/individu_cvi.zip
##rm /tmp/FD_INDCVI_2016.csv 

## load individu region table

curl -o /tmp/individu_reg.zip https://www.insee.fr/fr/statistiques/fichier/4171523/RP2016_indreg_csv.zip
unzip /tmp/individu_reg.zip -d /tmp/
read_meta rp2016 individu_reg /tmp/varmod_INDREG_2016.csv /tmp/load_individu_reg.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_individu_cvi.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.individu_cvi FROM '/tmp/FD_INDREG_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/individu_reg.zip
rm /tmp/FD_INDREG_2016.csv 

## load mobilite scolaire table

curl -o /tmp/mobsco.zip https://www.insee.fr/fr/statistiques/fichier/4171517/RP2016_mobsco_csv.zip
unzip /tmp/mobsco.zip -d /tmp/
read_meta rp2016 mobsco /tmp/varmod_MOBSCO_2016.csv /tmp/load_mobsco.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_mobsco.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.mobsco FROM '/tmp/FD_MOBSCO_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/mobsco.zip
rm /tmp/FD_MOBSCO_2016.csv 

## load mobilite professionnelle table

curl -o /tmp/mobpro.zip https://www.insee.fr/fr/statistiques/fichier/4171531/RP2016_mobpro_csv.zip
unzip /tmp/mobpro.zip -d /tmp/
read_meta rp2016 mobpro /tmp/varmod_MOBPRO_2016.csv /tmp/load_mobpro.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_mobpro.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.mobpro FROM '/tmp/FD_MOBPRO_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/mobpro.zip
rm /tmp/FD_MOBPRO_2016.csv 

## load mobilite zone d'emploi table

curl -o /tmp/mobzelt.zip https://www.insee.fr/fr/statistiques/fichier/4171535/RP2016_mobzelt_csv.zip
unzip /tmp/mobzelt.zip -d /tmp/
read_meta rp2016 mobzelt /tmp/varmod_MOBZELT_2016.csv /tmp/load_mobzelt.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_mobzelt.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.mobzelt FROM '/tmp/FD_MOBZELT_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/mobzelt.zip
rm /tmp/FD_MOBZELT_2016.csv 

## load mobilite residentielle commune table

curl -o /tmp/migcom.zip https://www.insee.fr/fr/statistiques/fichier/4171543/RP2016_migcom_csv.zip
unzip /tmp/migcom.zip -d /tmp/
read_meta rp2016 migcom /tmp/varmod_MIGCOM_2016.csv /tmp/load_migcom.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_migcom.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.migcom FROM '/tmp/FD_MIGCOM_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/migcom.zip
rm /tmp/FD_MIGCOM_2016.csv 

## load mobilite residentielle pays table

curl -o /tmp/miggco.zip https://www.insee.fr/fr/statistiques/fichier/4171547/RP2016_miggco_csv.zip
unzip /tmp/miggco.zip -d /tmp/
read_meta rp2016 miggco /tmp/varmod_MIGGCO_2016.csv /tmp/load_miggco.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_miggco.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.miggco FROM '/tmp/FD_MIGGCO_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/miggco.zip
rm /tmp/FD_MIGGCO_2016.csv 

## load mobilite residentielle departement table

curl -o /tmp/migdep.zip https://www.insee.fr/fr/statistiques/fichier/4171551/RP2016_migdep_csv.zip
unzip /tmp/migdep.zip -d /tmp/
read_meta rp2016 migdep /tmp/varmod_MIGDEP_2016.csv /tmp/load_migdep.sql

PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /tmp/load_migdep.sql
PGPASSWORD=$POSTGRES_PASSWORD psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "COPY rp2016.migdep FROM '/tmp/FD_MIGDEP_2016.csv' DELIMITER ';' CSV HEADER ;"
rm /tmp/migdep.zip
rm /tmp/FD_MIGDEP_2016.csv 
