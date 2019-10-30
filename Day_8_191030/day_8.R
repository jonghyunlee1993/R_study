rm(list=ls())

# 정규 표현식 사용

word = "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub("A", "", word)
gsub("a", "", word)
gsub("Aa", "", word)
gsub("(Aa)", "", word)
gsub("(Aa){2}", "", word)        # 반복되는 횟수 지정 / 2번 나온 애를 지우기
gsub("[Aa]", "", word)           # A 또는 a 를 삭제 []는 or 연산 처리
gsub("[가-힣]", "", word)        # 한글 텍스트 모두 지우기
gsub("[^가-힣]", "", word)       # ^form : form이 아닌 모든 것
gsub("[A-Za-z]", "", word)       # 대, 소문자 모두 삭제
#gsub("[[A-Z][a-z]]", "", word)   # 실행 x (?)
gsub("[&^%*]", "", word)
gsub("[[:punct:]]", "", word)    # 특수문자 삭제
gsub("[[:alnum:]]", "", word)    # character와 numeric
gsub("[^[:alnum:]]", "", word)
gsub("[[:alpha:]]", "", word)    # character
gsub("\\w", "", word)            # character
gsub("\\W", "", word)            # non-character
gsub("[[:lower:]]", "", word)    # lower case character
gsub("[[:upper:]]", "", word)    # upper case character 
gsub("[1234567890]", "", word)   # numeric / digit
gsub("[0-9]", "", word)          # numeric / digit
gsub("\\d", "", word)            # numeric / digit
gsub("[[:digit:]]", "", word)    # numeric / digit
gsub("[[:space:]]", "", word)    # 공백 문자
gsub("[[:blank:]]", "", word)    # space와 tab
gsub("\\s", "", word)            # 공백 문자
# 제어 문자 / [[:cntrl:]] / 프로그램상으로는 키 값이 존재하지만 print되지 않음
# [[:print:]]는 표면상으로 출력되는 것을 의미


# XML 패키지 이용
install.packages("XML")
library(XML)

# xml은 자신이 원하는 태그를 만들어서 사용할 수 있다는 장점
# xml 패키지로도 html 태그 파싱이 가능함 / 단 서버에 대한 request 기능은 없음

url = "http://www.hankookilbo.com"
html = read_html(url)
text = htmlParse(html)
content = xpathSApply(text, "//p[@class = 'title']", xmlValue)
content = gsub("[[:punct:][:cntrl:]]", "", content)
content = trimws(content) # trim white space
content = unique(content)
content

# //p[@class='title] : Xpath

# Xpath에서 // 의 의미는 조상의 정보에 무관하게 search하라는 의미
# //table/tbody/tr/th[@id = "f"]
# //table//th # table ... th 를 찾아라

# /wikimedia/projects/project[@name="Wikipedia"]/editions/edition/text()
# 텍스트 부분만 따로 추출 가능

# //ol/li[2] # 2번쨰 li 태그
# / 는 최상위에 위치하는 태그라는 의미 root element
# p.title            : html

# httr 패키지
install.packages("httr")
library(httr) # post 방식 지원 가능 / rvest는 get 만 가능 
library(rvest)
# post 방식을 지원하는 페이지를 get으로 호출 시에도 오류가 발생할 수 있음
http_standard = GET('http://www.w3.org/Protocols/rfc2616/rfc2616.html')
title2 = html_nodes(read_html(http_standard), "div.toc h2")
title2 = html_text(title2)
title2
