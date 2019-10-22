install.packages("ggplot2")
library(ggplot2)
# require(ggplot2)

data("diamonds")
head(diamonds)
str(diamonds)

install.packages("tabplot")
library(tabplot)

fftempdir = "C:/Users/student/Desktop"

tableplot(diamonds)
tableplot(diamonds, select=c(carat, cut, color, clarity, price), sortCol=price) 