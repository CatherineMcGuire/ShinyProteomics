# UI logic
ui <- fluidPage(
  titlePanel("Enhanced Volcano Plot"),
  sidebarLayout(
    sidebarPanel(
      h3("Select Parameters"),
      # Add any input widgets you may need, e.g., file upload, dropdowns, etc.
      textInput("plot_title", "Plot Title:", value = "Volcano Plot"),
      numericInput("x_min", "x min", value = -5),
      numericInput("x_max", "x max", value = 5),
    ),
    mainPanel(
      plotOutput("volcanoPlot")
    )
  )
)