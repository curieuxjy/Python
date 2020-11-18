source('preprocess/load_data/data_loader.R')
load_production()

# 아래 부터 책에 게재
library(tidyverse)


# ubBalance를 위한 라이브러리
library(unbalanced)
library(tidyverse)

# percOver의 설정값 계산
t_num <- production_tb %>% filter(fault_flg==T) %>% summarize(t_num=n())
f_num <- production_tb %>% filter(fault_flg==F) %>% summarize(f_num=n())
percOver <- round(f_num / t_num) * 100 - 100

# 불균형을 고칠 대상을 factor 형으로 변환(logical형이 아닌것에 주의)
# （"9장 9-1 카테고리 형"의 예제에서 설명）
production_tb$fault_flg <- as.factor(production_tb$fault_flg)

# ubBalance 함수로 오버 샘플링을 구현
# type에 ubSMOTE를 설정
# positive에는 적은 쪽의 값을 지정(지정하지 않을 수도 있지만 경고가 표시된다)
# percOver는 원본 데이터에서 몇 %늘릴지를 설정
# （200이면 3(200/100+1)배、500이면 6(500/100+1)배가 돤다. 100미만의 값은 버림으로 처리된다)
# percUnder는 언더 샘플링을 실행할 때 필요하지만 실행하지 않을 경우엔 0을 설정
# k는 smote의 k파라미터
production_balance <-
  ubBalance(production_tb[,c('length', 'thickness')],
            production_tb$fault_flg,
            type='ubSMOTE', positive='TRUE',
            percOver=percOver, percUnder=0, k=5)

# 생성한 fault_flg가 TRUE인 데이터와 원본의 fault_flg가 FALSE인 데이터를 합친다
bind_rows(

  # production_balance$X에 생성한 length와 thickness의 data.frame이 저장된다
  production_balance$X %>%

    # production_balance$Y에 생성한 fault_flg의 벡터가 저장된다
    mutate(fault_flg=production_balance$Y),

  # 원본의 fault_flg가 False인 데이터 구함
  production_tb %>%

    # factor형이기 때문에 일치 여부를 만족하는 값을 구함
    filter(fault_flg == 'FALSE') %>%
    select(length, thickness, fault_flg)
)
