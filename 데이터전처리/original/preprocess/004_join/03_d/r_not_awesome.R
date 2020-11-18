library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
library(tidyr)

# row_number 함수로 reserve_datetime을 이용하기 위해서 POSIXct 형으로 변환
# ("10장 일시형"에서 자세히 설명)
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

#  지난 90일간의 예약 금액 합계를 계산한 테이블
sum_table <-

  # reserve_datetime의 날짜를 확인하지 않고 customer_id가 같은 데이터들을 모두 결합
  inner_join(
    reserve_tb %>%
      select(reserve_id, customer_id, reserve_datetime),
    reserve_tb %>%
      select(customer_id, reserve_datetime, total_price) %>%
      rename(reserve_datetime_before=reserve_datetime),
    by='customer_id') %>%

  # checkin의 날짜를 비교하여 90일 이내의 데이터가 결합된 데이터만을 추출
  # 60*60*24*90는 60초*60분*24시간*90일을 의미하고, 90일 분의 초를 계산
  # (날짜 데이터 형식에 대해서는 "10장 일시형"에서 자세히 설명)
  filter(reserve_datetime > reserve_datetime_before &
           reserve_datetime - 60 * 60 * 24 * 90 <= reserve_datetime_before) %>%
  select(reserve_id, total_price) %>%

  # reserve_id 별로 total_price의 합을 계산
  group_by(reserve_id) %>%
  summarise(total_price_90d=sum(total_price)) %>%
  select(reserve_id, total_price_90d)

# 계산된 합을 결합하여 원본 테이불에 정보를 첨부
# 합계 값이 없는 레코드의 합계 값을 replace_na를 이용하여 0으로 변환
left_join(reserve_tb, sum_table, by='reserve_id') %>%
  replace_na(list(total_price_90d=0))
