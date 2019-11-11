library(shiny)
shinyUI(fluidPage(
  titlePanel("Sliders"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("aaa", "Integer:",
                  min=0, max=1000, value=500)
    ),
    mainPanel(
      h1("테스트"),
      tableOutput("values")
      # textOutput("values")
    )
  )
))