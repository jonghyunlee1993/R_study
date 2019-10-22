rm(list=ls())

# Q1
a = array(1:24, c(2,3,4))

# Q1_1
a[2, 3, 4]
print(a)

# Q1_2
a[2, , ]
print(a)

# Q1_3
a[, 1, ]
print(a)

# Q1_4
a[, , 3]
print(a)

# Q1_5
print(a + 100)

# Q1_6
a[, , 4] * 100
print(a)

# Q1_7
a[1, 2:3, ]
print(a)

# Q1_8
a[2, , 2] = a[2, , 2] + 100
print(a)

# Q1_9
a[, , 1] = a[, , 1] - 2

# Q1_10
a = a * 100

# Q1_11
rm(a)

# Q2
x = 1:5
y = seq(2,10,2)
df1 = data.frame(x,y)

# Q3
col1 = 1:5
col2 = letters[1:5]
col3 = 6:10
df2 = data.frame(col1, col2, col3)

# Q4
제품명 = c("사과", "딸기", "수박")
가격 = c(1800, 1500, 3000)
판매량 = c(24, 38, 13)
df3 = data.frame(제품명, 가격, 판매량, stringsAsFactors = FALSE)

# Q5
mean(df3$가격)
mean(df3$판매량)

# Q6
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
gender <- factor(c("M", "F", "M", "F", "M"))
math <- c(85, 76, 99, 88, 40)

df4 = data.frame(name, gender, math, stringsAsFactors = F)
df4$gender = as.factor(df4$gender)
str(df4)
class(df4$name)
class(df4$gender)
class(df4$math)

# Q6_1
stat = c(76, 73, 95, 82, 35)
df4$stat = stat

df4$score = df4$math + df4$stat

df4$grade = ifelse(df4$score >= 150, "A",
                   ifelse(df4$score >= 100, "B",
                          ifelse(df4$score >= 70, "C", "D")))
# Q7
emp <- read.csv(file.choose(),
                stringsAsFactors = F)
str(emp)

# Q8
emp[c(3,4,5),]

# Q9
emp$ename

# Q10
emp[, c("ename", "sal")]

# Q11
emp[emp$job=="SALESMAN", c("ename", "sal", "job")]

# Q12
emp[emp$sal >= 1000 & emp$sal <= 3000, c("ename", "sal", "empno")]

# Q13
emp[emp$job!="ANALYST", c("ename", "job", "sal")]

# Q14
emp[emp$job=="SALESMAN" | emp$job=="ANALYST", c("ename", "job")]

# Q15
emp[is.na(emp$comm), c("ename", "sal")]

# Q16
emp[order(emp$sal, decreasing = F),]
