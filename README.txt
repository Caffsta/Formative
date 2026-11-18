Formative project 

This project contains Bash and R scripts for processing and analysing BMI and accelerometer data

Conda environment set up

1. Open ubuntu terminal and set up a working directory as Formative project
2. Create the conda environment using the following code: conda env creat -f env_form.yml
3. Activate the environment: conda activate form 

Derived Body MEasurement Data:

File: Derived/body_measurement.csv

This dataset combines NHANES 2005-2006 body measurement data with demographic information and an indicator for accelerometer sample membership. 

The dataset includes:

Participant ID (seqno)

Accelerometer sample indicator (in_sample)

Gender (gender)

Age (age)

Ethnicity (ethnicity)

Body measurement variables, including BMI (bmxbmi) and height (bmxht)

Obesity indicator (obesity)

The obesity variable is coded as 1 for participants classified as having obesity and 0 for those not classified as having obesity. Missing values are retained where obesity cannot be classified.

The combined dataset retains all rows from the original Body Measurement Data.


