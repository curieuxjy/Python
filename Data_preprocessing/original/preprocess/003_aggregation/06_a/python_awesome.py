from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# rank 함수로 정렬하기 위해서 데이터형을 문자열에서 timestamp형으로 변환
# （"제 10장 일시형"에서 설명）
reserve_tb['reserve_datetime'] = pd.to_datetime(
  reserve_tb['reserve_datetime'], format='%Y-%m-%d %H:%M:%S'
)

# log_no를 새로운 열로 추가
# group_by를 이용하여 집약 단위 설정
# 고객 별로 묶은 reserve_datetime을 생성하여 rank 함수로 순위를 계산
# ascending을 True로 하여 오름 차순으로 정렬(False면 내림차순)
reserve_tb['log_no'] = reserve_tb \
  .groupby('customer_id')['reserve_datetime'] \
  .rank(ascending=True, method='first')
