library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb의 2차원 배열의 1차원 항목을 빈 값으로하여 모든 행을 추출
# reserve_tb의 2차원 배열의 2차원 항목에  숫자 벡터값을 지정하여 여러 열을 추출
reserve_tb[, c(1, 2, 3, 4, 5, 6, 7)]
