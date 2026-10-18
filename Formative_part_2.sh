#!/bin/bash

# Run this script from the Formative directory - set working directory

conda create -n form -c conda-forge r-base r-tidyverse -y
conda activate form 
conda env export --from-history > env_form.yml
cat env_form.yml

R -e "library(tidyverse)"

#check if can still recreate the environment
conda env create -f env_form.yml -n form_test

git init
nano .gitignore

# check git ignore statement 
cat .gitignore
git check-ignore -v Data/