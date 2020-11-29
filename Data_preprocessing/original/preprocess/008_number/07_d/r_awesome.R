source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 아래 부터 책에 게재
library(mice)

# mice 함수를 이용하기 위해 데이터형을 변환(mice 함수로 모델을 구성하기 위해)
production_missn_tb$type <- as.factor(production_missn_tb$type)

# fault_flg가 문자열이기 때문에 bool 형으로 변환("9장 카테고리형"에서 설명)
production_missn_tb$fault_flg <- production_missn_tb$fault_flg == 'TRUE'

# mice 함수에 pmm을 지정하여 다중대입법을 실행
# m은 획득할 데이터 세트의 수
# maxit은 값을 얻기 전에 시행할 횟수
production_mice <-
  mice(production_missn_tb, m=10, maxit=50, method='pmm', seed=71)

# 아래에 보완된 값이 저정된다
production_mice$imp$thickness
