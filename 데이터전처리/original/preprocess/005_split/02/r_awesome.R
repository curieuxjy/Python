library(dplyr)
source('preprocess/load_data/data_loader.R')
load_monthly_index()

# 아래 부터 책에 게재
# createTimeSlices를 위한 라이브러리
library(caret)

# 난수 시드 설정
set.seed(71)

# 연 월을 기준으로 데이터 정렬
target_data <- monthly_index_tb %>% arrange(year_month) %>% as.data.frame()

# createTimeSlices 함수로 학습 데이터와 검증 데이터로 분할한 데이터의 행 번호를 구함
# initialWindow에 학습 데이터 수를 설정
# horizon에 검증 데이터 수를 설정
# skip에 이동할 데이터 수 -1 을 설정
# fixedWindow를 T에 지정하면 학습 데이터 를 늘리지 않고 이동
timeSlice <-
  createTimeSlices(1:nrow(target_data), initialWindow=24, horizon=12,
                   skip=(12 - 1), fixedWindow=TRUE)

# 데이터를 분할한 수 만큼 for 문으로 반복
for(slice_no in 1:length(timeSlice$train)){

  # 행 번호를 지정하여 원본 데이터에서 학습 데이터를 구함
  train <- target_data[timeSlice$train[[slice_no]], ]

  # 행 번호를 지정하여 원본 데이터에서 검증 데이터를 구함
  test <- target_data[timeSlice$test[[slice_no]], ]

  # train을 학습 데이터로, test를 검증 데이터로 하여 기계학습 모델을 구축, 검증
}

# 교차 검증의 결과 정리
