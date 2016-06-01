#
# load the necessary libraries
#
library(dplyr)
#
# Assign the path where you want to work
# and download the files to the current path
# 
current.path <- c("/Users/sanchl")
setwd(current.path)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Dataset.zip",method="curl")
# ... unzip them
unzip(zipfile="./Dataset.zip",exdir="./assignment")
current.path <- paste(current.path, "/assignment", "/", "UCI HAR Dataset", sep = "")
setwd(current.path)
#
# read the files into tables
Activity.test <- read.table(file.path(current.path, "test" , "y_test.txt" ),header = FALSE)
Activity.train  <- read.table(file.path(current.path, "train" , "y_train.txt" ),header = FALSE)
Subject.test  <- read.table(file.path(current.path, "test" , "subject_test.txt" ),header = FALSE)
Subject.train  <- read.table(file.path(current.path, "train" , "subject_train.txt" ),header = FALSE)
Sensor.data.test  <- read.table(file.path(current.path, "test" , "X_test.txt" ),header = FALSE)
Sensor.data.train  <- read.table(file.path(current.path, "train" , "X_train.txt" ),header = FALSE)
Sensor.data.names  <- read.table(file.path(current.path, "features.txt" ),header = FALSE)
activity.names <- read.table(file.path(current.path, "activity_labels.txt"),header = FALSE)
#
#             1. Merges the training and the test sets to create one data set and name the columns
#
subject <- rbind(Subject.train, Subject.test)
names(subject) <- c("subject")
activity <- rbind(Activity.train, Activity.test)
names(activity) <- c("activity")
sensordata <- rbind(Sensor.data.train, Sensor.data.test)
Sensor.data.names  <- read.table(file.path(current.path, "features.txt" ),header = FALSE)
names(sensordata) = Sensor.data.names$V2
#
#             2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
only.mean.std.names <- Sensor.data.names$V2[grep("mean\\(\\)|std\\(\\)", Sensor.data.names$V2)]
final.column.names <- c("subject", "activity", as.character(only.mean.std.names))
tempframe1 = cbind(subject, activity)
alldata = cbind(tempframe1, sensordata)
alldata <- subset(alldata, select = final.column.names)
#
#             3. Uses descriptive activity names to name the activities in the data set
#
alldata$activity <- factor(alldata$activity, levels = activity.names$V1, labels = activity.names$V2)
#
#             4. Appropriately labels the data set with descriptive variable names
# ..... and normalize column names
worknames <- names(alldata)
worknames <- tolower(worknames)
worknames <- gsub("^t", "time", worknames)
worknames <- gsub("^f", "frecuency", worknames)
worknames <- gsub("acc", "accelerometer", worknames)
worknames <- gsub("gyro", "giroscope", worknames)
worknames <- gsub("mag", "magnitude", worknames)
worknames <- gsub("\\(\\)", "", worknames)
worknames <- gsub("-", "", worknames)
names(alldata) <- worknames
#
#             5. From the data set in step 4, creates a second, independent tidy data 
#                set with the average of each variable for each activity and each subject. 
#
newalldata <- alldata %>% group_by(subject, activity) %>% summarise_each(funs(mean))
write.csv(newalldata, file = "tidydataset.csv", row.names=FALSE)
#