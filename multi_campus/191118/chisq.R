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

library(ggplot2)
df = as.data.frame(table1)
df

names(df) = c('position', 'ans6', 'freq')

# 실제 카운트 결과를 보여줌
ggplot(df, aes(x = position, y = freq, fill = ans6)) +
  geom_bar(stat = 'identity')

# 전체 비율로 보여줌
ggplot(df, aes(x = position, y = freq, fill = ans6)) +
  geom_bar(stat = 'identity', position = 'fill')

# 탐색적 시각화 vs 설명적 시각화
# 탐색적 시각화는 데이터 이해하기 위해서 
# 설명적 시각화는 최종 보고서에서 결과 설명을 위해 / 개발 영역


