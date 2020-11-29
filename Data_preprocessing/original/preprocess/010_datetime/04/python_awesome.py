import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# timedelta을 위한 datetime 하이브러리 로드
import datetime

# reserve_datetime을 datetime64[ns]형으로 변환
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# reserve_datetime에서 date를 추출
reserve_tb['reserve_date'] = reserve_tb['reserve_datetime'].dt.date

# reserve_datetime에 1일 더한다
reserve_tb['reserve_datetime'] + datetime.timedelta(days=1)

# reserve_date에 1일 더한다
reserve_tb['reserve_date'] + datetime.timedelta(days=1)

# reserve_datetime에 1시간 더한다
reserve_tb['reserve_datetime'] + datetime.timedelta(hours=1)

# reserve_datetime에 1분 더한다
reserve_tb['reserve_datetime'] + datetime.timedelta(minutes=1)

# reserve_datetime에 1초 더한다
reserve_tb['reserve_datetime'] + datetime.timedelta(seconds=1)