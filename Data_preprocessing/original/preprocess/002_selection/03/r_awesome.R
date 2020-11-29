library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb에서 50% 샘플링
sample_frac(reserve_tb, 0.5)
