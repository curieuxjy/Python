library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 아래 부터 책에 게재
# 결손값을 제거하고 thickness의 평균값을 계산
# na.rm을 TRUE로 하여 NA를 제외한 집약 값을 계산 할 수 있다
thickness_mean <- mean(production_missn_tb$thickness, na.rm=TRUE)

# replace_na 함수를 이용하여 결손값을 제외한 thickness의 평균값으로 보완
production_missn_tb %>% replace_na(list(thickness = thickness_mean))
