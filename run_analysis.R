## Script for coursera Project - Getting and Cleaning Data

library (dplyr)

## Step 1
## Load column names with the 561 features names
cols <- read.table ("UCI HAR Dataset/features.txt")$V2

## Load test data and name columns (step 4)
Xtest <- read.table ("UCI HAR Dataset/test/X_test.txt")
colnames (Xtest) <- cols

## Load activity ids and name the column
Ytest <- read.table ("UCI HAR Dataset/test/Y_test.txt")
colnames (Ytest) <- ("Activity_ID")

## Add the Activity_ID to Xtest
Xtest <- cbind (Xtest, Ytest)

## Load subject ids and name the column
Subtest <- read.table ("UCI HAR Dataset/test/subject_test.txt")
colnames (Subtest) <- ("Subject_ID")

## Add the Subject_ID to Xtest
Xtest <- cbind (Xtest, Subtest)

## Same operations are applied to train data
Xtrain <- read.table ("UCI HAR Dataset/train/X_train.txt")
colnames (Xtrain) <- cols
Ytrain <- read.table ("UCI HAR Dataset/train/Y_train.txt")
colnames (Ytrain) <- ("Activity_ID")
Xtrain <- cbind (Xtrain, Ytrain)
Subtrain <- read.table ("UCI HAR Dataset/train/subject_train.txt")
colnames (Subtrain) <- ("Subject_ID")
Xtrain <- cbind (Xtrain, Subtrain)

## Merge train and test data by rows and keep only complete observations
X <- rbind (Xtest, Xtrain)
X <- X[complete.cases (X),]

## Step 2 : Select only means and std columns, as well as the Activity and Subject_ID columns
select = grep("mean\\(\\)|std\\(\\)|Activity|Subject_ID", names(X)) 
X<- X[select]

## Step 3 : Load activities names and add it as last column to data set
actinames <- read.table ("UCI HAR Dataset/activity_labels.txt")
colnames(actinames) <- c("Activity_ID", "Activity")
X <- merge (X, actinames)

## Drop first column ACtivity_ID since we only need activity names
X[,1] <- NULL

## Step 4 : has already been performed during step 1 when inserting variable names

## Step 5 : group X observations by subject and activity and take the mean of each variable 
Z <- group_by(X, Subject_ID, Activity) 
Z <- summarize_each (Z, funs(mean))

## Save it in a file
write.table(Z, "output.txt", row.name=FALSE)

## End of script
