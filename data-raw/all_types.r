files <- dir("data-raw/types/", full.names = TRUE)
types <- bind_rows(lapply(files, read_csv))

types %>% distinct() %>%
  arrange(Variable)
  select(Variable) %>%
  count(Variable) %>%
  filter(n > 1)
