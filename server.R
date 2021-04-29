### Download and load required packages
packages <- c("ggplot2","andrews","treemap","symbols","aplpack","tidyverse")

installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
invisible(lapply(packages, library, character.only = TRUE))



server <- function(input,output){

  ### TAB 2: Data file
  data <- reactive({
    req(input$file1)
    inFile <- input$file1
    
    # Display error when uploaded file and chosen separator mismatched
    tryCatch({
      df <- read.csv(input$file1$datapath,
                     header = input$header,
                     sep = input$sep)},
      error = function(e){
      stop(safeError(e))}
    )
    
    # Change character variables into factors to facilitate plotting
    df[sapply(df, is.character)] <- lapply(df[sapply(df, is.character)], as.factor)
    
    return(df)
  })
  
  # Display data in table view
  output$contents <- renderTable({data()})
  
  
  ### TAB 3: Visualization
  to_plot <- reactiveValues(plot = NULL)
  
  observeEvent(input$types, {
    updateTabsetPanel(inputId = "var", selected = input$types)
  })
  
  observeEvent(data(), {
    choices <- unique(names(data()))
    updateCheckboxGroupInput(inputId = "var_scatmat", choices = choices)
    updateCheckboxGroupInput(inputId = "var_box", choices = choices)
    updateSelectInput(inputId = "x_violin", choices = choices)
    updateSelectInput(inputId = "y_violin", choices = choices)
    updateSelectInput(inputId = "group_violin", choices = choices)
    updateSelectInput(inputId = "var1_mosaic", choices = choices)
    updateSelectInput(inputId = "var2_mosaic", choices = choices)
    updateSelectInput(inputId = "var3_mosaic", choices = choices)
    # updateSelectInput(inputId = "x_tree", choices = choices)
    # updateSelectInput(inputId = "y_tree", choices = choices)
  })
  
  output$plot1 <- renderPlot({

    nums <- unlist(lapply(data(),is.numeric))
    data.mat <- as.matrix(data()[,nums])
    
    if (input$types == "scatmat") {
      to_plot$plot <- pairs(data()[,input$var_scatmat],main="Scatterplot Matrix",pch=21)
    } else if (input$types == "andrew") {
      to_plot$plot <- andrews(data(),type=4,clr=5,main="Andrews Curve")
    } else if (input$types == "color") {
      to_plot$plot <- image(data.mat,main="Color Icon")
    } else if (input$types == "box") {
      to_plot$plot <- boxplot(data()[,input$var_box],main="Boxplot")
    } else if (input$types == "violin") {
      to_plot$plot <- ggplot(data(),aes(x=data()[,input$x_violin],y=data()[,input$y_violin],group=data()[,input$group_violin])) + 
        geom_violin() + geom_boxplot(width=0.1) + xlab(input$x_violin) + ylab(input$y_violin) + labs(title="Violin Plot")
    } else if (input$types == "mosaic") {
      df1 <- data.frame(data()[,input$var1_mosaic],data()[,input$var2_mosaic],data()[,input$var3_mosaic])
      to_plot$plot <- mosaicplot(df1,main="Mosaic Plot",shade=T)
    # } else if (input$types == "treemap") {
    #   df1 <- data.frame(index = data()[,input$x_tree], vSize = data()[,input$y_tree])
    #   df2 <- df1 %>% group_by(index) %>% summarise(vSize = mean(vSize))
    #   df2 <- as.data.frame(df2)
    #   to_plot$plot <- treemap(df2,index="index",vSize="vSize",type="index",main="Treemap")
    } else if (input$types == "heat") {
      to_plot$plot <- heatmap(data.mat,scale="column",main="Heatmap")
    } else if (input$types == "stick") {
      to_plot$plot <- symbol(data(),type="stick",labels=1,main="Stick Figures")
    } else {
      print("Error: No plot selected")
    }

    to_plot$plot

  })
}
