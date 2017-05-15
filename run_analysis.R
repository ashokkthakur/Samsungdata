library(dplyr)
library(tidyr)

## source file variable	
	file <- "./data/wearablecomputingsourcedata.zip"

## capture url and download the zip file, if not already exists.
	if (!file.exists(file)){
		url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
		download.file(url, "./data/wearablecomputingsourcedata.zip")
 	}
## unzip the source data and get the contents of the zip file.
	 ##zip_contents <- unzip("./data/wearablecomputingsourcedata.zip", list=TRUE)
	 unzip("./data/wearablecomputingsourcedata.zip", exdir="./data", junkpaths=TRUE)
## filter to get the list of text files with path in dataframe.
	 ##zip_text_files <- zip_contents %>% select(Name) %>% filter(grepl(".txt", Name)) %>% arrange(Name)

## read the 7 relevant text files and store in dataframes.
 	 y_test<- read.table("./data/y_test.txt")
	 x_test<- read.table("./data/X_test.txt")
	 subject_test<- read.table("./data/subject_test.txt")
	 y_train<- read.table("./data/y_train.txt")
	 x_train<- read.table("./data/X_train.txt")
	 subject_train<- read.table("./data/subject_train.txt")
	 activity_labels<- read.table("./data/activity_labels.txt")

##Step1
## merge the test and train datasets for all three file categories
 	 merged_y <- rbind(y_test, y_train)
	 merged_x <- rbind(x_test, x_train)
	 merged_subject <- rbind(subject_test, subject_train)

##Step2
## read the features table to get the variable names and assign columns names to the data frame in merged-X
	 features<- read.table("./data/features.txt")
	 names(merged_x) <- features[,2]
## select columns with "mean" and "std" values based on column names in merged data frame for X
	 merged_x_mean_std <- merged_x [grepl("(.*mean.*)|(.*std.*)", names(merged_x))]

##Step3
## join merged activity data (in y) with the description data labels
	 merged_y_desc <- merge(merged_y, activity_labels, by.x = "V1", by.y = "V1")


##Step4
## put appropriate column names to final merged tables for data frames- subject and activity
	 names(merged_subject)<- "subject"
	 names(merged_y_desc)<- c("activity_code", "activity_desc")

## create tidydataset by combining final data drames for- subject, y-activity and x-mean and std values.
	 tidydataset<- cbind(merged_subject, merged_y_desc, merged_x_mean_std)

## rename tidydataset for meaningful column names
	 names(tidydataset)<- sub("^f", "freq_", names(tidydataset))
	 names(tidydataset)<- sub("^t", "time_", names(tidydataset))	
	 names(tidydataset)<- sub("Gyro", "_gyroscope_", names(tidydataset))
	 names(tidydataset)<- sub("Acc", "_acceleration_", names(tidydataset))
	 names(tidydataset)<- sub("Mag", "magnitude", names(tidydataset))

##Step5
##independent data set with average of each variable, grouped by activity and subject
	 avg_tidydataset <- tidydataset %>% group_by(activity_desc, subject) %>% summarise_each(funs(mean))

## writing final tidy dataset to a text file with space as separator and no row names.
	 write.table(avg_tidydataset,"./data/tidydataset.txt",sep=" ",row.names=FALSE)


