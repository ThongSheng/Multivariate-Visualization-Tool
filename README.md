# Multivariate-Visualization-Tool
An R shiny app that is developed to help users visualize their custom multivariate dataset.

This shiny app is partitioned into three different tabs. <br>
- First tab (Summary)
  - renders an image that summarizes what purposes each multivariate plotting technique serves (e.g. relationship, pattern recognition, comparison etc.).
- Second tab (Data file)
  - allows users to upload the dataset of their interest and renders the data file as output.
- Third tab (Visualization)
  - users select the types of plot they wish to see and the system renders the plot using the dataset that was uploaded in the second tab.


# How To Run
1. Download "tab1example.png".
2. In your R working directory, open a new folder named "www" and place the "tab1example.png" in it.
3. Download all the files (app.R, server.R, ui.R) and run it on your local Rstudio app.
4. To render the plots, the following packages have to be installed and loaded. These packages should already be included in the shiny code, but in case it doesn't work, following are the packages required:
  - ***ggplot2:*** Violin plot
  - ***andrews:*** Andrew's Curve
  - ***treemap:*** Treemap
  - ***symbols:*** Stick figures
5. Happy plotting!
