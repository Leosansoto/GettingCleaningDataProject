# CodeBook

This code book describes the inputs, transformations and outputs and relevant information about variables, functions, decisions and details to performed achieve the target results of the project. Providing enough information for anyone to understand de R script developed.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The README.txt file included in the original data is key both to develop and understand the R coding. Let me simplify a few ideas.
There is a lot of information hold on numerous files that is not required for this project though be relevant for the experiments and scientist involved. Those files to get rid of are in the two Inertial Signals directories.
There are to blocks of information separated in two directories, test and train. We could say that this partition is artificial because, as stated in the README, “The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.”.

As even the file names are not very descriptive, here is a description of them:

X_test.txt and X_train.txt is the raw data of the experiment, as described above.
y_test.txt and y_train.txt is the coded number (1 to 6) of the activity performed by the subject (volunteer), aka: 1 = WALKING, 2 = WALKING_UPSTAIRS, etc,
subject_test.txt and subject_train.txt are the files that contains the number (1 to 30) of the subject performing the activity.
The number of rows of every test file, as no other way could be, is the same: 2.947.
The number of rows of every train file, again, is the same: 7.352.

After the join process we will face a data table with 10.299 rows. A first column with the activity code, a second column with subject code and a rest of 66 columns with the corresponding raw experiment data per subject/activity.

## Script coding Information (general steps)

- Setting directory path to download the zip file containing the project data.
- Download file from the Internet.
- Unzip the downloaded file into a directory called /assignment.
- Read all the relevant files, each of them to a different and dedicated data table.
- Using rbind function, join each pair of test/train files.
- Start working with their variable(column) names.
	- I still have doubts if choosing sensordata instead of features to name the table with the row data is 	appropriate or helps but here is my disclaimer.
	- features.txt (my sensor data) contains 561 variables or columns with the most misunderstandable names and we have to get rid of most of them. This point related with names and columns is the tricky part of the project.
- From those 561 variables choose (subset) only the ones with mean or std in their names.
- Use descriptive activity names, this is to factorize 1 to 6 numeric values to “WALKING”, etc. 
- We have learn to apply naming conventions and stile guidelines for variable names, at this point we clean these names. We use a work variable for this instead of working directly with names().
- Finally using nice features of dplyr library we group by subject and activity then we summarize the 66 row data columns of the experiment.
- Produce a .csv output file as the Tiny Dataset.

## Transformation applied to variable names.

Just as an example here I attach a few variable names before and after the “cleaning” process.

### Before

 [1] "tBodyAcc-mean()-X"
 [2] "tBodyAcc-mean()-Y"          
 [3] "tBodyAcc-mean()-Z"           
 [4] "tBodyAcc-std()-X"           
 [5] "tBodyAcc-std()-Y"            
 [6] "tBodyAcc-std()-Z"           
 [7] "tGravityAcc-mean()-X"        
 [8] "tGravityAcc-mean()-Y"       
 [9] "tGravityAcc-mean()-Z"        
[10] "tGravityAcc-std()-X"  
[11] "tGravityAcc-std()-Y"         
[12] "tGravityAcc-std()-Z"        
[13] "tBodyAccJerk-mean()-X"       
[14] ”tBodyAccJerk-mean()-Y"      
[15] "tBodyAccJerk-mean()-Z"       
[16] ”tBodyAccJerk-std()-X"       
[17] "tBodyAccJerk-std()-Y"        
[18] ”tBodyAccJerk-std()-Z"       
[19] "tBodyGyro-mean()-X"          
[20] ”tBodyGyro-mean()-Y"

### After

 [1] "timebodyAccelerometermeanx"                     
 [2] "timebodyAccelerometermeany"                     
 [3] "timebodyAccelerometermeanz"                     
 [4] "timebodyAccelerometerstdx"                      
 [5] "timebodyAccelerometerstdy"                      
 [6] "timebodyAccelerometerstdz"                      
 [7] "timegravityAccelerometermeanx"                  
 [8] "timegravityAccelerometermeany"                  
 [9] "timegravityAccelerometermeanz"                  
[10] "timegravityAccelerometerstdx"                   
[11] "timegravityAccelerometerstdy"                   
[12] "timegravityAccelerometerstdz"                   
[13] "timebodyAccelerometerjerkmeanx"                 
[14] "timebodyAccelerometerjerkmeany"                 
[15] "timebodyAccelerometerjerkmeanz"                 
[16] "timebodyAccelerometerjerkstdx"                  
[17] "timebodyAccelerometerjerkstdy"                  
[18] "timebodyAccelerometerjerkstdz"                  
[19] "timebodygiroscopemeanx"                         
[20] "timebodygiroscopemeany"

==================================================================
Human Activity Recognition Using Smartphones Dataset
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The data

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
