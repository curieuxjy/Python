library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # hotel_id를 집약 단위로 지정하여 호텔별 예약수를 계산
  group_by(hotel_id) %>%

  # 데아터 건수를 계산하여 호텔별 예약 횟수를 계산
  summarise(rsv_cnt=n()) %>%

  # 예약 횟수를 기준우로 순위를 계산, desc로 내림차순으로 정렬
  # transmute 함수로 rsv_cnt_rank를 생성하여,
  # 필요한 hotel_id와 rsv_cnt_rank만을 추출
  transmute(hotel_id, rsv_cnt_rank=min_rank(desc(rsv_cnt)))
