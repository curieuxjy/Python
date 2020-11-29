import pandas as pd
from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 아래 부터 책에 게재
# 더미 변수로 만들기 전에 카테고리 형으로 변환
customer_tb['sex'] = pd.Categorical(customer_tb['sex'])

# get_dummies 함수로 sex를 더미 변수화
# drop_first를 False로 하면, 카테고리값의 모든 종류 값의 더미 플래그를 생성
dummy_vars = pd.get_dummies(customer_tb['sex'], drop_first=False)
