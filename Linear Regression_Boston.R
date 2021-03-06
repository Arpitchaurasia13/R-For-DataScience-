library(MASS)
data("Boston")
View(Boston)

?Boston
set.seed(2)
library(caTools)

split <- sample.split(Boston$medv, SplitRatio  = 0.7)
split

training_data  <- subset(Boston,split == TRUE)
testing_data <- subset(Boston, split == FALSE)

plot(Boston$crim, Boston$medv, cex = 0.5, xlab = "Crime Rate", ylab = "Price" )

cr <- cor(Boston)

attach(Boston)
library(lattice)

splom(~Boston[c(1:6,14)], groups = NULL, data = Boston , axis.line.tck = 0, axis.text.alpha = 0)
splom(~Boston[c(7:14)], groups = NULL, data = Boston , axis.line.tck = 0, axis.text.alpha = 0)

plot(rm, medv)
abline(lm(medv~rm),col = "red")

library(corrplot)
corrplot(cr, type = "lower")
corrplot(cr, method = "number" )


library(caret)
Boston_a <- subset(Boston, select= -c(medv))
numericData <- Boston_a[sapply(Boston_a, is.numeric)]
descrCor <- cor(numericData)

library(car)
model <- lm(medv~., data = training_data)
vif(model)

model <- lm(medv~., data = training_data)

model <- lm(medv~., crim + zn + indus + chas + nox + rm + age + 
              dis + rad + tax + ptratio + black + lstat , data = training_data)

summary(model)

#model creation after removing tax

model <- lm(medv~., crim + zn + indus + chas + nox + rm + age + 
              dis + rad + ptratio + black + lstat , data = training_data)

summary(model)

predic <- predict(model, testing_data)
predic

plot(testing_data$medv, type = "l", lty = 1.8, col = "green")
lines(predic , type = "l", col = "blue")

predic <- predict(model, sample_data)
predic
