import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# 희소행렬 라이브러리 불러오기
from scipy.sparse import csc_matrix

# 고객 ID / 투숙객 수 별 예약 건수의 표를 생성
cnt_tb = reserve_tb \
  .groupby(['customer_id', 'people_num'])['reserve_id'].size() \
  .reset_index()
cnt_tb.columns = ['customer_id', 'people_num', 'rsv_cnt']

# sparseMatrix의 행/ 열에 해당하는 열의 값을 카테고리 형으로 변환
# 카테고리 형에 대해서는 "9장 카테고리형"에서 자세하ㅣ 설명
customer_id = pd.Categorical(cnt_tb['customer_id'])
people_num = pd.Categorical(cnt_tb['people_num'])

# 희소 행렬 생성
# 첫 번째 파라미터에는 지정한 행렬에 해당하는 값, 행 번호, 열 번호의 배열을 묶으은 튜플을 지정
# shape에는 희소 행렬의 크기를 지정(행 / 열의 수를 튜플로 지정)
# （customer_id.codes로 인덱스 번호를 구함）
# （len(customer_id.categories)로 customer_id의 유일한 수를 구함）
csc_matrix((cnt_tb['rsv_cnt'], (customer_id.codes, people_num.codes)),
           shape=(len(customer_id.categories), len(people_num.categories)))
