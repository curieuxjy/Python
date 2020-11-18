library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # group_by에 hotel_id와 people_num의 조합을 지정
  group_by(hotel_id, people_num) %>%

  # sum 함수를 total_price에 적용하여 매출 합계를 산출
  summarise(price_sum=sum(total_price))
