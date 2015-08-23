# Getting and Cleaning Data - Course Project

## How the script works

It is a script runnable with `source('run_analysis.R')`.

The script does the following:

1.  Merges the training and the test sets to create one data set.

    Binds the rows from train and test features, subject, and activity, separately; renames the columns for subject and activity then binds the columns to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

    Creates a reduced data set subsetting the columns with the indexes of columns containing "mean()"" and "std()". The variables now are 66 (plus Subject and Activity columns).

3. Uses descriptive activity names to name the activities in the data set.

    Creates levels and labels for the Activity column using the map in `activity_labels.txt`.

4. Appropriately labels the data set with descriptive variable names. 

    Sets the column name from column 1 to 66 with a subset of names with indexes from the step 2.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    Melts the data set then uses `dcast.data.table` to rebuild it with the averages, grouping by Subject and Activity columns.

## Code book

The script `run_analysis.R` produces a tidy data set with averages of values from experiments on Human Activity Recognition, conducted by Samsung with 30 volunteers performing activities of daily living, while carrying a waist-mounted smartphone with embedded inertial sensors.

The original data set is divided by two main criterias: train and test observations over 561 variables. The train and the test data sets provide 7352 and 2947 observations repectively.

The observations of each data set come in a folder structure containing text files.

"UCI HAR Dataset": main folder, contains:

  * `activity_labels.txt`: labels of the six different performed activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING);
  
  * `features.txt`: the descriptive column names in the data set.
  
  * the folders `train` and `test`; each folder, where * is the name of the folder, contains:

    * `X_*.txt`: values for every observation;
    * `y_*.txt`: the activity performed for every observation;
    * `subject_*.txt`: ids of the subject for every observation.

### Data set

**Subject**: the id of the volunteer that performed the activities wearing a smartphone on waist (1-30).

**Activity**: the activity the subject performed (values: 1-6; labels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The other variables are the average of values (within a range -1, 1) representing the acquired smartphone signals. Their names are descriptive:

* '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions;

* prefix 't' to denote time, 'f' frequency domain signals;

* variables from signals acquired from the accelerometer and gyroscope contains 'tAcc' and 'tGyro';

* the acceleration signal was separated into body and gravity acceleration signals ('tBodyAcc' and 'tGravityAcc');

* the body linear acceleration and angular velocity were derived in time to obtain Jerk signals  'tBodyAccJerk' and 'tBodyGyroJerk');

* the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag);

* a Fast Fourier Transform was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

