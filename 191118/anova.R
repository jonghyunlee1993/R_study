rm(list = ls())

data = iris

# 각 종류별 차이가 있는지
res = aov(Sepal.Width ~ Species, data)
summary(res)

summary(aov(Sepal.Length ~ Species, data))
summary(aov(Petal.Width ~ Species, data))
summary(aov(Petal.Length ~ Species, data))

boxplot(iris$Sepal.Length ~ iris$Species)

#

rm(list = ls())
data = read.csv('score.csv')
head(data)

library(ggplot2)

ggplot(data, aes(x=class.fac, y=score_stats, fill=gender.fac)) +
  geom_bar(stat = "identity")

res1 = aov(score_stats ~ gender.fac + class.fac, data)
summary(res1)

res2 = aov(score_stats ~ gender.fac * class.fac, data)
summary(res2)

ggplot(data, aes(x = gender.fac, y = score_stats)) +
  geom_bar(stat = "identity")

ggplot(data, aes(x = class.fac, y = score_stats)) + 
  geom_bar(stat = "identity")
