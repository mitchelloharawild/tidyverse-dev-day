issues <- readr::read_rds("data/issues.Rda")

function(session, input, output) {
  showModal(
    modalDialog(
      title = "Welcome to the tidyverse developer day!",
      easyClose = TRUE,
      footer = modalButton("Get started!")
    )
  )

  # Dashboard Boxes ---------------------------------------------------------
  # observe({
  #   tweets_in_last <- tweets() %>%
  #     tweets_in_last(d = 1)
  # 
  #   if (!nrow(tweets_in_last)) {
  #     updateBoxValue(session, "rate", 0)
  #     return()
  #   }
  # 
  #   rate <-
  #     tweets_in_last %>%
  #     tweets_volume(by = "1 hour") %>%
  #     pull(n) %>%
  #     mean()
  #   updateBoxValue(session, "rate", round(rate, 2))
  # })
  # 
  # observe({
  #   n_topic_tweets <-
  #     tweets_simple() %>%
  #     count() %>%
  #     pull(n) %>%
  #     format(big.mark = ",", digits = 0)
  # 
  #   updateBoxValue(session, "total_topic", n_topic_tweets)
  # })
  # 
  # observe({
  #   n_tweeters_today <-
  #     tweets_simple() %>%
  #     tweets_since(lubridate::today(tz_global())) %>%
  #     distinct(screen_name) %>%
  #     count() %>%
  #     pull(n) %>%
  #     format(big.mark = ",", digits = 0)
  # 
  #   updateBoxValue(session, "tweeters_today", n_tweeters_today)
  # })
  # 
  # observe({
  #   n_favorites <-
  #     tweets() %>%
  #     pull(favorite_count) %>%
  #     sum() %>%
  #     format(big.mark = ",", digits = 0)
  # 
  #   updateBoxValue(session, "total_favorites", n_favorites)
  # })
  # 
  # observe({
  #   n_topic_tweets_today <-
  #     tweets() %>%
  #     tweets_just(created_at) %>%
  #     filter(created_at >= lubridate::today()) %>%
  #     count() %>%
  #     pull(n) %>%
  #     format(big.mark = ",", digits = 0)
  # 
  #   updateBoxValue(session, "total_today", n_topic_tweets_today)
  # })
  # 
  # observe({
  #   n_all_tweets <-
  #     tweets_all() %>%
  #     nrow() %>%
  #     format(big.mark = ",", digits = 0)
  # 
  #   updateBoxValue(session, "total_all", n_all_tweets)
  # })


  # Dashboard Plots ---------------------------------------------------------
  # output$plot_hourly_tweet_volume <- renderPlotly({
  #   tweets_all() %>%
  #     tweets_just(created_at, is_topic) %>%
  #     group_by(is_topic) %>%
  #     tweets_volume() %>%
  #     mutate(topic = if_else(is_topic, "topic", "all")) %>%
  #     ungroup() %>%
  #     rename(Date = by_time) %>%
  #     select(-is_topic) %>%
  #     spread(topic, n, fill = 0) %>%
  #     plot_ly(x = ~ Date) %>%
  #     add_lines(y = ~topic, name = TOPIC$name, color = I(ADMINLTE_COLORS$teal)) %>%
  #     {
  #       if (!is.null(TOPIC$full_community)) {
  #         add_lines(., y = ~all, name = TOPIC$full_community, color = I(ADMINLTE_COLORS$purple))
  #       } else .
  #     }%>%
  #     config(displayModeBar = FALSE) %>%
  #     layout(
  #       xaxis = list(
  #         range = c(now(tz_global()) - days(7), now(tz_global())),
  #         rangeselector = list(
  #           buttons = list(
  #             list(
  #               count = 1,
  #               label = "Today",
  #               step = "day",
  #               stepmode = "todate"),
  #             list(
  #               count = 1,
  #               label = "Yesterday",
  #               step = "day",
  #               stepmode = "backward"),
  #             list(
  #               count = 7,
  #               label = "Week",
  #               step = "day",
  #               stepmode = "backward"),
  #             list(step = "all", label = "All"))),
  #         rangeslider = list(type = "date")),
  #       yaxis = list(title = "Tweets"),
  #       legend = list(orientation = 'h', x = 0.05, y = 0.9),
  #       hovermode = "compare" # thanks: https://stackoverflow.com/a/46733461/2022615
  #     ) %>%
  #     config(collaborate = FALSE, cloud = FALSE, mathjax = NULL)
  # })
  # 

  output$tbl_issues <- DT::renderDT({
    issues %>% 
      transmute(Repo = sub("https://api.github.com/repos/", "", repository_url), 
                Title = title, Submitter = map_chr(user, "login"),
                State = state, Created = as_datetime(created_at)) %>% 
      separate(Repo, c("Organisation", "Package"), sep = "/")
  })
}
