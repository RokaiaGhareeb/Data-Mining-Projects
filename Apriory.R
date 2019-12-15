library("arules") #library used to apply association rule 

library("arulesViz")#library used to use plot function

#used data is built in data , data type is transaction(must be)
data("Groceries")

#fuction used to show data content
str(Groceries)

#data Modeling :

#fuction check if data is transaction or not , show most frequent items
summary(Groceries) 

#apriori alogorithm built in function
rules = apriori(Groceries, parameter = list(supp =0.001 , conf = 0.80 , target="rules"))

#show lhs and rhs of transactions with their support confidence lift count {butter, jam} => {whole milk}
inspect(rules[1:10])

#data Visualization :

#plot top 10 frequent items
itemFrequencyPlot(items(rules),topN = 10, type = "relative", col = "Red")

#plot transactions graphically for most 7-frequent
plot(rules, method="graph", max = 7, control=list(layout=igraph::in_circle()))
