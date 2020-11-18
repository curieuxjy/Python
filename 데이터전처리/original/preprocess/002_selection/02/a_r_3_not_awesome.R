library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # filter함수에 checkin_date의 조건을 지정하여 조건을 만족하는 행을 추출
  filter(checkin_date >= '2016-10-12' & checkin_date <= '2016-10-13')
