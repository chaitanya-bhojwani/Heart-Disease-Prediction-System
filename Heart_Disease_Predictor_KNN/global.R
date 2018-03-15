rm(list = ls())
library(ggplot2)
library(dplyr)
library(class)
library(caret)
library(shiny)
library(Metrics)


# read in data and preprocess ####
ds <- read.csv("processed.cleveland.data",  header = F)
# add names to dataset
names(ds) <- c( "age", "sex", "cp",
                "trestbps", "chol",
                "fbs", "restecg",
                "thalach","exang",
                "oldpeak","slope",
                "ca","thal","num")
feature.list <- list("age" = "age", "sex" ="sex",
                     "cp"= "cp","trestbps" = "trestbps",
                     "chol"="chol","fbs"="fbs",
                     "restecg"="restecg","thalach"="thalach",
                     "exang"="exang","oldpeak"="oldpeak",
                     "slope"="slope","ca"="ca","thal"="thal")
# change the class of all columns to numeric
ds <- as.data.frame(apply(ds, 2, as.numeric))
# remove na/missing values (original data shows as ?)
ds <- na.omit(ds)
# all values of num > 0 are cases of heart disease 
# as per the data descriptions at the uci repository
ds$num[ds$num > 0] <- 1

# standardize/normalize the data
standardized.X <- scale(ds[,-14])
set.seed(55)

training.index <- createDataPartition(ds$num, p = .5,list = F)
train.X <- standardized.X[training.index,]
test.X  <- standardized.X[-training.index,]
train.Y <- ds$num[training.index]
test.Y <- ds$num[-training.index]
theme1 <- trellis.par.get()
theme1$plot.symbol$col = rgb(.2, .2, .2, .4)
theme1$plot.symbol$pch = 16
theme1$plot.line$col = rgb(1, 0, 0, .7)
theme1$plot.line$lwd <- 5
trellis.par.set(theme1)
table.settings <- list(searching = F, pageLength = 5, bLengthChange = F,
                       bPaginate = F, bInfo = F )