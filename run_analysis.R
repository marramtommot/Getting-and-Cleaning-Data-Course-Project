require(dplyr)
require(reshape2)

# The code should have a file run_analysis.R in the main directory that
# can be run as long as the Samsung data is in your working directory
dataDir <- wd <- getwd()

if(!dir.exists(file.path(dataDir, "UCI HAR Dataset"))) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  archive <- file.path(dataDir, "UCI_HAR_Dataset.zip")
  download.file(url, archive)
  
  unzip(archive, exdir = dataDir)
  
  dir(dataDir)
}

setwd(file.path(dataDir, "UCI HAR Dataset"))

features.names <- tbl_df(read.table("features.txt"))
activity.labels <- tbl_df(read.table("activity_labels.txt", header = F))

features.test <- tbl_df(read.table(file.path("test", "X_test.txt"), header = F))
activity.test <- tbl_df(read.table(file.path("test", "y_test.txt"), header = F))
subject.test <-  tbl_df(read.table(file.path("test", "subject_test.txt"), header = F))

features.train <- tbl_df(read.table(file.path("train", "X_train.txt"), header = F))
activity.train <- tbl_df(read.table(file.path("train", "y_train.txt"), header = F))
subject.train <-  tbl_df(read.table(file.path("train", "subject_train.txt"), header = F))

# Merges the training and the test sets (1)
features <- bind_rows(features.train, features.test)
activity <- bind_rows(activity.train, activity.test)
subject <- bind_rows(subject.train, subject.test)

# Appropriately labels the data set with descriptive variable names (4)
colnames(features) <- t(features.names$V2)
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

# Create one data set (1)
fullData <- bind_cols(features, subject, activity)

# Extracts only the measurements on the mean and standard deviation for each measurement (2)
data.indexes <- c(features.names[grep("-(mean|std)\\(", features.names$V2),]$V1, 562, 563)
dataset <- fullData[, data.indexes]

# Uses descriptive activity names to name the activities in the data set (3)
dataset$Activity <- factor(dataset$Activity, levels = activity.labels$V1, labels = activity.labels$V2) 

# Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject (5)
mdata <- melt(dataset, id.vars = c("Subject", "Activity"))
dataset <- dcast(mdata, Subject + Activity ~ variable, mean)

# Data set as a txt file created with write.table() using row.name=FALSE
write.table(dataset, "data5.txt", row.name = F)

setwd(wd)
