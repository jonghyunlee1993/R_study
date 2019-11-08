# Day 3 실습 
# 연산자, List 타입, 제어문 등

y = c(0, 25, 50, 75, 100)
z = c(50, 50, 50, 50, 50)

y == z
y != z
y > z

# 원소마다 50이랑 같은지를 비교함
y == 50

num1 = 11
num2 = 3

# 행렬 곱
num1 %*% num2
# 몫 계산
num1 %/% num2
# 나머지 계산
num1 %% num2


# List 실습
a = list(
  a = 1:3,
  b = "string",
  c = pi,
  d = list(-1, -5)
)

lds = list(1,2,3)
lds

# List 타입은 직접 연산이 안 됨
lds + 100

lds[1]
lds[[1]]

# List 타입을 제거한 후에 연산이 가능
# 각각의 서브 리스트에 다시 넣기 때문에 
lds[1] + 100
lds[[1]] + 100

# List 타입에 항목별 이름 부여
names(lds) = LETTERS[1:3]
names(lds)
lds$B

# 객체 관리
ls()
length(ls())
save(list=ls(), file='all.rda')
rm(list=ls())
load('all.rda')


# R 데이터 출력 함수
# 프린트 함수는 자동으로 개행처리
print("Hello World")
print("Hello World", quote = F)

test = c('1','2','3','4')
print(test)
print(test, print.gap = 5)

# cat 함수는 자동으로 개행처리를 하지 않음

cat(11); cat(21)
# 개행처리
cat(11, "\n"); cat(21)

v1 = c("aaa", "bbb", "ccc")
cat(v1)
cat(v1, sep="---")

# cat은 메시지를 보여줄때 주로 사용
# print는 데이터 셋을 보여줄때 주료 사용

# 파일 읽어 들이기
# 1) 숫자                    : scan()
# 2) 텍스트 형태 / 행        : readLine()
#                  워드 단위 : scan()
# 3) csv 형식                : read.csv()
# 4) excel 형식              : readxl 패키지, read_excel()
# 5) xml 형식                : XML 패키지, xmlParse(), xmlToList() 
# 6) DataBase의 데이터       : 
# 7) JSON 등                 : jsonlit, rjson 패키지 / fromJSON() 
#    - JavaScript Object Notation

# scan에 what은 문자열로 읽으라는 의미
nums = scan("sample_num.txt")
word_ansi = scan("sample_ansi.txt", what="")
word_utf8 = scan("sample_utf8.txt", what="", encoding="UTF-8")
lines_ansi = readLines("sample_ansi.txt")
lines_utf8 = readLines("sample_utf8.txt", encoding="UTF-8")

# 제어문
randomNum = sample(1:10, 1)
if (randomNum > 5){
  cat(randomNum, ": 5보다 크다", "\n")
}else{
  cat(randomNum, ": 5보다 작다", "\n")
}

if(randomNum %% 2){
  cat(randomNum, ": 홀수", "\n")
}else{
  cat(randomNum, "짝수", "\n")
}

# 학점 계산기
score = sample(1:100, 1)

if (score >= 90){
  cat(score, "점은 A등급입니다.\n", sep = "")
}else if (score >= 80){
  cat(score, "점은 B등급입니다.\n", sep = "")
}else if (score >= 70){
  cat(score, "점은 C등급입니다.\n", sep = "")
}else if (score >= 60){
  cat(score, "점은 D등급입니다.\n", sep = "")
}else{
  cat(score, "점은 F등급입니다.\n", sep = "")
}


# for loop
for (data in month.name){
  print(data)
}

# 중괄호 안 넣을 시 수행문으로 인식되지 않은 뒤의 print는 수행문이 모두 실행된 후에 실시되는 것
for (data in month.name) print(data); print("A");
# 중괄호를 넣을 시 모두 수행문으로 인식함
for (data in month.name) {print(data); print("A")}

for (n in 1:5){
  cat("Hello\n")
}

# 2중 for loop
for (i in 1:5){
  for (j in 1:5){
    cat("I is", i, "and J is", j, "\n")
  }
}

# 구구단
for (i in 2:9){
  for (j in 1:9){
    if (j == 1){
      cat("----", i, "단----", "\n", sep="")
      cat("\n")
    }
    cat(i, "X", j, "=", i*j, "\n")
  }
  cat("\n")
}

# switch / 수, 문자열에 따라 다른 방식으로 작동함
# R에서는 구문이 아닌 함수로 제공하는 특징이 있음
# 숫자의 경우
# switch(expr = 수치, 식1, 식2, 식3)
# 문자열의 경우
# switch(expr = 문자열, 값1 = 식1, 값2 = 식2, 값3 = , 값4 = 식3, 식4)
# 값3의 경우, 값3 | 값4 = 식3 을 의미하며, 디폴트 값으로 식4

# 문자열 switch 예시
Season = function(){
  month = sample(1:12, 1)
  month = print(paste(month, "월", sep = ""))
  result = switch(EXPR = month,
                  "12월"=, "1월"=, "2월"="겨울",
                  "3월"=, "4월"=, "5월"="봄",
                  "6월"=, "7월"=, "8월"="여름",
                  "가을")
  cat(month, "은 ", result, "입니다.\n", sep="")
}

for (i in 1:30){
  Season()
}

# 숫자 switch 예시
num = sample(1:10, 1)
num
switch(num, "A", "B", "C", "D") # 1, 2, 3, 4인 경우에만 리턴

for (num in 1:10){
  cat(num, ":", switch(num, "A", "B", "C", "D"), "\n")
}

# 순차적인 조건이 아닐 경우에는 문자열로 바꿔서 처리를 해야함
for (num in 1:10){
  num = as.character(num)
  cat(num, ":", switch(num, "7"="A", "8"="B", "9"="C", "10"="D", "Nothing"), "\n")
}
