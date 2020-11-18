import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 아래 부터 책에 게재
# replace 함수로 None을 nan로 변환
production_miss_num.replace('None', np.nan, inplace=True)

# fillna 함수로 thickness의 결손값을 1로 보완
production_miss_num['thickness'].fillna(1, inplace=True)
