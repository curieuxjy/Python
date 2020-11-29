library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_datetime을 POSIXct형으로 변환
reserve_tb$reserve_datetime_ct <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# 월의 숫자를 계절로 변환하는 함수(mutate 함수안에 직접 작성하는것도 가능)
to_season <- function(month_num){
  case_when(
    month_num >= 3 & month_num < 6  ~ 'spring',
    month_num >= 6 & month_num < 9  ~ 'summer',
    month_num >= 9 & month_num < 12 ~ 'autumn',
    TRUE                            ~ 'winter'
  )
}

# 계절로 변환
reserve_tb <-
  reserve_tb %>%
    mutate(reserve_datetime_season=to_season(month(reserve_datetime_ct)))

# 카테고리 형으로 변환
reserve_tb$reserve_datetime_season <-
  factor(reserve_tb$reserve_datetime_season,
         levels=c('spring', 'summer', 'autumn', 'winter'))
