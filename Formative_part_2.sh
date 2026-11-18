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
git status
git add .
git diff --cached --name-only
git commit -m "Initial commit of formative project"

# create new branch for readme document
git switch -c readme
git branch

# create readme and commit it
nano README.txt
git add README.txt
git commit -m "Add README with conda set up instructions" 

#This was a mistake committed renamed readme to main
git branch -M main

#Connect to github
git remote add origin https://github.com/Caffsta/Formative.git

# push the original project branch and readme branch
git push -u origin readme
git push -u origin main
git remote -v

# check 
git remote -v
git branch -a