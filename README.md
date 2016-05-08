## Getting and Cleaning Data Project

Nicolás Giannetti

Repo for the submission of the course project for the Johns Hopkins Getting and Cleaning Data course.

### Overview
This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent
analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Making Modifications to This Script
Once you have obtained and unzipped the source files, you will need to make one modification to the R file before you can process the data.
Note that on line 26 of run_analysis.R, you will set the path of the working directory to relect the location of the source files
in your own directory.

### Script summary
The following is a summary description of the script steps.

1. Load librarys
2. Download and unzip data
3. Get variable names from "features.txt" and handle some
4. Specific problems with commas so each variable name is one row in var_names
5. Get the data from test and train
6. Combine all rows, test and train, in one dataset
7. Rename subject and activity variables
8. Rename variables from x features
9. Select columns with "mean" or "std" in their names
10. Column bind the activity and subject columns to the x features dataset
11. Rename varible names for better understanding
12. Crate new dataset with 
13. Export the tidyData set to tidyData.txt 


### Additional Information
You can find additional information about the variables, data and transformations in the CodeBook.MD file.