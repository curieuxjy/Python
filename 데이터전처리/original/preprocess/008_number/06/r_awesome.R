library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 아래 부터 책에 게재
# prcomp 함수로 주성분 분석을 실행(알고리즘은 특이값 분해법)
# scale을 FALSE로 하면, 정규화는 실행하지 않고 주성분 분석을 실행
pca <- prcomp(production_tb %>% select(length, thickness), scale=FALSE)

# summary 함수로 각 차원의 아래의 값을 확인
# Proportion of Variance:기여율
# Cumulative Proportion:누적 기여율
summary(pca)

# 주성분 분석 적용 결과를 x에 저장
pca_values <- pca$x

# predict함수를 이용하여 같은 차원 압축 처리를 실행
pca_newvalues <-
  predict(pca, newdata=production_tb %>% select(length, thickness))
