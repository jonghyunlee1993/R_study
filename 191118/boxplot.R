rm(list=ls())

score = c(800, 750, 630, 970, 500)
gender = c(0, 1, 1, 0, 0)

data = data.frame(score, gender)
data

boxplot(data$score, by=data$gender)
boxplot(data$score[data$gender == 0], data$score[data$gender == 1])

boxplot(score ~ gender, data)
t.test(score ~ gender, data)
