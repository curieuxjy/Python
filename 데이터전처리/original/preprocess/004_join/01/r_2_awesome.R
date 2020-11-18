library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
inner_join(reserve_tb %>% filter(people_num == 1),
           hotel_tb %>% filter(is_business),
           by='hotel_id')
