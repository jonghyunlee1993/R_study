rm(list=ls())


# Q1
grade = sample(1:6, 1)
if (grade >= 4){
  cat(grade, "학년은 고학년입니다.", sep="")
}else{
  cat(grade, "학년은 저학년입니다.", sep="")
}


# Q2
choice = sample(1:5, 1)
result = switch(choice, 300+50, 300-50, 300*50, 300/50, 300%%50)
cat("결과값 : ", result, sep="")


# Q3
count = sample(3:10, 1)
deco = sample(1:3, 1)

if (deco == 1){
  temp = rep("*", count)
  print(temp)
  # gsub(", ", "", toString(temp))
}else if (deco == 2){
  temp = rep("$", count)
  print(temp)
  # gsub(", ", "", toString(temp))
}else{
  temp = rep("#", count)
  print(temp)
  # gsub(", ", "", toString(temp))
}


# Q4
score = sample(1:100, 1)

if (score >= 90){
  grade = 1
}else if (score >= 80){
  grade = 2
}else if (score >= 70){
  grade = 3
}else if (score >= 60){
  grade = 4
}else{
  grade = 5
}

# grade = ifelse(score >= 90, 1, 
#                ifelse(score >= 80, 2, 
#                       ifelse(score >= 70, 3,
#                              ifelse(score >= 60, 4, 5))))

# grade = ifelse(score %% 10 == 9, 1, 
#                ifelse(score %% 10 == 8, 2, 
#                       ifelse(score %% 10 == 7, 3,
#                              ifelse(score %% 10 == 6, 4, 5))))


grade_result = switch(grade, "A 등급", "B 등급", "C 등급", "D 등급", "F 등급")
cat(score, "점은 ", grade_result, "입니다.", sep="")

# Q5
alpha = paste(LETTERS, letters, sep="")
print(alpha)

# 다른 표현
# for (i in 1:length(LETTERS)){
#   cat(LETTERS[i], letters[i], sep="", collapse=" ")
# }
