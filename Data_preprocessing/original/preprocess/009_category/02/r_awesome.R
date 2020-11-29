library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 아래 부터 책에 게재
# dummyVars 함수를 이용하기 위한 라이브러리
library(caret)

# 더미 변수로 만들 변수를 파라미터에 지정
# fullRank를 FALSE로 하면 모든 카테고리 값을 플래그로 만든다.
dummy_model <- dummyVars(~sex, data=customer_tb, fullRank=FALSE)

# predict로 더미 변수를 생성
dummy_vars <- predict(dummy_model, customer_tb)
