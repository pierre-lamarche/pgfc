#!/bin/sh

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
