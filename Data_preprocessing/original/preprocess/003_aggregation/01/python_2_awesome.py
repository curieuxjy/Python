from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# agg 함수를 이용하여 집약 처리를 한꺼번에 지정
# reserve_id를 대상으로 count 함수를 적용
# customer_id를 대상으로 nunique 함수를 적용
result = reserve_tb \
  .groupby('hotel_id') \
  .agg({'reserve_id': 'count', 'customer_id': 'nunique'})

# reset_index 함수로 열 번호를 다시 설정（inplace=True 이기 때문에 직접 result를 갱신）
result.reset_index(inplace=True)
result.columns = ['hotel_id', 'rsv_cnt', 'cus_cnt']
