library(shiny)
library(bslib)
library(DT)

ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "minty"),
  titlePanel(h1("My timetable", align = "center" )),
  sidebarLayout(
    position = c("left"),
    sidebarPanel(
      width = 4,
      selectInput("select1", label = h5("Event:"),
                  choices = c("math" , "sience", "sport") ,
                  selected = 1,
                  width = 400),
      actionButton("action", label = "Add")),
    mainPanel(
      width = 8,
      dataTableOutput('my_table')
    )
  )
)

server <- function(input, output, session) {
  
  timetable <- reactiveVal(
    data.frame(monday = c("","","","",""),
               tuesday = c("","","","",""),
               wednesday = c("","","","",""),
               thursday = c("","","","",""),
               friday = c("","","","",""))
  )
  
  output$my_table = renderDataTable(timetable(), selection = list(mode = "single", target = "cell"))
  
  observeEvent(input$action, { 
    tmp <- timetable()
    tmp[1, "monday"] <- input$select1
    timetable(tmp)
  })
  
  observeEvent(input$my_table_cells_selected, {
    req(input$my_table_cells_selected)
    
    output$my_table = renderDataTable(datatable(timetable()))

  })
  
}

shinyApp(ui, server)