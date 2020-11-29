from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# customer_id별로 reserve_datetime로 데이터 정렬
result = reserve_tb.groupby('customer_id') \
  .apply(lambda x: x.sort_values(by='reserve_datetime', ascending=True)) \
  .reset_index(drop=True)

# 새로운 열로 price_avg를 추가
result['price_avg'] = pd.Series(
  result
    # customer_id 별로 total_price의 window3건의 평균값을 계산
    # min_periods를 1로 설정하여 1건 이상이면 계산하도록 설정
    .groupby('customer_id')
    ['total_price'].rolling(center=False, window=3, min_periods=1).mean()

    # group화를 해제하면서 customer_id 열을 제거
    .reset_index(drop=True)
)

# customer_id별로 price_avg를 1행 아래로 이동
result['price_avg'] = \
  result.groupby('customer_id')['price_avg'].shift(periods=1)



