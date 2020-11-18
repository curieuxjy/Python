from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# reserve_tb['customer_id'].unique()는 중복을 제거한 customer_id를 반환합니다.
# sample 함수를 이용하기 위해서 pandas.Series(pandas의 리스트 오브젝트)로 변환
# sample 함수로 고객 ID를 샘플링
target = pd.Series(reserve_tb['customer_id'].unique()).sample(frac=0.5)

# isin 함수를 이용하여 customer_id가 샘플링한 고객 ID 중에 존재하면, 해당 행을 추출
reserve_tb[reserve_tb['customer_id'].isin(target)]