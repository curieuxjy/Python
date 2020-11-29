import numpy as np
from preprocess.load_data.data_loader import load_production_missing_num
production_miss_num = load_production_missing_num()

# 아래 부터 책에 게재
# replace함수로 None을 nan으로 변환
# （None을 지정할 때는 문자열로 지정해야한다.)
production_miss_num.replace('None', np.nan, inplace=True)

# dropna 함수로 thickness에 nan이 포함된 레코드를 제거
production_miss_num.dropna(subset=['thickness'], inplace=True)
