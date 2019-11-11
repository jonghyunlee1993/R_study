rm(list = ls())

setwd('C:/Rstudy/Antique')
comp_data = read.csv('competing_risk_analysis_data.csv', header = T)

# install.packages("survival")
library(survival)
library(data.table)

comp_data <- setDT(comp_data)

comp_data$y1 = comp_data$cause
comp_data$y2 = comp_data$cause
comp_data[cause==2, y1:=0]
comp_data[cause==1, y2:=0]
comp_data[y2==2 , y2:=1]
