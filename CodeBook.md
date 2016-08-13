Getting And Cleaning Data

We will explain the code of run_analysis.R and the will explain the dataset too.

CODE:

CONCATENATE: 

First of all the activity files of train and test are saved in the variables, similarly the subject and features files are also saved in the variables as described in the R file.

Mergeing the Activity, subject and Features variables through rbind function:

The activity variables are merged and given a new variable and a combine dataset for activity data, similarly with the subject and activity dataset are formed. 

Final Dataset:

Now we have three datasets for activity,subject and features we will combine them to form a final dataset with the help of cbind function and the dataset is saved in a variable DATA.

Measurements For Mean() and Std():

with help of features datset we will now extract only the mean() and std() for each measurement of feature "subject" and "activity".And will subset that part of data from the datset to update the DATA dataset.

To make the dataset Tidy:

At this moment the dataset is not tidy beacuse the "t" represent "time" but in dataset it is presented as "t" so in order to make it tidy we will perform the following queries on the DATA dataset.
names(DATA) <- gsub("^t" , "time" , names(DATA))
names(DATA) <- gsub("^f", "frequency", names(DATA))
names(DATA) <- gsub("Acc" , "Accelerometer" , names(DATA))
names(DATA) <- gsub("Gyro", "Gyrometer", names(DATA))
names(DATA) <- gsub("Mag", "Magnitude" , names(DATA))
names(DATA) <- gsub("BodyBody" , "Body" , names(DATA))

Writing Tidy dataset to tidydata.txt file:

Create a tidydata.txt file and write the TidyData dataset to that file which is also present in the repo along with other files. 

INFORMATION RELATED TO DATASET:

The Y_test.txt and Y_train.txt includes the data information related to activity_labels.txt i.e it is break down into two further datasets.Whereas the subject_test.txt and subject_train.txt forms the subject dataset. Name of the variables features comes from features.txt which are further break down into X_test and X_train.   