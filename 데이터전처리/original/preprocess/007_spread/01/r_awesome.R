library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# 가로 데이터로 변환 했을 때 열 이름을 구할 수 있도록 카테고리 형(factor)으로 변경
# 카테고리 형에 대해서는 "9장 카테고리 형"에서 자세히 설명
reserve_tb$people_num <- as.factor(reserve_tb$people_num)

reserve_tb %>%
  group_by(customer_id, people_num) %>%
  summarise(rsv_cnt=n()) %>%

  # spread 함수로 가로 데이터로 변환
  # fill에 값을 없을 때 채울 값을 설정
  spread(people_num, rsv_cnt, fill=0)
