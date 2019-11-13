library(survival)

tx = Surv(data$os_gap, data$txgroups)
cox1 = coxph(tx ~ sex + age + ckd + dm + htn + cirrhosis + decom + initial_hbeag +
               plt_0 + alb_0 + bil_0 + inr_0 + afp_0 + ctp + albi + fib4 + meld, data = data)
summary(cox1)

cox2 = coxph(tx ~ sex + age + ckd + dm + htn + cirrhosis + decom + initial_hbeag +
               plt_0 + alb_0 + bil_0 + inr_0 + ctp + albi + fib4 + meld, data = data)
summary(cox2)

cox3 = coxph(tx ~ sex + age + dm + htn + cirrhosis + decom + initial_hbeag +
               plt_0 + bil_0 + inr_0 + ctp + albi + fib4 + meld, data = data)
summary(cox3)

cox4 = coxph(tx ~ sex + age + dm + htn + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + ctp + albi + fib4 , data = data)
summary(cox4)

cox5 = coxph(tx ~ sex + dm + htn + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + fib4 , data = data)
summary(cox5)

cox6 = coxph(tx ~ sex + dm + cirrhosis + decom + initial_hbeag +
               bil_0 + inr_0 + fib4 , data = data)
summary(cox6)

cox7 = coxph(tx ~ sex + dm + cirrhosis + decom + initial_hbeag +
               bil_0 + fib4 , data = data)
summary(cox7)

cox8 = coxph(tx ~ sex + cirrhosis + decom + initial_hbeag +
               fib4 , data = data)
summary(cox8)

cox9 = coxph(tx ~ sex + cirrhosis + decom + fib4 , data = data)
summary(cox9)



