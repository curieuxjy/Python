library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
library(tidyverse)

# 계산 대상의 연월 데이터 프레임 작성
month_mst <- data.frame(year_month=
  # 2017-01-01、2017-02-01, 2017-03-01을 생성하여 format 함수로 형식을 연월로 변환
  # (날짜 데이터 형에 대해서는 "10장 일시형"에서 자세히 설명)
  format(seq(as.Date('2017-01-01'), as.Date('2017-03-01'), by='months'),
         format='%Y%m')
)

# 고객 ID와 계산 대상의 모든 연월이 결합된 테이블
customer_mst <-

  # 모든 고객의 ID와 연월 마스터를 상호 결합
  merge(customer_tb %>% select(customer_id), month_mst) %>%

  # merge로 지정한 결합 키의 데이터 형이 카테고리 형이기 떄문에 문자열로 변환
  # (커테고리 형에 대해서는 "9장 카테고리형"에서 자세히 설명)
  mutate(customer_id=as.character(customer_id),
         year_month=as.character(year_month))

# 합계 이용 금액을 월별로 계산
left_join(
  customer_mst,

  # 예약 테이블에 연월 결합 키를 준비
  reserve_tb %>%
    mutate(checkin_month = format(as.Date(checkin_date), format='%Y%m')),

  # 같은 customer_id와 연월을 결합
  by=c('customer_id'='customer_id', 'year_month'='checkin_month')
) %>%

  # customer_id와 연월로 집약
  group_by(customer_id, year_month) %>%

  # 합계 금액을 계산
  summarise(price_sum=sum(total_price)) %>%

  # 예약 레코드가 없을 때 합계 금액을 값이 없음에서 0으로 변환
  replace_na(list(price_sum=0))
