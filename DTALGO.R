#Read data into R

library(readr)
data <- read_csv("diabetes.csv")

#Used Libraries to graph output and use (train, partioning, predict)

library(psych)
library(rpart)
library(rpart.plot)
library(caret)

#Edit outcome to have label from 0 --> False and 1 ---> True
data$Outcome <- factor(data$Outcome, levels = c(0,1), labels = c("False", "True"))

#commands to show data base in diffrient ways in console mode
#str(data)
head(data)
#describe(data)

#Cleaning data:

# 1 - Convert '0' values into NA
data[, 2:7][data[, 2:7] == 0] <- NA
missmap(data) #visualize the missing data(9-values were 0 and converted into NA)

# 2 - Use mice package to predict missing values to avoid decreasing data size
mice_mod <- mice(data[, c("Glucose","BloodPressure","SkinThickness","Insulin","BMI")], method='rf')
mice_complete <- complete(mice_mod)

# 3 - Transfer the predicted missing values into the main data set after editing it
data$Glucose <- mice_complete$Glucose
data$BloodPressure <- mice_complete$BloodPressure
data$SkinThickness <- mice_complete$SkinThickness
data$Insulin<- mice_complete$Insulin
data$BMI <- mice_complete$BMI

missmap(data)

#Data Visualization :

#Visual age effect "console commands"
ggplot(data, aes(Age, colour = Outcome)) + geom_freqpoly(binwidth = 1) + labs(title="Age Distribution by Outcome")
#visual all data effect
ggpairs(data)

#Modeling data :
#split data into training and test data sets
indxTrain <- createDataPartition(y = data$Outcome,p = 0.75,list = FALSE)
training <- data[indxTrain,] #used to train data and apply navieBayes(mathematical theory depends on conditional prop.)
testing <- data[-indxTrain,] #used in predection 
tree<- rpart(Outcome~., data = training, method = 'class')
rpart.plot(tree, cex = 0.5)


#Model Evaluation :
#Predict testing set
Predict <- predict(model,newdata = testing )

#Get the confusion matrix to prediction result
confusionMatrix(Predict, testing$Outcome )

