library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# scale함수로 파라미터의 열 값을 정규화
# center 파라미터를 TRUE로 하면 변환결과의 평균값이 0이 된다.
# scale 파라미터를 TRUE로 하면 변환결과의 분산값이 1이 된다.
reserve_tb %>%
  mutate(
    people_num_normalized=scale(people_num, center=TRUE, scale=TRUE),
    total_price_normalized=scale(total_price, center=TRUE, scale=TRUE)
  )
