library(ggplot2)
library(readr)
install.packages("corrgram")
install.packages("car")
install.packages("FNN")
install.packages("pROC")
install.packages("corrplot")
install.packages("knitr")
install.packages("lattice")
install.packages("MASS")
install.packages("naniar")
install.packages("ggplot2")
install.packages("rmdformats")
install.packages("mvnormtest")
install.packages("MVA")
library(ggplot2)
library(caret)
library(naniar)
library(MASS)
library(lattice)
library(e1071)
library(corrgram)
library(car)
library(pROC)
library(corrplot)
library(knitr)
library(caTools)
library(mvnormtest)
library(MVA)

dataurl <- ('http://archive.ics.uci.edu/ml/machine-learning-databases/parkinsons/telemonitoring/parkinsons_updrs.data')
download.file(url = dataurl, destfile = "parkinsons_updrs.data")
parkinsons_df <- read.csv("parkinsons_updrs.data",header = TRUE,sep = ',')

str(parkinsons_df)
colnames(parkinsons_df)
summary(parkinsons_df)
parkinsons_df <- parkinsons_df[!duplicated(parkinsons_df),]
dim(parkinsons_df)

vis_miss(parkinsons_df)
sum(is.na(parkinsons_df))


cm <- colMeans(parkinsons_df)
Cov <- cov(parkinsons_df)
d <- apply(parkinsons_df,1,function(parkinsons_df) t(parkinsons_df-cm)%*% solve(Cov) %*% (parkinsons_df-cm))

plot(qchisq((1:nrow(parkinsons_df)-1/2)/nrow(parkinsons_df),df=ncol(parkinsons_df)),
     sort(d),
     xlab = expression(paste(chi[22]^2, "Quantile")), ylab = "Ordered distances")
abline(a = 0, b = 1)

missing <- apply(parkinsons_df, 2, function(parkinsons_df) 
  round(100 * (length(which(is.na(parkinsons_df))))/length(parkinsons_df) , digits = 1))
as.data.frame(missing)

corrplot(cor(parkinsons_df), type="full", method ="color", title = "Parkinsons correlatoin plot", mar=c(0,0,1,0), tl.cex= 0.8, outline= T, tl.col="indianred4")

summary(parkinsons_df[,-3])
plot(jitter(total_UPDRS)~.,parkinsons_df)
bvbox(parkinsons_df[,6:7],xlab = "total_UPDRS", ylab = "Jitter")
bvbox(parkinsons_df[,c(6,12)],xlab = "total_UPDRS", ylab = "Shimmer")
bvbox(parkinsons_df[,c(6,18)],xlab = "total_UPDRS", ylab = "NHR")
bvbox(parkinsons_df[,c(6,20)],xlab = "total_UPDRS", ylab = "RPDE")
bvbox(parkinsons_df[,c(6,21)],xlab = "total_UPDRS", ylab = "DFA")
bvbox(parkinsons_df[,c(6,22)],xlab = "total_UPDRS", ylab = "PPE")

hull1 <- chull(parkinsons_df[,6:7])
parkhull <- match(lab <- rownames(parkinsons_df[hull1,]),rownames(parkinsons_df))
plot(parkinsons_df[,6:7],xlab = "total_UPDRS",ylab = "Jitter")
polygon(parkinsons_df$Jitter...[hull1]~parkinsons_df$total_UPDRS[hull1])
text(parkinsons_df[parkhull,6:7],labels = lab, pch=".", cex = 0.9)

outlier <- parkinsons_df[-hull1,]
dim(outlier)
dim(parkinsons_df)

hull2 <- chull(outlier[,c(6,12)])
parkinsons_df <- outlier[-hull2,]

hull3 <- chull(parkinsons_df[,c(6,18)])
outlier <- parkinsons_df[-hull3,]

hull4 <- chull(outlier[,c(6,20)])
parkinsons_df <- outlier[-hull4,]

hull5 <- chull(parkinsons_df[,c(6,21)])
outlier <- parkinsons_df[-hull5,]

hull6 <- chull(outlier[,c(6,22)])
parkinsons_df <- outlier[-hull6,]

dim(parkinsons_df)

parkinsoncorr <- cor(parkinsons_df)
colnames(parkinsoncorr) <- row.names(parkinsoncorr) <- parkinsonlabs <- c(colnames(parkinsons_df))
rnge <- sapply(parkinsons_df, function(parkinsons_df) diff(range(parkinsons_df)))
S_parkinsons <- sweep(parkinsons_df, 2, rnge, FUN = "/")
parkinsondist <- dist(S_parkinsons)
parkinsondist_mds <- cmdscale(parkinsondist, k = 21, eig = TRUE)
parkinsondistpoints <- parkinsondist_mds$points
lam <- parkinsondist_mds$eig
criterion1 <- cumsum(abs(lam)) / sum(abs(lam))
criterion2 <- cumsum(lam^2) / sum(lam^2)


x <- parkinsondist_mds$points[,1]
y <- parkinsondist_mds$points[,2]
plot(x, y, xlab="Coordinate 1", ylab="Coordinate 2", main="Parkinsons MDS",pch=20,cex=0.1)
text(x, y, labels = parkinsons_df[,3], cex=0.8)


