library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%
  filter(abs(total_price - mean(total_price)) / sd(total_price) <= 3)
