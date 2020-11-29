import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve, load_holiday_mst
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()
holiday_mst = load_holiday_mst()

# 아래 부터 책에 게재
# 휴일 마스터와 결합
pd.merge(reserve_tb, holiday_mst,
         left_on='checkin_date', right_on='target_day')
