library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
library(lubridate)

# reserve_datetime을 POSIXct형으로 변환
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# checkin_datetime을 POSIXct형으로 변환
reserve_tb$checkin_datetime <-
  as.POSIXct(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
             format='%Y-%m-%d %H:%M:%S')

# 년도의 차이를 계산(월 이하의 일시 요소는 고려하지 않음)
year(reserve_tb$checkin_datetime) - year(reserve_tb$reserve_datetime)

# 월의 차이를 계산(일 이하의 일시 요소는 고려하지 않음)
(year(reserve_tb$checkin_datetime) * 12
 + month(reserve_tb$checkin_datetime)) -
(year(reserve_tb$reserve_datetime) * 12
 + month(reserve_tb$reserve_datetime))

# 일 단위로 차이를 계산
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='days')

# 시간 단위로 차이를 계산
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='hours')

# 분단위로 차이를 계산
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='mins')

# 초단위로 차이를 계산
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='secs')
