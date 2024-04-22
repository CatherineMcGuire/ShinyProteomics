# UI logic
ui <- fluidPage(
  titlePanel("Enhanced Volcano Plot"),
  sidebarLayout(
    sidebarPanel(
      # fileInput("file", "Upload CSV File"),
      textInput("plot_title", "Plot Title", "Volcano Plot"),
      fluidRow(
        column(6, numericInput("x_min", "X-axis Min", min = 0, max = 10, value = -2)),
        column(6, numericInput("x_max", "X-axis Max", min = 0, max = 10, value = 2))
      ),
      # sliderInput(
      #   "x_range",
      #   "X-axis Range",
      #   min = -10,
      #   max = 10,
      #   value = c(0, 10),
      #   step = 0.1
      # ),
      downloadButton("downloadPlot", "Download Plot")
    ),
    mainPanel(
      plotOutput("volcanoPlot")
    )
  )
)