import pandas as pd
import numpy as np

# 아래 부터 책에 게재
import psycopg2
import os
import random
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold

# psycopg2를 이용하여 Redshift에 연결
con = psycopg2.connect(host='IP주소 또는 호스트 명',
                       port=접속 포트 번호,
                       dbname='DB이름',
                       user='접속 유저 이름',
                       password='접속 패스워드')


# SQL문을 파일로 읽기 
with open(os.path.dirname(__file__)+'/01_select_model_data.sql') as f:
  sql = f.read()

# 모델링을 위한 데이터를 Redshift에서 얻음
rsv_flg_logs = pd.read_sql(sql, con)

# 더미 변수 작성
rsv_flg_logs['is_man'] = \
  pd.get_dummies(rsv_flg_logs['sex'], drop_first=True)

# 수치 상태로 카테고리를 집약하고, 카테고리 형으로 변환
rsv_flg_logs['age_rank'] = np.floor(rsv_flg_logs['age'] / 10) * 10
rsv_flg_logs.loc[rsv_flg_logs['age_rank'] < 20, 'age_rank'] = 10
rsv_flg_logs.loc[rsv_flg_logs['age_rank'] >= 60, 'age_rank'] = 60

# 카테고리 형으로 변환
rsv_flg_logs['age_rank'] = rsv_flg_logs['age_rank'].astype('category')

# 연령 카테고리형을 더미 플래그로 변환하여 추가
rsv_flg_logs = pd.concat(
  [rsv_flg_logs,
   pd.get_dummies(rsv_flg_logs['age_rank'], drop_first=False)],
  axis=1
)

# 달을 12종류의 카테고리값에서 수치화
# 과학습 경향이 발생하면 맨 먼저 이 변수를 의심할 것
rsvcnt_m = rsv_flg_logs.groupby('month_num')['rsv_flg'].sum()
cuscnt_m = rsv_flg_logs.groupby('month_num')['customer_id'].count()
rsv_flg_logs['month_num_flg_rate'] =\
  rsv_flg_logs[['month_num', 'rsv_flg']].apply(
    lambda x: (rsvcnt_m[x[0]] - x[1]) / (cuscnt_m[x[0]] - 1), axis=1)

# 과거 1년간의 예약 금액 합계를 대수화
# 금액이 커질수록 금액의 절대적인 크기의 의미는 작아진다고 예측 가능하기 때문
rsv_flg_logs['before_total_price_log'] = \
  rsv_flg_logs['before_total_price'].apply(lambda x: np.log(x / 10000 + 1))

# 학습 데이터와 검증 데이터로 분할

# 모델로 이용할 변수명을 설정
target_log = rsv_flg_logs[['rsv_flg']]
# 불필요한 변수를 제거
rsv_flg_logs.drop(['customer_id', 'rsv_flg', 'sex', 'age', 'age_rank',
                   'month_num', 'before_total_price'], axis=1, inplace=True)

# 홀드 아웃 검증을 위해 학습 데이터와 검증 데이터로 분할 
train_data, test_data, train_target, test_target =\
  train_test_split(rsv_flg_logs, target_log, test_size=0.2)

# 인덱스 번호를 리셋
train_data.reset_index(inplace=True, drop=True)
test_data.reset_index(inplace=True, drop=True)
train_target.reset_index(inplace=True, drop=True)
test_target.reset_index(inplace=True, drop=True)

# 교차 검증용 데이터를 분할
row_no_list = list(range(len(train_target)))
random.shuffle(row_no_list)
k_fold = KFold(n_splits=4)

# 교차수 만큼 반복
for train_cv_no, test_cv_no in k_fold.split(row_no_list):
  train_data_cv = train_data.iloc[train_cv_no, :]
  train_target_cv = train_target.iloc[train_cv_no, :]
  test_data_cv = train_data.iloc[test_cv_no, :]
  test_target_cv = train_target.iloc[test_cv_no, :]

  # 교차 검증 모델링
  # 학습 데이터： train_data_cv, train_target_cv
  # 테스트 데이터： test_data_cv, test_target_cv

# 홀드 아웃 검증 모델링
# 학습 데이터： train_data, train_target
# 테스트 데이터： test_data, test_target
