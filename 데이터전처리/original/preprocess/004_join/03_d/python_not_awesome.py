from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
import pandas.tseries.offsets as offsets
import operator

# 시간 계산에 이용하기 위해 데이터형을 문자형에서 일시형으로 변환
# ("10장 일시형"에서 자세히 설명)
reserve_tb['reserve_datetime'] = \
  pd.to_datetime(reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S')

# reserve_datetime의 날짜를 확인하지 않고 customer_id가 같은 데이터들을 모두 결합
sum_table = pd.merge(
	reserve_tb[['reserve_id', 'customer_id', 'reserve_datetime']],
  reserve_tb[['customer_id', 'reserve_datetime', 'total_price']]
            .rename(columns={'reserve_datetime': 'reserve_datetime_before'}),
  on='customer_id')

# checkin의 날짜를 비교하여 90일 이내의 데이터가 결합된 데이터만을 추출
# operator의 and_ 함수를 이용하여 결합 조건을 지정
# reserve_id 별로 total_price의 합을 계산
# (날짜 데이터 형식에 대해서는 "10장 일시형"에서 자세히 설명)
sum_table = sum_table[operator.and_(
  sum_table['reserve_datetime'] > sum_table['reserve_datetime_before'],
  sum_table['reserve_datetime'] + offsets.Day(-90) <= sum_table['reserve_datetime_before']
)].groupby('reserve_id')['total_price'].sum().reset_index()

# 열 이름을 설정
sum_table.columns = ['reserve_id', 'total_price_sum']

# 계산된 합을 결합하여 원본 테이불에 정보를 첨부
# 합계 값이 없는 레코드의 합계 값을 fillna를 이용하여 0으로 변환
pd.merge(reserve_tb, sum_table, on='reserve_id', how='left').fillna(0)
