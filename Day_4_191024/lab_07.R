rm(list=ls())

# Q1
exam5 = function(num, str = "#"){
  if (num > 0){
    for (i in 1:num){
      cat(str)
    }
  }
}

exam5(7)
exam5(7, "%")

# Q2
exam6 = function(vec){
  result = c()
  if (sum(is.na(vec)) > 0){
    return(print("NA는 처리불가"))
  }else{
    for (i in 1:length(vec)){
      if (vec[i] >= 85){
        result[i] = "상"
      }else if (vec[i] >= 70){
        result[i] = "중"
      }else{
        result[i] = "하"
      }
    }
  }
  return(print(paste0(vec, ' 점은 ', result, '등급입니다.')))
}

exam6(c(50, 90, 30, 40))
exam6(c(100, 50, 12, NA))
exam6(c(100, 50, 12))

# Q3
countEvenOdd = function(vec){
  
  result = list()
  even = 0
  odd = 0

  if (!is.vector(vec) | !is.numeric(vec)){
    result = NULL
  }else{
    for (i in 1:length(vec)){
      if (vec[i] %% 2 == 1){
        odd = odd + 1
      }else{
        even = even + 1
      }
    }
    result = list(even, odd)
    names(result) = c('even', 'odd')
  }
  return(result)
}

countEvenOdd(c(1,2,3,4,5,6,7,8,9))
countEvenOdd(c('가', '나'))

# Q4
vmSum = function(vec){
  result = c()
  if (!is.vector(vec) | class(vec) == 'list'){
    print("벡터만 전달하숑!")
    result = NULL
  }else if (!is.numeric(vec)){
    print("숫자 벡터를 전달하숑!")
    result = c(0)
  }else{
    result = sum(vec)
  }
  return(result)
}

vmSum(c(1,2,3,4,5))
vmSum(c(1,2,3,4,'가'))
vmSum(list('가'))
vmSum(array(1:16, c(2,2,4)))
