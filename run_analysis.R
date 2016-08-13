#-------------------------ACTIVITY FILES------------------------------#

TestDataActivity <- read.table("test/Y_test.txt" , header = FALSE)
TrainDataActivity <- read.table("train/Y_train.txt" , header = FALSE)

#---------------------------------------------------------------------#

#-------------------------SUBJECT FILES-------------------------------#

TestDataSubject <- read.table("test/subject_test.txt" , header = FALSE)
TrainDataSubject <- read.table("train/subject_train.txt" , header = FALSE)

#---------------------------------------------------------------------#

#-------------------------FEATURES FILES------------------------------#

TestDataFeatures <- read.table("test/X_test.txt" , header = FALSE)
TrainDataFeatures <- read.table("train/X_train.txt" , header = FALSE)
FeaturesNamesData <- read.table("features.txt" , header = FALSE)

#---------------------------------------------------------------------#



# 1.Merges the training and the test sets to create one data set !!!

#--Merging the activity data files to create one data set of activity--#

ActivityData <- rbind(TestDataActivity,TrainDataActivity)

#---------------------------------------------------------------------#

#---Merging the subject data files to create one data set of subject---#

SubjectData <- rbind(TestDataSubject,TrainDataSubject)

#----------------------------------------------------------------------#

#--Merging the features data files to create one data set of features--#

FeaturesData <- rbind(TestDataFeatures,TrainDataFeatures)

#---------------------------------------------------------------------#

#-----------------------Naming the variables--------------------------#

names(ActivityData) <- c("activity")
names(SubjectData) <- c("subject")
names(FeaturesData) <- FeaturesNamesData$V2

#--------------------------------------------------------------------#

#-------Merging coloumns to get DATA in the form of data frame------# 

dt <- cbind(ActivityData,SubjectData)
DATA <- cbind(FeaturesData, dt)

#--------------------------------------------------------------------#

# 2.Extracts only the measurements on the mean and standard deviation 
#for each measurement.

FeatureMeanAndStd <- FeaturesNamesData$V2[grep("mean()|std()", FeaturesNamesData$V2)]
Names <- c(as.character(FeatureMeanAndStd), "subject" , "activity")
DATA <- subset(DATA,select = Names)

#--------------------------------------------------------------------#

# 3. Uses descriptive activity names to name the activities 
#in the data set.

ActivityLabel <- read.table("activity_labels.txt", header = FALSE)
names(ActivityLabel) <- "activityid"
DATA <- merge(DATA,ActivityLabel, by="activityid" , all.x = TRUE)

#-------------------------------------------------------------------#

# 4. Appropriately labels the data set with descriptive variable names.

names(DATA) <- gsub("^t" , "time" , names(DATA))
names(DATA) <- gsub("^f", "frequency", names(DATA))
names(DATA) <- gsub("Acc" , "Accelerometer" , names(DATA))
names(DATA) <- gsub("Gyro", "Gyrometer", names(DATA))
names(DATA) <- gsub("Mag", "Magnitude" , names(DATA))
names(DATA) <- gsub("BodyBody" , "Body" , names(DATA))

#--------------------------------------------------------------------#

# 5. From the data set in step 4, creates a second, independent 
#tidy data set with the average of each variable for each activity 
#and each subject.

TidyData <- aggregate(. ~subject + activity , DATA , mean)
TidyData <- TidyData[order(TidyData$subject, TidyData$activity), ]
write.table(TidyData, file = "tidydata.txt", row.name = FALSE)

#--------------------------------------------------------------------#
