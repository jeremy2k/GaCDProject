#install.packages("sqldf", repos="http://cran.us.r-project.org", dependencies=TRUE)
#library(sqldf)
#options(sqldf.driver = "SQLite")
#load all the needed packages
library(plyr)

#load all the raw data into R

activity<-read.table("./Data/UCI HAR Dataset/activity_labels.txt",header=FALSE)
names(activity)<-c("activity_id","activity_label")
features<-read.table("./Data/UCI HAR Dataset/features.txt",header=FALSE)
xtrain<-read.table("./Data/UCI HAR Dataset/train/X_train.txt",header=FALSE)
ytrain<-read.table("./Data/UCI HAR Dataset/train/y_train.txt",header=FALSE)
names(ytrain)<-c("activity_id")
strain<-read.table("./Data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
names(strain)<-c("subject")
xtest<-read.table("./Data/UCI HAR Dataset/test/X_test.txt",header=FALSE)
ytest<-read.table("./Data/UCI HAR Dataset/test/y_test.txt",header=FALSE)
names(ytest)<-c("activity_id")
stest<-read.table("./Data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
names(stest)<-c("subject")
xtrain1<-cbind(ytrain,xtrain)
factor_train<-factor(rep("train",length(strain$subject)))

#combine train data, activity, and subject
xtrain2<-cbind(factor_train,xtrain1)
xtrain3<-cbind(strain,xtrain2)
#sqldf("select * from xtrain3 limit 10")
xtest1<-cbind(ytest,xtest)
factor_test<-factor(rep("test",length(stest$subject)))

#combine test data, activity, and subject
xtest2<-cbind(factor_test,xtest1)
xtest3<-cbind(stest,xtest2)
names(xtest3)[2]<-c("test_group")
names(xtrain3)[2]<-c("test_group")

#combine test data and train data
fullds3<-rbind(xtrain3,xtest3)

colnames(fullds3)[4:564]<-as.character(features[,2])

#extract only mean and std for measurements
selectv<-grep("mean|std",colnames(fullds3))

tidydataset<-fullds3[,selectv]

tidydataset1<-cbind(fullds3[,1:3],tidydataset)

#tidydataset2<-sqldf("select a.activity_label, b.* from activity a join tidydataset1 b on a.activity_id=b.activity_id")

#
tidydataset2<-merge(activity,tidydataset1,by.x="activity_id",by.y="activity_id",all=FALSE)



#remove test/train group labels and then calculate the average of each variable for each activity and subject

tidydataset3<-tidydataset2[,c(1:3,5:83)]

tidydataset4<-aggregate(tidydataset3,list(tidydataset3$activity_id, tidydataset3$activity_label,tidydataset3$subject),mean)


# save the required tidy data set to the data file

tidydata<-tidydataset4[,c(2,4,6:85)]

names(tidydata)[1]<-c("activity_label")

write.table(tidydata,"./data/tidydataset.txt")