rm(list=ls())

install.packages("plyr")
library(plyr)

set.seed(1)
d = data.frame(year = rep(2000:2002, each=6), count = round(runif(9, 0, 20)))
d

ddply(d, "year", function(x){
  mean.count = mean(x$count)
  sd.count = sd(x$count)
  cv = sd.count / mean.count
  data.frame(cv.count = cv)
})

ddply(d, "year", summarise, mean.count = mean(count))

ddply(d, "year", function(x){
  mean.count = mean(x$count)
  sd.count = sd(x$count)
  cv = sd.count / mean.count
  data.frame(cv.count = cv,
             cv.mean = mean.count,
             cv.sd = sd.count)
})
