rm(list=ls())

# set up

# install.packages("xlsx")
library(xlsx)

setwd("~/Desktop/medical_bigdata_analysis_hanyang_hospital/Survival_analysis/")
data = read.xlsx("Reanalysis_190722_PSM.xlsx", 1)

# install.packages("dplyr")
library(dplyr)

names(data) = tolower(names(data))
raw_data = data %>% rename(sex = sex_m1f2)

# three groups 
# 0: HCC x OS x
# 1: HCC o OS x
# 2: OS o

data$cause = data$txgroups

for (i in 1:length(data$cause)){
  info = data$cause[i]
  os = data$os[i]
  
  if (info == 0 & os == 0){
    data$cause[i] = 0
  }else if (info == 1 & os == 0){
    data$cause[i] = 1
  }else if (os == 1){
    data$cause[i] = 2
  }
}

table(as.factor(data$cause))

# survial analysis
# find meaningful variable
# ignore OS variable
# use backword elimination methods

# install.packages("survival")
library(survival)

tx = Surv(data$hcc_gap, data$txgroups)
cox1 = coxph(tx ~ sex + age + ckd + dm + htn + cirrhosis + decom + initial_hbeag +
               plt_0 + alb_0 + bil_0 + inr_0 + afp_0 + ctp + albi + fib4 + meld, data = data)
summary(cox1)

cox2 = coxph(tx ~ sex + age + ckd + dm + htn + cirrhosis + decom + initial_hbeag +
               plt_0 + bil_0 + inr_0 + afp_0 + ctp + albi + fib4 + meld, data = data)
summary(cox2)

cox3 = coxph(tx ~ sex + age + dm + htn + cirrhosis + decom + initial_hbeag +
               plt_0 + bil_0 + inr_0 + afp_0 + ctp + albi + fib4 + meld, data = data)
summary(cox3)

cox4 = coxph(tx ~ sex + age + dm + cirrhosis + decom + initial_hbeag +
               plt_0 + bil_0 + inr_0 + ctp + albi + fib4 + meld, data = data)
summary(cox4)

cox5 = coxph(tx ~ sex + age + dm + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + ctp + albi + fib4 + meld, data = data)
summary(cox5)

cox6 = coxph(tx ~ sex + age + dm + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + albi + fib4, data = data)
summary(cox6)

cox7 = coxph(tx ~ sex + dm + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + albi + fib4, data = data)
summary(cox7)

cox8 = coxph(tx ~ sex + dm + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + fib4, data = data)
summary(cox8)

cox9 = coxph(tx ~ sex + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + fib4, data = data)
summary(cox9)

cox10 = coxph(tx ~ cirrhosis + decom + initial_hbeag +
                bil_0 + inr_0 + fib4, data = data)
summary(cox10)

cox11 = coxph(tx ~ decom + initial_hbeag +
                bil_0 + inr_0 + fib4, data = data)
summary(cox11)

cox12 = coxph(tx ~ decom + initial_hbeag +
                bil_0 + fib4, data = data)
summary(cox12)

cox13 = coxph(tx ~ decom + initial_hbeag +
                bil_0, data = data)
summary(cox13)

cox14 = coxph(tx ~ decom + bil_0, data = data)
summary(cox14)

cox15 = coxph(tx ~ decom, data = data)
summary(cox15)

CIC = cuminc(data$hcc_gap, data$cause, data$decom)
timepoints(CIC, times = c(seq(0,2000,250)))
CIC
plot(CIC, xlab = "Days", ylab = "Proportion of HCC")

# chi square statistic
CIC$Tests

cov_mat <- matrix(as.numeric(data$txgroups == 1))
colnames(cov_mat) <- "dis"

res_crr <- crr(ftime  = data$hcc_gap, # vector of failure/censoring times
               fstatus  = data$cause, # vector with a unique code for each failure type and censoring
               cov1     = cov_mat, #  matrix (nobs x ncovs) of fixed covariates
               ## cov2     = , # matrix of covariates that will be multiplied by functions of time
               ## tf       = , # functions of time
               ## cengroup = , # vector with different values for each group with a distinct censoring distribution
               failcode = 2, # code of fstatus that denotes the failure type of interest
               cencode  = 0 # code of fstatus that denotes censored observations
)
summary(res_crr)

library(Cprob)
CPC = cpf(Hist(hcc_gap, cause) ~ decom, data = data)
CPC
plot(CPC, xlab = "Days", ylab = "Proportion of HCC")


library(cmprsk)
CPC_reg = cpfpo(Hist(hcc_gap, cause) ~ decom, data = data,
                failcode = 1, tis = seq(0, max(data$hcc_gap), 10))
CPC_reg
