# Course Project : Getting and Cleaning Data

## Inspection of data set UCI HAR Dataset
Data sets are overall split in train data (70% of observations) and test data (30% of observations) located in the corresponding directories.

The basic raw data files collected from devices are the files contained in the "Inertial Signal" directories.

The Xtest and Xtrain files contain 561 data features derived from the raw data with resampling and transposition to the frequency domain via Fourier transforms.

The Ytest and Ytrain files contain the activity ids for each observation.

The subject_test and subject_train contain subject identifiers for each corresponding observation of X_test / X_train and Y_test / Y_train.

## Choice of data for the project
For the project, we need to collect in a single data frame :
* the means and stddevs of measures => only Xtest and Xtrain contain such data
* the activities => id are contained in the Ytest and Ytrain, and activity names are contained in the file "activity_labels.txt" 
* the subjects => id are contained in the files "subject_test.txt" and "subject_train.txt"

Note : The files in the "Inertial Signal" directories are not useful because they do not contain means or stddevs and step 2 only retains means and stddevs.

## Step 1 : Collection of data

We follow these steps both for train and test data :
* load X_ data (the 561 features)
* add column names read from the features.txt file
* add activity id read from the Y_ file
* add subject id read from the subject_

The number of columns is 561 + 2 = 563.
Then we combine train and test data.

## Step 2 : Extract means and devs
We keep only the following columns :
* those whose name contain "mean()" or "std()" : we get 79 variables
* the 2 last columns : "Subject_ID" and "Activity_ID"

We make sure that all activity id are correctly associated (inner join = outer join).

## Step 3 : Add activity names
Then we merge with activity names contained in file "activity_labels.txt", and drop the Activity_Id column.

## Step 4 : Label data with descriptive labels
The labels coming from the "activity_labels.txt" file are already readable. 
The last section of this CodeBook gives plain descriptions.

## Step 5 : Average of variables per activity / subject
We split the data per Activity and SUbject, and apply the mean function for all variables.
Data is then saved to "output.txt" file.

## Variable names
The first two variables are :
* SUBJECT_ID : the identifier of the subject performing activities
* Activity : the type of activity performed by subject

The other variables are means of the values collected for all observations for this SUBJECT_ID and this Activity.
See file "features.info.txt" for the detail of how this variables were derived from the accelerometer and gyroscope signals.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

*tBodyAcc-XYZ
*tGravityAcc-XYZ
*tBodyAccJerk-XYZ
*tBodyGyro-XYZ
*tBodyGyroJerk-XYZ
*tBodyAccMag
*tGravityAccMag
*tBodyAccJerkMag
*tBodyGyroMag
*tBodyGyroJerkMag

*fBodyAcc-XYZ
*fBodyAccJerk-XYZ
*fBodyGyro-XYZ
*fBodyAccMag
*fBodyAccJerkMag
*fBodyGyroMag
*fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
Note : additional estimations are present in the data set but not used for this project.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

*gravityMean
*tBodyAccMean
*tBodyAccJerkMean
*tBodyGyroMean
*tBodyGyroJerkMean

END OF CODEBOOK