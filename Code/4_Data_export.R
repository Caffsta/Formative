

library(haven)

Demographics <- read_xpt("data/original/DEMO_D.xpt")

head(Demographics)

Demographics <- dplyr::rename(Demographics, SEQNO = SEQN)

Demographics<- Demographics %>% 
  select (SEQNO, gender=RIAGENDR,age=RIDAGEYR,ethnicity=RIDRETH1)

head(Demographics)
glimpse(Demographics)

BMI <- read.csv("Data/Original/BMX_D.csv")
BMI <- dplyr::rename(BMI, SEQNO = SEQN)

names(BMI) <- tolower(names(BMI))
names(Demographics) <- tolower(names(Demographics))

BMI_Demographics <- BMI %>%
 left_join(Demographics, by ="seqno")

BMI_Demographics<- BMI_Demographics %>%
  relocate(gender,age,ethnicity, .after=seqno)

head(BMI_Demographics)

nrow(BMI)
nrow(BMI_Demographics)
anyDuplicated(Demographics$seqno)

Participants <- read.csv("Data/Original/participant_ID.csv")

colnames(Participants)

#Make participant ID lowercase
names(Participants) <- tolower(names(Participants))

#Create indicator for accelerometer data
BMI_Demographics <- BMI_Demographics %>%
  mutate(in_sample=if_else(seqno %in% Participants$seqno,1,0))

#Move indicator next to participant ID
BMI_Demographics <-BMI_Demographics %>%
  relocate(in_sample,.after=seqno)

#Keep only participants in the sample
table(BMI_Demographics$in_sample)

#Create obesity indicator using BMI
BMI_Demographics <- BMI_Demographics %>%
  mutate(obesity=if_else(bmxbmi>=30,1,0))

#check results
table(BMI_Demographics$obesity)
table(BMI_Demographics$obesity, useNA = "ifany")

#data summaries

#Question 1 - Obesity and activity monitor data
BMI_Demographics %>%
  filter(!is.na(obesity), !is.na(in_sample)) %>%
  group_by(obesity) %>%
  summarise(percentage = sum(in_sample == 1) / n() * 100)

#Question 2 - Gender and activity monitor data

BMI_Demographics %>%
  filter(!is.na(gender), !is.na(in_sample)) %>%
  group_by(gender) %>%
  summarise(percentage = sum(in_sample == 1) / n() * 100)

#question 3 - Maximum height of children under 16

BMI_Demographics %>% 
  filter(age<16) %>%
  summarise(maximum_height=max(bmxht,na.rm=TRUE))

#Export combined dataset to derived data directory
write.csv(BMI_Demographics,"Data/Derived/body_measurements.csv",row.names = FALSE)

#Check exported file
file.exists("Data/Derived/body_measurements.csv")
