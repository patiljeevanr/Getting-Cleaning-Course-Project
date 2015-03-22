##Step1
#Reading Train Dataset
trainData <- read.table("./dataset/train/X_train.txt")
trainLab <- read.table("./dataset/train/y_train.txt")
trainSub <- read.table("./dataset/train/subject_train.txt")
#Reading Test Dataset
testData <- read.table("./dataset/test/X_test.txt")
testLab <- read.table("./dataset/test/y_test.txt") 
testSub <- read.table("./dataset/test/subject_test.txt")
#Performing Join Operations
joinData <- rbind(trainData, testData)
joinLab <- rbind(trainLab, testLab)
joinSub <- rbind(trainSub, testSub)
#;;;;;;;;;;;;Step 1 Done;;;;;;;;;;;

##Step 2
# Step2. Extracts only the measurements on the mean and standard deviation for each measurement.
#Now read the features..
attrlab <- read.table("./dataset/features.txt")
meanStdVal <- grep("mean\\(\\)|std\\(\\)", attrlab[, 2])
joinData <- joinData[, meanStdVal]
#tidying the data :-)
# removeing "()"
names(joinData) <- sub("\\(\\)", "", attrlab[meanStdVal, 2])
# capitalize M
names(joinData) <- sub("mean", "Mean", names(joinData))
# capitalize S
names(joinData) <- sub("std", "Std", names(joinData))
# remove "-" in column names
names(joinData) <- sub("-", "", names(joinData))  
#;;;;;;;;;;;;Step 2 Done;;;;;;;;;;;

## Step3. Uses descriptive actData names to name the activities in the data set
actData <- read.table("./dataset/activity_labels.txt")
# To Lower Cases.
actData[, 2] <- tolower(sub("_", "", actData[, 2]))
#oops! now everything is in lower case  
# using substring(substr) to convert
# walkingupstairs to walkingUpstairs and walkingdownstairs to  walkingDownstairs
substr(actData[2, 2], 8, 8) <- toupper(substr(actData[2, 2], 8, 8))
substr(actData[3, 2], 8, 8) <- toupper(substr(actData[3, 2], 8, 8))
#adding it to joinLabel
actlab <- actData[joinLab[, 1], 2]
joinLab[, 1] <- actlab
names(joinLab) <- "actData"
#;;;;;;;;;;;;Step 3 Done;;;;;;;;;;;

# Step4. Appropriately labels the data set with descriptive actData names. 
names(joinSub) <- "subject"
cleanedData <- cbind(joinSub, joinLab, joinData)
# writing this to file
write.table(cleanedData, "merged_clean_data.txt") 
#;;;;;;;;;;;;Step 4 Done;;;;;;;;;;;

# Step5. Creates a second, independent tidy data set with the average of each 
# variable for each actData and each subject. 
subLen <- length(table(joinSub)) 
actLen <- dim(actData)[1] 
colLen <- dim(cleanedData)[2]
#creating result matrix of 180X68 initializing it with NA
resultData <- matrix(NA, nrow=subLen*actLen, ncol=colLen) 
#converting it to data.frame
resultData <- as.data.frame(resultData)
#giving cleanedData Column names to result
colnames(resultData) <- colnames(cleanedData)
row <- 1
for(i in 1:subLen) {
  for(j in 1:actLen) {
    resultData[row, 1] <- sort(unique(joinSub)[, 1])[i]
    resultData[row, 2] <- actData[j, 2]
    cond1 <- i == cleanedData$subject
    cond2 <- actData[j, 2] == cleanedData$actData
    resultData[row, 3:colLen] <- colMeans(cleanedData[cond1&cond2, 3:colLen])
    row <- row + 1
  }
}
View(resultData)
# writing the 2nd dataset to data_with_means
write.table(resultData,"dataset_with_computed_averages.csv",sep = ",")
write.table(resultData, "dataset_with_computed_averages.txt")
