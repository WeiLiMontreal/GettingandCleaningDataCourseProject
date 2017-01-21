######### download dataset and unzip files
library(downloader)
if (!file.exists("Dataset.zip")){
        url1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download(url1, dest="dataset.zip", mode="wb")
}
if (!file.exists("UCI HAR Dataset")){
unzip ("dataset.zip", exdir = "./")
}


######### load features and activite labels to R
file_features = "./UCI HAR Dataset/features.txt"
file_activity_labels="./UCI HAR Dataset/activity_labels.txt"

# read list of feature
features <- read.table(file_features, header = FALSE, fill = TRUE) 
# read Links the class labels with their activity name
activity_labels <- read.table(file_activity_labels, header = FALSE, fill = TRUE) 

######### decide which data files we need
file_subject_train = "./UCI HAR Dataset/train/subject_train.txt"
file_activity_label_train = "./UCI HAR Dataset/train/y_train.txt"
file_data_train = "./UCI HAR Dataset/train/X_train.txt"

file_subject_test = "./UCI HAR Dataset/test/subject_test.txt"
file_activity_label_test = "./UCI HAR Dataset/test/y_test.txt"
file_data_test = "./UCI HAR Dataset/test/X_test.txt"
######### choose the features the project required

idx_mean_std <- grep("mean\\(\\)|std\\(\\)",tolower(features$V2))
mean_std_features <- as.character(features$V2[idx_mean_std])

######### load data to R
subject_train <- read.table(file_subject_train, header = FALSE)
activity_label_train <- read.table(file_activity_label_train, header = FALSE)
data_train <- read.table(file_data_train, header = FALSE)

subject_test <- read.table(file_subject_test, header = FALSE)
activity_label_test <- read.table(file_activity_label_test, header = FALSE)
data_test <- read.table(file_data_test, header = FALSE)

######### combine the training and the test sets.
# combine train and test sets and assign names to variables
subject_combine <- rbind(subject_train,subject_test)
# combine activity label
activity_lable_combine <- rbind(activity_label_train, activity_label_test)
# combine measured data but only extracts the measurements on the mean and standard deviation for each measurement.
mean_std_data_combine <- rbind(data_train[,idx_mean_std], data_test[,idx_mean_std])

library(plyr)

## melt the data sets to creat the full data set with 68 variables and 10299 observation
all_combine_data <- cbind(subject_combine, activity_lable_combine)
all_combine_data <- cbind(all_combine_data, mean_std_data_combine)
names(all_combine_data) <- c("subject", "activity", mean_std_features)

## crate a tidy data set with the average of each variable for each activity and each subject
data_mean_activity <- aggregate(. ~subject + activity , all_combine_data, mean)
# order activity based on the activity label not letters of activity name words
data_mean_activity <- data_mean_activity[order(data_mean_activity$subject,data_mean_activity$activity),]
# Uses descriptive activity names to name the activities in the data set
data_mean_activity$activity <- mapvalues(as.character( data_mean_activity$activity),
                     from = as.character( activity_labels[,1]),
                     to = as.character( activity_labels[,2]))

# create tidydata.txt
write.table(data_mean_activity, file = "tidydata.txt",row.name=FALSE,  quote = FALSE)
