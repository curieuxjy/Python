from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# 예약 횟수를 계산 ("3-1 데이터의 수 및 종류의 수 계산"의 예제 참고)
rsv_cnt_tb = reserve_tb.groupby('hotel_id').size().reset_index()
rsv_cnt_tb.columns = ['hotel_id', 'rsv_cnt']

# 예약 횟수를 기준으로 순위를 계산
# ascending을 False로 하여 내림 차순으로 지정
# method를 min으로 지정하여, 값이 같은 경우엔 최소 순위를 지정
rsv_cnt_tb['rsv_cnt_rank'] = rsv_cnt_tb['rsv_cnt'] \
  .rank(ascending=False, method='min')

# 불필요한 rsv_cnt열을 제거
rsv_cnt_tb.drop('rsv_cnt', axis=1, inplace=True)
