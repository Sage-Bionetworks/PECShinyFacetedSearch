library(shiny)
library(DT)

shinyServer(function(input, output) {
  
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

})
