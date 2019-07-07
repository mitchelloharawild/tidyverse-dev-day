library(shiny)
library(shinydashboard)

dashboardPage(
  title = "tidyverse developer day",
  skin  = "blue",
  dashboardHeader(
    title = "Developer day"
  ),

  # Dashboard Sidebar -------------------------------------------------------
  dashboardSidebar(
    img(src="https://www.tidyverse.org/images/tidyverse-default.png", width = "100%"),
    sidebarMenu(
      menuItem("Issue tracker", tabName = "tab_issues", icon = icon("search")),
      tags$li(
        actionLink("btn_update",
                   style = "margin: 0;",
                   label = NULL,
                   class = "",
                   icon("refresh"),
                   span("Update data")
        )
      )
    )
  ),

  dashboardBody(
    includeCSS("www/tdd.css"),
    tabItems(

      tabItem(
        "tab_issues",
        fluidRow(
          box(
            width = 12,
            withSpinner(DT::DTOutput("tbl_issues"))
          )
          
        )
      )
    )
  )
)


