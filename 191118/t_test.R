rm(list=ls())

library(readxl)
setwd('C:/Rstudy/191118')

data = read_excel("dustdata.xlsx")
View(data)

library(dplyr)
dust = data %>% filter(area %in% c("성북구", "중구"))
dust

중구 = dust %>% filter(area == "중구")
성북구 = dust %>% filter(area == "성북구")

t.test(finedust ~ area, dust)
t.test(중구$finedust, 성북구$finedust)

boxplot(중구$finedust, 성북구$finedust)


