library(shiny)
library(EnhancedVolcano)
library(limma)

p_cutoff <- 0.05
fc_cutoff <- 1
p_cutoff_col <- "adj.P.Val"

# Server logic
server <- function(input, output) {
  # Function to read uploaded data or use default data
  data <- reactive({
    req(input$file)
    if (!is.null(input$file$datapath)) {
      read.csv(input$file$datapath, header = TRUE, stringsAsFactors = FALSE)
    } else {
      # Use default data if no file uploaded
      # Here, you can replace this with your own default data generation logic
      as.data.frame(matrix(rnorm(100), ncol = 2))
    }
  })

  data <- as.data.frame(matrix(rnorm(100), ncol = 2))

  # Generate Enhanced Volcano Plot
  output$volcanoPlot <- renderPlot({
    req(data())
    EnhancedVolcano(
      data(),
      title = input$plot_title,
      # xlim = input$x_range,
      xlim = c(input$x_min, input$x_max),
      # lab = rownames(data()),
      lab = data()[, "Gene.symbol"],
      x = "logFC",  # Assuming log fold change column is named logFC
      y = "adj.P.Val",
      # Assuming log adjusted p-value column is named logPValue
      labSize = 3,
      pCutoffCol = p_cutoff_col,
      pCutoff = p_cutoff,
      FCcutoff = fc_cutoff,
    )
  })

  # Download plot as PDF
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste(input$plot_title, ".pdf", sep = "")
    },
    content = function(file) {
      pdf(file)
      print(EnhancedVolcano(
        data(),
        title = input$plot_title,
        # xlim = input$x_range,
        xlim = c(input$x_min, input$x_max),
        lab = data()[, "Gene.symbol"],
        x = "logFC",  # Assuming log fold change column is named logFC
        y = "adj.P.Val",
        # Assuming log adjusted p-value column is named logPValue
        labSize = 3,
        pCutoffCol = p_cutoff_col,
        pCutoff = p_cutoff,
        FCcutoff = fc_cutoff,
      ))
      dev.off()
    }
  )
}
