library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
library(lubridate)

# reserve_datetime을 POSIXct형으로 변환
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# reserve_date을 Date형으로 변환
reserve_tb$reserve_date <-
  as.Date(reserve_tb$reserve_datetime, format='%Y-%m-%d')

# reserve_datetime에 1일 더한다
reserve_tb$reserve_datetime + days(1)

# reserve_datetime에 1시간 더한다
reserve_tb$reserve_datetime + hours(1)

# reserve_datetime에 1분 더한다
reserve_tb$reserve_datetime + minutes(1)

# reserve_datetime에 1초 더한다
reserve_tb$reserve_datetime + seconds(1)

# reserve_date에 1일 더한다
reserve_tb$reserve_date + days(1)
