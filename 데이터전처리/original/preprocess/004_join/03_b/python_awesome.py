from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# customer_id별로 reserve_datetime으로 데이터 정렬
result = reserve_tb.groupby('customer_id') \
  .apply(lambda x: x.sort_values(by='reserve_datetime', ascending=True)) \
  .reset_index(drop=True)

# 새로운 열로 price_sum을 추가
result['price_sum'] = pd.Series(
    # 필요한 데이터열만 선택
    result.loc[:, ["customer_id", "total_price"]]

    # customer_id별로 total_price의 window3건의 합계값을 계산
    .groupby('customer_id')
    .rolling(center=False, window=3, min_periods=3).sum()

    # group화를 해제하면서 total_price의 열을 구함
    .reset_index(drop=True)
    .loc[:, 'total_price']
)



