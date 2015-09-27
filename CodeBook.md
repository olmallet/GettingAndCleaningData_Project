# Course Project : Getting and Cleaning Data

## 1. Inspection of data set UCI HAR Dataset
Data sets are overall split in train data (70% of observations) and test data (30% of observations) located in the corresponding "train" and "test" directories.

The basic raw data files collected from devices are the files contained in the "Inertial Signal" sub-directories.

The Xtest and Xtrain files contain 561 data features derived from the raw data with resampling and transposition to the frequency domain via Fourier transforms.

The Ytest and Ytrain files contain the activity identifiers for each observation.

The "subject_test.txt" and "subject_train.txt" contain subject identifiers for each corresponding observation of X_test / X_train and Y_test / Y_train data.

## 2. Description of processing
The script run_analysis.R implements the 5 steps required for the project. This section provides details.

### Choice of relevant data files for the project
For the project, we need to collect in a single data frame :
* the computed means and stddevs of measures => only X_test and X_train contain such data
* the activities => activity ids are contained in the Y_test and Y_train data, and activity names are contained in the file "activity_labels.txt" 
* the subjects => id are contained in the files "subject_test.txt" and "subject_train.txt"

Note : The files in the "Inertial Signal" directories are not useful because they do not contain computed means or stddevs and step 2 of the instructions only retains means and stddevs.

### Step 1 : Collection of data

We follow these steps both for train and test data :
* load X_test/train data (the 561 features)
* add column names read from the features.txt file
* fix the columns wrongly named with bodybody (see section 3)
* add Activity_ID read from the Y_test/train file
* add Subject_ID read from the subject_test/train file

The number of columns is 561 + 2 = 563.
Then we combine train and test data into a single dataframe.

### Step 2 : Extract means and devs
We keep only the following columns :
* those whose name contain "mean()" or "std()" : we get 66 variables
* the 2 last columns : Activity_ID and Subject_ID

### Step 3 : Add activity names
Then we merge with activity names contained in file "activity_labels.txt", and drop the Activity_ID column.
We make sure that all activity id are correctly associated (inner join = outer join).
We remove potential incomplete observations.

### Step 4 : Label data with descriptive labels
The labels coming from the "activity_labels.txt" file are already readable. 
The last section of this CodeBook gives more details on the names and meanings.

### Step 5 : Average of variables per activity / subject
We split the data per Activity and Subject, and apply the mean function for all variables.
Data is then saved to "output.txt" file.

## 3. Variable description
The first two variables are :
* SUBJECT_ID : the identifier of the subject performing activities
* Activity : the type of activity performed by subject

The other 66 variables are means of the values collected for all observations for this SUBJECT_ID and this Activity.
See file "features.info.txt" for the detail of how this variables were derived from the accelerometer and gyroscope signals.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag

* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag (note : misnamed fBodyBodyAccJerkMag in data set)
* fBodyGyroMag (note : misnamed fBodyBodyGyroMag in data set)
* fBodyGyroJerkMag (note : misnamed fBodyBodyGyroJerkMag in data set)

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
Note : additional estimations are present in the full data set but not used for this project.

Units used for numeric variables :
* For accelerations (all names not mentioning jerk) : m/s^2
* For jerks : m/s^3

END OF CODEBOOK
