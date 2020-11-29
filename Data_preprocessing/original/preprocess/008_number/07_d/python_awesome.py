import pandas as pd
import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 아래 부터 책에 게재
from fancyimpute import MICE
# replace 함수로 None을 nan으로 변환
production_miss_num.replace('None', np.nan, inplace=True)

# mice 함수를 이용하기 위해 데이터형을 변환(mice 함수로 모델을 구성하기 위해)
production_miss_num['thickness'] = \
  production_miss_num['thickness'].astype('float64')
production_miss_num['type'] = \
  production_miss_num['type'].astype('category')
production_miss_num['fault_flg'] = \
  production_miss_num['fault_flg'].astype('category')

# 더미 변수화 ("9장 카테고리형"에서 설명)
production_dummy_flg = pd.get_dummies(
  production_miss_num[['type', 'fault_flg']], drop_first=True)

# mice함수에 PMM을 지정하여 다중대입법을 실행
# n_imputations는 획득할 데이터 세트의 수
# n_burn_in는 값을 얻기 전에 시행할 횟수 
mice = MICE(n_imputations=10, n_burn_in=50, impute_type='pmm')

# 처리 할 때 TensorFlow를 이용
production_mice = mice.multiple_imputations(
  # 수치의 열과 더미 변수를 연결
  pd.concat([production_miss_num[['length', 'thickness']],
             production_dummy_flg], axis=1)
)

# 아래에 보완된 값이 저장된다
production_mice[0]
