
# Data merge program - import datasets for an analysis create an indicator where accel data is know within BMI dataset

library(tidyverse)

#Import datasets
BMI <- read.csv("BMX_D.csv")
Participants<- read.csv("Participant_ID.csv")

#Ensure ID is the same name
BMI <- dplyr::rename(BMI, SEQNO = SEQN)

#Create indicator in participants to determine if BMI data exists
Participants <- Participants %>%
  mutate(BMI_indicator = if_else(SEQNO %in% BMI$SEQNO, 1, 0))

#Create indicator in BMI dataset to determine if accel data exists
BMI <- BMI %>%
  mutate(accel_indicator = if_else(SEQNO %in% Participants$SEQNO, 1, 0))

#Check datasets
table(Participants$BMI_indicator)
table(BMI$accel_indicator)