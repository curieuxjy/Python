import pandas as pd
import numpy as np
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
customer_tb['sex_and_age'] = pd.Categorical(
  # 연결할 열을 추출
  customer_tb[['sex', 'age']]

    # lambda 함수에서 sex와 10살 단위로 구분한 age 사이에 _를 추가하여 연결
    .apply(lambda x: '{}_{}'.format(x[0], np.floor(x[1] / 10) * 10),
           axis=1)
)
