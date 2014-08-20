#settig working directory
#set this directory to where your sumsung data is enziped
#setwd("F:/Cours/Coursera/The Data Science Specialization/Module 03 - Getting and Cleaning Data/data/Assessments")

#loading required libraries
library(plyr)
library(data.table)

#Creating the data Directory
dataDir<-"./UCI HAR Dataset"

########################################################################
##  1. Merging the training and the test sets to create one data set.
########################################################################
#Reading Training set
train_set_URL<-paste0(dataDir,"/train/X_train.txt" )
train_set<-read.table(file=train_set_URL)
#Reading Test set
test_set_URL<-paste0(dataDir,"/test/X_test.txt" )
test_set<-read.table(file=test_set_URL)

#Reading subject_train
subject_train_URL<-paste0(dataDir, "/train/subject_train.txt")
subject_train<-read.table(subject_train_URL)
names(subject_train)<-"subjectID"

#Reading subject_test
subject_test_URL<-paste0(dataDir, "/test/subject_test.txt")
subject_test<-read.table(subject_test_URL)
names(subject_test)<-"subjectID"

#Merging subject IDs for training set and test set

#Merging the training and the test sets
merged_train_and_test_set<-rbind(train_set, test_set)
merged_train_and_test_set$subjects= c(subject_train$subjectID, subject_test$subjectID)
merged_train_and_test_set$experiment= c(rep("Train", dim(train_set)[1]), rep("Test",dim(test_set)[1]))

########################################################################
##  2. Extracting only the measurements on the mean and 
##        standard deviation for each measurement.
########################################################################
#Reading features
features_URL<-paste0(dataDir, "/features.txt")
features<-read.table(features_URL)
names(features)<-c("featuresID", "featuresLabel")
selected_features<-features[grepl("(mean\\(\\)|std\\(\\))(.)*" ,features$featuresLabel),]
selected_data<-merged_train_and_test_set[ ,selected_features$featuresID]
names(selected_data)<-selected_features$featuresLabel

#names(selected_data)<-selected_features$featuresLabel
selected_data<-cbind( subjects=merged_train_and_test_set$subjects, experiment=merged_train_and_test_set$experiment, selected_data)



########################################################################
##  3. Using descriptive activity names to name  
##       the activities in the data set.
########################################################################
#Reading Activity Labels
activity_labels_URL<-paste0(dataDir,"/activity_labels.txt" )
activity_labels<-read.table(activity_labels_URL, sep=" ", header=FALSE)

#Reading Training labels
train_labels_URL<-paste0(dataDir,"/train/y_train.txt" )
train_labels<-read.table(train_labels_URL, sep=" ", header=FALSE)
#Traning Activity Labels: Merging traning labels and Activity labels
train_labels$order <- seq(len=nrow(train_labels))
train_activity_labels<-merge(train_labels, activity_labels, by.x="V1", by.y="V1", all.x = TRUE, sort=FALSE)
train_activity_labels<-train_activity_labels[sort.list(train_activity_labels$order), -2]
names(train_activity_labels)<-c("activityID", "activityLabel")

#Reading Test labels
test_labels_URL<-paste0(dataDir,"/test/y_test.txt" )
test_labels<-read.table(test_labels_URL, sep=" ", header=FALSE)
#Test Activity Labels: Merging test labels and Activity labels
test_labels$order <- seq(len=nrow(test_labels))
test_activity_labels<-merge(test_labels,activity_labels, by.x="V1", by.y="V1", all.x = TRUE, sort=FALSE)
test_activity_labels<-test_activity_labels[sort.list(test_activity_labels$order), -2]
names(test_activity_labels)<-c("activityID", "activityLabel")

#Merging Train activity labels and test activity labels
merged_activity_labels<-rbind(train_activity_labels, test_activity_labels)

#naming the activities in the data set "selected_data"
selected_data<-cbind(activityLabel=merged_activity_labels$activityLabel, selected_data)



########################################################################
##  4. Appropriately labels the data set with descriptive variable names.
########################################################################
names(selected_data)<-gsub("\\(\\)-", "",names(selected_data))
names(selected_data)<-gsub("\\(\\)", "",names(selected_data))
names(selected_data)<-gsub("-mean", "Mean",names(selected_data))
names(selected_data)<-gsub("-std", "Std",names(selected_data))



########################################################################
##  5. Creates a second, independent tidy data set with the average 
##      of each variable for each activity and each subject. 
########################################################################
data<-selected_data[ ,-3]
tidy_data<-ddply(data, .(activityLabel, subjects), colwise(mean))
tidy_data_URL<-paste0(dataDir,"/tidy_data.txt" )
write.table(tidy_data, tidy_data_URL, row.name=FALSE)

