#########################
##### R study Day 2 #####
#########################

rm(list=ls())

# matrix 실습
mat = matrix(1:4, nrow = 2, ncol = 2)
print(mat)

mat2 = matrix(5:8, nrow = 2)
print(mat2)

x1 = matrix(c(1,2,3,4,5,6,7,8), nrow=2)
x1 = x1 * 3
sum(x1); mean(x1); max(x1); min(x1)

# 요소의 개수가 부족한 경우 자동으로 반복해서 채워 넣음
x2 = matrix(1:8, nrow = 3)
# summary 함수를 실행시키면 열 단위로 확인
summary(x2)
# 행 단위로 보고 싶을 때는 apply 함수를 이용
apply(x2, 2, mean)
apply(x2, 2, min)
apply(x2, 2, max)

# 출력하는 여러 방법법
(chars = letters[1:10])
str(chars)
print(chars)

mat1 = matrix(chars)
mat1
matrix(chars, nrow = 1)
matrix(chars, nrow = 5, byrow=F)
matrix(chars, nrow = 5, byrow=T)

vec1 = c(1,2,3)
vec2 = c(4,5,6)
vec3 = c(7,8,9)

mat1 = rbind(vec1, vec2, vec3)
mat1
mat1 = cbind(vec1, vec2, vec3)
colnames(mat1) = NULL
mat1

# 매트릭스 형식으로 인덱싱하고 리턴
mat[1,1,drop=F]
# 벡터 형식으로 인덱싱하고 리턴
mat[1,1,drop=T]

# matrix 사이즈 리턴
dim(mat)
nrow(mat)
ncol(mat)

# 행 단위, 열 단위 연산
rowSums(mat)
colSums(mat)
rowMeans(mat)
colMeans(mat)

# apply 함수 / 함수를 호출해서 행 단위(1), 열 단위(2)로 적용
# apply(매트릭스, 1 or 2, function()) / 함수를 인자로 전달할 수 있음
apply(mat, 1, mean)
apply(mat, 2, mean)

# 일반 벡터 곱
print(mat * mat2)

# 행렬 곱
print(mat %*% mat2) 

# vector를 합쳐서 matrix로 
a = c(1,2,3,4)
b = c(5,6,7,8)

print(rbind(a,b))
print(cbind(a,b))

# 폴더 경로 관련 함수
getwd()
setwd("C:/Rstudy")

# Array 실습
a1 = array(1:30, dim=c(2,3,5))
a1
a1[1,3,]
a1[1,3,5]
a1[,,3]
a1[,2,]
a1[1,,]

# factor
score = c(1, 3, 2, 4, 2, 1, 3, 5, 1, 3, 3, 3)
class(score)
summary(score)

f_score = factor(score)
f_score
class(f_score)
# factor 형 데이터의 각 범주별 항복의 수 카운트
summary(f_score)
# factor 형 데이터가 갖는 levels를 리턴
levels(f_score)

# 연속형으로 취급
plot(score)
# 이산형으로 취급
plot(f_score)

# 주어진 데이터 내에서 factor의 level을 결정함
DOW = c("월", "수", "토", "월", "목", "화")
class(DOW)
summary(DOW)
f_DOW = factor(DOW)
summary(f_DOW)
levels(f_DOW)

# factor의 level을 사전에 지정한 후에 factor형으로 변환
week.korabbname = c("일", "월", "화", "수", "목", "금", "토")
f_DOW2 = factor(DOW, levels=week.korabbname)
summary(f_DOW2)

# factor에 지정이 되어 있지 않은 경우에는 결측치로 처리함
btype = factor(c("A", "O", "AB", "B", "O", "A"), 
               levels=c("A", "B", "O"))
summary(btype)

btype2 = factor(c("A", "O", "AB", "B", "O", "A"), 
               levels=c("A", "B", "O", "AB"))
summary(btype2)

# factor형에 레이블을 지정하는 경우
gender = factor(c(1,2,1,2,1,1,1,2,2,2,1), 
                levels=c(1,2),
                labels=c("남", "여"))
summary(gender)

# data frame 
# 내장 데이터 셋의 종류 보기
data(iris)
head(iris, n=10)
tail(iris, n=10)
str(iris)

# data frame의 인덱싱 방법
iris$Species[iris$Species != "setosa"]
iris[2,5]
iris[2,]
iris[,2]
iris$Species[2]

