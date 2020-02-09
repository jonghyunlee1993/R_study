rm(list=ls())

library(dplyr)

data = read.csv('emp.csv', stringsAsFactors = F)
str(data)

# Q1
ans_1 = data %>% filter(job == "MANAGER")
ans_1

# Q2
ans_2 = data %>% select(empno, ename, sal)
ans_2

# Q3
ans_3 = data %>% select(-empno)
ans_3

# Q4
ans_4 = data %>% select(ename, sal)
ans_4

# Q5
ans_5 = data %>% group_by(job) %>% count
ans_5

# Q6
ans_6 = data %>% filter(sal >= 1000 & sal <= 3000) %>% 
  select(ename, sal, deptno)
ans_6

# Q7
ans_7 = data %>% filter(job != "ANALYST") %>% 
  select(ename, job, sal)
ans_7

# Q8
ans_8 = data %>% filter(job == "SALESMAN" | job == "ANALYST") %>% 
  select(ename, job)
ans_8

# Q9
ans_9 = data %>% group_by(job) %>% 
  summarise(sum_sal = sum(sal))
ans_9

# Q10
ans_10 = data %>% arrange(sal)
ans_10

# Q11
ans_11 = data %>% arrange(desc(sal)) %>% head(1)
ans_11

# Q12
emp_new = data %>% rename(salary = sal, commrate = comm)
emp_new

# Q13
ans_13 = data %>% group_by(deptno) %>% 
  count(deptno) %>% arrange(desc(n)) %>%  head(1)
ans_13

# Q14
ans_14 = data %>% mutate(enamelength = nchar(ename)) %>% 
  arrange(enamelength) %>% select(ename)
ans_14

# Q15
ans_15 = data %>% filter(!is.na(comm)) %>% count
ans_15
