rm(list=ls())

my_function = function(){
  print(LETTERS[1])
  print(LETTERS[2])
  print(LETTERS[3])
  print(LETTERS[4])
  print(LETTERS[5])
  print("END")
}

my_function()


my_function = function(){
  print(LETTERS[1])
  print(LETTERS[2])
  today = weekdays(Sys.Date())
  if(today == "금요일"){
    return(today)
  }
  print(LETTERS[3])
  print(LETTERS[4])
  print(LETTERS[5])
  print("END")
}
my_function()


# 오류 발생 / stop()
testError = function(x){
  if (x <= 0){
    stop("양의 값을 전달하세요")
  }
  return(rep("테스트", x))
}

testError(4)
testError(0)
testError(-2)

# 경고 메시지 / warning() 
testWarn = function(x){
  if (x <= 0){
    stop("양의 값을 전달하세요")
  }else if (x > 5){
    warning("5보다 큰 수는 5로 처리합니다")
    x = 5
  }
  
  return(rep("테스트", x))
}

testWarn(4)
testWarn(10)


test1 = function(){
  cat("Go\n")
  testError(-1)
  # error 발생 시 호출한 함수 실행도 종료
  print("Go on?")
}

test1()


