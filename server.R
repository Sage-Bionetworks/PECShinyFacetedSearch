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
                    options = list(pageLength = 10,
                                   dom='C<"clear">Rfrtip',
                                   search = list(regex = TRUE),
                                   autoWidth = TRUE,
                                   columnDefs = list(list(targets=0, visible=FALSE))),
                    escape=1,
                    rownames=FALSE)
    })
    
    output$downloadData <- downloadHandler(
      filename = function() { paste('output_', 
                                    gsub(":", "", gsub(" ", "_", Sys.time())),
                                    '.csv', sep='')},
      content = function(file) {
        write.csv(allData[input$all_rows_all, ] %>% select(id, everything(), -synid),
                  file,
                  row.names = FALSE)
      }
    )
    
    
  })
  
})