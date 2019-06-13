---
title: "CodeBook"
output: html_document
---
##Coursera: Getting and Cleaning Data - Project

###Introduction
This notebook contain the description of the results obtain after work with the data provided. Include description of the following items:<br/>
+ Variables<br/>
+ Merging<br/>
+ Transformation and Tidying<br/>
  
###Variables
Source of the information of the variables used in the project and the identification of the columns. Each file contain information that will be merge in a single data repository.
  
>features: using the information of features.txt that include 561 rows and columns. This 2 columns were named "id" and "functions"

>activities: using the information of activity_labels.txt that include 6 rows and 2 columns.This 2 columns were named  "id" and "activity"
    
> subject: include the identification of the subjet who performed the activity. Two variables were created, 1 for tranning sample "subjectTrain" (using subject_test.txt) and 1 for test sample "subjectTest" (using subject_test.txt). In both variables the columns was named "id" due is the identification of the subject.

> set: include the recorded features information. Two variables were created, 1 for tranning sample "setTrain" (using X_train.txt) and 1 for test sample "setTest" (using X_test.txt). In both variables the columns were named according with the correspond label description in features variable.

> label: include the data of activities identification labels. Two variables were created, 1 for tranning sample "labelTrain" (using y_train.txt) and 1 for test sample "labelTest" (using y_test.txt). In both variables the columns were named id".

###Merging
Data rows from the new dataset for each variables were merge by data type:

>mergeSubjects is created by merging subjectTest and subjectTrain with the function rbind()

>mergeLabels is created by merging labelTest and labelTrain with the function rbind()

>mergeSets is created by merging setTest and setTrain with the function rbind()

A new dataset was created  by merging columns of the last 3 merge datasets, this contain the information of the complete group of study.

>activityRecognition is created by merging mergeSubjects, mergeLabels and mergeSets using the function cbind()

###Transformation and Tidying

The dataset t_activityRecognition include the summarization of activityRecognition and taking the means of each variable for each activity and each subject group by subject and activity.

The result is export to file named "tidy_data.txt"