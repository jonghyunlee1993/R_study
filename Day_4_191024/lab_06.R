rm(list=ls())

# Q1
exam1 = function(){
  result = paste(LETTERS, letters, sep="")
  # result = paste0(LETTERS, letters)
  retrun(result)
}

Q1_result = exam1()
Q1_result

# Q2
exam2 = function(my_num){
  result = 0
  for (i in 1:my_num){
    result = result + i
  }
  return(result)
}

Q2_result = exam2(10)
Q2_result

# Q3
exam3 = function(num1, num2){
  result = 0
  if (num1 > num2){
    result = num1 - num2
  }else if (num1 < num2){
    result = num2 - num1
  }else{
    result = 0
  }
  return(result)
}

Q3_result = exam3(10, 20)
Q3_result

# Q4
exam4 = function(num1, operator, num2){
  result = 0
  
  if (operator == "+"){
    result = num1 + num2
  }else if (operator == "-"){
    result = num1 - num2
  }else if (operator == "*"){
    result = num1 * num2
  }else if (operator == "%/%" | operator == "%%"){
    if (num1 == 0){
      result = "오류 1"
    }else if (num2 == 0){
      result = "오류 2"
    }else{
      if (operator == "%/%"){
        result = num1 %/% num2
      }else{
        result = num1 %% num2
      }
    }
  }else{
    result = "규격의 연산자만 전달하세요"
  }
  return(result)
}

Q4_result = exam4(10, "+", 20)
Q4_result

Q4_result = exam4(0, "%%", 3)
Q4_result

Q4_result = exam4(3, "%%", 0)
Q4_result

Q4_result = exam4(3, "/", 19)
Q4_result
