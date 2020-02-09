rm(list=ls())

library(dplyr)
library(ggplot2)

mpg = mpg %>% as.data.frame

# Q1-1
nrow(mpg)
ncol(mpg)

# Q1-2
head(mpg, 10)

# Q1-3
tail(mpg, 10)

# Q1-4
View(mpg)

# Q1-5
summary(mpg)

# Q1-6
str(mpg)

# Q2-1
mpg_rename = mpg %>% rename(city = cty, highway = hwy)

# Q2-2
head(mpg_rename)

# Q3-1
midwest = midwest %>% as.data.frame
str(midwest)
View(midwest)

# Q3-2
midwest_rename = midwest %>% rename(total = poptotal, asian = popasian)

# Q3-3
midwest = midwest %>% mutate(asian_ratio = popasian / poptotal * 100)
midwest$asian_ratio

# Q3-4
midwest = midwest %>% mutate(LS = ifelse(asian_ratio > mean(asian_ratio), "large", "small"))
midwest$LS

# Q4-1
mpg = mpg %>% as.data.frame
mpg %>% mutate(HL = ifelse(displ >= 5, "H", "L")) %>% 
  group_by(HL) %>% summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))

# Q4-2
mpg %>% filter(manufacturer %in% c("audi", "toyota")) %>% 
  group_by(manufacturer) %>% summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# Q4-3
mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
  summarise(mean_hwy = mean(hwy))

# Q5-1
mpg_small = mpg %>% select(class, cty)
head(mpg_small)

# Q5-2
mpg_small %>% filter(class %in% c("suv", "compact")) %>% 
  group_by(class) %>% summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

# Q6-1
mpg_audi = mpg %>% filter(manufacturer == "audi") %>% 
  arrange(desc(hwy))
head(mpg_audi, 5)

# mpg_audi_2 = mpg %>% filter(manufacturer == "audi") %>% 
#   group_by(model) %>% summarise(mean_hwy = mean(hwy)) %>% 
#   arrange(desc(mean_hwy))
# head(mpg_audi_2, 5)
