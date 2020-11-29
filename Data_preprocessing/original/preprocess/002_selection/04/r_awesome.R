library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb에서 고객 ID 벡터를 얻고 중복을 제거한 고객ID 벡터를 작성
all_id <- unique(reserve_tb$customer_id)

reserve_tb %>%

  # sample 함수를 이용하여 고객 ID에서 50% 샘플링하여 추출 대상의 ID를 얻는다.
  # 추출 대상 ID와 일치하는 행을 filter 함수로 추출
  filter(customer_id %in% sample(all_id, size=length(all_id) * 0.5))
