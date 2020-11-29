library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%

  # as.Date 함수로 문자열을 날짜 형으로 변환
  # （10장 "10-1 문자열、수치에서 일시형, 날짜형으로 변환"에서 설명)
  # between 함수로 checkin_date의 범위 설정
  filter(between(as.Date(checkin_date),
                 as.Date('2016-10-12'), as.Date('2016-10-13')))
