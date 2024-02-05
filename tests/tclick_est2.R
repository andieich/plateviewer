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
      textOutput("text")),
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
  

  observeEvent(input$my_table_cells_selected, {
    req(input$my_table_cells_selected)
    output$text <- renderText({
      paste(input$my_table_cells_selected[1],
            input$my_table_cells_selected[2])
  })
  })
  
}

shinyApp(ui, server)