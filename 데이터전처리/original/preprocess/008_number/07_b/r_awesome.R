library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 아래 부터 책에 게재
production_missn_tb %>%

  # replace_na 함수로 thickness가 NULL/NA/NaN 일 때 1로 보완
  replace_na(list(thickness = 1))
