
## Assuming you have dowloaded the initial dataset in your work directory
## with the same folder structure of the Samgung data
## Load dplyr and tidyr libraries for manipulating data

library(dplyr)
library(tidyr)


## LOAD data
## sep "" for not fixed number of spaces as col separator
## header FALSE for absence of header

activity.labels = read.table("activity_labels.txt", sep="", header=F, colClasses = c("numeric", "character"))
features = read.table("features.txt", sep="", header=F, colClasses = c("numeric", "character"))
train.subject = read.table("train/subject_train.txt", sep="", header=F, colClasses = "numeric")
train.data = read.table("train/x_train.txt", sep="", header=F, colClasses = "numeric")
train.activity = read.table("train/y_train.txt", sep="", header=F, colClasses = "numeric")
test.subject = read.table("test/subject_test.txt", sep="", header=F, colClasses = "numeric")
test.data = read.table("test/x_test.txt", sep="", header=F, colClasses = "numeric")
test.activity = read.table("test/y_test.txt", sep="", header=F, colClasses = "numeric")


## CLEAN variables/col names

variables.name = gsub("\\(", "", features[,2])
variables.name = gsub("\\)", "", variables.name)
variables.name = gsub("-", "", variables.name)
variables.name = gsub("std", "StdDev", variables.name)
variables.name = gsub("mean", "Mean", variables.name)
variables.name = gsub("meanFreq", "MeanFreq", variables.name)
variables.name = gsub("tBody", "TimeBody", variables.name)
variables.name = gsub("tGravity", "TimeGravity", variables.name)
variables.name = gsub("fBody", "FreqBody", variables.name)
rm(features)

## MERGE the training and the test sets to create one data set
## by row in a temporary dataframes (named data): 
##    train.data with test.data
##    train.activity with test.activity
##    train.subject with test.subject
## SET data column names with new variables.name then DROP some table no longer used

data = rbind(train.data, test.data)
activity = rbind(train.activity, test.activity)
subject = rbind(train.subject, test.subject)
rm(train.data, train.activity, train.subject, test.data, test.activity, test.subject)
names(data) = variables.name
names(activity) = "activity"
names(subject) = "subject" 

## SUBSET data 
## extracting only the measurements on the mean and standard deviation for each measurement

tidy.data = data[, c(grep("Mean", names(data)), grep("StdDev", names(data)))]


## USE descriptive activity names to name the activities in the data set
## converting numeric values of activities with the matching string description

for(i in 1:nrow(activity)){  
    activity[i,1] = activity.labels[activity[i,1], 2]  
    }


## Appropriately labels the data set with descriptive variable names
## merging by col in tidy.data activity and subject
## then drop some useless table, activity.labels, variables.name and i

tidy.data = cbind(subject, tidy.data)
tidy.data = cbind(activity, tidy.data)
rm(data, activity, subject, activity.labels, variables.name, i)


## From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject

tidy.data.grouped = group_by(tidy.data, activity, subject)
tidy.data.summarised = summarise_each(tidy.data.grouped, funs(mean)) 


## WRITE the final data set and DROP some table 

write.table(tidy.data.summarised, "tidy_Data.txt", row.name=F)
rm(tidy.data.grouped)