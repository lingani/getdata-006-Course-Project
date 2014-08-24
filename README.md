getdata-006-Course-Project
==========================

Coursera getdata-006 Project: repository for run_analysis.R script, the descriptions on how it works and the code book that describes the dataset returned
--------------------------------------------

This repository purpose is to provide:
  1. run_analysis.R: the R script file performed to get a tidy dataset as describle in the steps below;
  2. code book.md: the code book that describes the tidy dataset and
  3. Readme.md file describing how the run_analysis.R works

The row data set used for this data cleaning project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Here the steps we performed to create the run_analysis.R script:
 
 1. Merging the training and the test sets to create one data set.
 2. Extracting only the measurements on the mean and standard deviation for each measurement.
 3. Using descriptive activity names to name the activities in the data set
 4. Appropriately labeling the data set with descriptive variable names.
 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
 
How does the script work?
 1. Unzip the data set into your working directory so that it contains the forder 'UCI HAR Dataset'
 2. Open the script in RStudio
 3. CTRL + A / CMD + A to select all the script code
 4. Press CTRL + ENTER to run the script.
  The script creates an R tidy (space seperated) data named 'tidy_data.txt' in your working directory
