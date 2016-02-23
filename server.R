library(shiny)
library(DT)

shinyServer(function(input, output, session) {
  session$sendCustomMessage(type="readCookie",
                            message=list(name='org.sagebionetworks.security.user.login.token'))
  
  foo <- observeEvent(input$cookie, {
    
    synapseLogin(sessionToken=input$cookie)
    
    withProgress(message='Loading data...',
                 {source("load.R")})
    
    output$all <- DT::renderDataTable({
      DT::datatable(allData, 
                    extensions = c('ColReorder', 'ColVis'),
                    filter = list(position = 'top', clear = FALSE),
                    options = list(pageLength = 15,
                                   dom='C<"clear">Rfrtip',
                                   search = list(regex = TRUE),
                                   autoWidth = TRUE),
                    escape=1)
    })
    
    output$downloadData <- downloadHandler(
      filename = function() { paste('output_', 
                                    gsub(":", "", gsub(" ", "_", Sys.time())),
                                    '.csv', sep='')},
      content = function(file) {
        write.csv(allData[input$all_rows_selected, ], 
                  file,
                  row.names = FALSE)
      }
    )
    
    
  })
  
})