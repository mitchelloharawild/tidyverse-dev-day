library(shiny)
library(shinydashboard)

dashboardPage(
  title = "tidyverse-dev-day",
  skin  = "blue",
  dashboardHeader(
    title = "tidyverse-dev-day"
  ),

  # Dashboard Sidebar -------------------------------------------------------
  dashboardSidebar(
    sidebarMenu(
      menuItem("Issues", tabName = "tab_issues", icon = icon("dashboard"))
    )
  ),

  dashboardBody(
    tabItems(

      tabItem(
        "tab_issues",
        fluidRow(
          box(
            width = 12,
            title = "Issues",
            withSpinner(DT::DTOutput("tbl_issues"))
          )
          
        )
      )
    )
  )
)


