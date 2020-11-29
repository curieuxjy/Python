from preprocess.load_data.data_loader import load_hotel_reserve
import numpy as np
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# max/min/mean/median 함수에 total_price를 대상으로 적용
# Python의 람다 식을 agg 함수의 집약 처리에 지정
# 람다 식에는 numpy.percentile을 지정하여 백분위 값을 산출(20%를 지정)
result = reserve_tb \
  .groupby('hotel_id') \
  .agg({'total_price': ['max', 'min', 'mean', 'median',
                        lambda x: np.percentile(x, q=20)]}) \
  .reset_index()
result.columns = ['hotel_id', 'price_max', 'price_min', 'price_mean',
                  'price_median', 'price_20per']
