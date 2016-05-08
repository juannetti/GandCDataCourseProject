##  needed packages! instalation up to user
##  install.packages("dplyr")
##  install.packages("tidyr")
##  install.packages("downloader")

##  load librarys
library(dplyr)
library(tidyr)
library(downloader)

##  download and unzip data
##  http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data
urlData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(urlData, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./G&CD_CourseProyect")

##  get variable names from "features.txt" and handle some
##  specific problems with commas so each variable name is one row in var_names
var_names <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/features.txt", header = FALSE)


##  get the data from test and train
x_test <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/test/X_test.txt", header = FALSE)
x_train <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_test <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/test/y_test.txt", header = FALSE)
y_train <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_test <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject_train <- read.table("./G&CD_CourseProyect/UCI HAR Dataset/train/subject_train.txt", header = FALSE)


##  combine all rows, test and train, in one dataset
subject <- rbind(subject_test, subject_train)
activity <- rbind(y_test, y_train)
data <- rbind(x_test, x_train)


##  rename subject and activity variables
subject <- rename(subject, subject = V1)
activity <- rename(activity, activity = V1)


##  rename variables from x features
names(data) <- var_names$V2


##  select columns with "mean" or "std" in their names
##  "Extracts only the measurements on the mean and standard deviation for each measurement."
data <- select(data, matches("mean|std", ignore.case = TRUE))


##  column bind the activity and subject columns to the x features dataset
data <- cbind(subject, activity, data)

##  rename varible names for better understanding
names(data)<-gsub("[(]", "", names(data))
names(data)<-gsub(")", "", names(data))
names(data)<-gsub(",", "", names(data))
names(data)<-gsub("-", "", names(data))
names(data)<-gsub("std()", "SD", names(data))
names(data)<-gsub("mean()", "MEAN", names(data))
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))


##  crate new dataset with 
tidy <-  aggregate(data, by = list(s = data$subject, a = data$activity), mean)
tidyFinal <- tidy[, 3:length(names(tidy))]

##  Export the tidyData set 
write.table(tidyFinal, './tidyData.txt',row.names=TRUE,sep='\t')
