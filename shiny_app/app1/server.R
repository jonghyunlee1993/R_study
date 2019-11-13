library(shiny)

shinyServer(function(input, output){
  # client의 출력 값과 일치시키면 해당 값을 렌더링 가능
  output$summary <- renderPrint({
    dataset <- iris[-5]
    summary(dataset)
  })
  
})