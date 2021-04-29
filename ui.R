library(shinythemes)

ui <- navbarPage(
  theme = shinytheme("flatly"),
  title = "Multivariate Data Visualization Guide",
  
  ### TAB 1: Displays all plots with example and mouse-over description
  tabPanel("Example",
           
           # Output: render the image of plot examples
           mainPanel(tags$img(src = "tab1example.png", height = 700, width = 1400))
           ),
  
  ### TAB 2: Uploading data files (maybe able to select certain variables)
  tabPanel("Data file",
           
           # Side panel for inputs ---
           sidebarPanel(
             
             # Input: Upload files
             fileInput("file1", "Upload CSV File", multiple = F, 
                       accept = c("text/csv",
                                  "text/comma-separated-values,text/plain",
                                  ".csv")),
             
             # Input: Check if folder has header
             checkboxInput("header", "Header", TRUE),
             
             # Input: Select separator
             radioButtons("sep", "Separator",
                          choices = c(Comma = ",",
                                      Semicolon = ";",
                                      Tab = "\t"),
                          selected = ",")

        ),
        
        # Main panel for output display ---
        mainPanel(
          
          # Output: Data file
          tableOutput("contents")
          
        )
  ),
  
  ### TAB 3: Plot graphs using uploaded data files
  tabPanel("Visualization",
           sidebarPanel(
             
             # Input: Select types of plot
             radioButtons("types", "Types of plot: ",
                          c("Scatterplot Matrix"="scatmat",
                            "Andrew's Curve" = "andrew",
                            "Color Icon" = "color",
                            "Boxplot" = "box",
                            "Violin" = "violin",
                            "Mosaic" = "mosaic",
                            # "Treemap" = "treemap",
                            "Heatmap" = "heat",
                            "Stick figures" = "stick")),
             
             # Different inputs for different types of plot
             tabsetPanel(
               id = "var",
               type="hidden",
               tabPanel("scatmat",
                        checkboxGroupInput("var_scatmat",label="Select variables to plot",choices=NULL,selected=NULL)),
               tabPanel("andrew",),
               tabPanel("color",),
               tabPanel("box",
                        checkboxGroupInput("var_box",label="Select variables to plot",choices=NULL,selected=NULL)),
               tabPanel("violin",
                        selectInput("x_violin",label="X axis:",choices=NULL,selected=NULL),
                        selectInput("y_violin",label="Y axis:",choices=NULL,selected=NULL),
                        selectInput("group_violin",label="Grouping variable:",choices=NULL,selected=NULL)),
               tabPanel("mosaic",
                        selectInput("var1_mosaic", label="Variable1:", choices=NULL),
                        selectInput("var2_mosaic", label="Variable2:", choices=NULL),
                        selectInput("var3_mosaic", label="Variable3:", choices=NULL)),
               # tabPanel("treemap",
               #          selectInput("x_tree",label="X axis:",choices=NULL,selected=NULL),
               #          selectInput("y_tree",label="Y axis:",choices=NULL,selected=NULL)),
               tabPanel("heat",),
               tabPanel("stick",)
             )
             
           ),
           
           mainPanel(
             plotOutput("plot1", height = 700)
           )
    )
)
