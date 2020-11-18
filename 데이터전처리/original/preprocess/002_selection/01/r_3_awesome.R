library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# dplyr패키지를 이용하여 %>%로 reserve_tb을 다음 행의 함수로 전달
reserve_tb %>%

  # select함수의 파라미터로 추출할 열 이름을 입력하여 열을 추출
  select(reserve_id, hotel_id, customer_id, reserve_datetime,
         checkin_date, checkin_time, checkout_date) %>%

  # R의 data.frame으로 변환(이후 예제에서는 생략)
  as.data.frame()

