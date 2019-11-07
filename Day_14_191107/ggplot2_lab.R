rm(list = ls())

library(ggplot2)
library(xlsx)
library(dplyr)

# Q1
mpg = as.data.frame(mpg)
ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point(color='blue')

ggsave("result1.png")

# Q2
rm(mpg)
# mpg_count = mpg
# mpg_count$drv = as.factor(mpg$drv)

# 굳이 factor로 바꾸지 않아도 괜찮음
ggplot(data=mpg_count, aes(x=class)) + 
  geom_bar(aes(fill = drv))

ggsave("result2.png")

# Q3
midwest = as.data.frame(midwest)
options(scipen = 99) 
ggplot(data=midwest, aes(x=poptotal, y=popasian)) +
  geom_point() + 
  scale_x_continuous() +
  scale_y_continuous() +
  coord_cartesian(xlim = c(0, 500000), ylim = c(0, 10000)) 

ggsave("result3.png")

# Q4
rm(mpg)
mpg = as.data.frame(mpg)

mpg_class = mpg %>% filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data=mpg_class, aes(x=class, y=cty)) +
  geom_boxplot()

ggsave("result4.png")

# Q5
data = read.table("product_click.log")
data$V2 = as.factor(data$V2)

ggplot(data=data, aes(x = V2)) +
  geom_bar(aes(fill=V2))

ggsave("result5.png")

# Q6
time2 = strptime(data$V1, "%Y%m%d%H%M")
DOW = format(time2, "%A")
data$요일 = as.factor(DOW)

ggplot(data=data, aes(x=요일)) +
  geom_bar(aes(fill=요일)) +
  ylab("클릭수") + 
  theme(legend.position="none") +
  theme_light()

ggsave("result6.png")
