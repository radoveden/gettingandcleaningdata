Readme for this project
=======================

This is my solution for the "Getting and Cleaning Data" project of the Coursera course with the same name

## Preliminary remarks
- I did the exercise on a simple windows laptop
- I use the package "eeptools" for sorting purposes. The function library(eeptools) can give some errors, because it dependents on some others packages.
For our purposes these packages are not necessary. So I used the try function to avoid the script stops due to these errors.
- I put a 5 minutes wait between the download of the zip file and the unzip. Otherwise the script doesn't run properly.

## Description of the script
- Task 0 checks the zip file is downloaded already, if not it downloads and unzip it.
- Task 1 loads the test and training files in memory and glues them togother, resulting in three files:
a data file with the actual data
a subject file with the number of the test person
a label file describing the activity of the test person
- In task 2 we load the features files, which will be used as column names. After we extracts the measurements on the mean and standard deviation.
- In task 3 we change the activity number by their description and 
- glue them in task 4 together with the number of the test person as first columns before the rest of our data. 
- Task 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
