library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# checkin_date의 조건식에 따라 판정결과의 TRUE/FALSE 벡터값을 얻는다
# 조건식을 &로 연결하여 판정결과가 동시에 TRUE인 경우에만 TRUE가 되는 벡터값을 얻는다
# reserve_tb의 2차원 배열의 1차원 항목에 TRUE/FALSE의 벡터값을 지정하여 조건에 맞는 행을 추출
# reserve_tb의 2차원 배열의 2차원 항목에 빈 값을 설정하여 모든 열을 추출
reserve_tb[reserve_tb$checkin_date >= '2016-10-12' &
           reserve_tb$checkin_date <= '2016-10-13', ]
