age = c(20, 30, 40, 50)
gender = c("F", "M", "M", "F")
income = c(1000, 2000, 3000, 4000)
region = c('S', 'S', 'G', "G")

df = data.frame(age, gender, income, region)

library(reshape2)

df_melt = melt(df, id.vars = c("gender", "region"))
df_melt

dcast(df_melt, gender ~ variable + region)
dcast(df_melt, gender ~ region + variable)
dcast(df_melt, gender + region ~ variable)
