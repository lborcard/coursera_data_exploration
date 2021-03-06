set.seed(12345)
par(mar=rep(0.2,4))
dataMatrix<-matrix(rnorm(400), nrow= 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

#we add a pattern to the data
set.seed(678910)
for (i in 1:40) {
  #flip a coin 
  coinFlip<- rbinom(1, size =1, prob=0.5)
  #if coin is head add a common pattern to that row
  if (coinFlip) {
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0,3), each =5)
  }
}
par(mar=rep(0.2,4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

hh<- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, xlab="Row mean",ylab= "Row",pch=19)
plot(colMeans(dataMatrixOrdered), xlab="Column",ylab="Column Mean", pch =19)

##Singular value decomposition
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow =c(1,2))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1,,xlab="Row",ylab="frist left signular vector", pch=19)
plot(svd1$v[,1],xlab="Column",ylab="First right singular vector",pch=19)
par(mfrow =c(1,2))
plot(svd1$d,xlab="Column", ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column", ylab="prop. of variance explained",pch=19)
