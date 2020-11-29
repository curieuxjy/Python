from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb과 hotel_tb의 hotel_id가 같은 데이터를 내부 결합
# people_num가 1이고, is_business가 True인 데이터만 추출
pd.merge(reserve_tb, hotel_tb, on='hotel_id', how='inner') \
  .query('people_num == 1 & is_business')
