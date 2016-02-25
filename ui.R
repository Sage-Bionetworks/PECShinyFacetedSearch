
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  fluidPage(
    title = 'Faceted Data Search',
    
    tags$head(
      singleton(
        includeScript("www/readCookie.js")
      )
    ),
    
    mainPanel(
      downloadButton('downloadAll', 'Download current table as CSV'),
      tabsetPanel(
        tabPanel("All", 
                 DT::dataTableOutput('all')),
        tabPanel("RNA-Seq", 
                 DT::dataTableOutput('rnaseq')))
    )
  )
)





