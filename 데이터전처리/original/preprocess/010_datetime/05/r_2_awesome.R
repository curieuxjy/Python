library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_datetime을 POSIXlt형으로 변환
reserve_tb$reserve_datetime_lt <-
  as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# 월의 숫자를 계절로 변환하는 함수
to_season <-function(month_num){
  case_when(
    month_num >= 3 & month_num < 6  ~ 'spring',
    month_num >= 6 & month_num < 9  ~ 'summer',
    month_num >= 9 & month_num < 12 ~ 'autumn',
    TRUE                            ~ 'winter'
  )
}

# 계절로 변환
reserve_tb$reserve_datetime_season <-
  sapply(reserve_tb$reserve_datetime_lt$mon, to_season)

# 카테고리형으로 변환
reserve_tb$reserve_datetime_season <-
  factor(reserve_tb$reserve_datetime_season,
         levels=c('spring', 'summer', 'autumn', 'winter'))
