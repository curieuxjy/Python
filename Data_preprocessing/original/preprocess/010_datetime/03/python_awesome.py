import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_datetime을 datetime64[ns]형으로 변환
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# checkin_datetime을 datetime64[ns]형으로 변환
reserve_tb['checkin_datetime'] = \
  pd.to_datetime(reserve_tb['checkin_date'] + reserve_tb['checkin_time'],
                 format='%Y-%m-%d%H:%M:%S')

# 년도의 차이를 계산(월 이하의 일시 요소는 고려하지 않음)
reserve_tb['reserve_datetime'].dt.year - \
reserve_tb['checkin_datetime'].dt.year

# 월의 차이를 계산(일 이하의 일시 요소는 고려하지 않음)
(reserve_tb['reserve_datetime'].dt.year * 12 +
 reserve_tb['reserve_datetime'].dt.month) \
 - (reserve_tb['checkin_datetime'].dt.year * 12 +
    reserve_tb['checkin_datetime'].dt.month)

# 일 단위로 차이를 계산
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[D]')

# 시간 단위로 차이를 계산
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[h]')

# 분단위로 차이를 계산
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[m]')

# 초단위로 차이를 계산
(reserve_tb['reserve_datetime'] - reserve_tb['checkin_datetime']) \
  .astype('timedelta64[s]')
