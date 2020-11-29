library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()
load_holiday_mst()

# 아래 부터 책에 게재
# 휴일 마스터와 결함
inner_join(reserve_tb, holiday_mst, by=c('checkin_date'='target_day'))
