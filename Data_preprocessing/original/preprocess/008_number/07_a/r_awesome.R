library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 아래 부터 책에 게재
# drop_na 함수로 thickness 가 NULL/NA/NaN인 레코드를 제거
production_missn_tb %>% drop_na(thickness)

# 모든 열중에서 하나라도 NULL, NA, NaN을 가지는 모든 레코드를 제거
# na.omit(production_missn_tb)
