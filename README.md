# Getting and Cleaning Data Course Project

Project requirements
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average
of each variable for each activity and each subject.

Files included in this repository
CodeBook.md: information about all varialbles and observations to creat the tidy data set from the raw data
README.md: this file
run_analysis.R: R script to transform raw data sets into the final tidy one

How to create the tidy data set:
1. download compressed raw data unzip raw data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. decide which data files are needed for the project.
3. load data to R.
4. analyse which measurements are extracted from the raw data.
5. combine the training and test data set.
6. sort the data set and calculate the average to creat the tidy data set.
7. write the tidy data set to txt file.

