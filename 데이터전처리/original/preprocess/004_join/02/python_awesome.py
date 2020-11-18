from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
import numpy as np
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# 가비지콜렉션(불필요한 메모리 해제)를 위한 라이브러리
import gc

# small_area_name별로 호텔 수를 계산
small_area_mst = hotel_tb \
  .groupby(['big_area_name', 'small_area_name'], as_index=False) \
  .size().reset_index()
small_area_mst.columns = ['big_area_name', 'small_area_name', 'hotel_cnt']

# 20건 이상이면 join_area_id에 small_area_name을 지정
# 20건 미만이면 join_area_id에 big_area_name을 지정
# -1로 자신을 제외
small_area_mst['join_area_id'] = \
  np.where(small_area_mst['hotel_cnt'] - 1 >= 20,
           small_area_mst['small_area_name'],
           small_area_mst['big_area_name'])

# 필요 없어진 열을 제거
small_area_mst.drop(['hotel_cnt', 'big_area_name'], axis=1, inplace=True)

# 추천 대상 호텔에 small_area_mst를 결합하여 join_area_id를 설정
base_hotel_mst = pd.merge(hotel_tb, small_area_mst, on='small_area_name') \
                   .loc[:, ['hotel_id', 'join_area_id']]

# 아래는 필요에 따라 메모리 해제(필수는 아니지만 메모리에 여유가 없을 때 이용)
del small_area_mst
gc.collect()

# recommend_hotel_mst는 추천 후보 테이블
recommend_hotel_mst = pd.concat([
  # join_area_id를 big_area_name으로한 추천 후보 마스터
  hotel_tb[['small_area_name', 'hotel_id']] \
    .rename(columns={'small_area_name': 'join_area_id'}, inplace=False),

  # join_area_id를 small_area_name으로한 추천 후보 마스터
  hotel_tb[['big_area_name', 'hotel_id']] \
    .rename(columns={'big_area_name': 'join_area_id'}, inplace=False)
])

# 결합 할 때 hotel_id 열 이름이 중복 되므로 변경
recommend_hotel_mst.rename(columns={'hotel_id': 'rec_hotel_id'}, inplace=True)

# base_hotel_mst와 recommend_hotel_mst를 결합하여 추천 후보의 정보를 부여
# query 함수로 추천 후보에서 자신을 제외
pd.merge(base_hotel_mst, recommend_hotel_mst, on='join_area_id') \
  .loc[:, ['hotel_id', 'rec_hotel_id']] \
  .query('hotel_id != rec_hotel_id')
