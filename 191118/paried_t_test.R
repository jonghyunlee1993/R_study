rm(list = ls())

mid = c(16,20,21,22,23,22,27,25,27,28)
final = c(19,22,24,24,25,25,26,26,28,32)

t.test(mid, final, paired = TRUE)

