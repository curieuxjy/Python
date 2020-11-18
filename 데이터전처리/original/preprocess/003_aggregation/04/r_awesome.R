library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%
  group_by(hotel_id) %>%

  # var 함수에 total_price를 지정하여 분산 값을 계산
  # sd 함수에 total_price를 지정하여 표준 편차 값을 계산
  # 데아터 수가 1건 이면 NA 이므로 
  # coalesce 함수를 이용하여 NA이면 0으로 치환
  summarise(price_var=coalesce(var(total_price), 0),
            price_std=coalesce(sd(total_price), 0))
