require(reshape2)
require(data.table)

wd <- getwd()

if(!dir.exists("UCI HAR Dataset")) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  archive <- "UCI_HAR_Dataset.zip"
  download.file(url, archive)
  
  unzip(archive)
  unlink(archive)
}

# 1. Merges the training and the test sets to create one data set

# Faster fread crashes on larger files (on my computer) and cannot handle
# multiple space column delimiter... 
# using read.table instead for X_test.txt and X_train.txt

setwd("UCI HAR Dataset")

features <- rbind(data.table(read.table(file.path("train", "X_train.txt"))),
                  data.table(read.table(file.path("test", "X_test.txt"))))

activity <- rbind(fread(file.path("train", "y_train.txt")),
                  fread(file.path("test", "y_test.txt")))

subject <- rbind(fread(file.path("train", "subject_train.txt")),
                 fread(file.path("test", "subject_test.txt")))

setnames(activity, 1, "Activity")
setnames(subject,  1, "Subject")

full.dataset <- cbind(features, subject, activity)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
features.names <- fread("features.txt")
features.mean.and.std.indexes <- c(grep("-(mean|std)\\(", features.names$V2))

full.dataset.ncols = ncol(full.dataset)
reduced.dataset.columns <- c(features.mean.and.std.indexes, 
                             full.dataset.ncols - 1,  # column Subject
                             full.dataset.ncols)

reduced.dataset <- full.dataset[, reduced.dataset.columns, with = F]

# 3. Uses descriptive activity names to name the activities in the data set
activity.labels <- fread("activity_labels.txt")
reduced.dataset$Activity <- factor(reduced.dataset$Activity,
                           levels = activity.labels$V1, 
                           labels = activity.labels$V2) 

# 4. Appropriately labels the data set with descriptive variable names
setnames(reduced.dataset, 1:(ncol(reduced.dataset) - 2),
         t(features.names[features.mean.and.std.indexes,]$V2))

# 5. Creates a second, independent tidy data set with the average of each variable
#    for each activity and each subject
melted.dataset <- melt(reduced.dataset, id.vars = c("Subject", "Activity"))
final.dataset <- dcast.data.table(melted.dataset, Subject + Activity ~ variable, mean)

# Data set as a txt file created with write.table() using row.name=FALSE
write.table(final.dataset, "averages.txt", row.name = F)

setwd(wd)
