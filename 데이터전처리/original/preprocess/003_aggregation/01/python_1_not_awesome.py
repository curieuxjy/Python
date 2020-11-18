from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# groupby 함수로 reserve_id를 집약 단위로 지정하고 size 함수로 데이터 수를 카운트
# groupby 함수에 의해 행 번호(index)가 흩어지게 되므로
# hotel_id가 집약 단위인 상태에서 reset_index 함수로 새로운 행 이름을 현재의 행 번호로 고친다
rsv_cnt_tb = reserve_tb.groupby('hotel_id').size().reset_index()

# 집약 결과의 열 이름을 설정
rsv_cnt_tb.columns = ['hotel_id', 'rsv_cnt']

# groupby로 hotel_id를 집약 단위로 설정하여,、
# customer_id의 값을 nunique 함수를 이용하여 고객 수를 카운트
cus_cnt_tb = \
  reserve_tb.groupby('hotel_id')['customer_id'].nunique().reset_index()

# 집약 결과의 열 이름을 설정
cus_cnt_tb.columns = ['hotel_id', 'cus_cnt']

# merge 함수로 hotel_id를 결합 키로하여 결합("4장 결합"에서 해설)
pd.merge(rsv_cnt_tb, cus_cnt_tb, on='hotel_id')
