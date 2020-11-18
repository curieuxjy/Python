library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production_missing_category()

# 아래 부터 책에 게재
# knn 함수를 이용하기 위한 라이브러리 
library(class)

# type을 factor로 변환
production_missc_tb$type <- factor(production_missc_tb$type)

# 결손이 발생하지 않은 데이터 추출
train <- production_missc_tb %>% filter(type != '')

# 결손이 발생한 데이터 추출
test <- production_missc_tb %>% filter(type == '')

# knn으로 type 값을 보완
# k는 knn의 파라미터 prob를 FALSE로 하여 출력 을 보완값으로 설정
test$type <- knn(train=train %>% select(length, thickness),
                 test=test %>% select(length, thickness),
                 cl=factor(train$type), k=3, prob=FALSE)
