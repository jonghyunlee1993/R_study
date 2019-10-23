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
