library(rpart)				        # Popular decision tree algorithm
library(rpart.plot)				# Enhanced tree plots
library(RColorBrewer)				# Color selection for fancy tree plot
library(party)					# Alternative decision tree algorithm
library(partykit)				# Convert rpart object to BinaryTree
library(caret)
library(e1071)
# library(rattle)         # Fancy tree plot
library(ElemStatLearn) 
data(SAheart)
head(SAheart) 
names(SAheart) 
set.seed(12345)
table(SAheart$chd)
SAheart$chd = as.factor(SAheart$chd) 
SAheart$famhist = as.factor(SAheart$famhist) 
splitTrain <- createDataPartition(y= SAheart$chd, p = 0.7,list = FALSE) 
train <- SAheart[splitTrain, ] 
Xvalid <- SAheart[-splitTrain, ] 
dim(train);dim(Xvalid)
fulltree = rpart(chd ~ ., data = train , method= "class")
#fancyRpartPlot(fulltree)
prp(fulltree)
#plot(fulltree)
#print(fulltree)
prediction = predict(fulltree,newdata=Xvalid,type = "class")
y = Xvalid$chd
confusionMatrix(prediction, y,positive = "1")

