df = read.csv('./data/Abc1115.csv', header = FALSE)
head(df)

#데이터셋 출력
#1. 컬럼명 바꾸기
names(df) <- c('std_no','email','kor','eng','math','sci','hist','total','mgr_code',
'acc_code','local_code')

names(df)
df <- df[-12]
names(df)
library(dplyr)
df_b = df %>% filter(local_code=='B')
head(df_b)
nrow(df_b)
dim(df_b)
df %>% select(std_no, total, local_code)
df_b = df_b %>% mutate(temp = kor + eng)
head(df_b,15)
df_b = df_b %>% arrange(desc(temp))

#5번째 뽑기
df_b[5, ]   

#학번 가져오기
df_b[5, 1]

df_b[1,12]
