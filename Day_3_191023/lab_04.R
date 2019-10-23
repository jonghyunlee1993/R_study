rm(list=ls())

# Q1
L1 = list("scott", 3000)
names(L1) = c('name', 'sal')
L1

result1 = L1$sal * 2

# Q2
L2 = list(
  "scott", c(100, 200, 300)
)
L2

# Q3
L3 = list(c(3,5,7), c("A", "B", "C"))
L3[[2]][1] = 'Alpha'
L3

# Q4 
L4 = list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
L4[['alpha']] = L4[['alpha']] + 10
L4

# Q5
L5 = list(math=list(95, 90), writing=list(90, 85), reading=list(85, 80))
mean(unlist(L5))

# Q6
time = 32150
hour = time %/% 3600
minute = time %% 3600 %/% 60
sec = time %% 60

paste(hour, "시간 ", minute, "분 ", sec, "초", sep="")

# 표현 다른 방법
result = c(hour, minute, sec)
paste(result, c("시간", "분", "초"), sep = "", collapse = " ")
