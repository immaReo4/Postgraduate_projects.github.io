install.packages("caret")
install.packages("e1071")
library(caret)
library(e1071)

dataurl <- ('http://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data')
download.file(url = dataurl, destfile = "ionosphere.data")
ionosphere_df <- read.csv("ionosphere.data",header = FALSE,sep = ',')

str(ionosphere_df)
summary(ionosphere_df)

set.seed(3000)
initrain <- createDataPartition(y = ionosphere_df$V1, p=0.7, list = FALSE)
trainingdata <- ionosphere_df[initrain,]
testingdata <- ionosphere_df[-initrain,]

dim(trainingdata)
dim(testingdata)

anyNA(ionosphere_df)
trainingdata[["V1"]] = factor(trainingdata[["V1"]])
trnControl <- trainControl(method = "repeatedcv",number =5,repeats = 6)
set.seed(4000)
knn_df <- train(V1~.,data = trainingdata, method = "knn",
                trControl = trnControl,
                preProcess = c("center","scale"),
                tuneLength = 10)
#knn_df

testprediction <- predict(knn_df,newdata = testingdata)
testprediction

testingdata$V1
#confusionMatrix(testprediction,testingdata$V1)

