library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# row_number함수로 정렬하기 위해서 데이터 형을 문자열에서 POSIXct형으로 변환
# （제 10장 일시형에서 설명）
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

reserve_tb %>%

  # group_by 함수를 사용하여 집약 단위를 지정
  group_by(customer_id) %>%

  # mutate 함수로 log_no라는 열을 새롭게 추가
  # row_number 함수로 예약 시간을 기준으로 순위를 계산
  mutate(log_no=row_number(reserve_datetime))