#Dataframe 실습
no <- c(1,2,3,4)
name <- c('Apple','Banana','Peach','Berry')
qty <- c(5,2,7,9)
price <- c(500,200,200,500)
fruit <- data.frame(no, name, qty, price)
# fruit <- data.frame(no, name, qty, price, stringsAsFactors = F)
str(fruit)
View(fruit)

fruit[1,]
fruit[-1,]
fruit[,2]
fruit[,3] # fruit[,3, drop=F]
fruit[, c(3,4)]
fruit[3,2]
fruit[3,1]

fruit[,3]
fruit$qty
fruit[[3]]
fruit[3]  # 데이터프레임 형식 유지

# data frame의 구조를 버리고 벡터로 변환
str(fruit$qty)
# data frame의 구조를 유지
str(fruit[3])

# dataframe exam1
english <- c(90, 80, 60, 70)
math <- c(50, 60, 100, 20)
classnum <- c(1,1,2,2)
df_midterm <- data.frame(
  english, math, classnum)
df_midterm
str(df_midterm)
colnames(df_midterm)
rownames(df_midterm)
names(df_midterm)
mean(df_midterm$english)
mean(df_midterm$math)

df_midterm2 <- data.frame(
  c(90, 80, 60, 70), 
  c(50, 60, 100, 20), 
  c(1,1,2,2))
colnames(df_midterm2)
rownames(df_midterm2)
names(df_midterm2)
df_midterm2
df_midterm2 <- data.frame(
  영어=c(90, 80, 60, 70), 
  수학=c(50, 60, 100, 20), 
  클래스=c(1,1,2,2))
df_midterm2
df_midterm2$영어

df <- data.frame(var1=c(4,3,8), 
                 var2=c(2,6)) # 오류
df <- data.frame(var1=c(4,3,8), 
                 var2=c(2,6,1))
str(df)
# 기존에 없던 결과를 data frame에 합산하는 것, 파생 변수 생성
df$var_sum <- df$var1 + df$var2
df$var_mean <- df$var_sum/2
df$result <- ifelse(df$var1>df$var2, 
                    "var1이 크다", "var1이 작다")

getwd() # setwd('xxx')

#csv파일열기
score <- read.csv("Day_2/data/score.csv")
score
str(score)
score$sum <- 
  score$math+score$english+score$science
score$result <- ifelse(score$sum >= 200, 
                       "pass", "fail")
score

summary(score$result) 
table(score$result) # 집계표를 만들어주는 함수
summary(factor(score$result))
score$result = factor(score$result)
# score$result = as.factor(score$result) # as.factor로 변환
str(score)
summary(score)

# char형으로 변환
score$id = as.character(score$id)
score$class = as.factor(score$class)

score$grade<-as.factor(ifelse(score$sum >= 230,"A",
                        ifelse(score$sum >= 215,"B", 
                           ifelse(score$sum >=200,"C","D"))))
score
summary(score$grade)

# order() 와 sort()
v <- c(10,3,7,4,8)
sort(v)
order(v)
v[order(v)] # sort(v)랑 똑같은 결과

emp <- read.csv(file.choose(),
                stringsAsFactors = F)
emp
str(emp)

# 1. emp에서 직원 이름
emp$ename
emp[,2]
emp[,"ename"] 
emp[,2, drop=FALSE] 
emp[,"ename",drop=F] 
emp[2]
emp["ename"] 

# 2. emp에서 직원이름, 잡, 샐러리
emp[,c(2,3,6)]
emp[,c("ename","job","sal")]
subset(emp,select = c(ename, job, sal))
?subset
# 3. emp에서 1,2,3 행 들만
emp[1:3,]
emp[c(1,2,3),]

# 4. ename이 "KING"인 직원의 모든 정보
emp[9,] 
emp$ename=="KING"
emp[c(F,F,F,F,F,F,F,F,T,F,F,F,
      F,F,F,F,F,F,F,F),]
subset(emp,subset= emp$ename=="KING")
subset(emp,emp$ename=="KING") 

emp[emp$ename=="KING",] 

# 5. select ename,sal from emp where sal>=2000
subset(emp, select=c("ename","sal"), subset= emp$sal>= 2000)
subset(emp, emp$sal>= 2000, c("ename","sal"))
emp[emp$sal>=2000,c("ename","sal")]

# 6. select ename,sal from emp where sal between 2000 and 3000
subset(emp, select=c("ename","sal"), subset=(sal>=2000 & sal<=3000))
emp[emp$sal>=2000 & emp$sal <=3000, c("ename","sal")]


emp[!is.na(emp$comm), c("ename", "comm")]




