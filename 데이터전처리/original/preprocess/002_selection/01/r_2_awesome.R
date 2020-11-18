library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb의 2차원 배열의 2차원 항목에 문자 벡터로 추출할 열의 이름을 지정
reserve_tb[, c('reserve_id', 'hotel_id', 'customer_id', 'reserve_datetime',
               'checkin_date', 'checkin_time', 'checkout_date')]
