library(shiny)
shinyUI(pageWithSidebar(
  uiOutput('header'),
  sidebarPanel(
    fileInput('file1', 'Choose file to upload',
              accept = c('.xls','.xlsx')
    ),
    tags$hr(),
    uiOutput('colnames')
  ),
  mainPanel(
    dataTableOutput("distPlot")
  )
))
