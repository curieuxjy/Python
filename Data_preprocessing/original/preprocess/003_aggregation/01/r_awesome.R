library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # group_by 함수로 집약 단위를 hotel_id로 지정
  group_by(hotel_id) %>%

  # summarise 함수를 사용하여 집약 처리를 지정
  # n 함수를 사용하여 예약 수를 카운트
  # n_distinct 함수에 customer_id를 지정하여 customer_id의 유니크 카운트 세기 
  summarise(rsv_cnt=n(),
            cus_cnt=n_distinct(customer_id))
