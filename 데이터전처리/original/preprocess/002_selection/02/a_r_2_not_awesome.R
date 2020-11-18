library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# which 함수에 조건식을 지정하여 판정 결과가 TRUE가 되는 행 번호 벡터를 얻는다.
# intersect 함수로 두 파라미터에 동시에 출현하는 행번호만 선택한다.
# reserve_tb의 2차원 배열의 1차원 항목에 행번호 벡터를 지정하여 조건을 만족하는 행을 추출한다.
reserve_tb[
  intersect(which(reserve_tb$checkin_date >= '2016-10-12'),
            which(reserve_tb$checkin_date <= '2016-10-13')), ]
