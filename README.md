GaCDProject
===========

#This git repo has included all the scripts and data sets needed for the project.

#The R script file is run_analysis.R and all the original data sets are in the folder ./Data/UCI HAR Dataset/

#If you want to use your own datasets, please put all the data needed in the folder: YOUR_WORKING_DIRECTORY/Data/UCI HAR Dataset/

#After you download this repo to your local path, you should set your working directory to this folder

#And then you can open the script file run_analysis.R and then run it straightforward in R

#The script will mainly do several data operations as follows:


#1 install the necessary packages, e.g. plyr, etc.

#2 load all the raw data into R

#3 combine train data, activity, and subject and make descriptive labels

#4 combine test data, activity, and subject and make descriptive labels

#5 combine test data and train data and make descriptive variable names

#extract only mean and std for measurements and make descriptive variable names

#initialize the first 3 columns of the tidydataset and make descriptive variable names

#use for loop to calculate the average of each variable for each activity and subject and make descriptive variable names

#save the result tidy data set in the file "tidydataset.txt"
