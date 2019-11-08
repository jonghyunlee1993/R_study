#즉석실습 - date_lab.R 로 제출한다.
#(1) 내가 태어난 요일 출력하기
birth = as.Date("1993/08/12")
format(birth, "%A")
format(birth, "%a")

#(2) 내가 태어난지 며칠이 되었는지 알아보기
today = Sys.Date()
today - birth

#(3) 올해의 크리스마스 요일 2가지 방법(요일명, 숫자)
chirstmas = "2019/12/25"

format(as.Date(chirstmas), "%A")
as.POSIXlt(chirstmas)$wday

#(4) 2020년 1월 1일 어떤 요일
future_day = as.Date("2020/01/01")

format(future_day, "%A")

#(5) 오늘은 xxxx년x월xx일x요일입니다 형식으로 출력
today = Sys.Date()
year = format(today, "%Y")
mon = format(today, "%m")
dat = format(today, "%d")
dow = format(today, "%a")

cat(paste0("오늘은 ", year, "년 ", mon, "월 ", dat, "일 ", dow, "요일입니다."))

# (6) emp 데이터셋에서 직원들의 입사년도만 출력
emp = read.csv("emp.csv")
format(as.Date(emp$hiredate), "%Y")