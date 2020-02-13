install.packages("FSelector")
install.packages("rpart")
install.packages("caret", dependencies = TRUE)
install.packages("dplyr")
install.packages("rpart.port")
install.packages("xlsx")
install.packages("data.tree")
install.packages("caTools")
install.packages('ElemStatLearn',repos='http://cran.us.r-project.org')

Sys.setenv(JAVA_HOME = "C:\\Work\\Java\\jdk1.8.0_241\\jre")
Sys.getenv('JAVA_HOME')

library(FSelector)
library(rpart)
library(caret)
library(rpart.plot)
library(dplyr)
library(xlsx)
library(data.tree)
library(caTools)
library(ElemstatLearn)

data <- read.csv("C:/Users/Chaurash/Desktop/New_folder/R/train.csv")

data <- select(data, Survived, Pclass, Sex , Age)

data <- mutate(data, Survived = factor(Survived) , Pclass = as.numeric(Pclass), Age = as.numeric(Age))

set.seed(123)
sample = sample.split(data$Survived, SplitRatio = .70)

train = subset(data, sample == TRUE)
test = subset(data, sample == FALSE)

tree <- rpart(Survived ~.,data = train)


tree.Survived.predicted <- predict(tree, test, type = 'class')

confusionMatrix(tree.Survived.predicted, as.factor(data$Survived))
summary(tree.Survived.predicted)
summary(tree)
plot(tree)
