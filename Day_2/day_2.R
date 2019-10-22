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

