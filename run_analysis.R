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
var_names <- read.csv("./G&CD_CourseProyect/UCI HAR Dataset/features.txt", header = FALSE)
var_names_filtered <- filter(var_names, nchar(levels(V1)[V1]) > 2, V1 != "gravity)", V1 != "gravityMean)")

##  get the data from test and train
test <- read.csv("./G&CD_CourseProyect/UCI HAR Dataset/test/X_test.txt", header = FALSE)
train <- read.csv("./G&CD_CourseProyect/UCI HAR Dataset/train/X_train.txt", header = FALSE)

##  transform into as many columns as the features.txt declare as variables
##  giving the proper descriptive name for each variable
test_separated <- separate(test, V1, var_names_filtered[,1], sep = "[0-9]( |\t|\n|\r|\b)")
train_separated <- separate(train, V1, var_names_filtered[,1], sep = "[0-9]( |\t|\n|\r|\b)")

##  merge into one data set
dataset <- rbind(test_separated, train_separated)

##  select columns with "mean" or "std" in their names
##  "Extracts only the measurements on the mean and standard deviation for each measurement."
dataset_final <- select(dataset, matches("mean|std", ignore.case = TRUE))
View(dataset_final)
