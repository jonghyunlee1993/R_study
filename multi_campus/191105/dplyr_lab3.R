rm(list=ls())

library(dplyr)
library(ggplot2)

data = as.data.frame(mpg)

# Q7-1
data_copy = data %>% mutate(tot = cty + hwy)

# Q7-2
data_copy = data_copy %>% mutate(avg = tot / 2)

# Q7-3
head(data_copy,3)

# Q7-4
data %>% mutate(tot = cty + hwy, avg = tot / 2) %>% head(3)

# Q8-1
data_group = data %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty))
data_group

# Q8-2
data_group = data_group %>% arrange(desc(mean_cty))
data_group

# Q8-3
data_group_high = data %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))
head(data_group_high, 3)

# Q8-4
data_compact = data %>% filter(class == "compact") %>% 
  group_by(manufacturer) %>% count %>% arrange(desc(n))
data_compact

# Q9-1
fuel = data.frame(fl = c("c", "d", "e", "p", "r"),
                  price = c(2.35, 2.38, 2.11, 2.76, 2.22),
                  stringsAsFactors = F)
fuel

data_price = data
data_price$price_fl = rep(0, nrow(data_price))

for (i in 1:nrow(data_price)){
  if (data_price$fl[i] == 'c'){
    data_price$price_fl[i] = fuel$price[fuel$fl == 'c']
  }else if (data_price$fl[i] == 'd'){
    data_price$price_fl[i] = fuel$price[fuel$fl == 'd']
  }else if (data_price$fl[i] == 'e'){
    data_price$price_fl[i] = fuel$price[fuel$fl == 'e']
  }else if (data_price$fl[i] == 'p'){
    data_price$price_fl[i] = fuel$price[fuel$fl == 'p']
  }else if (data_price$fl[i] == 'r'){
    data_price$price_fl[i] = fuel$price[fuel$fl == 'r']
  }
}

# data_price = data %>% left_join(fuel, by='fl')

# Q10-1
midwest = midwest

midwest_child = midwest %>% 
  mutate(child_ratio = 100-(popadults/poptotal)*100)

# Q10-2
midwest_child = midwest_child %>% arrange(desc(child_ratio)) %>% 
  select(county, child_ratio)
head(midwest_child,5)

# Q10-3
midwest_child %>% mutate(child_grade = ifelse(child_ratio >= 40, "large", 
                                              ifelse(child_ratio >= 30, "middle", "small"))) %>% 
  group_by(child_grade) %>% count

# Q10-4
midwest %>% mutate(asian_ratio = popasian/poptotal*100) %>% 
  arrange(asian_ratio) %>% select(county, asian_ratio) %>% 
  head(10)

# Q11-1
mpg = as.data.frame(mpg)
mpg[c(65,124,131,153,212),"hwy"] = NA

sum(is.na(mpg$drv))
sum(is.na(mpg$hwy))

mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy))

# Q12-1
rm(mpg)
mpg = as.data.frame(mpg)
mpg[c(10, 14, 58, 93), "drv"] = "k"
mpg[c(29, 43, 129, 203), "cty"] = c(3,4,39,42)

sum(!mpg$drv %in% c('4', 'f', 'r'))
mpg$drv[!mpg$drv %in% c('4', 'f', 'r')] = NA

stats = boxplot(mpg$cty)$stats
mpg$cty = ifelse(mpg$cty < stats[1,1] | mpg$cty > stats[5,1], NA, mpg$hwy)
boxplot(mpg$cty)

mpg %>% filter(!is.na(drv)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty, na.rm = T)) %>% 
  arrange(desc(mean_cty))
