#Getting and Cleaning Data Course Project
========================================================

This file describes how the "run_analysis.R" will work
Download the 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip Zip file, extract it and rename 
the folder to "dataset"

Before running "run_analysis.R" make sure that current working Dir contains the folder "dataset" and the RScript file "run_analysis.R"

Now, run the file "run_analysis.R" by source("run_analysis.R")

This commands results in creation of two files 

	1. merged_clean_data.txt (8.3 Mb): contains data frame called cleanedData with 10299x68 dimension.
	2. dataset_with_computed_averages.txt (224.9 Kb): contains data frame called resultData with 180x68 dimension.

By using command dt <- read.table("data_with_means.txt") read the file. 

There are average of each variable for 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.
