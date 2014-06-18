try(library(eeptools))
# Task 0 - downloading the zip file and extracting it
if(!file.exists("project.zip")){
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
	setInternet2(use = TRUE)
	download.file(fileUrl, destfile = "project.zip", mode="wb")
	Sys.sleep(300)# better wait here a bit
	unzip("project.zip")
}

#  Task 1 - Merges the training and the test sets to create one data set.
testX <- read.table("UCI HAR Dataset/test/X_test.txt") #data
testY <- read.table("UCI HAR Dataset/test/y_test.txt") #label
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainX <- read.table("UCI HAR Dataset/train/X_train.txt") #data
trainY <- read.table("UCI HAR Dataset/train/y_train.txt") #label
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
data <- rbind(testX, trainX)
label <- rbind(testY, trainY)
subject <- rbind(testSubject, trainSubject)

# Task 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# First we load the description of the columns
features <- read.table("UCI HAR Dataset/features.txt")
# and put them as columns names
# Through head(features) we see that V1 gives the column number and V2 the description of that column
# so let put them as column names
names(data) <- features$V2
# We only need to retain the columns with -mean() or -std() in the description
keepcol <- grep("mean\\(\\)|std\\(\\)", names(data))
data <- data[, keepcol]
# Maybe we need to clean up the columns names, but they are fine for me now

# Task 3 - Uses descriptive activity names to name the activities in the data set
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
# since I don't like capitals, let's change it in lower case
activity$V2 <- tolower(activity$V2)
# change the numeric value in the label table by their activity meaning
label[, 1] <- activity[label[, 1], 2]
# Task 4 - Appropriately labels the data set with descriptive variable names. 
# first let us column names to these new colums
names(label) <- "activity"
names(subject) <- "subject"
# then bind everything together
data <- cbind(subject, label, data)
# and sort them a bit
# library(eeptools) # install packages if necessary
sorteddata <- data[order(data$subject, data$activity) , ]
# you can keep this data frame now
# write.table(sorteddata, "result1.txt") 
# Task 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidydata <- aggregate(sorteddata, by=list(subject = sorteddata$subject, activity = sorteddata$activity), FUN=mean)
#clean some obsolete columns
tidydata[,4] = NULL
tidydata[,3] = NULL
tidydata <- tidydata[order(tidydata$subject, tidydata$activity) , ] # let's sort one more time
write.table(tidydata, "tidydata.txt") 
