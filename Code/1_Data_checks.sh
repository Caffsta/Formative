####Formative assessessment Q1 and Q2 - assessing the data and creating files. 

#!bin/bash

# Run this script from the Formative directory - set working directory

mkdir Code
mkdir Data
mkdir Results

cd Data
mkdir Original
mkdir Derived
cd ..

unzip accel.zip
rm accel.zip

mv accel Data/
cd Data
mv accel Original/

cd Original
cd accel

#Explores the data
head -n15 BMX_D.csv
tail -n15 BMX_D.csv
wc -l BMX_D.csv

# prints fields in the top row
head -n1 BMX_D.csv | awk -F',' '{print NF}'

# prints rows without 28 columns - none were found
awk -F, '{print NF}' BMX_D.csv | grep -v 28 

head -n15 accel-31128.txt
head -n15 accel-31129.txt
wc -l accel-31128.txt
wc -l accel-31129.txt
ls -1 *.txt | wc -l

#Print text files without 8 columns
awk -F '\t' 'FNR>2 && NF!=8 {print FILENAME}' accel-*.txt | sort -u


nano code/README.txt
mv Data/Original/accel/README.txt code/