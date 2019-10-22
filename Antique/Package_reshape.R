rm(list=ls())

install.packages("reshape")
library(reshape)

data("airquality")
head(airquality)
str(airquality)

names(airquality) = tolower(names(airquality))
names(airquality)

aqm = melt(airquality, id=c("month", "day"), na.rm=T)
aqm

# 각 항목의 일, 월별 값을 보여줌
a = cast(aqm, day ~ month ~ variable)
a

# 월별 평균 합쳐서 보여줌
b = cast(aqm, month ~ variable, mean)
b

# 월별 평균을 각 항목 별로 나눠서 보여줌
c = cast(aqm, month ~ . | variable, mean)
c

# 전체 평균 결과도 보여줌
d = cast(aqm, month ~ variable, mean, margins=c("grand_row", "grand_col"))
d

# 특정 변수에 대해서만 결과
e = cast(aqm, day ~ month, mean, subset=variable=="ozone")
e

# 최댓값, 최솟값 보여주기
f = cast(aqm, month ~ variable, range)
f
