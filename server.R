options(shiny.maxRequestSize = 9*1024^2)
library(shiny)
library(openxlsx)
library(dplyr)

shinyServer(function(input, output) {
  output$header <- renderUI({
    inFile <- input$file1
    if (is.null(inFile))
      return(headerPanel("Simple Table upload"))
    headerPanel(paste0(inFile$name))
  })
  
  output$colnames <- renderUI({
    inFile <- input$file1
    if (is.null(inFile))
      return(radioButtons(inputId = 'coln',"Select Type",c("Instructions"="Instructions")))
    checkboxGroupInput(inputId='coln',"Columns to display",
                       choices = colnames(dataset()),
                       selected = colnames(dataset())[1])
  })
  
  output$distPlot <- renderDataTable({
    dataset() %>%
      tibble::as_tibble() %>%
      select(one_of(input$coln)) %>%
      as.data.frame
  })
#   
#   transcheck <- function(x,y = FALSE){
#     if(y==FALSE)
#       return(x)
#     rws = smartnames(x)
#     rt = t(x) %>% as.data.frame
#     colnames(rt) <- rws
#     rt
#   }
# #   
#   smartnames <- function(x){
#     i = 1
#     while(smartcolumns==unique(smartcolumnss) && i < 10){
#       smartcolumns = x[,c(1:i)]
#       i = i+1
#     }
#     smartcolumns
#   }
#   
  dataset <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(data.frame(Instructions = c("Please upload an excel file")))
    read.xlsx(inFile$datapath)
  })
})