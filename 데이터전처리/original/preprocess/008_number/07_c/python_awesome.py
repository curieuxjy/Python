import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 아래 부터 책에 게재
# replace 함수로 None을 nan으로 변환
production_miss_num.replace('None', np.nan, inplace=True)

# thickness를 수치형으로 변환(None이 섞여 있기 때문에 수치형이 아닌 상태이다)
production_miss_num['thickness'] = \
  production_miss_num['thickness'].astype('float64')

# thickness의 평균값을 계산
thickness_mean = production_miss_num['thickness'].mean()

# thickness의 결손 값을 thickness의 평균값으로 보완
production_miss_num['thickness'].fillna(thickness_mean, inplace=True)

