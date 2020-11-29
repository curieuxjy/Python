library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # select함수의 파라미터로 추출할 열 이름을 입력하여 열을 추출
  # starts_with 함수를 하용하여 접두사에 check가 붙은 열을 추출
  select(reserve_id, hotel_id, customer_id, reserve_datetime,
         starts_with('check'))
