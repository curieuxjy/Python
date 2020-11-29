library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# lubridate 라이브러리
# (parse_date_time, parse_date_time2, fast_strptime의 라이브러리)
library(lubridate)

# POSIXct형으로 변환
as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
as.POSIXct(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
           format='%Y-%m-%d %H:%M:%S')

# POSIXlt형으로 변환
as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
as.POSIXlt(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
           format='%Y-%m-%d %H:%M:%S')

# parse_date_time 함수로 POSIXct형으로 변환
parse_date_time(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')
parse_date_time(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
                orders='%Y-%m-%d %H:%M:%S')

# parse_date_time2 함수로 POSIXct형으로 변환
parse_date_time2(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')
parse_date_time2(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
                 orders='%Y-%m-%d %H:%M:%S')

# strptime 함수로 POSIXltに変換
strptime(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
strptime(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
         format='%Y-%m-%d %H:%M:%S')

# fast_strptime 함수로 POSIXlt형으로 변환
fast_strptime(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
fast_strptime(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
              format='%Y-%m-%d %H:%M:%S')

# Date형으로 변환
as.Date(reserve_tb$reserve_datetime, format='%Y-%m-%d')
as.Date(reserve_tb$checkin_date, format='%Y-%m-%d')
