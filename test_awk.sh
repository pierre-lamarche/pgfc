#!/bin/sh

awk -F ";" 'BEGIN{RS = "\r\n" 
		print "CREATE TABLE logement \n("} 
		NR > 1 { if ($1 != prev) {
				if ($5 == "CHAR") print "\t" $1 " CHARACTER(" $6 ")"
				if ($5 == "NUM") print "\t" $1 " NUMERIC"
				}
			prev = $1}
		END {print ")"}' /home/pierre/Documents/pro/insee/git/varmod_LOGEMT_2016.csv > /home/pierre/Documents/pro/insee/git/test.txt
	    
