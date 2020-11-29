library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# round 함수로 total_price를 1000 단위로 반올림
# table 함수로 금액별 예약 수를 계산
# (벡터의 속성 정보(names)가 계산된 금액, 벡터의 값이 예약 수)
# which.max 함수로 예약수가 최대인 벡터 요소 구함
# names 함수로 예약수가 최대인 벡터 요소의 속성 정보를(names) 구함
names(which.max(table(round(reserve_tb$total_price, -3))))
