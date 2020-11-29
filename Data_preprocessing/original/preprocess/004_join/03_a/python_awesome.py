from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# customer별로 reserve_datetime으로 정렬
# groupby 함수 뒤에 apply 함수를 적용하여 group별로 정렬
# sort_values 함수로 데이터를 정렬, axis가 0이면 행을, 1이면 열을 정렬
result = reserve_tb \
  .groupby('customer_id') \
  .apply(lambda group:
         group.sort_values(by='reserve_datetime', axis=0, inplace=False))

# result는 이미 customer_id 별로 그룹화 되어 있다
# customer별로 2건 이전의 total_price를 efore_price로 저장
# shift 함수는 periods의 파라미터의 수 만큼 데이터를 밑으로 옮기는 함수
result['before_price'] = \
    pd.Series(result['total_price'].shift(periods=2))
  
