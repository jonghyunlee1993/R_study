data = mtcars
summary(data)

result = t.test(data$mpg, data$hp)

mpg = (data$mpg - mean(data$mpg)) / sd(data$mpg)
hp = (data$hp - mean(data$hp)) / sd(data$hp)

result2 = t.test(mpg, hp)
result2

library(dplyr)

data %>% group_by(am) %>%
  summarize(mean_mpg = mean(mpg))

t_test_raw = data %>% group_by(am)

t.test(t_test_raw[t_test_raw$am == 0,]$mpg, 
       t_test_raw[t_test_raw$am == 1,]$mpg,)

t.test(mpg ~ am, data)

t.test(data %>% group_by(am) %>% select(mpg))
