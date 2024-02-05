library(shiny)
library(DT)


DF = as.data.frame(
  cbind(
    matrix(round(rnorm(50), 3), 10),
    sample(0:1, 10, TRUE),
    rep(FALSE, 10)
  )
)

ui <- shinyUI(
  fluidRow(
    tags$style(HTML('table.dataTable tr.selected td, table.dataTable td.selected {background-color: lightgreen !important;}')),
    DT::dataTableOutput("myDT")
  )
)

server <- shinyServer(function(input, output, session) {
  
  output$myDT <- DT::renderDataTable({
    DT::datatable(DF, 
                  selection = list(mode="multiple", target="cell"), 
                  editable = F,
                  filter = "none",
                  options = list(dom='t',ordering=F),
                  rownames = FALSE)
  })
  
})

shinyApp(ui, server)