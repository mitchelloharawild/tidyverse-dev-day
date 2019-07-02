library(httr)
library(tidyverse)
issues <- gh::gh("GET /search/issues", q = 'label:"tidy-dev-day :nerd_face:"',
                 per_page = 100)

if(length(issues$items) < issues$total_count){
  issues$items <- flatten(
    c(
      list(issues$items),
      map(seq_len(ceiling(issues$total_count/100-1)) + 1,
          ~ gh::gh("GET /search/issues", q = 'label:"tidy-dev-day :nerd_face:"', 
                   page = ., per_page = 100)$items
      )
    )
  )
}

issues <- map_dfr(issues$items, function(issue){
  as_tibble(map(issue, function(param){
    if(is.null(param) || length(param) == 0) NA else if(length(param) > 1) list(param) else param
  }))
})

readr::write_rds(issues, "data/issues.Rda")


# gh::gh("GET /repos/tidyverse/tidyr/issues/665/comments")
