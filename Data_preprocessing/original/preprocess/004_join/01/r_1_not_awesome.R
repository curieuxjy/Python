library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_table과 hotel_tb의 hotel_id가 같은 데이터를 내부 결합
inner_join(reserve_tb, hotel_tb, by='hotel_id') %>%
  
  # people_num가 1이고 is_business가 True인 데이터만 추출
  filter(people_num == 1, is_business)
