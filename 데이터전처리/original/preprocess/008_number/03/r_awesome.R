library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
customer_tb %>%
  mutate(age_rank=as.factor(floor(age / 10) * 10))
