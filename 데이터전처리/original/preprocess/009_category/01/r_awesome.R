library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# sex가 man일 때 TRUE 값을 가지는 불린 형을 추가
# 이 코드는 as.logical 함수가 아니여도 불린형으로 변환된다
customer_tb$sex_is_man <- as.logical(customer_tb$sex == 'man')

# sex를 카테고리 형으로 변환
customer_tb$sex_c <- factor(customer_tb$sex, levels=c('man', 'woman'))

# 수치로 변환하면 인덱스 데이터의 수치 값을 얻을 수 있다
as.numeric(customer_tb$sex_c)

# levels 함수를 사용하면 마스터 데이터에 접근할 수 있다
levels(customer_tb$sex_c)
