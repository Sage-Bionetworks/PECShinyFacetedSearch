library(shiny)
library(DT)

shinyServer(function(input, output, session) {
  
  output$all <- DT::renderDataTable({
    DT::datatable(allData, 
                  extensions = c('ColReorder', 'ColVis'),
                  filter = list(position = 'top', clear = FALSE),
                  options = list(pageLength = 15,
                                 dom='C<"clear">Rfrtip',
                                 search = list(regex = TRUE),
                                 autoWidth = TRUE,
                                 columnDefs = list(list(targets=1, visible=FALSE))),
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
  
  
  
  output$downloadData <- downloadHandler(
    filename = function() { paste('output_', 
                                  gsub(":", "", gsub(" ", "_", Sys.time())),
                                  '.csv', sep='')},
    content = function(file) {
      rows <- isolate(input$all_rows_all)
      cat(file=stderr(), paste(rows, collapse=","))
      write.csv(allData[rows, ] %>% select(id, everything(), -synid),
                file,
                row.names = FALSE)
    }
  )
  
  
})
