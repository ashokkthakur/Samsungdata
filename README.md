# Samsungdata
* Analyze Samsung wearable data and create tidy data set

* README updated as part of run_analysis code application on the source data set

* This program is to download the "wearablecomputing.zip" source data and process it in 5 different steps to make it a tidy dataset and 
  write the output to a text file with space separated variables.

# To run the program -

## Place the source code "run_analysis.R" in the working directory, and create s subfolder "data" - (./data)
* From the R console, after moving to working directory, execute the code-
** source("run_analysis.R")
## The code will perform the below listed steps and will return back to the prompt.
* execute "View(avg_tidydataset)" to view the final output.
* open file "tidydataset.txt" from the "./data" subfolder to view the output file.
## Refer "codebook.md", for the details of the program and variable names.


# Analysis steps- 
## 	Download, unzip and read the relevant files-
	## the source zip file "wearablecomputing.zip" gets downloaded to "./data" subfolder under working directory.
	## the file gets unzipped and placed in the same location
	## unzip the source data and get the contents of the zip file.
	## the 7 relevant text files are read and stored in dataframes.
		 * "y_test"
		 * "x_test"
		 * "subject_test"
		 * "y_train"
		 * "x_train"
		 * "subject_train"
		 * "activity_labels"

## 	Step1 - merge files
	## merge the test and train datasets for all three file categories
		 * "merged_y"
		 * "merged_x"
		 * "merged_subject"

## 	Step2 - extract only the mean and std variables
	## read the features table to get the variable names and assign columns names to the data frame in merged-x
		 * "merged_x"
	## select columns with "mean" and "std" values based on column names in merged data frame for X 
		 * "merged_x_mean_std"

## 	Step3 - use descriptive activity names
	## join merged activity data (in y) with the description data labels - 
		 * "merged_y_desc"

## 	Step4 - label dataset with descriptive variable names
	## put appropriate column names to final merged tables for data frames- subject and activity
		 * "subject" from subject file
		 * "activity_code" and "activity_desc" from "merged_y_desc"
	## create "tidydataset" by combining final data drames for- subject, y-activity and x-mean and std values.
	## rename tidydataset for meaningful column names --
		 * substitute variable starting with "f" to "freq_"
		 * substitute variable starting with "t" to "time_"	
		 * substitute variable name with string "Gyro" to "_gyroscope_"
		 * substitute variable name with string "Acc" to "_acceleration_"
		 * substitute variable name with string "Mag" to "magnitude"

# 	Step5 - Final data set with summary
	## independent data set with average of each variable, grouped by activity and subject 
		 * "avg_tidydataset"
	## writing final tidy dataset to a text file with space as separator and no row names 
		 * "tidydataset.txt"

The complete list of variables in the text file "tidydataset.txt" is listed in "codebook.md"
