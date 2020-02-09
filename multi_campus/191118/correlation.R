rm(list = ls())

data = read.csv("http://goo.gl/HKnl74")
head(data)

dim(data)

cor.test(data$distance, data$num.child)
ggplot(data, aes(num.child, distance)) + 
  geom_bar(stat = "identity")

attach(data)
cor(overall, rides)
cor.test(overall, rides)
ggplot(data, aes(overall, rides)) + 
  geom_bar(stat = "identity")

# ggplot(data, aes(data[, 4:8], data[, 4:8])) +
#   geom_point()

plot(data[, 4:8], data[, 4:8])

# install.packages('corrplot')
library(corrplot)
corrplot(cor(data[, 4:8]))
corrplot(cor(data[, 4:8]), method = "square", type = "upper")
corrplot.mixed(cor(data[,4:8]))
