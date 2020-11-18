library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 아래 부터 책에 게재
# sample.split을 위한 패키지
library(caTools)

# cvFolds을 위한 패키지 
library(cvTools)

# 난수 시트 설정. 71은 행운을 부른다고 한다.
set.seed(71)

# 홀드 아웃 검증을 위한 데이터 분할
# production_tb$fault_flg, 데이터 행수와 같은 길이의 벡터라면 아무거나 상관 없다.
# test_tf는 학습 데이터엔 FALSE, 검증 데이터엔 TRUE 값을 가지는, 데이터 행수와 같은 길이의 벡터
# SplitRatio는 검증 데이터 비율
test_tf <- sample.split(production_tb$fault_flg, SplitRatio=0.2)

# production_tb에서 홀드 아웃 검증에 사용될 학습 데이터를 추출
train <- production_tb %>% filter(!test_tf)

# production_tb에서 홀드 아웃 검증에 사용될 검증 데이터를 추출
private_test  <- production_tb %>% filter(test_tf)

# 교차 검증을 위한 데이터 분할
cv_no <- cvFolds(nrow(train), K=4)

# cv_no$K로 설정한 교차수 만큼 반복하여 처리(병렬처리 가능)
for(test_k in 1:cv_no$K){

  # production_tb에서 교차 검증에 사용될 학습 데이터 추출
  train_cv <- train %>% slice(cv_no$subsets[cv_no$which!=test_k])

  # production_tb에서 교차 검증에 사용될 검증 데이터 추출
  test_cv <- train %>% slice(cv_no$subsets[cv_no$which==test_k])

  # train_cv를 학습 데이터로, test_cv를 검증 데이터로 하여 기계 학습 모델을 구축, 검증
}

# 교차 검증의 결과 정리

# train을 학습 데이터로, private_test를 검증 데이터로 하여 기계 학습 모델을 구축, 검증
