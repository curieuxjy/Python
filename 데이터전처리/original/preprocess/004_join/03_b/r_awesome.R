library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# roll_sum 함수를 이용하기 위한 라이브러리
library(RcppRoll)

reserve_tb %>%

  # 데이터 행을 customer_id 별로 그룹화
  group_by(customer_id) %>%

  # customer_id 별로 reserve_datetime으로 데이터 정렬
  arrange(reserve_datetime) %>%

  # RcppRoll의 roll_sum으로 이동 합계값을 계산
  mutate(price_sum=roll_sum(total_price, n=3, align='right', fill=NA))
