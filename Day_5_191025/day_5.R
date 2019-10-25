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

# R에서는 try 함수로 구현
test2 = function(){
  cat("Go\n")
  try(testError(-1))
  print("Go on?")
}

test2()

# tryCatch({try codeblock}, warning = function(w), error = function(e), finally = {code block})
testAll = function(p){
  tryCatch({
    if(p == "오류 테스트"){
      testError(-1)
    }else if (p == "경고 테스트"){
      testWarn(6)
    }else{
      cat("정상 수행\n")
      print(testError(2))
      print(testWarn(3))
    }
  }, warning = function(w){ # warning이 발생해야만 수행
    print(w)
    cat("warning\n")
  }, error = function(e){ # error이 발생해야만 수행
    print(e)
    cat("error\n")
  }, finally = { # error, warning의 여부와 무관하게 수행
    cat("오류, 경고 발생 여부를 떠나 반드시 수행되는 부분")
  })
}

testAll("오류 테스트")
testAll("경고 테스트")
testAll("정상 테스트")

# is.na 
f.case1 = function(x){
  if(is.na(x)){
    return("NA")
  }else{
    return("NO")
  }
}

f.case1(100)
f.case1(c(10,20,30))
f.case1(1:5)
f.case1(c(10, NA, 20))

# any & is.na / 하나라도 true 이면 true
f.case2 = function(x){
  if(any(is.na(x))){
    return("NA")
  }else{
    return("NO")
  }
}

f.case2(100)
f.case2(c(10,20,30))
f.case2(1:5)
f.case2(c(10, NA, 20))

# sum & is.na
f.case3 = function(x){
  if(sum(is.na(x))){
    return("NA")
  }else{
    return("NO")
  }
}

f.case3(100)
f.case3(c(10,20,30))
f.case3(1:5)
f.case3(c(10, NA, 20))

# Sys.sleep
testSleep = function(x){
  for (data in 6:10){
    # cat(data, "\n")
    if (x){
      Sys.sleep(1)
      cat(data, "\n")
    }
  }
  return()
}

testSleep(F)
testSleep(T)

