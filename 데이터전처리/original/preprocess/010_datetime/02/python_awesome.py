import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_datetime을 datetime64[ns]형으로 변환
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# 년도를 얻음
reserve_tb['reserve_datetime'].dt.year

# 월을 얻음
reserve_tb['reserve_datetime'].dt.month

# 일을 얻음
reserve_tb['reserve_datetime'].dt.day

# 요일（0=일요일、1＝월요일）을 수치로얻음
reserve_tb['reserve_datetime'].dt.dayofweek

# 시각 정보의 시를 얻음
reserve_tb['reserve_datetime'].dt.hour

# 시각 정보의 분을 얻음
reserve_tb['reserve_datetime'].dt.minute

# 시각 정보의 초를 얻음
reserve_tb['reserve_datetime'].dt.second

# 지정한 포맷의 문자열로 변환
reserve_tb['reserve_datetime'].dt.strftime('%Y-%m-%d %H:%M:%S')