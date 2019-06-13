##Getting and Cleaning Data Course Project
##One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
##Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
##The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 


##A full description is available at the site where the data was obtained:

##http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Here are the data for the project:

##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##You should create one R script called run_analysis.R that does the following:

##Prerequisite
library(dplyr)

##Getting Data
zfileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zfile <- "UCI HAR Dataset.zip"
if (!file.exists(zfile)){download.file(zfileUrl,zfile)}
datapath <- "UCI HAR Dataset"
if(!file.exists(datapath)){unzip(zfile)}

##Reading data extracted and identification of the columns
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id","functions"))
activity_labels  <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
subjectTrain <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
setTrain <-  read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
labelTrain <-read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
subjectTest <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
setTest <-  read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
labelTest <-  read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

## 1. Merges the training and the test sets to create one data set.
mergeSets <- rbind(setTrain, setTest)
mergeLabels <- rbind(labelTrain, labelTest)
mergeSubjects <- rbind(subjectTrain, subjectTest)
activityRecognition <- cbind(mergeSubjects, mergeLabels, mergeSets)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
t_activityRecognition <- activityRecognition %>% 
select(subject, id, contains("mean"), contains("std"))

## 3. Assign descriptive names to the Activities in the data repository
t_activityRecognition$id <- activity_labels[t_activityRecognition$id, 2]

## 4. Appropriately labels the data set with descriptive variable names.
names(t_activityRecognition)[2] = "activity"
names(t_activityRecognition)<-gsub("Acc", "Accelerometer", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("Gyro", "Gyroscope", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("BodyBody", "Body", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("Mag", "Magnitude", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("^t", "Time", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("^f", "Frequency", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("tBody", "TimeBody", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("-mean()", "Mean", names(t_activityRecognition), ignore.case = TRUE)
names(t_activityRecognition)<-gsub("-std()", "STD", names(t_activityRecognition), ignore.case = TRUE)
names(t_activityRecognition)<-gsub("-freq()", "Frequency", names(t_activityRecognition), ignore.case = TRUE)
names(t_activityRecognition)<-gsub("angle", "Angle", names(t_activityRecognition))
names(t_activityRecognition)<-gsub("gravity", "Gravity", names(t_activityRecognition))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Result <-t_activityRecognition %>%group_by(subject, activity) %>%
summarise_all(funs(mean))
## Checking and creatinf File
str(Result)
write.table(Result, "tidy_data.txt", row.name=FALSE)
View(Result)
