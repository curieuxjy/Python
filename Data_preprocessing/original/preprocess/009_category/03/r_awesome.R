library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
customer_tb$age_rank <- factor(floor(customer_tb$age / 10) * 10)

# 마스터 데이터에 '60세 이상'을 추가
levels(customer_tb$age_rank) <- c(levels(customer_tb$age_rank), '60세 이상')

# 집약할 데이터 변경하기
# 카테고리형은 == 또는 != 로만 판별할 수 있다.
# in 함수를 이용하여 차환을 구현
customer_tb[customer_tb$age_rank %in% c('60', '70', '80'), 'age_rank'] <-
  '60세 이상'

# 사용되지 않는 마스터 데이터(60, 70, 80)를 제거
customer_tb$age_rank <- droplevels(customer_tb$age_rank)
