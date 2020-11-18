library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
reserve_tb %>%
  group_by(hotel_id) %>%

  # quantile 함수에 total_price와 대상 값을 지정하여 20% 백분위 값을 산출
  summarise(price_max=max(total_price),
            price_min=min(total_price),
            price_avg=mean(total_price),
            price_median=median(total_price),
            price_20per=quantile(total_price, 0.2))
