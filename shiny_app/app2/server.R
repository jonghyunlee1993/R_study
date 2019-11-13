library(shiny)
shinyServer(function(input, output){
  # slide bar의 값이 바뀔 때마다 aaa에 담긴 값을 가져옴
  sliderValues <- reactive({
    data.frame(
      Parameter="BBB",
      Value = as.character(input$aaa)
    ) 
  })
  output$values <- renderTable({
    sliderValues()
  })
  # output$values <- renderPrint({
  #  sliderValues()
  # })
})