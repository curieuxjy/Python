import pandas as pd
import numpy as np
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# pd.Categorical로 category형으로 변환
customer_tb['age_rank'] = \
  pd.Categorical(np.floor(customer_tb['age']/10)*10)

# 마스터 데이터에 '60 이상'을 추가
customer_tb['age_rank'].cat.add_categories(['60 이상'], inplace=True)

# 집약할 데이터 변경하기
# category형은 = 또는 != 만 판정할 수 있기 때문에 isin 함수를 이용
customer_tb.loc[customer_tb['age_rank'] \
           .isin([60.0, 70.0, 80.0]), 'age_rank'] = '60 이상'

# 사용되지 않는 마스터 데이터를 제거
customer_tb['age_rank'].cat.remove_unused_categories(inplace=True)
