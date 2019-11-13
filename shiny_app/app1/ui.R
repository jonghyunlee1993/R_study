library(shiny)

shinyUI(fluidPage(
  titlePanel("제목 패널"),
  sidebarPanel("측면 패널"),
  mainPanel(
    h3("iris 요약통계량 결과"),
    verbatimTextOutput("summary")
    # textOutput("summary")
  )
))