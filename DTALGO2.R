#reading data
data(iris)

#show data
table(iris$Species)
head(iris)
describe(iris)


library(psych)
library(rpart)
library(rpart.plot)
library(caret)

#data Visulization :


#Visual age effect "console commands"
ggplot(iris, aes(iris$Sepal.Length, colour = Species)) + geom_freqpoly(binwidth = 1) + labs(title="Sepal length distribution by species")
#visual all data effect
ggpairs(iris)


#data Modeling :

#split data into training and test data sets
indxTrain <- createDataPartition(y = iris$Species,p = 0.75,list = FALSE)
training <- iris[indxTrain,] #used to train data and apply navieBayes(mathematical theory depends on conditional prop.)
testing <- iris[-indxTrain,] #used in predection 
tree<- rpart(Species~., data = training, method = 'class')
rpart.plot(tree)

#data Evalution:

Prediction <- predict(tree,newdata = testing )
