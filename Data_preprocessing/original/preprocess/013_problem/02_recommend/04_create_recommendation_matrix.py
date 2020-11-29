import pandas as pd
# 아래 부터 책에 게재
import psycopg2
import os
from scipy.sparse import csr_matrix

# psycopg2를 이용하여 Redshift에 연결
con = psycopg2.connect(host='IP주소 또는 호스트 명',
                       port=접속 포트 번호,
                       dbname='DB이름',
                       user='접속 유저 이름',
                       password='접속 패스워드')

# 고객 카테고리 마스터를 Redshift에서 구함
# 추천 계산후에 인덱스 번호에서 ID로 변환하기 위해 이용
customer_category_mst = \
  pd.read_sql('SELECT * FROM work.customer_category_mst', con)

# 호텔 카테고리 마스터를 Redshift에서 구함
# 추천 계산후에 인덱스 번호에서 ID로 변환하기 위해 이용
hotel_category_mst = \
  pd.read_sql('SELECT * FROM work.hotel_category_mst', con)

# SQL문을 파일에서 읽어 들임
sql_path = os.path.dirname(__file__)+"/03_select_recommendation_data.sql"
with open(sql_path) as f:
  sql = f.read()

# 고객, 호텔의 2016년 숙박 예약수를 세로 데이터로 Redshift에서 구함
matrix_data = pd.read_sql(sql, con)

# csc_matrix를 이용하여 희소행렬을 작성
recommend_matrix = csr_matrix(
  (matrix_data['rsv_cnt'],
   (matrix_data['customer_category_no'], matrix_data['hotel_category_no'])),
  shape=(customer_category_mst.shape[0], hotel_category_mst.shape[0])
)
