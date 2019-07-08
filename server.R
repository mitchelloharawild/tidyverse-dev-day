library(dplyr)
library(purrr)
library(lubridate)
library(tidyr)

if(!file.exists("data/issues.Rda")){
  source("R/data.R")
}

function(session, input, output) {
  observeEvent(input$btn_update, {
    source("R/data.R")
  })
  
  gh_issues <- reactiveFileReader(1000, session, "data/issues.Rda", readr::read_rds)
  
  output$tbl_issues <- DT::renderDT({
    gh_issues() %>% 
      transmute(Repo = sub("https://api.github.com/repos/", "", repository_url), 
                Number = number, Title = title,
                Submitter = factor(map_chr(user, "login")),
                State = factor(state), 
                Type = map(pull_request, ~ if(is.null(.)) "Issue" else "Pull"),
                Created = as_datetime(created_at),
                `Last active` = as_datetime(updated_at)) %>% 
      separate(Repo, c("Organisation", "Package"), sep = "/") %>% 
      mutate(Organisation = factor(Organisation), Package = factor(Package)) %>% 
      DT::datatable(
        filter = "top", 
        options = list(
          autoWidth = TRUE,
          paging = FALSE,
          scrollY = "650px",
          columnDefs = list(
            list(width = '50px', targets = 1),
            list(width = '50px', targets = 2),
            list(width = '30px', targets = 3),
            list(width = '50px', targets = 5),
            list(width = '30px', targets = 6)
          ),
          sDom  = '<"top">lrt<"bottom">ip'
        ),
        selection = "single",
        callback = htmlwidgets::JS("
          table.on('click', 'tr', function() {
            var td = $(this), row = table.row(td.closest('tr'));
            window.open('https://github.com/' + row.data()[1] + '/' + row.data()[2] + '/issues/' + row.data()[3]);
          });"
        ))
  })
}
