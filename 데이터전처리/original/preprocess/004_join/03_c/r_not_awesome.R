library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# row_number 함수로 reserve_datetime을 이용하기 위해서 POSIXct 형으로 변환
# ("10장 일시형"에서 자세히 설명)
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

reserve_tb %>%
  group_by(customer_id) %>%
  arrange(reserve_datetime) %>%

  # １〜3 건 이전의 total_price의 합계를 lag 함수로 계산
  # if_else 함수와 rank 함수를 조합하여 계산한 건수를 판별
  # order_by=reserve_datetime을 지정하는것은 미리 정렬이 되어 있기 떄문에 필수 사항은 아니다.
  # 계산된 건수가 0이면, 분모가 0이기 때문에 price_avg가 NAN이 된다.
  mutate(price_avg=
           (  lag(total_price, 1, order_by=reserve_datetime, default=0)
            + lag(total_price, 2, order_by=reserve_datetime, default=0)
            + lag(total_price, 3, order_by=reserve_datetime, default=0))
           / if_else(row_number(reserve_datetime) > 3,
                     3, row_number(reserve_datetime) - 1))
