# Getting-and-Cleaning-Data-Course-Project

The script `run_analysis.R` produces a tidy data set with averages of values from experiments conducted by Samsung over 30 volunteers performing several activities wearing a smartphone on the waist.

## How the script works

It is a plain script runnable with `source('run_analysis.R')`.

The script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Code book

The original data set is divided by two main criteria: train and test observations over 561 variables.
The train data set contains 7352 observations and the test data set contains 2947 observations.

The observations of each data set come in a folder structure containing several text files.

"UCI HAR Dataset": main folder, contains:

  * `activity_labels.txt`: labels of the six different performed activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING);
  
  * `features.txt`: the descriptive column names in the data set.
  
  * the folders `train` and `test`; each folder, where * is the name of the folder, contains:

    * `subject_*.txt`: ids of the subject for every observation;
    * `X_*.txt`: values for every observation;
    * `y_*.txt`: the activity performed for every observation.

### Data set

*Subject*: the id of the volunteer that performed the activities wearing a smartphone on waist (1-30).

*Activity*: the activity the subject performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The other variables are the average of values that come from the signals:

* '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions;

* prefix 't' to denote time, 'f' frequency domain signals;

* variables from signals acquired from the accelerometer and gyroscope contains 'tAcc' and 'tGyro';

* the acceleration signal was separated into body and gravity acceleration signals ('tBodyAcc' and 'tGravityAcc');

* the body linear acceleration and angular velocity were derived in time to obtain Jerk signals  'tBodyAccJerk' and 'tBodyGyroJerk');

* the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag);

* a Fast Fourier Transform was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

