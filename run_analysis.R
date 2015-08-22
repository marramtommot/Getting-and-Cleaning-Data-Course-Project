require(data.table)
require(reshape2)

# setwd("~/Desktop/Coursera/Data Science/3. Getting and Cleaning Data")

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

features.names <- fread("features.txt", header = F)
activity.labels <- fread("activity_labels.txt", header = F)

# read all dataset files

# test dataset

# faster fread crashes on larger files (on my computer)...  read.table...
features.test <- data.table(read.table(file.path("test", "X_test.txt")))
activity.test <- fread(file.path("test", "y_test.txt"))
subject.test <-  fread(file.path("test", "subject_test.txt"))

#train dataset
features.train <- data.table(read.table(file.path("train", "X_train.txt")))
activity.train <- fread(file.path("train", "y_train.txt"))
subject.train <-  fread(file.path("train", "subject_train.txt"))

# Merges the training and the test sets (1)
features <- rbind(features.train, features.test)
activity <- rbind(activity.train, activity.test)
subject <- rbind(subject.train, subject.test)

features.names.length <- nrow(features.names)

# Appropriately labels the data set with descriptive variable names (4)
setnames(features, 1:features.names.length, t(features.names$V2))
setnames(activity, 1, "Activity")
setnames(subject, 1, "Subject")

# Create one data set (1)
fullData <- cbind(features, subject, activity)

# Extracts only the measurements on the mean and standard deviation for each measurement (2)
data.indexes <- c(grep("-(mean|std)\\(", features.names$V2),
                  features.names.length + 1, features.names.length + 2)
dataset <- fullData[, data.indexes, with = F]

# Uses descriptive activity names to name the activities in the data set (3)
dataset$Activity <- factor(dataset$Activity, levels = activity.labels$V1, labels = activity.labels$V2) 

# Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject (5)
mdata <- melt(dataset, id.vars = c("Subject", "Activity"))
dataset <- dcast(mdata, Subject + Activity ~ variable, mean)

# Data set as a txt file created with write.table() using row.name=FALSE
write.table(dataset, "averages.txt", row.name = F)

setwd(wd)
