#!bin/bash

# Run this script from the Formative directory - set working directory

#search for files that don't have the following header columns - all headers are the same
awk -F '\t' 'FNR==2 {gsub(/"/,""); if ($1!="PAXSTAT" || $2!="PAXCAL" || $3!="PAXDAY" || $4!="PAXN" || $5!="PAXHOUR" || $6!="PAXMINUT" || $7!="PAXINTEN" || $8!="PAXSTEP" || NF!=8) print FILENAME}' accel-*.txt 

#search for rows where there is not 8 columns - accel-31268.txt has some with 3 columns 10083-10092, 34974 - lines 10083 - 10097
awk -F '\t' 'FNR>2 && NF!=8 {print FILENAME, "Line:", FNR, "Columns:", NF}' accel-*.txt

#removes rows where there are not 8 columns of data in these files and moved to derived data
for f in accel-31268.txt accel-34974.txt; do
    awk -F '\t' 'FNR<=2 || NF!=3' "$f" > "Data/Derived/$f"
done

# move all the other conistent files into derived so they are all contained in one folder
for f in accel-*.txt; do
    if [[ "$f" != "accel-31268.txt" && "$f" != "accel-34974.txt" ]]; then
    mv "$f" "Data/Derived/"
    fi
done

# Check all files  now have 8 columns in derived
awk -F '\t' 'FNR>2 && NF!=8 {print FILENAME}' accel-*.txt |sort -u

# moved back to original as it didn't work the previous command fully
mv "Data/Derived/accel-34974.txt" "Data/Original/accel"

# re-ran the following
for f in accel-*.txt; do
    if [[ "$f" != "accel-31268.txt" && "$f" != "accel-34974.txt" ]]; then
    mv "$f" "Data/Derived/"
    fi
done

awk -F '\t' 'FNR>2 && NF!=8 {print FILENAME}' accel-*.txt |sort -u

# create a file with one row for each header 
awk 'FNR==1 {print $0}' accel-*.txt > participant_id.txt
sed -i 's/<ACTIGRAPH ID=//g; s/>//g' participant_id.txt
sed -i '1i SEQNO' participant_id.txt
mv participant_id.txt participant_id.csv
mv participant_id.csv "Data/Original/"