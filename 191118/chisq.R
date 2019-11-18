rm(list = ls())

data = read.csv('survey.csv')
head(data)

names(data) = c('position', 'ans6', 'ans7')
View(data)

table1 = table(data$position, data$ans6)
table1
# df_table1 = as.data.frame(table1)
chisq.test(table1)
chisq.test(table1, simulate.p.value = T)


table2 = table(data$position, data$ans7)
table2[,2:3]

chisq.test(table2[,2:3], simulate.p.value = T)
# chisq.test(table2, simulate.p.value = T)
