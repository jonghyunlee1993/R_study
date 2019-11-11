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

cause1 <- Surv(comp_data$dftime, comp_data$y1)
cox1 <- coxph(cause1 ~ age+hgb+blktxcat+clinstg, data=comp_data)

cause2 <- Surv(comp_data$dftime, comp_data$y2)

cox2 <- coxph(cause2 ~ age+hgb+blktxcat+clinstg, data=comp_data)

summary(cox2)


cause2 <- Surv(comp_data$dftime, comp_data$y2)

cox2 <- coxph(cause2 ~ age+hgb+blktxcat+clinstg, data=comp_data)

summary(cox2)


library(Cprob)
CPC <- cpf(Hist(dftime, cause)~blktxcat, data=comp_data, failcode=1)
CPC
plot(CPC, xlab="month", ylab="proportion dying")



