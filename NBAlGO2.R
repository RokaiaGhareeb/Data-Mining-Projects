#Read data into R
data(iris)

#Used Libraries to graph output

library(tidyverse)
library(ggplot2)
library(caret)
library(caretEnsemble)
library(psych)
library(Amelia)
library(mice)
library(GGally)
library(rpart)
library(randomForest)



#commands to show data base in diffrient ways in console mode
#str(iris)
head(iris)
#describe(data)


#Data Visualization :

#Visual age effect "console commands"
ggplot(iris, aes(iris$Sepal.Length, colour = Species)) + geom_freqpoly(binwidth = 1) + labs(title="Sepal length distribution by species")
#visual all data effect
ggpairs(iris)

#Modeling data :

#split data into training and test data sets
indxTrain <- createDataPartition(y = iris$Species,p = 0.75,list = FALSE)
training <- iris[indxTrain,] #used to train data and apply navieBayes(mathematical theory depends on conditional prop.)
testing <- iris[-indxTrain,] #used in predection 


#create objects x which holds the predictor(evedince) variables and y which holds the response(outcome) variables
x = training[,-9]
y = training$Species

#navie bayes package
library(e1071) 
model = naiveBayes(Species ~., data = iris)
model

#Model Evaluation :

#Predict testing set
Predict <- predict(model,newdata = testing )

#Get the confusion matrix to prediction result
confusionMatrix(Predict, testing$Species )