parkinsoncorr <- cor(parkinsons_df)
colnames(parkinsoncorr) <- row.names(parkinsoncorr) <- parkinsonlabs <- c(colnames(parkinsons_df))
rnge <- sapply(parkinsons_df, function(parkinsons_df) diff(range(parkinsons_df)))
S_parkinsons <- sweep(parkinsons_df, 2, rnge, FUN = "/")
parkinsondist <- dist(parkinsoncorr)
parkinsondist_mds <- cmdscale(parkinsondist, k = 21, eig = TRUE)
parkinsondistpoints <- parkinsondist_mds$points
lam <- parkinsondist_mds$eig
criterion1 <- cumsum(abs(lam)) / sum(abs(lam))
criterion2 <- cumsum(lam^2) / sum(lam^2)
#criterion 1 and criterion 2 suggests that the first two coordinates can represents majority of the data points since the cummulative proportion is above the threshold value of 0.8 
#hence the MDS plot can be on a 2D scatterplot
x <- parkinsondist_mds$points[,1]
y <- parkinsondist_mds$points[,2]
plot(x, y, xlab="Coordinate 1", ylab="Coordinate 2", main="Parkinsons MDS",pch=20,cex=0.1)
text(x, y, labels = colnames(parkinsoncorr), cex=0.8)

install.packages("party")
install.packages("randomForest")
library(randomForest)
#scaling the data
rnge <- sapply(parkinsons_df, function(parkinsons_df) diff(range(parkinsons_df)))

S_parkinsons <- sweep(parkinsons_df, 2, rnge, FUN = "/")
# Create the forest.
output.forest <- randomForest(S_parkinsons$total_UPDRS~age+sex+test_time+Jitter...+Jitter.Abs.+Jitter.RAP+Jitter.PPQ5+Jitter.DDP+Shimmer+Shimmer.dB.+Shimmer.APQ3+Shimmer.APQ5+Shimmer.APQ11+Shimmer.DDA+NHR+HNR+RPDE+DFA+PPE, data = S_parkinsons,mtry = 6)
# View the forest results.
print(output.forest) 
# Importance of each predictor.
impfactors <- importance(output.forest,type = 2)
impfactors <- data.frame(impfactors)
impfactorsranked <- impfactors[order(-impfactors$IncNodePurity),,drop=FALSE]
print(impfactorsranked)


#Exploratory factor analysis
library(MVA)
options(digits = 3)
# EFA
#head(parkinsons) #2:4,8,16,18:22
parkinson.EFA <- factanal(parkinsons_df[, c(2:5,8,16,18:22)], 3, n.obs = nrow(parkinsons_df), rotation="varimax", control=list(trace=T))
parkinson.EFA
print(parkinson.EFA$loadings, cut = 0.40)


parkinson.EFA <- factanal(parkinsons_df[, c(2:8,17,18:22)], 2, n.obs = nrow(parkinsons_df), rotation="varimax", control=list(trace=T))
parkinson.EFA
print(parkinson.EFA$loadings, cut = 0.5)

#install.packages("sem")
#install.packages("semPlot")
#library(sem)
#library(semPlot)
#parkinsonscovar<- cor(parkinsons_df[,-c(1)])
#parkinson_model <- specifyModel(file = "C:\\ttu\\spring18\\MVA\\project\\ParkinsonsDiseaseDataAnalysis-master\\parkinson_sem_model_efa2.txt")

#opt <- options(fit.indices = c("GFI", "AGFI", "SRMR"))
#parkinson_sem <- sem(parkinson_model, parkinsonscovar, nrow(parkinsons_df))
#summary(parkinson_sem)
# restricted Cor matrix
#rescor <- parkinson_sem$C
# non-restricted Cor matrix
#nonrescor <- parkinson_sem$S
#differences of the elements of the observed covariance matrix and the covariance matrix of the fitted model
#covresiduals <- round(parkinson_sem$S - parkinson_sem$C, 3)
#semPaths(parkinson_sem, "est",edge.label.cex=1.5)


#library(sem)
#library(semPlot)
#parkinsonscovar<- cor(parkinsons_df[,-c(1)])
#parkinson_model <- specifyModel(file = "C:\\ttu\\spring18\\MVA\\project\\ParkinsonsDiseaseDataAnalysis-master\\parkinson_sem_model_efa1.txt")

#opt <- options(fit.indices = c("GFI", "AGFI", "SRMR"))
#parkinson_sem <- sem(parkinson_model, parkinsonscov, nrow(parkinsons_df))
#summary(parkinson_sem)
# restricted Cor matrix
#rescor <- parkinson_sem$C
# non-restricted Cor matrix
#nonrescor <- parkinson_sem$S
#differences of the elements of the observed covariance matrix and the covariance matrix of the fitted model
#covresiduals <- round(parkinson_sem$S - parkinson_sem$C, 3)
#semPaths(parkinson_sem, "est",edge.label.cex=1.5)


#Principal Componenets Analysis
library(stats)
#outliers have alreaady been removed so PCA does not requiere any changes in the data
#standard deviations of data set
p_sd <- sd(is.numeric(parkinsons_df))
# creating covariance matrix for entire dataset
p_cov <- cov(parkinsons_df, use = "everything")
#creating correlation matrix for the entire dataset
p_corr <-cor(parkinsons_df, use = "everything")
#Principal Components Analysis for correlation matrix
# we have chosen to utilize the correlation matrix for the PCA since the variables have different scales and variances
parkinsons_pca_corr <- princomp(parkinsons_df, cor = T, scores = TRUE)
summary(parkinsons_pca_corr, loadings = T)

