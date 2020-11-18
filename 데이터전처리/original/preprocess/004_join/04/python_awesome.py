from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# 날짜형을 위한 라이브러리
import datetime
# 날짜를 계산하기위한 라이브러리
from dateutil.relativedelta import relativedelta

# 연월 마스터 테이블 생성
month_mst = pd.DataFrame({
  'year_month':
    # relativedelta로 2017-01-01을 x월간 보낸다. x에는 0,1,2를 대입
    # 2017-01-01, 2017-02-01, 2017-03-01의 리스트 생성
    [(datetime.date(2017, 1, 1) + relativedelta(months=x)).strftime("%Y%m")
     for x in range(0, 3)]
})

# cross join을 위해 모두 같은 값을 가지는 결합키를 준비
customer_tb['join_key'] = 0
month_mst['join_key'] = 0

# customer_tb와 month_mst를 준비한 결합키로 내부 결합하여 상호 결합을 구현
customer_mst = pd.merge(
  customer_tb[['customer_id', 'join_key']], month_mst, on='join_key'
)

# 예약 테이블에/로? 연월의 결합키를 준비
reserve_tb['year_month'] = reserve_tb['checkin_date'] \
  .apply(lambda x: pd.to_datetime(x, format='%Y-%m-%d').strftime("%Y%m"))

# 예약 레코드와 결합하여 이용 금액 합계를 계산
summary_result = pd.merge(
  customer_mst,
  reserve_tb[['customer_id', 'year_month', 'total_price']],
  on=['customer_id', 'year_month'], how='left'
).groupby(['customer_id', 'year_month'])["total_price"] \
 .sum().reset_index()

# 예약 레코드가 없을 때 합계 금액을 값이 없음에서 0으로 변환
summary_result.fillna(0, inplace=True)
