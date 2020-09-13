library(rpart)
install.packages('rpart')
install.packages('mlbench')
install.packages('caTools')


library(rpart)
library(mlbench)
library(caTools)
data('Ionosphere')

summary(Ionosphere)
str(Ionosphere)
data <- Ionosphere
samples <- sample.split(data$Class,SplitRatio = 0.75)
train_set <- subset(data,samples==TRUE)
test_set <- subset(data,samples==FALSE)
modeling <- rpart(Class~.,data = train_set,method = 'class')
plot(modeling)
text(modeling)

model_predict <- predict(modeling,test_set[,-35],type = 'class')
score <- mean(model_predict==test_set$Class)
score
table(predicted=model_predict,actuals=test_set$Class)
cp <- which.min(modeling$cptable[,'xerror'])
cpt <- modeling$cptable[cp,'CP']

pruned_modeling <- prune(modeling,cpt)
plot(pruned_modeling)
text(pruned_modeling)
pruned_predict <- predict(pruned_modeling,test_set[,-35],type = 'class')
pruned_score <- mean(pruned_predict==test_set$Class) 
pruned_score
