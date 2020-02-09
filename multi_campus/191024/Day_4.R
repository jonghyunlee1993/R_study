for (data in month.name){
  print(data)
}

# break 문은 break가 사용된 것과 가장 가까운 반복문을 중지시킨다. 
sum = 0
for (i in 5:15){
  if (i %% 10 == 0){
    break;
  }
  sum = sum + 1
  print(paste(i, " : ", sum))
}

# next 문의 경우, 해당 조건만 넘긴다.
sum = 0
for (i in 5:15){
  if (i %% 10 == 0){
    next;
  }
  sum = sum + 1
  print(paste(i, " : ", sum))
}

# crawling에서 자주 사용된다. 

sum = 0
for (i in 5:15){

  sum = sum + 1
  print(paste(i, " : ", sum))
  
  if (i %% 10 == 0){
    next;
  }
  
  print("after next")
}

# 예외처리: break, next, stop ... 

# while은 조건 비교를 수행해서 해당 조건이 거짓이 될 때까지 실행되는 것
# for의 경우는 특정 횟수만큼 반복되게끔 하는 것
sum_number = 0
while (sum_number <= 20){
  i = sample(1:5, 1)
  sum_number = sum_number + i
  cat(sum_number, "\n")
}

# 무한 루프 / while의 조건을 모르겠는 경우, 단 수행하면서 조건을 알아야하는 경우는 while 제한\
# while (true) 랑 똑같은 것
repeat{
  cat("A\n")
}

sum_number = 0
repeat{
  i = sample(1:5, 1)
  sum_number = sum_number + i
  cat(sum_number, "\n")
  
  if (sum_number > 20){
    break
  }
}

# 함수 (function)
# 
# 1) 함수를 사용하는 경우
# - 호출 
# - 함수명, 기능, 아규먼트의 요구 사항, 리턴 값의 유무, 리턴 값의 타입, 리턴 값의 의미 등
# - 도큐먼트를 참고한다.
# 
# 2) 함수를 만드는 경우
# - 정의
# - 자주 사용되는 기능을 수행코드로 만든 모듈(코드 덩어리)
# - 고려사항: 어떤 기능을 구현할 것인지, 해당 기능을 제공하는 함수가 이미 있는지를 확인하기 (기본 함수 내에서는 확인해볼만 하다)
# - 함수명: 함수명을 통해서 기능을 유추할 수 있어야 함
# - 매개변수: 함수에 전달할 인자가 있는지, 몇 개의 인자를 전달해야하는지
# 
# Func1 = function()
#   수행문장
# 
# Func2 = function(A)
#   수행문장
# 
# Func3 = function(A, B){
#   수행문장
#   수행문장
# }
# 
# 아규먼트의 개수 제한이 없는 경우
# Func4 = function(...){
#   수행문장
#   수행문장
# }
# 
# 리턴 값이 없는 경우 / NULL이 리턴된다
# Func5 = function(...){
#   수행문장
#   return()
# }
# 
# 리턴 값이 있는 경우
# Func5 = function(...){
#   수행문장
#   return(리턴 값)
# }
# 
# retrun 값을 지정해주지 않으면 마지막으로 생성된 결과가 할당될 수 있음
# 매개변수의 타입을 확인하기 위해서는 함수의 body에서 is.character 등을 사용한다.

# 사용자 정의 함수 실습
f1 = function() print("TEST")
f2 = function(num){print("TEST"); print(num)}
f3 = function(p="R"){print(p)}

f1()
f2(100)
f3()
f3("python")
f3(p = "JAVA")

f4 = function(p1 = "A", p2){
  for (i in 1:p2){
    print(p1)
  }
}

f4(p2 = 10)

f5 = function(...){
  print("TEST")
  data = c(...)
  print(length(data))
}

f5(c(1,2,3,4,5,6))

# 함수 정의 실습
rm(list=ls())

func1 = function(){
  xx = 10
  yy = 20
  return(xx * yy)
}

func1()

func1_result = func1()
func1_result
xx # 함수 밖에서 함수 안에서 생성된 변수에 접근할 수 없음. 
# 지역 변수(Local Variable), 전역 변수(Global Variable)의 개념 

xx=0
func1_1 = function(){
  print(xx)
  xx = 10
  print(xx)
  return(xx)
}

print(xx)
K = func1_1()
print(K)
print(xx)

func2 = function(x,y){
  xx = x
  yy = y
  return(sum(xx,yy))
}

func2_result = func2(1,2) # 함수 호출 식
func2_result

func3 = function(x,y){
  x3 = x+1
  y3 = y+1
  x4 = func2(x3,y3)
  return(x4)
}
func3(9,13)

func4 = function(x=100, y=200, z){
  return(x+y+z)
}

func4()
func4(10,20,30)
func4(z=100)

a = 3; b = 7; c = 11;
ft = function(a){
  b = a + 10
  c <<- a + 10 # local 변수의 값을 전역 변수로 할당해 줌 / 전역 대입 연산
  d = a
  print(a); print(b); print(c); print(d)
  return()
}
print(ft(100))
a; b; c; d


testParamType = function(x){
  if (is.vector(x)){
    print("Vector")
  }else if (is.data.frame(x)){
    print("data frame")
  }else if (is.list(x)){
    print("list")
  }else if (is.matrix(x)){
    print("matrix")
  }else if (is.array(x)){
    print("array")
  }else if (is.function(x)){
    print("function")
  }
}

# 아규먼트의 개수를 제한하지 않는 경우에 사용 가능 ...
f5 = function(...){
  print("TEST")
  data = c(...)
  print(data)
  print(length(data))
}

f5(1,2,3,4,5,6)
f5("abc", TRUE, 10, 20)
f5(temp = list(c(1,2,3)))

f6 = function(...){
  print("Start")
  data = c(...)
  for (item in data){
    print(item)
  }
  return(length(data))
}

f6()
f6(10, 20, 30, 40, 50, 60)
f6(10, 'abc', T, F)

f7 = function(...){
  data = c(...) # 벡터로 합치기 때문에 기존의 데이터 형태가 파괴됨
  sum_result = 0
  
  for (item in data){
    if (is.numeric(item)){
      sum_result = sum_result + item
    }else{
      print(item)
    }
  }
  return(sum_result)
}

f7(10, 20, 30)
f7(10, 20, "test", 30, 40)


f8 = function(...){
  data = list(...) # 리스트로 합치면 기존의 데이터 형태 유지 가능
  sum_result = 0
  
  for (item in data){
    if (is.numeric(item)){
      sum_result = sum_result + item
    }else{
      print(item)
    }
  }
  return(sum_result)
}

f8(10, 20, 30)
f8(10, 20, "test", 30, 40)
