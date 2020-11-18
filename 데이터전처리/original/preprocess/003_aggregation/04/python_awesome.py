from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# total_price를 var 함수와 std 함수에 적용하여 분산값과 표준편차를 계산
result = reserve_tb \
  .groupby('hotel_id') \
  .agg({'total_price': ['var', 'std']}).reset_index()
result.columns = ['hotel_id', 'price_var', 'price_std']

# 데이터가 1건이면, 분산값과 표준 편차 값이 na가 되므로 0으로 변환
result.fillna(0, inplace=True)
