library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # group_by를 이용하여 customer_id로 데이터를 그룹화
  group_by(customer_id) %>%

  # LAG 함수를 이용하여 2건 전의 total_price를 before_price로 구함
  # LAG 함수로 참조할 그룹의 데이터를 reserve_datetime이 오래된 순서로 정렬
  mutate(before_price=lag(total_price, n=2,
                          order_by=reserve_datetime, default=NA))
