library(dplyr)

withr::with_options(list(timeout = 10000), {
  if (!file.exists("data-raw/electricity.txt.zip"))
    download.file(
      "https://archive.ics.uci.edu/ml/machine-learning-databases/00321/LD2011_2014.txt.zip",
      "data-raw/electricity.txt.zip"
    )
})

df <- readr::read_csv2("data-raw/electricity.txt.zip")

electricity_hourly <- df %>%
  rename(date = `...1`) %>%
  mutate(date_hour = lubridate::floor_date(date, "hour")) %>%
  group_by(date_hour) %>%
  summarise(across(starts_with("MT_"), mean)) %>%
  tidyr::pivot_longer(
    cols = starts_with("MT_"),
    names_to = "client",
    values_to = "consumption"
  ) %>%
  filter(consumption != 0) %>%
  tsibble::tsibble(key = client, index = date_hour) %>%
  tsibble::group_by_key() %>%
  tsibble::fill_gaps(
    consumption = 0
  ) %>%
  ungroup() %>%
  as_tibble()

usethis::use_data(electricity_hourly, overwrite = TRUE)
