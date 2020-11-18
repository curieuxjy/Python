import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# pivot_table 함수로 가로 데이터로의 변환과 집약 처리를 동시에 실행
# aggfunc에 예약 수를 카운트 하기 위한 함수를 지정
pd.pivot_table(reserve_tb, index='customer_id', columns='people_num',
               values='reserve_id',
               aggfunc=lambda x: len(x), fill_value=0)