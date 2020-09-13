library(rpart)
library(mlbench)
library(caTools)
library()

dataurl <- ('http://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data')
download.file(url = dataurl, destfile = "ionosphere.data")
ionosphere_df <- read.csv("ionosphere.data",header = FALSE,sep = ',')
View(ionosphere_df)

str(ionosphere_df)
dim(ionosphere_df)
summary(ionosphere_df)
set.seed(200)
ionosphere_df <- ionosphere_df[sample(nrow(ionosphere_df)),]
traindata.df <- ionosphere_df[1:as.integer(0.75*351),]
testdata.df <- ionosphere_df[as.integer(0.75*351 + 1):351,]


euclideandist <- function(x,y){
  dt = 0
  for(i in c(1:(length(x)-1)))
    {
      dt = dt + (x[[i]]-y[[i]])^2
  }
  dt = sqrt(dt)
  return(dt)
}

knn_predict <- function(testdata,traindata,kval){
  pred <- c()
  for(i in c(1:nrow(testdata))){
    eucdist = c()
    eucchar = c()
    good = 0
    bad = 0
    
    for(j in c(1:nrow(traindata))){
      eucdist <- c(eucdist,euclideandist(testdata[i,],traindata[j,]))
      eucchar <- c(eucchar,as.character(traindata[j,][[35]]))
    }
    
    euc <- data.frame(eucchar,eucdist)
    euc <- euc[order(euc$eucdist),]
    euc <- euc[1:kval,]
    
    for(k in c(1:nrow(euc))){
      if(as.character(euc[k,"eucchar"]) == "g"){
        good = good + 1
      }
      else
        bad = bad + 1
    }
    if(good>bad){
      pred <- c(pred,"g")
    }
    else if(good<bad){
      pred <- c(pred,"b")
    }
  }
  return(pred)
}

accuracyval <- function(testdata){
  correct = 0
  for(i in c(1:nrow(testdata))){
    if(testdata[i,35] == testdata[i,36]){
      correct = correct + 1
    } 
  }
  accuval = correct/nrow(testdata)*100
  return(accuval)
}

K=5
predictions <- knn_predict(testdata.df,traindata.df,K)
testdata.df[,36] <- predictions
print(accuracyval(testdata.df))

View(testdata.df)
