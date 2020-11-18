library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# sparseMatrix를 위한 패키지
library(Matrix)

cnt_tb <-
  reserve_tb %>%
    group_by(customer_id, people_num) %>%
    summarise(rsv_cnt=n())

# sparseMatrix의 행/열에 해당하는 열의 값을 카테고리형(factor)으로 변환
# "9장 카테고리형"에서 자세히 설명
cnt_tb$customer_id <- as.factor(cnt_tb$customer_id)
cnt_tb$people_num <- as.factor(cnt_tb$people_num)

# 희소 행렬 생성
# 첫 번째 부터 세번째 파라미터에 가로 데이터의 값을 지정
# 첫 번째 : 행번호, 두 번째: 열 번호, 세 번째 : 지정한 행렬에 해당하는 값을 벡터로 지정
# dims에는 희소 행렬의 크기를 지정(행 / 열의 수를 벡터로 지정)
# （as.numeric(cnt_tb$customer_id)로 인덱스 번호 구함）
# （length(levels(cnt_tb$customer_id))로 customer_id의 유일한 수를 구함）
sparseMatrix(as.numeric(cnt_tb$customer_id), as.numeric(cnt_tb$people_num),
             x=cnt_tb$rsv_cnt,
             dims=c(length(levels(cnt_tb$customer_id)),
                    length(levels(cnt_tb$people_num))))
