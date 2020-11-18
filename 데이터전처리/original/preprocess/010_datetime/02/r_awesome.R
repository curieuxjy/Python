library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
library(lubridate)

# reserve_datetime을 POSIXct형으로 변환
reserve_tb$reserve_datetime_ct <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# reserve_datetime을 POSIXlt형으로 변환
reserve_tb$reserve_datetime_lt <-
  as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# POSIXct형과 Date형은 함수를 이용하여 특정 일시 요소를 얻는다
# (내부에 일시 요소를 꺼내기 위한 계산을 실행하고 있다)
# POSIXlt형은 직접 특정 일시요소를 꺼낼 수 있다.

# 년도를 얻음
year(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$year

# 월을 얻음
month(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$mon

# 일을 얻음
days_in_month(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$mday

# 요일（0=일요일、1＝월요일）을 수치로얻음
wday(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$wday

# 요일을 문자열로 얻음
weekdays(reserve_tb$reserve_datetime_ct)

# 시각 정보의 시를 얻음
hour(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$hour

# 시각 정보의 분을 얻음
minute(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$min

# 시각 정보의 초를 얻음
second(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$sec

# 지정한 포맷의 문자열로 변환
format(reserve_tb$reserve_datetime_ct, '%Y-%m-%d %H:%M:%S')
